-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

display.setStatusBar( display.TranslucentStatusBar )

local DBManager = require('src.resources.DBManager')
local composer = require( "composer" )

local isUser = DBManager.setupSquema()
if isUser then
	composer.gotoScene("src.Home")
else
	composer.gotoScene("src.Login")
end
