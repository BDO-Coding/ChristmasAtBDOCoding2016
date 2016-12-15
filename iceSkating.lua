iceSkating={}
require "images"
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

	iceSkating.setupMap()
	iceSkating.setupMapView()
	iceSkating.setupTileset()

	airFriction = 0.02 -- -airFrictionPerTick
	redX,redY,redXMomentum,redYMomentum = 1,1,0,0
	blueX,blueY,blueXMomentum,blueYMomentum = 1,1,0,0

end

function iceSkating.update(dt)

	currentTile = map[(math.floor(mapX+0.5))+9][(math.floor(mapY+0.5))+5]

	for x=1,mapWidth do
		for y=1,mapHeight do
				
			end
		end
	end

	redVelocity = 0.022

	if love.keyboard.isDown("lctrl") then
		redVelocity = 0.025
	end

	if love.keyboard.isDown("w") == true then
		redYMomentum = redYMomentum - redVelocity
	end

	if love.keyboard.isDown("s") == true then
		redYMomentum = redYMomentum + redVelocity
	end

	if love.keyboard.isDown("a") == true then
		redXMomentum = redXMomentum - redVelocity
	end

	if love.keyboard.isDown("d") == true then
		redXMomentum = redXMomentum + redVelocity
	end

end

function iceSkating.hitbox(x1,x2,y1,y2)

	if redX > x1 then
		redX = x1
	end

	if redX < x2 then
		redX = x2
	end

	if redY > y1 then
		redY = y1
	end

	if redY < y2 then
		redY = y2
	end

end

function iceSkating.characterPhysics(dt)

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

	if redY < -30 then
		redY = -30
		if love.keyboard.isDown("w") then
			iceSkating.moveMap(0, -0.2 * tileSize * dt)
		end
	end

	if redX < -30 then
		redX = -30
		if love.keyboard.isDown("a") then
			iceSkating.moveMap(-0.2 * tileSize * dt, 0)
		end
	end

	if redY > images.windowHeight - 30 then
		redY = images.windowHeight - 30
		if love.keyboard.isDown("s") then
			iceSkating.moveMap(0, 0.2 * tileSize * dt)
		end
	end

	if redX > images.windowWidth - 30 then
		redX = images.windowWidth - 30
		if love.keyboard.isDown("d") then
			iceSkating.moveMap(0.2 * tileSize * dt, 0)
		end
	end

end

function iceSkating.draw()

	love.graphics.draw(tilesetBatch, math.floor(-zoomX*(mapX%1)*tileSize), math.floor(-zoomY*(mapY%1)*tileSize), 0, zoomX, zoomY)
	love.graphics.draw(images.redEskimoIce,redX,redY)

end

function iceSkating.setupMap()

	mapWidth = 100
	mapHeight = 100

	map = {}
	for x=1,mapWidth do
		map[x] = {}
		for y=1,mapHeight do
			if x == 1 then
				map[x][y] = 1
			elseif map[x-1][y] == 1 then
				map[x][y] = 2
			elseif map[x-1][y] ~= 0 then
				map[x][y] = 1
			else
				map[x][y] = 0
			end
			createSnow = love.math.random(1, 200)
			if createSnow == 1 then
				map[x][y] = 0
			end
		end
	end

end
 
function iceSkating.setupMapView()

	mapX = 1
	mapY = 1

	tilesDisplayWidth = 60
	tilesDisplayHeight = 35

	zoomX = 1
	zoomY = 1

end
 
function iceSkating.setupTileset()

	tilesetImage = love.graphics.newImage("images/tileset.png")
	tilesetImage:setFilter("nearest", "linear") -- this "linear filter" removes some artifacts if we were to scale the tiles
	tileSize = 32

	tileQuads[0] = love.graphics.newQuad(1 * tileSize, 0 * tileSize, tileSize, tileSize, tilesetImage:getWidth(), tilesetImage:getHeight())
	tileQuads[1] = love.graphics.newQuad(4 * tileSize, 0 * tileSize, tileSize, tileSize, tilesetImage:getWidth(), tilesetImage:getHeight())
	tileQuads[2] = love.graphics.newQuad(5 * tileSize, 0 * tileSize, tileSize, tileSize, tilesetImage:getWidth(), tilesetImage:getHeight())

	tilesetBatch = love.graphics.newSpriteBatch(tilesetImage, tilesDisplayWidth * tilesDisplayHeight)

	iceSkating.updateTilesetBatch()

end
 
function iceSkating.updateTilesetBatch()

	tilesetBatch:clear()
	for x=0, tilesDisplayWidth-1 do
		for y=0, tilesDisplayHeight-1 do
			tilesetBatch:add(tileQuads[map[x+math.floor(mapX)][y+math.floor(mapY)]], x*tileSize, y*tileSize)
		end
	end
	tilesetBatch:flush()

end

function iceSkating.moveMap(dx, dy)

	oldMapX = mapX
	oldMapY = mapY
	mapX = math.max(math.min(mapX + dx, mapWidth - tilesDisplayWidth), 1)
	mapY = math.max(math.min(mapY + dy, mapHeight - tilesDisplayHeight), 1)
	if math.floor(mapX) ~= math.floor(oldMapX) or math.floor(mapY) ~= math.floor(oldMapY) then
		iceSkating.updateTilesetBatch()
	end

end

function UPDATE_ICESKATING(dt)

	iceSkating.update(dt)
	iceSkating.characterPhysics(dt)

end

function DRAW_ICESKATING()

	iceSkating.draw()

end