iceSkating={}

function iceSkating.load()

end

function iceSkating.update(dt)

end

function iceSkating.draw()

	love.graphics.print("Ice skating is a\nto-be-added feature",screenWidth/12,screenHeight/2,0,5,5)

end

function UPDATE_ICESKATING(dt)

	iceSkating.update(dt)

end

function DRAW_ICESKATING()

	iceSkating.draw()

end