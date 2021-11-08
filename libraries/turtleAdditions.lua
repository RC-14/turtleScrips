local ta = {}

function ta.uTurn(right)
    local turnFunc = turtle.turnLeft

    if right then
        turnFunc = turtle.turnRight
    end

    turnFunc()
    turnFunc()
end

function ta.getId()
    local success, data = turtle.inspect()

    if success then
        return data.name
    end

    return 'minecraft:air' -- success is false if the block is air
end

function ta.getIdUp()
    local success, data = turtle.inspectUp()

    if success then
        return data.name
    end

    return 'minecraft:air' -- success is false if the block is air
end

function ta.getIdDown()
    local success, data = turtle.inspectDown()

    if success then
        return data.name
    end

    return 'minecraft:air' -- success is false if the block is air
end

function ta.searchInventoryFor(itemID) -- searches the inventory of the turtle for slots with items that have the given item id and returns a table with the reults
    local slots = {}

    for i = 1, 16 do
        local item = turtle.getItemDetail(i)

        if not item == nil and item.name == itemID then
            slots[#slots + 1] = i
        end
    end

    return slots
end

return ta
