require("tetrinos")
require("system")

Board = {
	board = {}
}

-- Initializing the Board.board
function Board.reset()
	for i = 1, 19 do
		Board.board[i] = {}
		for j = 1, 10 do
			Board.board[i][j] = 0
		end
	end
	math.randomseed(os.clock())
	nextTetrinoType = math.ceil(math.random() * 7)
	nextTetrino = getTetrino(nextTetrinoType, 0, 10, 10)
end

function Board.drawNext()
	love.graphics.setColor(getTetrinoColor(nextTetrinoType))
	nextTetrino = getTetrino(nextTetrinoType, 0, 10, 10)
	for i = 1, 4 do
		love.graphics.rectangle('fill', 350 + nextTetrino[i][1] * 25, 0 + nextTetrino[i][2] * 25 - 25, 25, 25)
	end
end

-- Draws a tetrino by it's blocks onto the Board.board
function Board.drawTetrino(tetrinoType, rotation, x, y)
	-- Perhaps the existence of l is breaking the board and causing a reset loop?
	if Board.checkPositioning(tetrinoType, rotation, x, y - 1, "moveDown") == false then
		-- Bug: Having the L block screws up loss detection
		Board.reset()
		System.reset()
	end
	-- Drawing the tetrino
	currentTetrino = getTetrino(tetrinoType, rotation, x, y)
	for i = 1, 4 do
		love.graphics.rectangle('fill', 275 + currentTetrino[i][1] * 25, 0 + currentTetrino[i][2] * 25, 25, 25)
	end

	-- Drawing the ghost
	lowestY = Board.getLowestY(tetrinoType, rotation, x, y)
	ghostTetrino = getTetrino(tetrinoType, rotation, x, lowestY, true)
	for i = 1, 4 do
		love.graphics.rectangle('fill', 275 + ghostTetrino[i][1] * 25, 0 + ghostTetrino[i][2] * 25, 25, 25)
	end
end

function Board.getLowestY(tetrinoType, rotation, x, y)
	while Board.checkPositioning(tetrinoType, rotation, x, y, "moveDown") do
		y = y + 1
	end
	return y
end

function Board.clearLine(lineNumber)
	for i = 1, 10 do
		Board.board[lineNumber][i] = 0
	end
	while lineNumber > 1 do
		Board.board[lineNumber] = Board.board[lineNumber-1]
		lineNumber = lineNumber - 1
	end
end

function Board.checkLines()
	linesComplete = 0
	for row = 2, 19 do
		lineValid = true
		for i = 1, 10 do
			if Board.board[row][i] == 0 then
				lineValid = false
			end
		end
		if lineValid then
			Board.clearLine(row)
			linesComplete = linesComplete + 1
		end
	end
	if linesComplete > 0 then
		System.calculateScore(linesComplete)
	end
end

-- Stores a tetrino into the Board.board matrix
function Board.storeTetrino(tetrinoType, rotation, x, y)
	currentTetrino = getTetrino(tetrinoType, rotation, x, y)
	for i = 1, 4 do
		Board.board[currentTetrino[i][2] + 1][currentTetrino[i][1] + 1] = tetrinoType
	end
	Board.checkLines()
end

-- Checks if a tetrino can be moved in a certain direction
function Board.checkPositioning(tetrinoType, rotation, x, y, action)
	currentTetrino = getTetrino(tetrinoType, rotation, x, y)
	local validity = true
	if action == "moveLeft" then
		for i = 1, 4 do
			if currentTetrino[i][1] <= 0 or Board.board[currentTetrino[i][2] + 1][currentTetrino[i][1]] ~= 0 then
				validity = false
			end
		end
	elseif action == "swingLeft" then
		for i = 1, 4 do
			if currentTetrino[i][1] < 0 or Board.board[currentTetrino[i][2] + 1][currentTetrino[i][1] + 1] ~= 0 then
				validity = false
			end
		end
	elseif action == "swingRight" then
		for i = 1, 4 do
			if currentTetrino[i][1] > 9 or Board.board[currentTetrino[i][2] + 1][currentTetrino[i][1] + 1] ~= 0 then
				validity = false
			end
		end
	elseif action == "moveRight" then
		for i = 1, 4 do
			if currentTetrino[i][1] + 1 > 9 or Board.board[currentTetrino[i][2] + 1][currentTetrino[i][1] + 2] ~= 0 then
				validity = false
			end
		end
	elseif action == "moveDown" then
		for i = 1, 4 do
			if currentTetrino[i][2] >= 18 or Board.board[currentTetrino[i][2] + 2][currentTetrino[i][1] + 1] ~= 0 then
				validity = false
			end
		end
	elseif action == "swingDown" then
		for i = 1, 4 do
			if currentTetrino[i][2] > 18 or Board.board[currentTetrino[i][2] + 1][currentTetrino[i][1] + 1] ~= 0 then
				validity = false
			end
		end
	end
	return validity
end

-- Checks if a tetrino could be swung in a set rotation
function Board.checkSwinging(tetrinoType, rotation, x, y)
	if rotation == 270 then
		rotation = 0
	else
		rotation = rotation + 90
	end

	tmpTetrino = currentTetrino -- Holding the old value of the current tetrino
	currentTetrino = getTetrino(tetrinoType, rotation, x, y)
	if Board.checkPositioning(tetrinoType, rotation, x, y, "swingLeft") and Board.checkPositioning(tetrinoType, rotation, x, y, "swingRight") and Board.checkPositioning(tetrinoType, rotation, x, y, "swingDown") then
		currentTetrino = tmpTetrino
		return true
	else
		return false
	end
end

-- Reads the Board.board array and draws it to the window
function Board.drawBoard()
	for col = 2, 19 do
		for row = 1, 10 do
			if Board.board[col][row] ~= 0 then
				tetrinoColors = getTetrinoColor(Board.board[col][row])
				love.graphics.setColor(tetrinoColors[1], tetrinoColors[2], tetrinoColors[3])
				love.graphics.rectangle('fill', 275 + (row * 25) - 25, 0 + (col * 25) - 25, 25, 25)
			end
		end
	end
end

