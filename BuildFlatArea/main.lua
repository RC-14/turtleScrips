local ta = require '/libraries/turtleAdditions'

local length, width, requiredFuelLevel = ...

local function showUsage()
    local tmp = string.find(string.reverse(shell.getRunningProgram()), '/')
    local programName = string.sub(shell.getRunningProgram(), -1 * tmp + 1)

    print(programName .. ' length width [requiredFuelLevel]')
    print()
    print('width')
    print('|')
    print('^--- length')
    print()
    print('^ is the turtle (POV: you are above the turtle)')
end

if length == nil or width == nil then
    showUsage()
    error('length and width must be set')
elseif requiredFuelLevel == nil then
    requiredFuelLevel = turtle.getFuelLimit()
end

-- conversion to integers
length = math.floor(length)
width = math.floor(width)
requiredFuelLevel = math.floor(requiredFuelLevel)

if length < 1 or width < 1 or requiredFuelLevel < 1 then
    showUsage()
    error("length, width and requiredFuelLevel can't be lower than 1")
end

local function refuelIfNeeded()
    if turtle.getFuelLevel() ~= 0 then
        return
    end

    print('Waiting for refuel...')
    print("(Don't try to use the turtles inventory, it won't work.)")

    while turtle.getFuelLevel() < requiredFuelLevel do
        -- don't search the inventory for fuel because it's either a block or it got droped with placeBlock
        sleep(10)
    end
end

local function placeBlock(place)
    place = place or turtle.place

    local origSlot = turtle.getSelectedSlot()
    local success = false

    repeat
        for i = 1, 16 do
            local count = turtle.getItemCount(i)

            if count ~= 0 then
                turtle.select(i)
                success = place()

                if not success then
                    turtle.drop()
                else
                    break
                end
            end
        end

        if not success then
            print('out of blocks')
            print('waiting for more...')
            os.pullEvent('turtle_inventory') -- wait for changes to the turtles inventory
        end
    until success

    turtle.select(origSlot)
end

local function moveBack()
    if not turtle.back() then
        ta.uTurn()
        turtle.dig()
        ta.uTurn()
        if not turtle.back() then
            error("couldn't move backwards")
        end
    end
end

local turn = turtle.turnRight

ta.uTurn()
for i = 1, width do
    for j = 1, length - 1 do
        refuelIfNeeded()

        moveBack()
        placeBlock()
    end

    if i < width then
        turn()

        moveBack()
        placeBlock()

        turn()

        if turn == turtle.turnLeft then
            turn = turtle.turnRight
        else
            turn = turtle.turnLeft
        end
    else
        if turtle.up() then
            placeBlock(turtle.placeDown)
        elseif turtle.back() then
            placeBlock()
        elseif turtle.turnLeft() and turtle.back() then
            placeBlock()
        elseif ta.uTurn() and turtle.back() then
            placeBlock()
        elseif turtle.down() then
            placeBlock(turtle.placeUp)
        end
    end
end
