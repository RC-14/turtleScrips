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

ta.uTurn()

turtle.select(1)
local item = turtle.getItemDetail()

if item == nil or item.name ~= ENDERCHEST_ID or not isEnderChest() then
    fail('No item chest.')
elseif item.count > 1 then
    turtle.drop(item.count - 1)
end

turtle.select(2)
item = turtle.getItemDetail()

if item == nil or item.name ~= TURTLECHARGER_ID then
    fail('No charger.')
elseif item.count > 1 then
    turtle.drop(item.count - 1)
end

turtle.select(3)
item = turtle.getItemDetail()

if item == nil or item.name ~= ENERGYCELL_ID then
    fail('No energy cell.')
elseif item.count > 1 then
    turtle.drop(item.count - 1)
end

turtle.select(4)
item = turtle.getItemDetail()

if item == nil or item.name ~= ENDERCHEST_ID or not isEnderChest() then
    fail('No energy chest.')
elseif item.count > 1 then
    turtle.drop(item.count - 1)
end

turtle.select(16)
for i = 5, 16 do
    turtle.select(i)
    turtle.drop()
end

local hasPickaxe = false

turtle.equipRight()
item = turtle.getItemDetail()
if item == nil or item.name ~= CHUNKLOADER_ID and item.name ~= PICKAXE_ID then
    turtle.equipRight()
    fail('Wrong/No tools')
end
hasPickaxe = item.name == PICKAXE_ID
turtle.equipRight()

turtle.equipLeft()
item = turtle.getItemDetail()
if item == nil or hasPickaxe and item.name ~= CHUNKLOADER_ID or not hasPickaxe and item.name ~= PICKAXE_ID then
    turtle.equipLeft()
    fail('Wrong tools')
end
turtle.equipLeft()

ta.uTurn()
