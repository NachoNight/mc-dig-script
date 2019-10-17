local tArgs = {...}
if #tArgs ~= 1 then
    print("Usage: makeroom <size>")
    return
end
-- Mine in a spiral pattern
size = tonumber(tArgs[1])
if size < 1 then
    print("Room size must be positive")
    return
end

local collected = 0
local function collect()
    collected = collected + 1
    if math.fmod(collected, 25) == 0 then
        print("Mined " .. collected .. " items.")
    end
end
local function tryDig()
    while turtle.detect() do
        if turtle.dig() then
            collect()
            sleep(0.5)
        else
            return false
        end
    end
    return true
end

local function tryDigUp()
    while turtle.detectUp() do
        if turtle.digUp() then
            collect()
            sleep(0.5)
        else
            return false
        end
    end
    return true
end

local function refuel()
    local fuelLevel = turtle.getFuelLevel()
    if fuelLevel == "unlimited" or fuelLevel > 0 then return end

    local function tryRefuel()
        for n = 1, 16 do
            if turtle.getItemCount(n) > 0 then
                turtle.select(n)
                if turtle.refuel(1) then
                    turtle.select(1)
                    return true
                end
            end
        end
        turtle.select(1)
        return false
    end

    if not tryRefuel() then
        print("Add more fuel to continue.")
        while not tryRefuel() do sleep(1) end
        print("Resuming Room.")
    end
end

local function tryUp()
    refuel()
    while not turtle.up() do
        if turtle.detectUp() then
            if not tryDigUp() then return false end
        elseif turtle.attackUp() then
            collect()
        else
            sleep(0.5)
        end
    end
    return true
end

local function tryForward()
    refuel()
    while not turtle.forward() do
        if turtle.detect() then
            if not tryDig() then return false end
        elseif turtle.attack() then
            collect()
        else
            sleep(0.5)
        end
    end
    return true
end

local function channelForward(length)
    refuel()
    for i = 1, length do
        tryDigUp()
        tryForward()
    end
    return true
end

function reset()
    local target = math.ceil(size / 2) - 1
    turtle.turnLeft()
    for i = 1, target do turtle.back() end
    turtle.turnLeft()
    for i = 1, target - 1 do turtle.back() end
end

local function digLoop()
    local n = 1
    while n < size do
        channelForward(n)
        turtle.turnRight()
        channelForward(n)
        turtle.turnRight()
        n = n + 1
        if (n >= size) then reset() end
    end
end

print("Making Room...")
digLoop()
channelForward(n - 1)
tryDigUp()
print("Room complete.")
print("Mined " .. collected .. " items total.")
