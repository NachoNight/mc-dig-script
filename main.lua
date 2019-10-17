turtle.refuel()

local function Start()
	write("Width: ")
	local Width = read()
	write("Length: ")
	local Length = read()
end

-- Dig function
local function Dig(num)
	turtle.turnRight()
	for i=1, num do
		turtle.dig()
	end
	turtle.turnRight()
end

-- Startup function
function StartDigging()
	while Width > 1 do
		Dig(i)
		Width -= 1
	end
	write("Keep digging? (Y/n)")
	local Answer = read()
	if(Answer:lower() == "y") Start()
	print("Done!")
end

StartDigging()
