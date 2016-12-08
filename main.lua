require "menu"
require "images"
require "snowballFight"


function love.load()

	love.mouse.setVisible(true)
	ingame = 0
	inmenu = true
	loadFunctions = false
	version_show = true 
	fps_show = true 

	images.load()
	menu.load()
	snowballFight.load()
	
	--load all non-game classes
	
end
 
function love.update(dt)

	if loadFunctions == true then
		--load all game classes
        loadFunctions = false
	end

	if ingame == 1 then
		--update all game classes
		UPDATE_SNOWBALLFIGHT(dt)
	end
	
	--update all non-game classes
	UPDATE_IMAGES()
	UPDATE_MENU(dt)


end
 
function love.draw()

	love.graphics.setColor(255, 255, 255)

	if ingame == 1 then
	    --draw all game classes
		DRAW_SNOWBALLFIGHT()

	end
	
	DRAW_MENU()
	--draw all non-game classes

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

	love.graphics.print("MouseX: "..love.mouse.getX(), 10, 50)
    love.graphics.print("MouseY: "..love.mouse.getY(), 10, 60)

    if ingame == 1 and doLoadScreen == false then
    	--print ingame stuff
	end

end