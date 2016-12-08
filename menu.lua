menu = {}
require "snowballFight"
local map -- stores tiledata
local mapWidth, mapHeight -- width and height in tiles
 
local mapX, mapY -- view x,y in tiles. can be a fractional value like 3.25.
 
local tilesDisplayWidth, tilesDisplayHeight -- number of tiles to show
local zoomX, zoomY
 
local tilesetImage
local tileSize -- size of tiles in pixels
local tileQuads = {} -- parts of the tileset used for different tiles
local tilesetSprite

function menu.load()

	r = 0
	g = 200
	b = 255

    options = false
    credits = false
    loading = false

    clickDelay = 0.5
    doThisOnce = true

    mouseX = love.mouse.getX()
    mouseY = love.mouse.getY()

    playerImageSize = 3
    playerImageX = 500

    moveSpeed = 0.001
    moveTime = 0.001
    moveDelay = 20

    menu.setupMap()
    menu.setupMapView()
    menu.setupTileset()

    fps_show = false
    version_show = false
    volume = 50
    seed_show = false
    autoSave = false

    love.keyboard.setKeyRepeat(true)

end

function menu.draw()

    mouseX = love.mouse.getX()
    mouseY = love.mouse.getY()

    if ingame == 0 then

        love.graphics.draw(tilesetBatch, math.floor(-zoomX*(mapX%1)*tileSize), math.floor(-zoomY*(mapY%1)*tileSize), 0, zoomX, zoomY)
        love.graphics.setColor(r, g, b)
        love.graphics.draw(images.title, 30, 0, 0, 2, 2)
  
    end

    if inmenu == true and options == false and ingame == 0 and credits == false then

        if mouseX > 170 and mouseX < 390 and mouseY > 180 and mouseY < 240 then
            love.graphics.setColor(59, 70, 219)
            love.graphics.rectangle("fill", 170, 180, 220, 60)
        else
            love.graphics.setColor(126, 204, 230)
            love.graphics.rectangle("fill", 170, 180, 220, 60)
        end

        if mouseX > 170 and mouseX < 390 and mouseY > 280 and mouseY < 340 then  -- Load button
            love.graphics.setColor(59, 70, 219)
            love.graphics.rectangle("fill", 170, 280, 220, 60)
        else
            love.graphics.setColor(126, 204, 230)
            love.graphics.rectangle("fill", 170, 280, 220, 60)
        end

        if mouseX > 170 and mouseX < 390 and mouseY > 380 and mouseY < 440 then
            love.graphics.setColor(59, 70, 219)
            love.graphics.rectangle("fill", 170, 380, 220, 60)
        else
            love.graphics.setColor(126, 204, 230)
            love.graphics.rectangle("fill", 170, 380, 220, 60)
        end

        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("line", 170, 180, 220, 60)
        love.graphics.rectangle("line", 170, 280, 220, 60)
        love.graphics.rectangle("line", 170, 380, 220, 60)

        love.graphics.print("Play Game", 218, 190, 0, 2, 3)
        love.graphics.print("Options", 232, 290, 0, 2, 3)
        love.graphics.print("Credits", 235, 390, 0, 2, 3)

        love.graphics.setColor(255, 255, 255)
        love.graphics.draw(images.snowman, playerImageX, playerImageX/3, 0, playerImageSize, playerImageSize)

        menu.updateTilesetBatch()
    
    end

    if inmenu == true and options == false and ingame == 1 then

        if mouseX > 500 and mouseX < 720 and mouseY > 150 and mouseY < 210 then
            love.graphics.setColor(59, 70, 219)
            love.graphics.rectangle("fill", 500, 150, 220, 60)
        else
            love.graphics.setColor(126, 204, 230)
            love.graphics.rectangle("fill", 500, 150, 220, 60)
        end

        if mouseX > 500 and mouseX < 720 and mouseY > 250 and mouseY < 310 then
            love.graphics.setColor(59, 70, 219)
            love.graphics.rectangle("fill", 500, 250, 220, 60)
        else
            love.graphics.setColor(126, 204, 230)
            love.graphics.rectangle("fill", 500, 250, 220, 60)
        end

        if mouseX > 500 and mouseX < 720 and mouseY > 350 and mouseY < 410 then
            love.graphics.setColor(59, 70, 219)
            love.graphics.rectangle("fill", 500, 350, 220, 60)
        else
            love.graphics.setColor(126, 204, 230)
            love.graphics.rectangle("fill", 500, 350, 220, 60)
        end

        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("line", 500, 150, 220, 60)
        love.graphics.rectangle("line", 500, 250, 220, 60)
        love.graphics.rectangle("line", 500, 350, 220, 60)

        love.graphics.print("Resume", 562, 160, 0, 2, 3)
        love.graphics.print("Options", 562, 260, 0, 2, 3)
        love.graphics.print("Save", 580, 360, 0, 2, 3)

    end 

    if credits == true then
        love.graphics.setColor(0, 255, 255)
        love.graphics.rectangle("fill", 300, 200, 800, 390, 10)
        love.graphics.setColor(0, 0, 0)
        love.graphics.print("Coded by: \n         Danny Harris and Ori Taylor", 320, 220, 0, 2, 2)
        love.graphics.print("Art by: \n         Danny Harris and Ori Taylor", 320, 300, 0, 2, 2)
        --love.graphics.print("Sound by: \n         Nobody", 320, 380, 0, 2, 2)
        love.graphics.print("Programs used: \n         LÖVE for Lua\n         paint.net\n         Sublime Text", 320, 460, 0, 2, 2)

        if mouseX > 170 and mouseX < 390 and mouseY > 600 and mouseY < 660 then -- Back
            love.graphics.setColor(59, 70, 219)
            love.graphics.rectangle("fill", 170, 600, 220, 60)
        else
            love.graphics.setColor(126, 204, 230)
            love.graphics.rectangle("fill", 170, 600, 220, 60)
        end
    end

