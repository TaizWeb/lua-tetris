System = {
	level = 1,
	score = 0,
	lines = 0
}

-- reset: Set values back to start
function System.reset()
	System.level = 1
	System.score = 0
	System.lines = 0
end

function System.getLevel()
	return System.level
end

function System.getScore()
	return System.score
end

function System.addScore(score)
	System.score = System.score + score
end

function System.getLines()
	return System.lines
end

function System.addLines(lines)
	System.lines = System.lines + lines
	if System.lines / 10 >= 1 then
		System.level = math.floor(System.lines / 10)
	end
end

function System.calculateScore(lines)
	if lines == 1 then
		System.addScore(100 * System.getLevel())
	elseif lines == 2 then
		System.addScore(300 * System.getLevel())
	elseif lines == 3 then
		System.addScore(500 * System.getLevel())
	elseif lines == 4 then
		System.addScore(800 * System.getLevel())
	end

	System.addLines(lines)
end

