images={}

function images.load ()

	images.windowWidth,images.windowHeight = love.graphics.getDimensions()

	images.snowball = love.graphics.newImage("images/snowball.png")
	images.rock = love.graphics.newImage("images/rock.png")
	images.redEskimoFight = love.graphics.newImage("images/redEskimoFight.png")
	images.redEskimoSnow = love.graphics.newImage("images/redEskimoSnowman.png")
	images.redEskimoIce = love.graphics.newImage("images/redEskimoIce.png")
	images.blueEskimoFight = love.graphics.newImage("images/blueEskimoFight.png")
	images.blueEskimoSnow = love.graphics.newImage("images/blueEskimoSnowman.png")
	images.blueEskimoIce = love.graphics.newImage("images/blueEskimoIce.png")
	images.snowman = love.graphics.newImage("images/snowman.png")
	images.title = love.graphics.newImage("images/title.png")
	images.barricade = love.graphics.newImage("images/barricade.png")
	images.pointer = love.graphics.newImage("images/pointer.png")

end

function images.showhitbox(x,y,sizex,sizey)

	love.graphics.rectangle("line", x, y, sizex, sizey)

end

function UPDATE_IMAGES(dt)

	images.windowWidth,images.windowHeight = love.graphics.getDimensions() -- gets window dimensions

end