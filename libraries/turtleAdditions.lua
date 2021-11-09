local ta = {}

function ta.searchInventoryFor(itemID) -- Searches the inventory of the turtle for slots with items that have the given item id and returns a table with the results.
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

function ta.uTurn(right) -- Let the turtle make a U turn. (if the optional parameter is true it uses turnRight instead of turnLeft)
    local turnFunc = turtle.turnLeft

    if right then
        turnFunc = turtle.turnRight
    end

    turnFunc()
    turnFunc()
end

return ta
