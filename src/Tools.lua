---------------------------------------------------------------------------------
-- Amor Perron
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- Encabezao general
---------------------------------------------------------------------------------
require('src.Menu')
require('src.resources.Globals')
local composer = require( "composer" )
--local facebook = require("plugin.facebook.v4")
local Sprites = require('src.resources.Sprites')
--local DBManager = require('src.resources.DBManager')
local RestManager = require('src.resources.RestManager')

local scrMenu, bgShadow, grpNewAlert, grpAlertLogin, grpScrCity
local btnBackFunction = false

local grpAlertSlideDown
local iconAlertSlideDown = nil
local bgSlideDown = nil
local titleAlertSlideDow = nil

Tools = {}
function Tools:new()
    -- Variables
    local self = display.newGroup()
    local h = display.topStatusBarContentHeight
   -- local fxTap = audio.loadSound( "fx/click.wav")
    self.y = h
	
    -------------------------------
    -- Creamos la el toolbar
	-------------------------------
    function self:buildHeader()
	
		local bgHeader = display.newRect( midW, 0, intW, 65 )
		bgHeader.anchorY = 0
		bgHeader:setFillColor( 49/255, 120/255, 200/255 )
		self:insert(bgHeader)
		
		local lineHeader = display.newRect( midW, 63, intW, 2 )
		lineHeader.anchorY = 0
		lineHeader:setFillColor( 30/255, 74/255, 123/255 )
		self:insert(lineHeader)
		
		local lblHeader = display.newText({
			text = "AmorPerron",     
			x = midW, y = 30,
			font = fontBold,
			fontSize = 32, align = "center"
		})
		lblHeader:setFillColor( 1 )
		self:insert(lblHeader)
		
		local imgToolBar = display.newImage( "img/btn/menu-4-32.png" )
		imgToolBar:translate( 35, 30 )
		self:insert(imgToolBar)
		
		local lineToolBar1 = display.newRect( 70, 1, 2, 61 )
		lineToolBar1.anchorY = 0
		lineToolBar1:setFillColor( 30/255, 74/255, 123/255 )
		self:insert(lineToolBar1)
		
		local imgToolBar2 = display.newImage( "img/btn/contacts-32.png" )
		imgToolBar2:translate( 445, 30 )
		self:insert(imgToolBar2)
		
		local lineToolBar2 = display.newRect( 410, 1, 2, 61 )
		lineToolBar2.anchorY = 0
		lineToolBar2:setFillColor( 30/255, 74/255, 123/255 )
		self:insert(lineToolBar2)
		
		if not scrMenu then
			scrMenu = MenuRight:new()
			scrMenu:buildMenu()
		end
		
		--imgMenu2:setFillColor( 0 )
    end
	
	function self:buildFooter()
	
		local bgFooter = display.newRect( midW, intH - h - 70, intW, 70 )
		bgFooter.anchorY = 0
		bgFooter:setFillColor( 49/255, 120/255, 200/255 )
		--bgFooter:setFillColor( 1 )
		self:insert(bgFooter)
		
		local lineFooter = display.newRect( midW, intH - 70 - h, intW, 2 )
		lineFooter.anchorY = 0
		lineFooter:setFillColor( 30/255, 74/255, 123/255 )
		self:insert(lineFooter)
		
		--bottons subFooter
		
		local bgLocacion = display.newRect( 0, intH - 117 - h, midW, 47 )
		bgLocacion.anchorY = 0
		bgLocacion.anchorX = 0
		bgLocacion:setFillColor( 1 )
		self:insert(bgLocacion)
		
		local iconLocation = display.newImage( "img/btn/map-marker-2-32.png" )
		iconLocation:translate( 30, intH - 95 - h )
		iconLocation:setFillColor( 49/255, 120/255, 200/255 )
		self:insert(iconLocation)
		
		local lblLocation = display.newText({
			text = "Mi localizacion",     
			x = 120, y = intH - 95 - h,
			font = fontLight,
			fontSize = 18, align = "left"
		})
		lblLocation:setFillColor( 0 )
		self:insert(lblLocation)
		
		local bgFilter = display.newRect( midW, intH - 117 - h, midW, 47 )
		bgFilter.anchorY = 0
		bgFilter.anchorX = 0
		bgFilter:setFillColor( 1 )
		self:insert(bgFilter)
		
		local iconFilter = display.newImage( "img/btn/empty-filter-32.png" )
		iconFilter:translate( 450, intH - 95 - h )
		iconFilter:setFillColor( 49/255, 120/255, 200/255 )
		self:insert(iconFilter)
		
		local lblFilter = display.newText({
			text = "Filtros",     
			x = 360, y = intH - 95 - h,
			font = fontLight,
			fontSize = 18, align = "center"
		})
		lblFilter:setFillColor( 0 )
		self:insert(lblFilter)
		
		--botton footer
		
		local icon1 = display.newImage( "img/btn/stack-of-photos-48.png" )
		icon1:translate( 48, intH - 35 - h )
		icon1.height = 38
		icon1.width = 38
		self:insert(icon1)
		
		local icon2 = display.newImage( "img/btn/worldwide-location-48.png" )
		icon2:translate( 144, intH - 35 - h )
		icon2.height = 38
		icon2.width = 38
		self:insert(icon2)
		
		local circleIcon3 = display.newCircle( 240, intH - 70 - h, 45 )
		circleIcon3:setFillColor( 1 )
		circleIcon3:setStrokeColor( 30/255, 74/255, 123/255 )
		circleIcon3.strokeWidth = 4
		self:insert(circleIcon3)
		
		
		local icon3 = display.newImage( "img/btn/camera-5-48.png" )
		icon3:translate( 240, intH - 70 - h )
		self:insert(icon3)
		icon3:setFillColor( 49/255, 120/255, 200/255 )
		
		local icon4 = display.newImage( "img/btn/footprints-cat-48.png" )
		icon4:translate( 336, intH - 35 - h )
		icon4.height = 38
		icon4.width = 38
		self:insert(icon4)
		
		local icon5 = display.newImage( "img/btn/define-location-48.png" )
		icon5:translate( 432, intH - 35 - h )
		icon5.height = 38
		icon5.width = 38
		self:insert(icon5)
		
	end
    
	--------------------------
    -- Creamos loading
	--------------------------
    function self:setLoading(isLoading, parent)
        if isLoading then
            if grpLoading then
                grpLoading:removeSelf()
                grpLoading = nil
            end
            grpLoading = display.newGroup()
            parent:insert(grpLoading)
            
            local bg = display.newRect( (display.contentWidth / 2), (parent.height / 2), 
                display.contentWidth, parent.height )
            bg:setFillColor( .95 )
            bg.alpha = .3
            grpLoading:insert(bg)
            local sheet = graphics.newImageSheet(Sprites.loading.source, Sprites.loading.frames)
            local loading = display.newSprite(sheet, Sprites.loading.sequences)
            loading.x = display.contentWidth / 2
            loading.y = parent.height / 2 
            grpLoading:insert(loading)
            loading:setSequence("play")
            loading:play()
            local titleLoading = display.newText({
                text = "Loading...",     
                x = (display.contentWidth / 2) + 5, y = (parent.height / 2) + 60,
                font = native.systemFontBold,   
                fontSize = 18, align = "center"
            })
            titleLoading:setFillColor( .3, .3, .3 )
            grpLoading:insert(titleLoading)
        else
            if grpLoading then
                grpLoading:removeSelf()
                grpLoading = nil
            end
        end
    end
	
	-----------------------------------------------------
	-- creacion de mensaje de problema con la conexion
	-----------------------------------------------------
	function self:noConnection(isConnection, parent, message)
		if isConnection then
            if grpConnection then
                grpConnection:removeSelf()
                grpConnection = nil
            end
            grpConnection = display.newGroup()
            parent:insert(grpConnection)
			
			local bgNoConection = display.newRect( midW, 150 + h, display.contentWidth, 80 )
			bgNoConection:setFillColor( 236/255, 151/255, 31/255, .7 )
			grpConnection:insert(bgNoConection)
			
			local lblNoConection = display.newText({
				text = message, 
				x = midW, y = 150 + h,
				font = native.systemFont,   
				fontSize = 34, align = "center"
			})
			lblNoConection:setFillColor( 1 )
			grpConnection:insert(lblNoConection)
            
        else
            if grpConnection then
                grpConnection:removeSelf()
                grpConnection = nil
            end
        end
	end
	
	---------------------------------------------------------------------
	-- creacion de mensaje cuando no se encuentren mensajes o canales
	---------------------------------------------------------------------
	function self:NoMessages(isMesage, parent, message)
	
		if isMesage then
            if grpNoMessages then
                grpNoMessages:removeSelf()
                grpNoMessages = nil
            end
            grpNoMessages = display.newGroup()
            parent:insert(grpNoMessages)
			
			local titleNoMessages = display.newText({
				text = message,     
				x = midW, y = midH - 200,
				font = native.systemFontBold, width = intW - 50, 
				fontSize = 34, align = "center"
			})
			titleNoMessages:setFillColor( 0 )
			grpNoMessages:insert( titleNoMessages )
            
        else
            if grpNoMessages then
                grpNoMessages:removeSelf()
                grpNoMessages = nil
            end
        end
		
		return grpNoMessages
	end
	
	-------------------------
	--creamos una alerta
	-------------------------
	function NewAlert(isTrue, text)
		if isTrue then
			if grpNewAlert then
				grpNewAlert:removeSelf()
				grpNewAlert = nil
			end
			grpNewAlert = display.newGroup()
			
			--combobox
			local bg0 = display.newRect( midW, midH + h, intW, intH )
			bg0:setFillColor( 0 )
			bg0.alpha = .8
			grpNewAlert:insert( bg0 )
			bg0:addEventListener( 'tap', noAction )
		
			local bg1 = display.newRoundedRect( midW, midH + h, 608, 310, 10 )
			bg1:setFillColor( 129/255, 61/255, 153/255 )
			grpNewAlert:insert( bg1 )
			
			local bg2 = display.newRoundedRect( midW, midH + h, 600, 300, 10 )
			bg2:setFillColor( 1 )
			grpNewAlert:insert( bg2 )
			
			local lbl0 = display.newText({
				text = text, 
				x = midW, y = midH + h,
				width = 500,
				font = 	native.systemFont,   
				fontSize = 38, align = "center"
			})
			lbl0:setFillColor( 0 )
			grpNewAlert:insert(lbl0)
		else
			if grpNewAlert then
				grpNewAlert:removeSelf()
				grpNewAlert = nil
			end
		end
	end
	
	------------------------------------------
	-- alerta que se despliega desde abajo
	-- @param isOpen indica si la alerta se abre o cierra
	-- @param message mensaje que se muestra en la alerta
	-- @param typeAlert indica que tipo de alerta es (loading / message )
	-- @param success si el mensaje es un message indica si esta correcto o incorrecto
	------------------------------------------
	function alertSlideDown(isOpen, message, typeAlert, success)
	
		if isOpen then
			if grpAlertSlideDown then
				--grpAlertSlideDown:removeSelf()
				--grpAlertSlideDown = nil
				
				--local iconAlertSlideDown = nil
				--local bgSlideDown = nil
				if success == true then
					bgSlideDown:setFillColor( 68/255, 157/255, 68/255 )
				else
					bgSlideDown:setFillColor( 236/255, 151/255, 31/255 )
				end
				titleAlertSlideDown.text = message
				
				iconAlertSlideDown:removeSelf()
				iconAlertSlideDown = nil
				
				if typeAlert == "loading" then
					iconAlertSlideDown = display.newImage( "img/btn/checkmark-48.png"  )
					
					local sheet = graphics.newImageSheet(Sprites.loading.source, Sprites.loading.frames)
					local iconAlertSlideDown = display.newSprite(sheet, Sprites.loading.sequences)
					iconAlertSlideDown.x = intW/2
					iconAlertSlideDown.y = intH - 50
					grpAlertSlideDown:insert(iconAlertSlideDown)
					iconAlertSlideDown:setSequence("play")
					iconAlertSlideDown:play()
					
				else
					if success == true then
						iconAlertSlideDown = display.newImage( "img/btn/checkmark-48.png"  )
					else
						iconAlertSlideDown = display.newImage( "img/btn/alert-48.png"  )
					end
					
					iconAlertSlideDown.x = intW/2
					iconAlertSlideDown.y = intH - 50
					grpAlertSlideDown:insert(iconAlertSlideDown)
					
				end
				
			else
			
				grpAlertSlideDown = display.newGroup()
				grpAlertSlideDown.y = intH
			
				local bgAlertSlideDown = display.newRect( midW, -midH + h, intW, intH )
				bgAlertSlideDown:setFillColor( 0 )
				bgAlertSlideDown.alpha = 0.5
				grpAlertSlideDown:insert(bgAlertSlideDown)
				bgAlertSlideDown:addEventListener( "tap", noAction )
				
				bgSlideDown = nil
				bgSlideDown = display.newRect( intW/2, intH - 75, intW, 150 )
				if success == true then
					bgSlideDown:setFillColor( 68/255, 157/255, 68/255 )
				else
					bgSlideDown:setFillColor( 236/255, 151/255, 31/255 )
				end
				grpAlertSlideDown:insert(bgSlideDown)
			
				
				bgSlideDown:addEventListener( 'tap' , noAction )
				
				iconAlertSlideDown = nil
				
				if typeAlert == "loading" then
					iconAlertSlideDown = display.newImage( "img/btn/checkmark-48.png"  )
					
					local sheet = graphics.newImageSheet(Sprites.loading.source, Sprites.loading.frames)
					iconAlertSlideDown = display.newSprite(sheet, Sprites.loading.sequences)
					iconAlertSlideDown.x = intW/2
					iconAlertSlideDown.y = intH - 50
					grpAlertSlideDown:insert(iconAlertSlideDown)
					iconAlertSlideDown:setSequence("play")
					iconAlertSlideDown:play()
					
				else
					if success == true then
						iconAlertSlideDown = display.newImage( "img/btn/checkmark-48.png"  )
					else
						iconAlertSlideDown = display.newImage( "img/btn/alert-48.png"  )
					end
					
					iconAlertSlideDown.x = intW/2
					iconAlertSlideDown.y = intH - 50
					grpAlertSlideDown:insert(iconAlertSlideDown)
					
				end
		
				titleAlertSlideDown = display.newText( message, 0, 15, fontLight, 25)
				titleAlertSlideDown:setFillColor( 1 )
				titleAlertSlideDown.x = display.contentWidth / 2
				titleAlertSlideDown.y = intH - 120
				grpAlertSlideDown:insert(titleAlertSlideDown)
		
				transition.to( grpAlertSlideDown, { y = 0, time = 600, transition = easing.outExpo, onComplete=function()
					end
				})
				transition.to( bgAlertSlideDown, { y = midH, time = 600, transition = easing.outExpo, onComplete=function()
					end
				})
			
			end
		else
			if grpAlertSlideDown then
				transition.to( grpAlertSlideDown, { y = 200, time = 300, transition = easing.inQuint, onComplete=function()
					if grpAlertSlideDown then
						grpAlertSlideDown:removeSelf()
						grpAlertSlideDown = nil
					end
				end})
			end
		end
	
	end
	
	-------------------------------------------
	-- deshabilita los eventos tap no deseados
	-- deshabilita el traspaso del componentes
	-------------------------------------------
	function noAction( event )
		return true
	end
    
    return self
end