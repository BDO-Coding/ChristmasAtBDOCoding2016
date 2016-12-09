iceSkating={}
local map -- stores tiledata
local mapWidth, mapHeight -- width and height in tiles
 
local mapX, mapY -- view x,y in tiles. can be a fractional value like 3.25.
 
local tilesDisplayWidth, tilesDisplayHeight -- number of tiles to show
local zoomX, zoomY
 
local tilesetImage
local tileSize -- size of tiles in pixels
local tileQuads = {} -- parts of the tileset used for different tiles
local tilesetSprite

function iceSkating.load()

	airFriction = 0.02 -- -airFrictionPerTick
	redX,redY,redXMomentum,redYMomentum = 1,1,0,0
	blueX,blueY,blueXMomentum,blueYMomentum = 1,1,0,0

	menu.setupMap()
    menu.setupMapView()
    menu.setupTileset()

end

function iceSkating.update(dt)

end

function iceSkating.draw()

	--love.graphics.print("Ice skating is a\nto-be-added feature",screenWidth/12,screenHeight/2,0,5,5)
	love.graphics.draw(images.redEskimo,redX,redY)

end

function UPDATE_ICESKATING(dt)

	iceSkating.update(dt)

end

function DRAW_ICESKATING()

	iceSkating.draw()

end