if not turtle then
    error('this is not a turtle')
end

local ta = {}

ta.isAdvanced = not (not multishell or false)

function ta.searchInventoryFor(itemID) -- Searches the inventory for slots with items that have the given item id and returns a table with the results.
    local slots = {}

    for i = 1, 16 do
        local item = turtle.getItemDetail(i)

        if not item == nil and item.name == itemID then
            slots[#slots + 1] = i
        end
    end

    return slots
end

function ta.getId() -- Returns the item id of the block in front of the turtle.
    local success, data = turtle.inspect()

    if success then
        return data.name
    end

    return 'minecraft:air' -- success is false if the block is air
end

function ta.getIdUp() -- Returns the item id of the block above the turtle.
    local success, data = turtle.inspectUp()

    if success then
        return data.name
    end

    return 'minecraft:air' -- success is false if the block is air
end

function ta.getIdDown() -- Returns the item id of the block below the turtle.
    local success, data = turtle.inspectDown()

    if success then
        return data.name
    end

    return 'minecraft:air' -- success is false if the block is air
end

function ta.placeItem(itemID) -- Searches the inventory for the specified item and tries to place it in front of the turtle.
    local origSlot = turtle.getSelectedSlot()
    local slots = ta.searchInventoryFor(itemID)

    if #slots == 0 then
        return false
    end

    turtle.select(slots[1])
    local success = turtle.place()

    turtle.select(origSlot)

    return success
end

function ta.placeItemUp(itemID) -- Searches the inventory for the specified item and tries to place it above the turtle.
    local origSlot = turtle.getSelectedSlot()
    local slots = ta.searchInventoryFor(itemID)

    if #slots == 0 then
        return false
    end

    turtle.select(slots[1])
    local success = turtle.placeUp()

    turtle.select(origSlot)

    return success
end

function ta.placeItemDown(itemID) -- Searches the inventory for the specified item and tries to place it below the turtle.
    local origSlot = turtle.getSelectedSlot()
    local slots = ta.searchInventoryFor(itemID)

    if #slots == 0 then
        return false
    end

    turtle.select(slots[1])
    local success = turtle.placeDown()

    turtle.select(origSlot)

    return success
end

function ta.uTurn(right) -- Let the turtle make a U turn. (if the optional parameter is true it uses turnRight instead of turnLeft)
    local turnFunc = turtle.turnLeft

    if right then
        turnFunc = turtle.turnRight
    end

    return turnFunc() and turnFunc()
end

return ta
