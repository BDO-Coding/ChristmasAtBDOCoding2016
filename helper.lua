helper = {}

function helper.load(DIC)

	objectArray = {{}}
	objectModel = {"mode","x","y","width","height","image","xVel","yVel","rotation","rotationalVel"}
	feedbackArray = {{}}
	feedbackArray[1] = {"Helper Initiated","Use the scrollwheel to see more feedback."}


	objectNum = 0
	feedbackNum = 1
	selectedFeedback = feedbackNum
	lineSpacing = 20
	imageCropping = DIC
	airFriction = 0.001

end

function helper.feedback()

	while selectedFeedback < 1 do
		selectedFeedback = selectedFeedback + 1
	end

	while selectedFeedback > feedbackNum do
		selectedFeedback = selectedFeedback - 1
	end

	love.graphics.print(selectedFeedback.."/"..feedbackNum,1,1)
	lineNum = 1
	love.graphics.print(feedbackArray[selectedFeedback][1],1,lineNum*lineSpacing)
	lineNum = lineNum + 1
	love.graphics.print(feedbackArray[selectedFeedback][2],1,lineNum*lineSpacing)

end

function helper.track(objectID)

	if objectNum > 0 then
		for i=1,5 do
			printData = objectArray[objectID][i]
			love.graphics.print(objectModel[i].."="..printData,600,i*lineSpacing)
		end
		for i=7,#objectModel do
			printData = objectArray[objectID][i]
			love.graphics.print(objectModel[i].."="..printData,600,(i*lineSpacing)-lineSpacing)
		end
	end

end

function helper.addFeedback(primary,secondary)

	feedbackArray[feedbackNum+1] = {primary,secondary}
	feedbackNum = feedbackNum+1

end

function love.wheelmoved(x,y)

    if y > 0 then
        selectedFeedback = selectedFeedback - 1
    elseif y < 0 then
        selectedFeedback = selectedFeedback + 1
    end

end

function helper.newObject(type,x,y,xSize,ySize,image,rotation)

	objectArray[objectNum+1] = {type,x,y,xSize,ySize,image,0,0,rotation,0}
	objectArray[objectNum+1][6]:setFilter("nearest","nearest")
	objectNum = objectNum+1
	helper.addFeedback("A "..type.." object has been added to the object list at number "..objectNum..".","Height,width,x and y position are as follows: "..ySize..", "..xSize..", "..x..", "..y..".")
	if not imageCropping == false then
		helper.adjustObjectDimensions(objectNum)
	end

end

function helper.drawHitboxes()

	for i=1, objectNum do
		love.graphics.push()
		love.graphics.translate(objectArray[i][2],objectArray[i][3])
		love.graphics.rotate((objectArray[i][9]*math.pi)/180)
		love.graphics.translate(-objectArray[i][2], -objectArray[i][3])
		love.graphics.setColor(0xff, 0xff, 0xff)
		love.graphics.rectangle('line', objectArray[i][2], objectArray[i][3], objectArray[i][4],objectArray[i][5])
		love.graphics.pop()
	end

end

function helper.adjustObjectDimensions(objectID)

		if objectArray[objectID][1] == "image" then
			xSize,ySize = objectArray[objectID][6]:getDimensions()
			xScale,yScale = objectArray[objectID][4]/xSize,objectArray[objectID][5]/ySize
		if xScale < yScale then
			scale = xScale
			prevHeight = objectArray[objectID][5]
			objectArray[objectID][5] = ySize*xScale
			helper.addFeedback("Image object number "..objectID.." did not have perfectly scaled width and heights and so these values were slightly altered.","The height of the object has been reduced by "..prevHeight-objectArray[objectID][5].." to "..objectArray[objectID][5]..". This is so the its hitbox fits exactly to the image size!")
		else
			if xScale > yScale then
				scale = yScale
				prevWidth = objectArray[objectID][4]
				objectArray[objectID][4] = xSize*yScale
				helper.addFeedback("Image object number "..objectID.." did not have perfectly scaled width and heights and so these values were slightly altered.","The width of the object has been reduced by "..prevWidth-objectArray[objectID][4].." to "..objectArray[objectID][4]..". This is so the its hitbox fits exactly to the image size!")
			else
				helper.addFeedback("Well done! Image object number "..objectID.." has perfectly scaled width and heights!","This means they will not have been altered and are exactly as you entered them.")
			end
		end	
	end

