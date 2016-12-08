snowballFight={}
require "images"

function snowballFight.load ()

	snowballNum = 1
	snowballMinSpeed = 50 -- in km/hour
	snowballMaxSpeed = 50 -- in km/hour
	airFriction = 0.02 -- -airFrictionPerTick

	redX,redY,redXMomentum,redYMomentum = 1,1,0,0


	snowballArray = {{}}

	for i=1, snowballNum do
		snowballArray[i] = {math.random(1,images.windowWidth),math.random(1,images.windowHeight),1,1,math.random(snowballMinSpeed,snowballMaxSpeed),math.random(snowballMinSpeed,snowballMaxSpeed),0.25,100,true} --snowballX, snowballY, snowballBounceX, snowballBounceY, speedX, speedY, size, despawnTimer,active
	end

end

function snowballFight.draw()

	for i=1, snowballNum do
		if snowballArray[i][9] == true then
			love.graphics.draw(images.snowball,snowballArray[i][1],snowballArray[i][2],snowballArray[i][7],snowballArray[i][7])
		end
	end
		love.graphics.draw(images.redEskimo,redX,redY)

end

function UPDATE_SNOWBALLFIGHT(dt)

	redY,redX = redY + redYMomentum, redX + redXMomentum

	if redYMomentum > 0 then
		redYMomentum = redYMomentum - airFriction*2
	end

	if redXMomentum > 0 then
		redXMomentum = redXMomentum - airFriction*2
	end

	if redYMomentum < 0 then
		redYMomentum = redYMomentum + airFriction*2
	end
	
	if redXMomentum < 0 then
		redXMomentum = redXMomentum + airFriction*2
	end

	snowballPhysics()
	characterMovement()
	if love.mouse.isDown(1) == true then
		addSnowball(1,1,1,1,math.random(10,50),math.random(10,50))
	end

end

function DRAW_SNOWBALLFIGHT()

	snowballFight.draw()

end

function snowballPhysics()

	for i=1, snowballNum do
		if snowballArray[i][9] == true then
			--DO AIR FRICTION
			if snowballArray[i][5] > 0 then
				snowballArray[i][5] = snowballArray[i][5] - airFriction
			else
				snowballArray[i][5] = snowballArray[i][5] + airFriction
			end

			if snowballArray[i][6] > 0 then
				snowballArray[i][6] = snowballArray[i][6] - airFriction
			else
				snowballArray[i][6] = snowballArray[i][6] + airFriction
			end

			--DO MOVEMENT

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


			--DO BOUNCING

			if snowballArray[i][1]>images.windowWidth or snowballArray[i][1] < 1 then
				bounceSnowball(i,"x")
			end

			if snowballArray[i][2]>images.windowHeight or snowballArray[i][2] < 1 then
				bounceSnowball(i,"y")
			end

			--KILL STOPPED SNOWBALLS

			if snowballArray[i][5] < 1 and snowballArray[i][6] < 1 then
				snowballArray[i][8] = snowballArray[i][8] - 1
				if snowballArray[i][8] < 0 then
					snowballArray[i][9] = false
				end
			end
		end
	end
end

function addSnowball(x,y,bounceX,bounceY,xChange,yChange)


	snowballArray[snowballNum+1] = {x,y,bounceX,bounceY,xChange,yChange,0.25,1000,true}
	snowballNum = snowballNum + 1

end

function bounceSnowball(snowballID,bounceType)

	if bounceType == "x" then
			if snowballArray[snowballID][3] == 1 then
				snowballArray[snowballID][3] = 0
			else
				snowballArray[snowballID][3] = 1
			end
		end

		if bounceType == "y" then
			if snowballArray[snowballID][4] == 1 then
				snowballArray[snowballID][4] = 0
			else
				snowballArray[snowballID][4] = 1
			end
		end

end

function characterMovement()

if love.keyboard.isDown("w") == true then
	redYMomentum = redYMomentum - 0.05
end

if love.keyboard.isDown("s") == true then
	redYMomentum = redYMomentum + 0.05
end

if love.keyboard.isDown("a") == true then
	redXMomentum = redXMomentum - 0.05
end

if love.keyboard.isDown("d") == true then
	redXMomentum = redXMomentum + 0.05
end

end