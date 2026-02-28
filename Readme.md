# **Dash Dodge**
#### **v. 1.2**
#### ***an OpenMW Lua mod by Rosynant***

Changelog
- v. 1.2: added an optional evasion effect when dashing (100% Sanctuary), more random NPC cooldown, more parameters exposed in the settings, disabled dashing when standing still
- v. 1.1: added dashing ability to NPCs, code refactor, minor bug fixes
- v. 1.0: initial release

## Why this mod?

It's no secret Morrowind's combat is not the main thing people love this game for. I thought it would be nice to implement some modern gameplay mechanics to spicy up the fights.

## What does it do?

In many games there is a dash/dodge action that allows you to move very fast in a fraction of a second to quickly change direction, shorten the distance or surprise the enemy. So this mod does exactly that.

### Performing the dash

1. Assign a dedicated button to the dash action in the settings
2. Draw your weapon (enter the combat stance)
3. Move
4. Press the dash button
5. You will dash in the direction of your current movement

Dashing consumes some amount of Fatigue and triggers a short cooldown so that you can't keep dashing forever. Optionally, it also applies a 100% Sanctuary effect for the duration of the dodge.

### Dash requirements

The dash ability depends on your Athletics, so the higher the skill, the longer and quicker your dodging will be. I added a limit that caps the skill modifier at 100, so expect no exploits here.

### NPC dashing

Moreover, NPCs will dash in combat as well. The chance of performing a dodge and the cooldown between subsequent dashes are randomized to provide a more varied combat experience. All the other rules apply to NPCs as well: dashing effectiveness depends on their Athletics and they can also gain a temporary Sanctuary effect.

### SFX

There is also a subtle sound effect that triggers when performing the dash, both for the player and the NPCs.

### Settings

You can tweak virtually everything in the Settings section. Change modifiers related to the speed, duration, cost and cooldown of the dodge, separately for the player and the NPCs. Enabled/disable NPC dashing, change (or mute) the sfx, enable/disable the evasion Sanctuary effect. Adjust the mod to your liking. To see the changes take effect run the *reloadlua* command in the console or save/load the game.

## Requirements

- [OpenMW 0.50](https://openmw.org/downloads/), although will probably work on 0.48+ as well.
- Bloodmoon
- Tribunal

## Installation

Install like any other mod for OpenMW. Follow the official guide [here](https://openmw.readthedocs.io/en/latest/reference/modding/mod-install.html). Enable both the plug-in and the scripts in your mod list.

## Compatibility

Should be compatible with anything.

## Credits

- [Solthas](https://www.nexusmods.com/profile/Solthas?gameId=100) for letting me use their code from the [Jump Air Dash (OpenMW Lua)](https://www.nexusmods.com/morrowind/mods/52287) mod as the starting point.
- [dash 2 sfxwav by perduuus](https://freesound.org/s/701844/) (License: [Attribution NonCommercial 4.0](https://creativecommons.org/licenses/by-nc/4.0/), no changes made)