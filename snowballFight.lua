snowballFight={}
require "images"

function snowballFight.load ()

	snowballNum = 1
	snowballMinSpeed = 50 -- in km/hour
	snowballMaxSpeed = 50 -- in km/hour


	snowballArray = {{}}

	for i=1, snowballNum do
		snowballArray[i] = {math.random(1,images.windowWidth),math.random(1,images.windowHeight),1,1,math.random(snowballMinSpeed,snowballMaxSpeed),math.random(snowballMinSpeed,snowballMaxSpeed),0.25} --snowballX, snowballY, snowballBounceX, snowballBounceY, speedX, speedY, size
	end

end

function snowballFight.draw()

	for i=1, snowballNum do
		love.graphics.draw(images.snowball,snowballArray[i][1],snowballArray[i][2],snowballArray[i][7],snowballArray[i][7])
	end

end

function UPDATE_SNOWBALLFIGHT(dt)

	snowballPhysics()
	if love.mouse.isDown(1) == true then
		addSnowball(1,1,1,1,math.random(10,50),math.random(10,50))
	end

end

function DRAW_SNOWBALLFIGHT()

	snowballFight.draw()

end

function snowballPhysics()

	for i=1, snowballNum do
		if snowballArray[i][3] == 1 then
			snowballArray[i][1] = snowballArray[i][1] + snowballArray[i][5]/100
		else
			snowballArray[i][1] = snowballArray[i][1] - snowballArray[i][5]/100
		end

		if snowballArray[i][4] == 1 then
			snowballArray[i][2] = snowballArray[i][2] + snowballArray[i][6]/100
		else
			snowballArray[i][2] = snowballArray[i][2] - snowballArray[i][6]/100
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

function addSnowball(x,y,bounceX,bounceY,xChange,yChange)


	snowballArray[snowballNum+1] = {x,y,bounceX,bounceY,xChange,yChange,0.25}
	snowballNum = snowballNum + 1

end