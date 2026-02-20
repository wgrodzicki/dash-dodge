local input = require('openmw.input')
local interfaces = require('openmw.interfaces')

-- Default setting values
local isEnabled = true
local sfxVolumeMultiplier = 1.0
local buffSpeedMultiplier = 1.0
local buffDurationMultiplier = 1.0
local fatigueCostMultiplier = 1.0

-- Helper functions
local function getBoolSetting(settingKey, settingDef)
    return {
        key = settingKey,
        renderer = 'checkbox',
        name = settingKey .. '_name',
        description = settingKey .. '_desc',
        default = settingDef,
    }
end

local function getNumberSetting(settingKey, settingDef, settingInt, settingMin, settingMax)
    return {
        key = settingKey,
        renderer = 'number',
        name = settingKey .. '_name',
        description = settingKey .. '_desc',
        default = settingDef,
        argument = {
            int = settingInt,
            min = settingMin,
            max = settingMax,
        },
    }
end

interfaces.Settings.registerPage({
    key = 'DashDodge',
    l10n = 'DashDodge',
    name = 'name',
    description = 'description',
})

-- Base value settings
interfaces.Settings.registerGroup({
    key = 'Settings_DashDodge',
    page = 'DashDodge',
    l10n = 'DashDodge',
    name = 'group_name',
    permanentStorage = true,
    settings = {
        getBoolSetting('isEnabled', isEnabled),
        getNumberSetting('sfxVolumeMultiplier', sfxVolumeMultiplier, false, 0.0, 2.0),
        getNumberSetting('buffSpeedMultiplier', buffSpeedMultiplier, false, 0.1, 2.0),
        getNumberSetting('buffDurationMultiplier', buffDurationMultiplier, false, 0.1, 2.0),
        getNumberSetting('fatigueCostMultiplier', fatigueCostMultiplier, false, 0.0, 2.0),
    },
})

-- Input settings
input.registerAction {
    key = 'DashDodgeAction',
    type = input.ACTION_TYPE.Boolean,
    l10n = 'DashDodge',
    defaultValue = false,
}

interfaces.Settings.registerGroup({
    key = 'Dash Dodge Controls',
    page = 'DashDodge',
    l10n = 'DashDodge',
    name = 'Controls',
    permanentStorage = true,
    order = 1,
    settings = {
        {
            key = "DashDodgeActionButton",
            renderer = "inputBinding",
            default = "Dash_Dodge_Action_Button",
            name = "Dash Dodge",
            description = 'Press this button to perform a dash dodge when in combat stance.',
            argument = {
                type = "action",
                key = "DashDodgeAction"
            },
        }
    }
})