local ta = require '/libraries/turtleAdditions'

local TURTLECHARGER_ID = 'peripheralsplusone:rf_charger'
local ENERGYCELL_ID = 'thermalexpansion:cell'
local ENDERCHEST_ID = 'enderstorage:ender_storage'
local CHUNKLOADER_ID = 'peripheralsplusone:chunk_loader_upgrade'
local PICKAXE_ID = 'minecraft:diamond_pickaxe'

local function isEnderChest()
    turtle.place()
    local state = turtle.inspect().state
    turtle.dig()

    return state.type == 'ender_chest'
end

local function fail(message)
    turtle.drop()
    error(message)
end
