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

local function placeBlock()
    local origSlot = turtle.getSelectedSlot()
    local success = false

    for i = 1, 16 do
        local count = turtle.getItemCount(i)

        if count ~= 0 then
            turtle.select(i)
            success = turtle.place()

            if not success then
                turtle.drop()
            else
                break
            end
        end
    end

    turtle.select(origSlot)

    return success
end

for i = 1, width do
    for j = 1, length do
    end
end
