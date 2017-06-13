---------------------------------------------------------------------------------
--
-- scene1.lua
--
---------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

local image, text1, text2, text3, memTimer

-- Touch event listener for background image
local function onSceneTouch( self, event )
	if event.phase == "began" then
		
		composer.gotoScene( "scene2", "slideLeft", 300  )
		
		return true
	end
end







-- Called when the scene's view does not exist:
function scene:create( event )
	local sceneGroup = self.view
	
	image = display.newImage( "bg1.png" )
	image.x = display.contentCenterX
	image.y = display.contentCenterY
	
	sceneGroup:insert( image )
	
	image.touch = onSceneTouch
	
	text1 = display.newText( "Welcome to Lua Trainer!", 0, 0, native.systemFontBold, 24 )
	text1:setFillColor( 255 )
	text1.x, text1.y = display.contentWidth * 0.5, 50
	sceneGroup:insert( text1 )


	startText = display.newText("Tap the correct answer", 0, 50, Arial, 22)
	startText:setFillColor( 255 )
	startText.x, startText.y = display.contentWidth * 0.5, 150
	sceneGroup:insert( startText )

	
	text2 = display.newText( " ", 0, 0, native.systemFont, 16 )
	text2:setFillColor( 255 )
	text2.x, text2.y = display.contentWidth * 5, display.contentHeight * 5
	sceneGroup:insert( text2 )
	
	text3 = display.newText( "Begin", 0, 0, native.systemFontBold, 45 )
	text3:setFillColor( 255 ); text3.isVisible = false
	text3.x, text3.y = display.contentWidth * 0.5, display.contentHeight - 100
	sceneGroup:insert( text3 )
	
	print( "\n1: create event")
end

function scene:show( event )
	
	local phase = event.phase
	
	if "did" == phase then
	
		print( "1: show event, phase did" )
	
		-- remove previous scene's view
		composer.removeScene( "scene5" )
	
		-- Update Lua memory text display
		local showMem = function()
			image:addEventListener( "touch", image )
			text3.isVisible = true
			text2.text = text2.text .. collectgarbage("count")/1000 .. "MB"
			text2.x = display.contentWidth * 0.5
		end
		memTimer = timer.performWithDelay( 1000, showMem, 1 )
	
	end
	
end

function scene:hide( event )
	
	local phase = event.phase
	
	if "will" == phase then
	
		print( "1: hide event, phase will" )
	
		-- remove touch listener for image
		image:removeEventListener( "touch", image )
	
		-- cancel timer
		timer.cancel( memTimer ); memTimer = nil;
	
		-- reset label text
		text2.text = "MemUsage: "
	
	end
	
end

function scene:destroy( event )
	print( "((destroying scene 1's view))" )
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene