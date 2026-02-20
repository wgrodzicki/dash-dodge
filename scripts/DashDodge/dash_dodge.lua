local input = require('openmw.input')
local self = require('openmw.self')
local types = require('openmw.types')
local async = require('openmw.async')
local debug = require('openmw.debug')
local ambient = require('openmw.ambient')
local storage = require('openmw.storage')

local settingsGroup = storage.playerSection('Settings_DashDodge')

-- Constants
local BASE_SPEED_BUFF = 500
local DEFAULT_FATIGUE_COST = 40
local DEFAULT_SPEED_BUFF_DURATION = 0.05
local SKILL_BUFF_MAGNITUDE_FACTOR = 2.5
local SKILL_BUFF_DURATION_FACTOR = 2.0
local DEFAULT_COOLDOWN_DURATION = 1.5
local MIN_COOLDOWN_DURATION = 0.5

-- From settings (user-adjustable)
local isEnabled = true
local buffSpeedMultiplier = 1.0
local buffDurationMultiplier = 1.0
local fatigueCostMultiplier = 1.0
local sfxVolumeMultiplier = 1.0

local baseSpeedBuffDuration = 0.0
local fatigueCost = 0.0
local speedBuffValue = 0
local canApplySpeedBuff = true
local totalSpeedBuffValue = 0
local attributes = types.Actor.stats.attributes
local skills = types.NPC.stats.skills
local dynamic = types.Actor.stats.dynamic

-- Gets user settings.
local function getCurrentSettings()
    isEnabled = settingsGroup:get('enabled')
    sfxVolumeMultiplier = settingsGroup:get('sfxVolumeMultiplier')
    buffSpeedMultiplier = settingsGroup:get('buffSpeedMultiplier')
    buffDurationMultiplier = settingsGroup:get('buffDurationMultiplier')
    fatigueCostMultiplier = settingsGroup:get('fatigueCostMultiplier')

    baseSpeedBuffDuration = DEFAULT_SPEED_BUFF_DURATION * buffDurationMultiplier
    fatigueCost = DEFAULT_FATIGUE_COST * fatigueCostMultiplier
end

-- Applies a speed modifier. Positive values are buffs, negative values are debuffs.
local function modifySpeed(modifierValue)
    if modifierValue > 0 then -- if positive effect, then modifier; else damage
        attributes.speed(self).modifier = math.max(0, attributes.speed(self).modifier + modifierValue)
    else
        modifierValue = math.abs(modifierValue)
        attributes.speed(self).damage = math.max(0, attributes.speed(self).damage + modifierValue)
    end
end

local function onActive()
    getCurrentSettings()
end

local function onSave()
    return {
        totalSpeedBuffValue = totalSpeedBuffValue
    }
end

local function onLoad(data)
    if not data then
        return
    end

    totalSpeedBuffValue = data.totalSpeedBuffValue
    modifySpeed(totalSpeedBuffValue * -1)
    totalSpeedBuffValue = 0
end

local function onUpdate()
    -- Mod disabled
    if isEnabled == false then
        return
    end

    -- No input
    if input.getBooleanActionValue("DashDodgeAction") == false then
        return
    end

    -- Still on cooldown
    if canApplySpeedBuff == false then
        return
    end

    -- In the air/water
    if types.Actor.isOnGround(self) == false or types.Actor.isSwimming(self) then
        return
    end

    -- Not in combat stance
    if types.Actor.getStance(self) == types.Actor.STANCE.Nothing then
        return
    end

    local currentFatigue = dynamic.fatigue(self).current

    -- Not enough fatigue
    if currentFatigue <= fatigueCost then
        return
    end

    -- Spend fatigue
    if not debug.isGodMode() then
        dynamic.fatigue(self).current = math.max(0, currentFatigue - fatigueCost)
    end

    -- Get the skill modifier (capped at 100)
    local currentSkillValue = skills.athletics(self).modified

    if (currentSkillValue > 100) then
        currentSkillValue = 100
    end

    -- Calculate the buff value depending on the skill
    speedBuffValue = (BASE_SPEED_BUFF + (currentSkillValue * SKILL_BUFF_MAGNITUDE_FACTOR)) * buffSpeedMultiplier

    -- Actually buff speed
    modifySpeed(speedBuffValue)
    totalSpeedBuffValue = totalSpeedBuffValue + speedBuffValue

    -- Play sfx
    if ambient and (sfxVolumeMultiplier > 0.0) then
        ambient.playSound("Ros_dash_dodge_sound",
            { volume = (0.7 * sfxVolumeMultiplier), pitch = (1.75 + 0.1 * math.random()) })
    end

    canApplySpeedBuff = false

    local speedBuffDuration = baseSpeedBuffDuration + (currentSkillValue / SKILL_BUFF_DURATION_FACTOR / 1000)

    -- Set debuff timer
    async:newUnsavableSimulationTimer(
        speedBuffDuration,
        function()
            modifySpeed(totalSpeedBuffValue * -1)
            totalSpeedBuffValue = 0
        end
    )

    -- Calculate the cooldown depending on the skill
    local cooldownDuration = DEFAULT_COOLDOWN_DURATION - (currentSkillValue / 100)

    -- Make sure the cooldown is never less than the buff itself to prevent instant re-buff
    if cooldownDuration <= speedBuffDuration then
        cooldownDuration = MIN_COOLDOWN_DURATION
    end

    -- Set cooldown timer
    async:newUnsavableSimulationTimer(
        cooldownDuration,
        function()
            canApplySpeedBuff = true
        end
    )
end

-- Make sure settings are up to date
settingsGroup:subscribe(async:callback(getCurrentSettings))

---@type EngineHandlers
local engineHandlers = {
    onActive = onActive,
    onSave = onSave,
    onLoad = onLoad,
    onUpdate = onUpdate,
}

return {
    engineHandlers = engineHandlers
}
