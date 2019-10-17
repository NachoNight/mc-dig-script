local passes = 0

local function Start()
	StartDigging()
end

local function Dig(num)
	for i = 1, num do
		-- If a block exists:
		if turtle.detect() then
			turtle.dig()
			turtle.forward()
		else
			-- No block
			turtle.forward();
			Dig(num - 1)
		end
	end
end

-- Startup function
function StartDigging()
	write("Width: ")
	local width = tonumber(read())
	while width ~= passes do
		Dig(width)
		passes = passes	+ 1
		turtle.turnRight()
		Dig(1)
		turtle.turnRight()
	end
	write("Keep digging? (Y/n)")
	local Answer = read()
	if(Answer:lower() == "y") then 
		Start()
	end
	print("Done!")
end

Start()
