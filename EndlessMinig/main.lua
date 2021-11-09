local ta = require 'libraries.turtleAdditions'

local TURTLECHARGER_ID = 'peripheralsplusone:rf_charger'
local ENERGYCELL_ID = 'thermalexpansion:cell'
local ENDERCHEST_ID = 'enderstorage:ender_storage'

local hasRequiredItems = (function()
    local hasCharger = false
    local hasEnergyCell = false
    local enderChestCounter = 0
    local enderChestType = 'ender_chest'

    local hasTurned = false

    for i = 1, 16 do
        local item = turtle.getItemDetail(i)

        if item ~= nil then
            if item.name == TURTLECHARGER_ID and not hasCharger then
                hasCharger = true

                if item.count > 1 then
                    if not hasTurned then
                        ta.uTurn()
                        hasTurned = true
                    end
                    turtle.select(i)
                    turtle.drop(item.count - 1)
                end
            elseif item.name == ENERGYCELL_ID and not hasEnergyCell then
                hasEnergyCell = true

                if item.count > 1 then
                    if not hasTurned then
                        ta.uTurn()
                        hasTurned = true
                    end
                    turtle.select(i)
                    turtle.drop(item.count - 1)
                end
            elseif item.name == ENDERCHEST_ID and enderChestCounter < 2 then
                if item.count > 1 then
                    if not hasTurned then
                        ta.uTurn()
                        hasTurned = true
                    end
                    turtle.select(i)
                    turtle.drop(item.count - 1)
                end

                turtle.select(i)
                turtle.place()
                local state = turtle.inspect().state
                turtle.dig()

                if state.type == enderChestType then
                    enderChestCounter = enderChestCounter + 1
                else
                    if not hasTurned then
                        ta.uTurn()
                        hasTurned = true
                    end
                    turtle.select(i)
                    turtle.drop(item.count)
                end
            else
                if not hasTurned then
                    ta.uTurn()
                    hasTurned = true
                end
                turtle.select(i)
                turtle.drop()
            end
        end
    end

    if hasTurned then
        ta.uTurn()
    end
end)()

turtle.select(1)
