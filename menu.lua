menu={}
require "images"

function menu.load ()

	snowballNum = 100
	snowballMinSpeed = 1 -- in km/hour
	snowballMaxSpeed = 10 -- in km/hour

	framesINANhour = love.timer.getFPS()*3600
	pixelsINAKM = 3703703.7037

	speedModifier = pixelsINAKM*framesINANhour --converts km/hour to pixels/frame

	snowballArray = {{}}

	for i=1, snowballNum do
		snowballArray[i] = {math.random(1,images.windowWidth),math.random(1,images.windowHeight),1,1,math.random(snowballMinSpeed,snowballMaxSpeed),math.random(snowballMinSpeed,snowballMaxSpeed),0.25} --snowballX, snowballY, snowballBounceX, snowballBounceY, speedX, speedY, size
	end

end

function menu.draw()

	for i=1, snowballNum do
		love.graphics.draw(images.snowball,snowballArray[i][1],snowballArray[i][2],snowballArray[i][7],snowballArray[i][7])
	end

end

function UPDATE_MENU(dt)

snowballPhysics()

end

function DRAW_MENU()

	menu.draw()

end

function snowballPhysics()

	--[[	framesINANhour = love.timer.getFPS()*3600
	pixelsINAKM = 3703703.7037

	speedModifier = pixelsINAKM*framesINANhour --converts km/hour to pixels/frame]]

	for i=1, snowballNum do
		if snowballArray[i][3] == 1 then
			snowballArray[i][1] = snowballArray[i][1] + snowballArray[i][5]
		else
			snowballArray[i][1] = snowballArray[i][1] - snowballArray[i][5]
		end

		if snowballArray[i][4] == 1 then
			snowballArray[i][2] = snowballArray[i][2] + snowballArray[i][6]
		else
			snowballArray[i][2] = snowballArray[i][2] - snowballArray[i][6]
		end

		if snowballArray[i][1]>images.windowWidth or snowballArray[i][1] < 1 then
			if snowballArray[i][3] == 1 then
				snowballArray[i][3] = 0
			else
				snowballArray[i][3] = 1
			end
		end

		if snowballArray[i][2]>images.windowHeight or snowballArray[i][2] < 1 then
			if snowballArray[i][4] == 1 then
				snowballArray[i][4] = 0
			else
				snowballArray[i][4] = 1
			end
		end
	end
end