end

function helper.drawObjects()

	for i=1, objectNum do
		if objectArray[i][1] == "image" then
			xSize,ySize = objectArray[i][6]:getDimensions()
			xScale,yScale = objectArray[i][4]/xSize,objectArray[i][5]/ySize

			if xScale < yScale then
				scale = xScale
			else
				scale = yScale
			end

			love.graphics.draw(objectArray[i][6],objectArray[i][2]+xSize*(scale/2),objectArray[i][3]+ySize*(scale/2),math.rad(objectArray[i][9]),scale,scale,xSize/2,ySize/2)
		end
		if objectArray[i][1] == "rectangle" then
			love.graphics.rectangle("fill",objectArray[i][2],objectArray[i][3],objectArray[i][4],objectArray[i][5])
		end
	end

end

function helper.movement(objectID,mode,x,y,speed)

	if mode == "move" then
		helper.move(objectID,x,y)
	end

	if mode == "accelerate" then
		helper.accelerate(objectID,x,y,speed)
	end

	if mode == "rotationalVelocity" then
		objectArray[objectID][10] = objectArray[objectID][10] + speed
	end

end

function helper.move(objectID,x,y)

	objectArray[objectID][2] = objectArray[objectID][2] + x
	objectArray[objectID][3] = objectArray[objectID][3] + y

end

function helper.accelerate(objectID,x,y,speed)

	objectArray[objectID][7] = objectArray[objectID][7] + x*speed
	objectArray[objectID][8] = objectArray[objectID][8] + y*speed

end

function helper.applyVelocities()

	for i=1, objectNum do
		helper.move(i,objectArray[i][7],objectArray[i][8])
		helper.rotate(i,objectArray[i][10])
	end

end

function helper.rotate(objectID,degrees)

	objectArray[objectID][9] = objectArray[objectID][9] + degrees
	if objectArray[objectID][9] > 360 then
		objectArray[objectID][9] = 0
	else
		if objectArray[objectID][9] < 0 then
	 		objectArray[objectID][9] = 360
		end
	end

end

function helper.draw()

	helper.drawObjects()
	helper.drawHitboxes()
	helper.feedback()

end

function helper.update()

	helper.applyVelocities()
	helper.applyFriction()

end

function helper.get(objectID)

	return objectArray[objectID]

end

function helper.checkCollision(object1,object2)

	if objectArray[object1][9] == 0 and objectArray[object2][9] == 0 then
		if objectArray[object2][2] < objectArray[object1][2] + objectArray[object1][4] and objectArray[object2][2] > objectArray[object1][2] - objectArray[object2][4] then
			if objectArray[object2][3] < objectArray[object1][3] + objectArray[object1][5] and objectArray[object2][3] > objectArray[object1][3] - objectArray[object2][5] then
				return true
			end
		end
	end

end

function helper.setAirFriction(friction)

	airFriction = friction

end

function helper.applyFriction()

	for i=1, objectNum do
		if objectArray[i][7] ~= 0 then
			if objectArray[i][7] > 0 then
				objectArray[i][7] = objectArray[i][7] - airFriction
			else
				objectArray[i][7] = objectArray[i][7] + airFriction
			end
		end

		if objectArray[i][8] ~= 0 then
			if objectArray[i][8] > 0 then
				objectArray[i][8] = objectArray[i][8] - airFriction
			else
				objectArray[i][8] = objectArray[i][8] + airFriction
			end
		end
	end

end