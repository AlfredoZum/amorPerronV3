
require('src.resources.Globals')
local DBManager = require('src.resources.DBManager')
local RestManager = require('src.resources.RestManager')

MenuLeft = {}
MenuRight = {}

function MenuRight:new()

	local selfR = display.newGroup()
	
	--selfR.x = -480
	
	function selfR:buildMenu()
		
		local bgMenuRight = display.newRect( display.contentCenterX, display.contentCenterY + h, intW, intH )
		bgMenuRight:setFillColor( 0 )
		bgMenuRight.alpha = .5
		--bgMenuLeft:addEventListener("tap",hideMenuLeft)
		--bgMenuLeft:addEventListener("touch",blockMenu)
		selfR:insert(bgMenuRight)
		
		local menuRight = display.newRect( 130 , display.contentCenterY + h, 350, intH )
		menuRight.anchorX = 0
		menuRight:setFillColor( 30/255, 74/255, 123/255 )
		menuRight.alpha = 1
		--menuRight:addEventListener("tap",blockMenu)
		--menuRight:addEventListener("touch",blockMenu)
		selfR:insert(menuRight)
		
		local lineLeftmenuRigh = display.newLine( 131, h, 131, intH )
		lineLeftmenuRigh:setStrokeColor( .2 )
		lineLeftmenuRigh.strokeWidth = 3
		lineLeftmenuRigh.alpha = .5
		
		local lineLeftmenuRigh = display.newLine( 128, h, 128, intH )
		lineLeftmenuRigh:setStrokeColor( 0 )
		lineLeftmenuRigh.strokeWidth = 8
		lineLeftmenuRigh.alpha = .3
		
		local lineTopMenuRigh = display.newLine( 131, h, 480, h )
		lineTopMenuRigh:setStrokeColor( .2 )
		lineTopMenuRigh.strokeWidth = 2
		lineTopMenuRigh.alpha = .3
		
		local lineBottomMenuRigh = display.newLine( 131, intH - 1, 480, intH - 1 )
		lineBottomMenuRigh:setStrokeColor( .2 )
		lineBottomMenuRigh.strokeWidth = 3
		lineBottomMenuRigh.alpha = .4
		
		RestManager.getInfoUser()
		
	end
	
	
    local function cerrarSession( event )
        hideMenuLeft()
        logout()
    end
	
	return selfR
	
end



