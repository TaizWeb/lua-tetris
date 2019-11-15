-- TODO: Make functions into a library? Accessing data rather than computing it is faster
function getTetrino(tetrinoType, rotation, x, y, isGhost)
	--[[
		1 - 'L' shape
		2 - backwards 'L' shape
		3 - '|' shape
		4 - cube shape
		5 - 'z' shape
		6 - backwards 'z' shape
		7 - '+' with 3 tendrils shape
	--]]
	if isGhost then
		alpha = 150
	else
		alpha = 255
	end

	if tetrinoType == 1 then
		love.graphics.setColor(255, 165, 0, alpha)
		if rotation == 0 then
			return {{x, y}, {x - 1, y}, {x - 1, y + 1}, {x + 1, y}}
		elseif rotation == 90 then
			return {{x, y}, {x, y - 1}, {x, y + 1}, {x - 1, y - 1}}
		elseif rotation == 180 then
			return {{x, y}, {x + 1, y}, {x - 1, y}, {x + 1, y - 1}}
		elseif rotation == 270 then
			return {{x, y}, {x, y - 1}, {x, y + 1}, {x + 1, y + 1}}
		end
	elseif tetrinoType == 2 then
		love.graphics.setColor(0, 0, 255, alpha)
		if rotation == 0 then
			return {{x, y}, {x + 1, y}, {x - 1, y}, {x + 1, y + 1}}
		elseif rotation == 90 then
			return {{x, y}, {x, y + 1}, {x, y - 1}, {x - 1, y + 1}}
		elseif rotation == 180 then
			return {{x, y}, {x - 1, y}, {x + 1, y}, {x - 1, y - 1}}
		elseif rotation == 270 then
			return {{x, y}, {x, y - 1}, {x, y + 1}, {x + 1, y - 1}}
		end
	elseif tetrinoType == 3 then
		love.graphics.setColor(112, 163, 24, alpha)
		if rotation == 0 or rotation == 180 then
			return {{x, y}, {x + 1, y}, {x + 1 * 2, y}, {x + 1 * 3, y}}
		elseif rotation == 90 or rotation == 270 then
			return {{x, y}, {x, y + 1}, {x, y + 1 * 2}, {x, y + 1 * 3}}
		end
	elseif tetrinoType == 4 then
		love.graphics.setColor(255, 255, 0, alpha)
		return {{x, y}, {x, y + 1}, {x + 1, y}, {x + 1, y + 1}}
	elseif tetrinoType == 5 then
		love.graphics.setColor{255, 0, 0, alpha}
		if rotation == 0 then
			return {{x, y}, {x + 1, y + 1}, {x, y + 1}, {x - 1, y}}
		elseif rotation == 90 then
			return {{x, y}, {x, y - 1}, {x - 1, y}, {x - 1, y + 1}}
		elseif rotation == 180 then
			return {{x, y}, {x + 1, y}, {x, y - 1}, {x - 1, y - 1}}
		elseif rotation == 270 then
			return {{x, y}, {x, y + 1}, {x + 1, y - 1}, {x + 1, y}}
		end
	elseif tetrinoType == 6 then
		love.graphics.setColor(0, 255, 0, alpha)
		if rotation == 0 then
			return {{x, y}, {x - 1, y + 1}, {x, y + 1}, {x + 1, y}}
		elseif rotation == 90 then
			return {{x, y}, {x, y + 1}, {x - 1, y}, {x - 1, y - 1}}
		elseif rotation == 180 then
			return {{x, y}, {x - 1, y}, {x, y - 1}, {x + 1, y - 1}}
		elseif rotation == 270 then
			return {{x, y}, {x, y - 1}, {x + 1, y + 1}, {x + 1, y}}
		end
	elseif tetrinoType == 7 then
		love.graphics.setColor(128, 0, 128, alpha)
		if rotation == 0 then
			return {{x, y}, {x + 1, y}, {x, y + 1}, {x - 1, y}}
		elseif rotation == 90 then
			return {{x, y}, {x, y - 1}, {x, y + 1}, {x - 1, y}}
		elseif rotation == 180 then
			return {{x, y}, {x + 1, y}, {x - 1, y}, {x, y - 1}}
		elseif rotation == 270 then
			return {{x, y}, {x, y - 1}, {x, y + 1}, {x + 1, y}}
		end
	end
end

function getTetrinoColor(tetrinoType)
	if tetrinoType == 1 then
		return {255, 165, 0}
	elseif tetrinoType == 2 then
		return {0, 0, 255}
	elseif tetrinoType == 3 then
		return {112, 163, 24}
	elseif tetrinoType == 4 then
		return {255, 255, 0}
	elseif tetrinoType == 5 then
		return {255, 0, 0}
	elseif tetrinoType == 6 then
		return {0, 255, 0}
	elseif tetrinoType == 7 then
		return {128, 0, 128}
	end
end

