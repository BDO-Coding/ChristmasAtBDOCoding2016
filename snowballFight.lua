snowballFight={}
require "images"

function snowballFight.load ()

	love.graphics.setBackgroundColor(192,223,235)

	snowballNum = 1
	snowballMinSpeed = 50 -- in km/hour
	snowballMaxSpeed = 50 -- in km/hour
	airFriction = 0.02 -- -airFrictionPerTick
	redX,redY,redXMomentum,redYMomentum = 1,1,0,0
	blueX,blueY,blueXMomentum,blueYMomentum = 1,1,0,0

	snowballArray = {{}}
	barricadeArray = {{}}

	for i=1, snowballNum do
		snowballArray[i] = {math.random(1,images.windowWidth),math.random(1,images.windowHeight),1,1,math.random(snowballMinSpeed,snowballMaxSpeed),math.random(snowballMinSpeed,snowballMaxSpeed),0.25,100,true,3} --snowballX, snowballY, snowballBounceX, snowballBounceY, speedX, speedY, size, despawnTimer,active,team 0=red 1= blue 3 = neutral
	end

	for i=1, 3 do
		barricadeArray[i] = {math.random(1,images.windowWidth),math.random(1,images.windowHeight),0} --X,Y,team
	end

end
 
function snowballFight.draw()

	for i=1, snowballNum do
		if snowballArray[i][9] == true then	
			if developerMode == true then --Shows hitboxes
				images.showhitbox(snowballArray[i][1], snowballArray[i][2]+3, 12, 12)
			end
			love.graphics.draw(images.snowball,snowballArray[i][1],snowballArray[i][2],snowballArray[i][7],snowballArray[i][7])
		end
	end
	if developerMode == true then --Shows hitboxes
		images.showhitbox(redX+10, redY+12, 42, 52)
		images.showhitbox(blueX+10, blueY+12, 42, 52)
	end


	for i=1, 3 do
		love.graphics.draw(images.barricade,barricadeArray[i][1],barricadeArray[i][2])
		if developerMode == true then
			images.showhitbox(barricadeArray[i][1]+24, barricadeArray[i][2], 20, 60)
		end
	end
		love.graphics.draw(images.redEskimoFight,redX,redY)
		love.graphics.draw(images.blueEskimoFight,blueX,blueY)

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

			for a=1, 3 do
				if snowballArray[i][1]>barricadeArray[a][1]+24 and snowballArray[i][1] < barricadeArray[a][1]+44 then
					if snowballArray[i][2]>barricadeArray[a][2] and snowballArray[i][2] < barricadeArray[a][2]+60 then
						bounceSnowball(i,"x")
					end
				end
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

	snowballArray[snowballNum+1] = {x,y,bounceX,bounceY,xChange,yChange,0.25,1000,true,0}
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

	redVelocity = 0.022

	if love.keyboard.isDown("lctrl") then
		redVelocity = 0.025
	end

	if love.keyboard.isDown("e") == true then
		redYMomentum = redYMomentum - redVelocity
	end

	if love.keyboard.isDown("d") == true then
		redYMomentum = redYMomentum + redVelocity
	end

	if love.keyboard.isDown("s") == true then
		redXMomentum = redXMomentum - redVelocity
	end

	if love.keyboard.isDown("f") == true then
		redXMomentum = redXMomentum + redVelocity
	end


	blueVelocity = 0.022

	if love.keyboard.isDown("lctrl") then
		blueVelocity = 0.025
	end

	if love.keyboard.isDown("up") == true then
		blueYMomentum = blueYMomentum - blueVelocity
	end

	if love.keyboard.isDown("down") == true then
		blueYMomentum = blueYMomentum + blueVelocity
	end

	if love.keyboard.isDown("left") == true then
		blueXMomentum = blueXMomentum - blueVelocity
	end

	if love.keyboard.isDown("right") == true then
		blueXMomentum = blueXMomentum + blueVelocity
	end

	if love.keyboard.isDown("return") == true then
		blueXMomentum = blueXMomentum + blueVelocity
	end

end

function characterPhysics()

	redY,redX = redY + redYMomentum, redX + redXMomentum

	if redYMomentum > 0 then
		redYMomentum = redYMomentum - airFriction
	end

	if redXMomentum > 0 then
		redXMomentum = redXMomentum - airFriction
	end

	if redYMomentum < 0 then
		redYMomentum = redYMomentum + airFriction
	end
	
	if redXMomentum < 0 then
		redXMomentum = redXMomentum + airFriction
	end

	for i = 1, snowballNum do
		if snowballArray[i][9] == true then
			if redX < snowballArray[i][1]-10 and redX > snowballArray[i][1]-40 and redY > snowballArray[i][2]-73 and redY < snowballArray[i][2]+16 then
				if snowballArray[i][10] ~= 0 then
					snowballArray[i][9] = false
				else
					bounceSnowball(i,"x")
					bounceSnowball(i,"y")
				end
			end
		end
	end

	blueY,blueX = blueY + blueYMomentum, blueX + blueXMomentum

	if blueYMomentum > 0 then
		blueYMomentum = blueYMomentum - airFriction
	end

	if blueXMomentum > 0 then
		blueXMomentum = blueXMomentum - airFriction
	end

	if blueYMomentum < 0 then
		blueYMomentum = blueYMomentum + airFriction
	end
	
	if blueXMomentum < 0 then
		blueXMomentum = blueXMomentum + airFriction
	end

	for i = 1, snowballNum do
		if snowballArray[i][9] == true then
			if blueX < snowballArray[i][1]-10 and blueX > snowballArray[i][1]-40 and blueY > snowballArray[i][2]-73 and blueY < snowballArray[i][2]+16 then
				if snowballArray[i][10] ~= 0 then
					snowballArray[i][9] = false
				else
					bounceSnowball(i,"x")
					bounceSnowball(i,"y")
				end
			end
		end
	end


end

function UPDATE_SNOWBALLFIGHT(dt)

	characterPhysics()
	snowballPhysics()
	characterMovement()
	if love.mouse.isDown(1) == true then
		addSnowball(1,1,1,1,math.random(10,100),math.random(10,100))
	end

end

function DRAW_SNOWBALLFIGHT()

	snowballFight.draw()

end

function love.keypressed(key)

	if key == "q" then
		addSnowball(redX,redY,1,1,-100,0)
	end

	if key == "m" then
		addSnowball(blueX,blueY,1,1,100,0)
	end

end