--[[
    This has its own file because I think this can be done more user friendly.
    
    Examples:
     - Get files from all over the inventory and place them in the right slots
     - Check the chests (empty / contains required items)
     - Somehow manage to distinguish Ender Chests with diffrent color codes
     - Make sure we can access the Ender Chests
     - ...
--]]
local ta = require '/libraries/turtleAdditions'

local TURTLECHARGER_ID = 'peripheralsplusone:rf_charger'
local ENERGYCELL_ID = 'thermalexpansion:cell'
local ENDERCHEST_ID = 'enderstorage:ender_storage'
local CHUNKLOADER_ID = 'peripheralsplusone:chunk_loader_upgrade'
local PICKAXE_ID = 'minecraft:diamond_pickaxe'

local function isEnderChest() -- required because Ender Chest and Ender Tank share the same item ID
    turtle.place()
    local _, state = turtle.inspect()
    state = state.state
    turtle.dig()

    return state.type == 'ender_chest'
end

local function fail(message)
    turtle.drop()
    error(message)
end

ta.uTurn()

if not ta.isAdvanced then
    error('not an advanced turtle')
end

--[[ Check for the required items
    Slot 1: Enderchest for items
    Slot 2: Turtle Charger
    Slot 3: Energy Cell
    Slot 4: Enderchest for energy stuff
--]]
-- Ender Chest for items
turtle.select(1)
local item = turtle.getItemDetail()

if item == nil or item.name ~= ENDERCHEST_ID or not isEnderChest() then
    fail('No item chest.')
elseif item.count > 1 then
    turtle.drop(item.count - 1)
end

-- Turtle Charger
turtle.select(2)
item = turtle.getItemDetail()

if item == nil or item.name ~= TURTLECHARGER_ID then
    fail('No charger.')
elseif item.count > 1 then
    turtle.drop(item.count - 1)
end

-- Energy Cell
turtle.select(3)
item = turtle.getItemDetail()

if item == nil or item.name ~= ENERGYCELL_ID then
    fail('No energy cell.')
elseif item.count > 1 then
    turtle.drop(item.count - 1)
end

-- Ender Chest for energy stuff
turtle.select(4)
item = turtle.getItemDetail()

if item == nil or item.name ~= ENDERCHEST_ID or not isEnderChest() then
    fail('No energy chest.')
elseif item.count > 1 then
    turtle.drop(item.count - 1)
end

-- Throw away all other items
turtle.select(16)
for i = 5, 16 do
    turtle.select(i)
    turtle.drop()
end

-- Check for Chunk Loader and Pickaxe
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

-- Success! we have erverything we need

ta.uTurn()
