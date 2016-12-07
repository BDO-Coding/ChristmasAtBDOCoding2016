menu={}
require "images"

function menu.load ()

	snowballX, snowballY, snowballBounceX, snowballBounceY = 1,1,1,1

end

function menu.draw()

	love.graphics.draw(images.snowball,snowballX,snowballY,0.25,0.25)

end

function UPDATE_MENU(dt)

	if snowballBounceX == 1 then
		snowballX = snowballX + 1
	else
		snowballX = snowballX - 1
	end

	if snowballBounceY == 1 then
		snowballY = snowballY + 1
	else
		snowballY = snowballY - 1
	end

	if snowballX>images.windowWidth or snowballX < 1 then
		if snowballBounceX == 1 then
			snowballBounceX = 0
		else
			snowballBounceX = 1
		end
	end

	if snowballY>images.windowHeight or snowballY < 1 then
		if snowballBounceY == 1 then
			snowballBounceY = 0
		else
			snowballBounceY = 1
		end
	end

end

function DRAW_MENU()

	menu.draw()

end