end

function menu.setupMap()

    mapWidth = 280
    mapHeight = 220

    map = {}
    for x=1, mapWidth do
        map[x] = {}
        for y=1, mapHeight do
           map[x][y] = love.math.random(0,3)
        end
    end

end
 
function menu.setupMapView()

    mapX = 1
    mapY = 1

    tilesDisplayWidth = 26
    tilesDisplayHeight = 26

    zoomX = 2
    zoomY = 2

end

function menu.setupTileset()

    tilesetImage = love.graphics.newImage("images/tileset.png")
    tilesetImage:setFilter("nearest", "linear") -- this "linear filter" removes some artifacts if we were to scale the tiles
    tileSize = 32

    -- Ocean
    tileQuads[0] = love.graphics.newQuad(0 * tileSize, 0 * tileSize, tileSize, tileSize, tilesetImage:getWidth(), tilesetImage:getHeight())
    --Snow
    tileQuads[1] = love.graphics.newQuad(1 * tileSize, 0 * tileSize, tileSize, tileSize, tilesetImage:getWidth(), tilesetImage:getHeight())
    --Ice
    tileQuads[2] = love.graphics.newQuad(2 * tileSize, 0 * tileSize, tileSize, tileSize, tilesetImage:getWidth(), tilesetImage:getHeight())

    tilesetBatch = love.graphics.newSpriteBatch(tilesetImage, tilesDisplayWidth * tilesDisplayHeight)

end

