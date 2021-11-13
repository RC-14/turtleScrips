local ta = require '/libraries/turtleAdditions'

local CHARGER_ID = 'peripheralsplusone:rf_charger'
local ENERGYCELL_ID = 'thermalexpansion:cell'
local ENDERCHEST_ID = 'enderstorage:ender_storage'

local ITEMCHEST_SLOT, CHARGER_SLOT, ENERGYCELL_SLOT, ENERGYCHEST_SLOT = 1, 2, 3, 4

local hasRequiredItems = shell.run('/' .. fs.getDir(shell.getRunningProgram()) .. '/checkForRequirements.lua')

if not hasRequiredItems then
    error()
end

turtle.select(1)
