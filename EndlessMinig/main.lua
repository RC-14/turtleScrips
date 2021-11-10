local ta = require '/libraries/turtleAdditions'

local TURTLECHARGER_ID = 'peripheralsplusone:rf_charger'
local ENERGYCELL_ID = 'thermalexpansion:cell'
local ENDERCHEST_ID = 'enderstorage:ender_storage'

local hasRequiredItems =
    shell.run(
    '/' .. fs.getDir(shell.getRunningProgram()) .. '/checkForRequiredItems.lua',
    TURTLECHARGER_ID,
    ENERGYCELL_ID,
    ENDERCHEST_ID
)

turtle.select(1)