function menu.updateTilesetBatch()

    tilesetBatch:clear()
	for x=0, tilesDisplayWidth-1 do
		for y=0, tilesDisplayHeight-1 do
			tilesetBatch:add(tileQuads[1]--[[map[x+math.floor(mapX)][y+math.floor(mapY)]], x*tileSize, y*tileSize)
		end
	end
	tilesetBatch:flush()

end

function menu.moveMap(dx, dy)

    oldMapX = mapX
	oldMapY = mapY
	mapX = math.max(math.min(mapX + dx, mapWidth - tilesDisplayWidth), 1)
	mapY = math.max(math.min(mapY + dy, mapHeight - tilesDisplayHeight), 1)
	-- only update if we actually moved
	if math.floor(mapX) ~= math.floor(oldMapX) or math.floor(mapY) ~= math.floor(oldMapY) then
		menu.updateTilesetBatch()
	end

end

function menu.update(dt)

    --r = r + love.math.random(-10, 10)
    --b = b + love.math.random(-5, 50)
    --g = g + love.math.random(-10, 10)

    clickDelay = clickDelay - dt

    if love.keyboard.isDown("x") and clickDelay < 0 then
    	clickDelay = 0.5
    	developerMode = not developerMode
    end

    if ingame == 0 then
        moveDelay = moveDelay - moveTime
        if moveDelay > 15 then
            menu.moveMap(moveSpeed * tileSize, 0)
        elseif moveDelay > 10 then
            menu.moveMap(0, moveSpeed * tileSize)
        elseif moveDelay > 5 then
            menu.moveMap(-moveSpeed * tileSize, 0)
        elseif moveDelay > 0 then
            menu.moveMap(0, -moveSpeed * tileSize)
        elseif moveDelay < 0 then
            moveDelay = 20
        end
    end

end

function menu.options()

    if inmenu == true and options == true then
        if mouseX > 170 and mouseX < 390 and mouseY > 200 and mouseY < 260 then -- FPS on/off
            love.graphics.setColor(59, 70, 219)
            love.graphics.rectangle("fill", 170, 200, 220, 60)
        else
            love.graphics.setColor(126, 204, 230)
            love.graphics.rectangle("fill", 170, 200, 220, 60)
        end

        if mouseX > 170 and mouseX < 390 and mouseY > 280 and mouseY < 340 then -- version on/off
            love.graphics.setColor(59, 70, 219)
            love.graphics.rectangle("fill", 170, 280, 220, 60)
        else
            love.graphics.setColor(126, 204, 230)
            love.graphics.rectangle("fill", 170, 280, 220, 60)
        end

        if mouseX > 410 and mouseX < 630 and mouseY > 200 and mouseY < 260 then -- audio volume
            love.graphics.setColor(59, 70, 219)
            love.graphics.rectangle("fill", 410, 200, 220, 60)
        else
            love.graphics.setColor(126, 204, 230)
            love.graphics.rectangle("fill", 410, 200, 220, 60)
        end

        if mouseX > 170 and mouseX < 390 and mouseY > 600 and mouseY < 660 then -- Back
            love.graphics.setColor(59, 70, 219)
            love.graphics.rectangle("fill", 170, 600, 220, 60)
        else
            love.graphics.setColor(126, 204, 230)
            love.graphics.rectangle("fill", 170, 600, 220, 60)
        end

        love.graphics.setColor(0, 0, 0)                         -- set colour to black for borders and text

        love.graphics.rectangle("line", 170, 200, 220, 60)      -- draw 'FPS on/off' border
        if fps_show == true then                                -- detect if fps is on or off 
            love.graphics.print("FPS:On", 239, 210, 0, 2, 3)    -- print fps:on
        else
            love.graphics.print("FPS:Off", 239, 210, 0, 2, 3)   -- print fps:off
        end

        love.graphics.rectangle("line", 170, 280, 220, 60)      -- draw 'verison on/off' border
        if version_show == true then                            -- detect if fps is on or off
            love.graphics.print("Version:On", 217, 290, 0, 2, 3) -- print version:on
        else
            love.graphics.print("Version:Off", 217, 290, 0, 2, 3) -- print version:off
        end

        love.graphics.rectangle("line", 410, 200, 220, 60)      --draw 'Audio' border
        love.graphics.print("Audio: "..volume.."%", 455, 210, 0, 2, 3)    --print Audio

        if ingame == 1 and autoSave == true then
            love.graphics.print("Auto-Save:On", 200, 370, 0, 2, 3)
        elseif ingame == 1 and autoSave == false then
            love.graphics.print("Auto-Save:Off", 200, 370, 0, 2, 3)
        end
    end

    if inmenu == true then
        love.graphics.setColor(0, 0, 0)
        if credits == true or options == true then
            if ingame == 0 then
                love.graphics.rectangle("line", 170, 600, 220, 60)      --draw 'back' border
                love.graphics.print("Back", 249, 610, 0, 2, 3)          --print back
            elseif ingame == 1 then
                love.graphics.rectangle("line", 170, 500, 220, 60)      --draw 'back' border
                love.graphics.print("Back", 249, 510, 0, 2, 3)          --print back
            end
        end
    end

end

function love.mousepressed(x, y, button, istouch)

    if inmenu == true then

        if ingame == 0 then

            if button == 1 and x > 170 and x < 390 and y > 180 and y < 240 and options == false and credits == false and clickDelay < 0 then
            	inmenu = false
                ingame = 1
                snowballFight.load()
                clickDelay = 0.5
            end

            if button == 1 and x > 170 and x < 390 and y > 280 and y < 340 and options == false and clickDelay < 0 then
                options = true
                clickDelay = 0.5
            end

            if button == 1 and x > 170 and x < 390 and y > 380 and y < 440 and credits == false and clickDelay < 0 then
                credits = true
                clickDelay = 0.5
            end

            if button == 1 and x > 170 and x < 390 and y > 600 and y < 660 and clickDelay < 0 then
                options = false
                credits = false
                love.timer.sleep(0.1)
                clickDelay = 0.5
            end

        elseif ingame == 1 then

            if button == 1 and x > 170 and x < 390 and y > 360 and y < 420 and options == true and clickDelay < 0 then
                autoSave = not autoSave
            end

            if button == 1 and x > 500 and x < 720 and y > 150 and y < 210 and options == false and clickDelay < 0 then    --pause menu resume
                inmenu = false
            end

            if button == 1 and x > 500 and x < 720 and y > 250 and y < 310 and options == false and clickDelay < 0 then    --pause menu options
                options = true
                clickDelay = 0.5
            end          
            
            if button == 1 and x > 170 and x < 390 and y > 500 and y < 560 and options == true and clickDelay < 0 then     --back from options
                options = false
                clickDelay = 0.5
            end

            if button == 1 and x > 500 and x < 720 and y > 350 and y < 410 and clickDelay < 0 then -------SAVING
                save.save()
                love.event.quit( )
            end

        end

        if button == 1 and x > 410 and x < 630 and y > 280 and y < 500 and options == true and clickDelay < 0 then
            seed_show = not seed_show
        end

        if button == 1 and x > 170 and x < 390 and y > 280 and y < 340 and options == true and clickDelay < 0 then     --show version
            version_show = not version_show
        end

        if button == 1 and x > 170 and x < 390 and y > 200 and y < 260 and options == true and clickDelay < 0 then     --fps on/off
            fps_show = not fps_show
        end

        if button == 1 and x > 410 and x < 630 and y > 200 and y < 260 and options == true and clickDelay < 0 then

            if volume == 0 then
                volume = 25
            elseif volume == 25 then
                volume = 50
            elseif volume == 50 then
                volume = 75
            elseif volume == 75 then
                volume = 100
            elseif volume == 100 then
                volume = 0
            end

        end
        
    end

end

function UPDATE_MENU(dt)

    love.mousepressed()
    menu.update(dt)

end

function DRAW_MENU()

    menu.draw()
    menu.options()

end