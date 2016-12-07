require "menu"
require "images"


function love.load()

    love.window.setMode(800, 600, {resizable=true, vsync=false, minwidth=400, minheight=300})

	love.mouse.setVisible(true)
	ingame = false
	loadFunctions = false
	version_show = true 
	fps_show = true 

	menu.load()
	images.load()

	--load all non-game classes
	
end
 
function love.update(dt)

	if loadFunctions == true then

		--load all game classes

        loadFunctions = false

	end

	if ingame == true then
		--update all game classes
	end
	
		--update all non-game classes

		UPDATE_IMAGES()
		UPDATE_MENU()


end
 
function love.draw()

	love.graphics.setColor(255, 255, 255)

	if ingame == true then
	    --draw all game classes

	end
	
	DRAW_MENU()
		--draw all non-game classes

	love.graphics.setColor(255, 0, 0)

	if version_show == true then
		local major, minor, revision, codename = love.getVersion()
	    local str = string.format("Love Version %d.%d.%d - %s", major, minor, revision, codename)
	    love.graphics.print(str, 10, 20)
		love.graphics.print("Lua Version: " .._VERSION, 10, 30) --Lua Version
	end


	if fps_show == true then
    	love.graphics.print("FPS: "..love.timer.getFPS(), 10, 10) --FPS Counter	
    end

		love.graphics.print("MouseX: "..love.mouse.getX(), 10, 50)
    	love.graphics.print("MouseY: "..love.mouse.getY(), 10, 60)

    if ingame == true and doLoadScreen == false then
    	--print ingame stuff
	end

end