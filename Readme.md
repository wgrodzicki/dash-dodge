# **Dash Dodge**
#### **v. 1.1**
#### ***an OpenMW Lua mod by Rosynant***

Changelog
- v. 1.1: added dashing ability to NPCs, code refactor, minor bug fixes
- v. 1.0: initial release

## Why this mod?

It's no secret Morrowind's combat is not the main thing people love this game for. I thought it would be nice to implement some modern gameplay mechanics to spicy up the fights.

## What does it do?

In many games there is a dash/dodge action that allows you to move very fast in a fraction of a second to quickly change direction, shorten the distance or surprise the enemy. So this mod does exactly that.

When in combat stance you can press a dedicated button to dash in the direction you're currently moving in. It consumes some amount of Fatigue and triggers a short cooldown so that you can't keep dashing forever.

The dash ability depends on your Athletics, so the higher the skill, the longer and quicker your dodging will be. I added limit that caps the skill modifier at 100, so expect no exploits here.

Moreover, NPCs will dash in combat as well. The chance of performing the dodge depends on NPC level, so the higher the level (the "tougher" the opponent), the more likely they will be to dash.

There is also a subtle sound effect that triggers when performing the dash. You can turn it off in the settings section if you like. Tweak modifiers related to the speed, duration and cost of the dodge, as well as NPC chance of dashing, to your liking. Don't forget to bind a custom button to the action.

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