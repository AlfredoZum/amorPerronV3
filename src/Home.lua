---------------------------------------------------------------------------------
-- Godeals App
-- Alberto Vera
-- GeekBucket Software Factory
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- REQUIRE & VARIABLES
---------------------------------------------------------------------------------
require('src.Tools')
local json = require("json")
require('src.resources.Globals')
local widget = require( "widget" )
local composer = require( "composer" )

-- Grupos y Contenedores
local screen
local grpHome
local scene = composer.newScene()

-- Variables
local fontRegular = 'Lato-Regular'
local fontBold = 'Lato-Bold'
local fontLight = 'Lato-Light'
local fontLight = 'Lato-Italic'

local lastY = 0

---------------------------------------------------------------------------------
-- LISTENERS
---------------------------------------------------------------------------------



---------------------------------------------------------------------------------
-- FUNCTIONS
---------------------------------------------------------------------------------

function screenHome()
	return grpHome
end

---------------------------------------------------------------------------------
-- OVERRIDING SCENES METHODS
---------------------------------------------------------------------------------

function scene:create( event )
	screen = self.view
    screen.y = h
    
	grpHome = display.newGroup()
	screen:insert(grpHome)
	
	--baground
    local bg = display.newRect( midW, midH + h, intW, intH )
    bg:setFillColor( 49/255, 120/255, 200/255 )   
    grpHome:insert(bg)
	
	--baground StatusBar
	local bgSB = display.newRect( midW, h / 2, intW, h )
	bgSB:setFillColor( 30/255, 74/255, 123/255 )   
    grpHome:insert(bgSB)
	
	tools = Tools:new()
    tools:buildHeader()
	tools:buildFooter()
    grpHome:insert(tools)
	
	local o = display.newRect( midW, 65 + h, intW, intH - 213 )
	o.anchorY = 0
	o:setFillColor( .5 )
	grpHome:insert(o)
	
	tools:toFront()
	
	if ( system.getInfo( "device" ) == "simulator" ) then
		--[[local myMap = native.newMapView( midW, 65 + h, intW, intH - 213 )
		myMap.anchorY = 0
		--screen:insert(myMap)

		-- Display map as vector drawings of streets (other options are "satellite" and "hybrid")
		myMap.mapType = "standard"

		-- Initialize map to a real location
		myMap:setCenter( 37.331692, -122.030456 )]]
	end
	
	--[[local ]]
	
	
    
end	
-- Called immediately after scene has moved onscreen:
function scene:show( event )
end

-- Hide Scene
function scene:hide( event )
	native.setKeyboardFocus( nil )
end

-- Remove Scene
function scene:destroy( event )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene