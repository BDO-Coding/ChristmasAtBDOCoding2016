images={}

function images.load ()

	images.windowWidth,images.windowHeight = love.graphics.getDimensions()
	images.snowball = love.graphics.newImage("images/snowball.png")
	images.snowman = love.graphics.newImage("images/snowman.png")
	images.title = love.graphics.newImage("images/title.png")

end

function UPDATE_IMAGES(dt)

	images.windowWidth,images.windowHeight = love.graphics.getDimensions() -- gets window dimensions

end