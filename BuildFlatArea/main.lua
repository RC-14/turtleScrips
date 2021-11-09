local ta = require '/libraries/turtleAdditions'

local length, width = ...

if length == nil or width == nil then
    error('length and width must be set')
end

-- conversion to integers
length = math.floor(length)
width = math.floor(width)

if length < 1 or width < 1 then
    error("length and width can't be lower than 1")
end
