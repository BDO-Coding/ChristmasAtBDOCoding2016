require "menu"
require "images"
require "helper"
require "snowballFight"
require "iceSkating"

function love.load()

	helper.load(doImageCropping)
	love.mouse.setVisible(true)
	ingame = 0
	inmenu = true
	developerMode = false
	version_show = true 
	fps_show = true 

	images.load()
	menu.load()
	
end
 
function love.update(dt)

	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()

	if ingame == 1 then
		UPDATE_SNOWBALLFIGHT(dt)
	elseif ingame == 2 then
		UPDATE_ICESKATING(dt)
	end
	
	UPDATE_IMAGES()
	UPDATE_MENU(dt)

end
 
function love.draw()

	love.graphics.setColor(255, 255, 255)

	if ingame == 1 then
		DRAW_SNOWBALLFIGHT()
	elseif ingame == 2 then
		DRAW_ICESKATING()
	end
	
	DRAW_MENU()

	love.graphics.setColor(255, 50, 50)

	if version_show == true then
		local major, minor, revision, codename = love.getVersion()
	    local str = string.format("Love Version: %d.%d.%d - %s", major, minor, revision, codename)
	    love.graphics.print(str, 10, 20)
		love.graphics.print("Lua Version: " .._VERSION, 10, 30) --Lua Version
	end


	if fps_show == true then
    	love.graphics.print("FPS: "..love.timer.getFPS(), 10, 10) --FPS Counter	
    end

    if developerMode == true then
    	love.graphics.print("MouseX: "..love.mouse.getX(), 10, 50)
    	love.graphics.print("MouseY: "..love.mouse.getY(), 10, 60)
	end

end