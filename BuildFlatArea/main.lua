local ta = require '/libraries/turtleAdditions'

local length, width, requiredFuelLevel = ...

if length == nil or width == nil then
    error('length and width must be set')
elseif requiredFuelLevel == nil then
    requiredFuelLevel = turtle.getFuelLimit()
end

-- conversion to integers
length = math.floor(length)
width = math.floor(width)
requiredFuelLevel = math.floor(requiredFuelLevel)

if length < 1 or width < 1 or requiredFuelLevel < 1 then
    error("length, width and requiredFuelLevel can't be lower than 1")
end


for i = 1, width do
    for i = 1, length do
    end
end
