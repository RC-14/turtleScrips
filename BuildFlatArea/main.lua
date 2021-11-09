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


for i = 1, width do
    for i = 1, length do
    end
end
