images={}

function images.load ()


	images.snowball = love.graphics.newImage("images/snowball.png")

end

function images.draw()



end

function UPDATE_IMAGES(dt)

	images.windowWidth,images.windowHeight = love.graphics.getDimensions() -- gets window dimensions

end

function DRAW_IMAGES()

	images.draw()

end