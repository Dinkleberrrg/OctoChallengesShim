# OctoChallengesShim

Fixes a Lua error in OctoWoW's target frame (WoW 1.12).

## Problem
OctoWoW is a Turtle WoW fork and took over its `Interface\FrameXML\TargetFrame.lua`. That file accesses the global table `Turtle_ChallengesCache`, which on Turtle WoW is provided by the `Turtle_General` addon. OctoWoW does not ship that addon, so targeting something raises:

- without the table: `attempt to index global 'Turtle_ChallengesCache'`
- with an empty table: `attempt to index field '?'`, because it is accessed two levels deep

## Solution
The addon creates `Turtle_ChallengesCache` if it is missing. A metatable returns the same empty table for every unknown key, so the second access cleanly yields `nil`. No memory grows.

## Settings
None.

## Removal
Delete the folder.
