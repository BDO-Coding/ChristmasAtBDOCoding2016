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

	createRockArray = true
	airFriction = 0.02 -- -airFrictionPerTick
	redX,redY,redXMomentum,redYMomentum = 1,1,0,0
	blueX,blueY,blueXMomentum,blueYMomentum = 1,1,0,0

end

function iceSkating.hitbox(x,y,sizex,sizey)

	if redX > x-60 and redX < x+sizex and redY > y-60 and redY < y+sizey then
		if redDirect == "left" then
			redX = x+sizex
		elseif redDirect == "right" then
			redX = x-60
		elseif redDirect == "up" then
			redY = y+sizey
		elseif redDirect == "down" then
			redY = y-60
		end
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

function iceSkating.rock()

	if createRockArray == true then
		rockArray = {{}}
		rockArray[1] = {love.math.random(100, 2000), love.math.random(100, 2000)}
		for i=1, 30 do
			rockArray[#rockArray + 1] = {love.math.random(100, 2000), love.math.random(100, 2000)}
		end
		createRockArray = false
	else
		for i=1, 30 do
			iceSkating.hitbox(math.floor((mapX)*-64)+rockArray[i][1], math.floor((mapY)*-64)+rockArray[i][2], 100, 100)
		end
	end

end

function iceSkating.update(dt)

	redVelocity = 0.022

	if love.keyboard.isDown("w") == true then
		redYMomentum = redYMomentum - redVelocity
		redDirect = "up"
	end

	if love.keyboard.isDown("s") == true then
		redYMomentum = redYMomentum + redVelocity
		redDirect = "down"
	end

	if love.keyboard.isDown("a") == true then
		redXMomentum = redXMomentum - redVelocity
		redDirect = "left"
	end

	if love.keyboard.isDown("d") == true then
		redXMomentum = redXMomentum + redVelocity
		redDirect = "right"
	end

end

function iceSkating.draw()

	love.graphics.draw(tilesetBatch, math.floor(-zoomX*(mapX%1)*tileSize), math.floor(-zoomY*(mapY%1)*tileSize), 0, zoomX, zoomY)
	love.graphics.draw(images.redEskimoIce,redX,redY)
	if createRockArray == false then
		for i=1, 30 do
			images.showhitbox(math.floor((mapX)*-64)+rockArray[i][1], math.floor((mapY)*-64)+rockArray[i][2], 100, 100)
		end
	end

end

function UPDATE_ICESKATING(dt)

	iceSkating.update(dt)
	iceSkating.characterPhysics(dt)
	iceSkating.rock()

end

function DRAW_ICESKATING()

	iceSkating.draw()

end