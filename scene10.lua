--scene10--scene9

--scene6---------------------------------------------------------------------------------
--
-- scene3.lua
--
---------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

local image, text1, text2, text3, memTimer, myLuaScoreText

local function onSceneTouch( self, event )
	if event.phase == "began" then
		composer.gotoScene( "scene1", "slideUp", 300  )
		myLuaScoreText.isVisible = false

		return true
	end
end

function scene:create( event )
	local sceneGroup = self.view
	
	image = display.newImage( "bg10.png" )
	image.x = display.contentCenterX
	image.y = display.contentCenterY
	
	sceneGroup:insert( image )
	
	image.touch = onSceneTouch
	
	---------Q&A-----------------------
	text1 = display.newText( "What is a piece of data", 160, 50, native.systemFontBold, 20 )
	text1:setFillColor( 255 )
	secondLine = display.newText("stored in memory,", 160, 80, native.systemFontBold, 20)
	thirdLine = display.newText("such as a name,", 160, 110, native.systemFontBold, 20)
	forthLine = display.newText("an address, or a phone number.", 160, 140, native.systemFontBold, 20)
	fifthLine = display.newText("It’s immutable, meaning", 160, 170, native.systemFontBold, 20)
	sixthLine = display.newText("it can’t be changed?", 160, 200, native.systemFontBold, 20)




	--text1.x = display.contentCenterX
	--text1.x, text1.y = display.contentWidth * 0.5, 50
	sceneGroup:insert( text1 )
	sceneGroup:insert( secondLine )
	sceneGroup:insert( thirdLine )
	sceneGroup:insert( forthLine )
	sceneGroup:insert( fifthLine )
	sceneGroup:insert( sixthLine )



	answer1 = display.newText( "1. Literal", 0, 0, native.systemFont, 16 )
	answer1:setFillColor( 255 )
	answer1.x, answer1.y = display.contentWidth * 0.5, display.contentHeight * 0.55
	answer1.touch = answerTouch
	sceneGroup:insert( answer1 )

	answer2 = display.newText( "2. Variable" , 0, 0, native.systemFont, 16 )
	answer2:setFillColor( 255 )
	answer2.x, answer2.y = display.contentWidth * 0.5, display.contentHeight * 0.65
	answer2.touch = wrongAnswerTouch
	sceneGroup:insert( answer2 )




	
	text2 = display.newText( ": ", 0, 2000, native.systemFont, 16 )
	text2:setFillColor( 255 )
	text2.x, text2.y = display.contentWidth * 0.5, display.contentHeight * 5
	sceneGroup:insert( text2 )
	
	text3 = display.newText( "Play Again ?", 0, 0, native.systemFontBold, 18 )
	text3:setFillColor( 255 ); text3.isVisible = false
	text3.x, text3.y = display.contentWidth * 0.5, display.contentHeight - 100
	sceneGroup:insert( text3 )
	
	print( "\n3: create event" )
end






local function answerTouch(event)		
	myLuaScoreText.text = "Correct!"
	myLuaScoreText:setFillColor(0,1,0)	

	print ("My score is: Correct! " )	
	return true
end

local function wrongAnswerTouch(event)	
	myLuaScoreText.text = "Incorrect!"
	myLuaScoreText:setFillColor(1,0,0)	

	print ("My score is: Incorrect!")	
	return true
end


myLuaScoreText = display.newText("", display.contentCenterX, 500, Arial, 40)

myLuaScoreText:addEventListener("tap", answerTouch)










function scene:show( event )
	
	local phase = event.phase
	if "did" == phase then
	
		print( "3: show event, phase did" )
	
		-- remove previous scene's view
		composer.removeScene( "scene9" )
	
		-- update Lua memory text display
		local showMem = function()
			image:addEventListener( "touch", image )
			answer1:addEventListener("touch", answerTouch)
			answer2:addEventListener("touch", wrongAnswerTouch)
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
	
		print( "3: hide event, phase will" )
	
		-- remove touch listener for image
		image:removeEventListener( "touch", image )
	
		-- cancel timer
		timer.cancel( memTimer ); memTimer = nil;
	
		-- reset label text
		text2.text = "MemUsage: "
	
	end
end

function scene:destroy( event )
	
	print( "((destroying scene 3's view))" )
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene