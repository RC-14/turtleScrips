local ta = require '/libraries/turtleAdditions'

local diameter = ...

local CHARGER_ID = 'peripheralsplusone:rf_charger'
local ENERGYCELL_ID = 'thermalexpansion:cell'
local ENDERCHEST_ID = 'enderstorage:ender_storage'

local ITEMCHEST_SLOT, CHARGER_SLOT, ENERGYCELL_SLOT, ENERGYCHEST_SLOT = 1, 2, 3, 4

local function clearInventory()
    local origSlot = turtle.getSelectedSlot()
    local iChest, charger, cell, eChest = false, false, false, false

    -- Drop all unnecessary items
    for i = 1, 16 do
        local item = turtle.getItemDetail(i)
        if item ~= nil and (item.name ~= CHARGER_ID or item.name ~= ENERGYCELL_ID or item.name ~= ENDERCHEST_ID) then
            turtle.select(i)
            turtle.drop()
        end
    end

    -- Check for Turtle Charger
    local slot = ta.searchInventoryFor(CHARGER_ID)
    slot = slot[1]

    if slot == nil then
        error('Lost Turtle Charger')
    end

    if slot == CHARGER_SLOT then
        charger = true
    end

    -- Check for Energy Cell
    slot = ta.searchInventoryFor(ENERGYCELL_ID)
    slot = slot[1]

    if slot == nil then
        error('Lost Energy Cell')
    end

    if slot == ENERGYCELL_SLOT then
        cell = true
    end

    -- Check for Ender Chests
    local slots = ta.searchInventoryFor(ENDERCHEST_ID)

    if #slots < 2 then
        error('Lost Ender Chest(s)')
    end

    for i, slot in ipairs(slots) do
        if slot == ITEMCHEST_SLOT then
            iChest = true
        elseif slot == ENERGYCHEST_SLOT then
            eChest = true
        end
    end

    if iChest and charger and cell and eChest then -- return if everything is in the right slot
        turtle.select(origSlot)
        return
    end

    -- Move items to the correct slots
    local function moveToSlot(id, slot, ignoreSlot)
        if turtle.getItemDetail(slot) ~= nil then
            turtle.select(slot)

            for i = 5, 16 do
                if turtle.transferTo(i) then
                    break
                end
            end
        end

        local itemSlot
        for i, v in ipairs(ta.searchInventoryFor(id)) do
            if v ~= ignoreSlot then
                itemSlot = v
            end
        end

        turtle.select(itemSlot)
        turtle.transferTo(slot)
    end

    if not iChest then
        moveToSlot(ENDERCHEST_ID, ITEMCHEST_SLOT, ENERGYCHEST_SLOT)
    end

    if not charger then
        moveToSlot(CHARGER_ID, CHARGER_SLOT)
    end

    if not cell then
        moveToSlot(ENERGYCELL_ID, ENERGYCELL_SLOT)
    end

    if not eChest then
        moveToSlot(ENDERCHEST_ID, ENERGYCHEST_SLOT, ITEMCHEST_SLOT)
    end

    turtle.select(origSlot)
end

local move = {}
function move.forward()
    if not turtle.forward() then
        error("Couldn't move forward")
    end
end
function move.back()
    if not turtle.back() then
        error("Couldn't move back")
    end
end
function move.up()
    if not turtle.up() then
        error("Couldn't move up")
    end
end
function move.down()
    if not turtle.down() then
        error("Couldn't move down")
    end
end

-- Make better dig functions because sand and gravel exist
local dig = {}

function dig.forward()
    local result
    local success

    repeat
        success = turtle.dig()
        result = result or success
    until not success

    return success
end
function dig.up()
    local result
    local success

    repeat
        success = turtle.digUp()
        result = result or success
    until not success

    return success
end
function dig.down()
    local result
    local success

    repeat
        success = turtle.digDown()
        result = result or success
    until not success

    return success
end

local fulfillsRequirements =
    shell.run('/' .. fs.getDir(shell.getRunningProgram()) .. '/checkForRequirements.lua', diameter)

if not fulfillsRequirements then
    error()
end

diameter = math.floor(diameter) -- make sure we have an integer

turtle.select(16)

while true do
    -- recharge
    dig.forward()
    turtle.select(ENERGYCELL_SLOT)
    turtle.place()
    turtle.select(16)
    dig.up()
    move.up()
    turtle.select(CHARGER_SLOT)
    turtle.placeDown()

    print('Recharging...')
    while turtle.getFuelLevel() < turtle.getFuelLimit() do
        sleep(10)
    end
    print('Full')

    dig.down()
    move.down()
    turtle.select(ENERGYCELL_SLOT)
    dig.forward()

    clearInventory()

    -- put the energy cell in the energy chest
    turtle.select(ENERGYCHEST_SLOT)
    turtle.place()
    turtle.select(ENERGYCELL_SLOT)
    turtle.drop()
    turtle.select(CHARGER_SLOT)
    turtle.drop()

    -- prepare to start mining
    turtle.select(16)
    turtle.turnRight()
    dig.forward()
    move.forward()
    ta.uTurn()
    turtle.select(ITEMCHEST_SLOT)
    turtle.place()
    ta.uTurn()

    -- mine a chunk
    shell.run('excavate', diameter)
    ta.uTurn()

    -- if necessary wait for all items to be dropped
    while not ta.isInventoryEmpty() do
        print('Unloading... (Chest is full)')
        for i = 1, 16 do
            turtle.select(i)
            turtle.drop()
        end
    end

    -- get all required items again
    turtle.select(ITEMCHEST_SLOT)
    dig.forward()
    move.forward()
    turtle.turnRight()
    turtle.select(ENERGYCELL_SLOT)
    turtle.suck()
    turtle.select(ENERGYCHEST_SLOT)
    dig.forward()

    clearInventory()
    turtle.select(16)

    -- move forward to the next position
    for i = 1, diameter do
        while not turtle.forward() do
            dig.forward()
        end
    end
end
