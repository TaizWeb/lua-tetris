require("board")
-- TODO: Design UI (have scores default to 0000000 since it looks nicer)
-- TODO: Add "next block" panel
-- TODO: Add "high score" panel (with fs storage)
-- TODO: Add nice animations for line clears and game loss
-- TODO: Add pausing
-- TODO: Redesign tetrinos
-- TODO: Make currentTetrino into a Tetrino Object
-- TODO: Make the roof 2 blocks higher

-- Love Resolution: 800 x 600
-- Tetris board: 10 x 18
-- Our Tetris board: 250
-- Each square: 25

function love.load()
	love.keyboard.setKeyRepeat(true)
	Board.reset()
	x, y = 5, 1 -- Where the tetrinos will be spawning
	frameCounter = 0
	rotation = 0
	tetrinoType = 2
end

function love.keypressed(key, scancode, isrepeat)
	if (key == "left" or key == "h") and Board.checkPositioning(tetrinoType, rotation, x, y, "moveLeft") then
		x = x - 1
	elseif (key == "right" or key == "l") and Board.checkPositioning(tetrinoType, rotation, x, y, "moveRight") then
		x = x + 1
	elseif (key == "down" or key == "j") and Board.checkPositioning(tetrinoType, rotation, x, y, "moveDown") then
		y = y + 1
		System.addScore(10)
		frameCounter = 0
	elseif key == "z" and Board.checkSwinging(tetrinoType, rotation, x, y) then
		if rotation == 270 then
			rotation = 0
		else
			rotation = rotation + 90
		end
	elseif key == "x" then
		lowestY = Board.getLowestY(tetrinoType, rotation, x, y)
		System.addScore(10 * (lowestY - y))
		y = lowestY
		frameCounter = 60
	end
end

function love.update(dt)
	if frameCounter >= 60 - (5 * (System.getLevel() - 1)) then
		if Board.checkPositioning(tetrinoType, rotation, x, y, "moveDown") then
			y = y + 1
		else
			Board.storeTetrino(tetrinoType, rotation, x, y)
			-- set cur to next hten calc next again
			tetrinoType = nextTetrinoType
			math.randomseed(os.clock())
			nextTetrinoType = math.ceil(math.random() * 7)
			-- current bug is next tetrino is right color but not right shape
			rotation = 0
			x = 5
			y = 1
		end
		frameCounter = 0
	else
		frameCounter = frameCounter + 1
	end
end

function love.draw()
	love.graphics.setColor(100, 100, 100)
	love.graphics.rectangle('fill', 275, 25, 250, 450)
	love.graphics.rectangle('fill', 550, 200, 100, 100)
	Board.drawNext()
	Board.drawBoard()
	Board.drawTetrino(tetrinoType, rotation, x, y)
	love.graphics.setColor(255, 255, 255)
	love.graphics.print("FPS: " .. tostring(love.timer.getFPS()) .. "\nRotation: " .. tostring(rotation) .. "\nScore: " .. tostring(System.getScore() .. "\nLines: " .. tostring(System.getLines())) .. "\nLevel: " .. tostring(System.getLevel()), 10, 10)
end

