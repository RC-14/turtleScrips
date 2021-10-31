local sqrdist=3
local farmx=16 -- (farmx-1)mod3=0
local farmy=4 -- (farmy-1)mod3=0
destroyTree()

function destroyTree() 
    if turtle.compare() then
        turtle.dig()
        turtle.forward()
        while turtle.detectUp() do  
            turtle.digUp()
            turtle.up()
        end
        while not turtle.detectDown() do  
            turtle.down()
        end
        turtle.back()
    end
end

