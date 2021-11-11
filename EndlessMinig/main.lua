local ta = require '/libraries/turtleAdditions'

local TURTLECHARGER_ID = 'peripheralsplusone:rf_charger'
local ENERGYCELL_ID = 'thermalexpansion:cell'
local ENDERCHEST_ID = 'enderstorage:ender_storage'

local hasRequiredItems = shell.run('/' .. fs.getDir(shell.getRunningProgram()) .. '/checkForRequirements.lua')

if not hasRequiredItems then
    error()
end

turtle.select(1)
