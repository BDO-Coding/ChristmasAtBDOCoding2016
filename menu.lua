menu={}
require "images"

function menu.load ()

	snowballNum = 10

	snowballArray = {{}}

	for i=1, snowballNum do
		snowballArray[i] = {math.random(1,images.windowWidth),math.random(1,images.windowHeight),1,1,math.random(0.5,3),math.random(0.5,3),0.25} --snowballX, snowballY, snowballBounceX, snowballBounceY, speedX, speedY, size
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