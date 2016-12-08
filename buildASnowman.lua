buildASnowman={}

function buildASnowman.load()

end

function buildASnowman.update(dt)

end

function buildASnowman.draw()

	love.graphics.print("Build a snowman is a\nto-be-added feature",screenWidth/12,screenHeight/2,0,5,5)

end

function UPDATE_BUILDASNOWMAN(dt)

	buildASnowman.update(dt)

end

function DRAW_BUILDASNOWMAN()

	buildASnowman.draw()

end