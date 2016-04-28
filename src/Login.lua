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
local RestManager = require('src.resources.RestManager')

-- Grupos y Contenedores
local screen
local grpMain, grpSignIn, grpSignUp
local scene = composer.newScene()

-- Variables


local lastY = 0
local txtLogInEmail, txtLogInPass, txtSignUpUser, txtSignUpEmail, txtSignUpPass, txtSignUpRePass
local btnBack2

---------------------------------------------------------------------------------
-- LISTENERS
---------------------------------------------------------------------------------

--logeo de usuarios
function SignIn( event )

	local function trimString( s )
		return string.match( s,"^()%s*$") and "" or string.match(s,"^%s*(.*%S)" )
	end
	
	--if flag == 0 then
		--flag = 1
		--trim
		local textEmail = trimString(txtLogInEmail.text)
		local textPass = txtLogInPass.text
		if textEmail ~= "" and textPass ~= "" then
			--tools:setLoading(true,grpLoad)
			alertSlideDown(true,"Conectando...","loading", true)
			
			--[[]]
			RestManager.validateUser( textEmail, textPass, 0000 )
		else
			print('vacio')
			alertSlideDown(true,"Campos vacios","message", false)
			timeMarker = timer.performWithDelay( 2000, function()
				alertSlideDown(false,"","message", false)
				flag = 0
			end, 1 )
		end
	--end
	
	return true
end

function returnSignIn( message, isTrue )
	alertSlideDown(true,message,"message", isTrue)
	timeMarker = timer.performWithDelay( 2000, function()
		alertSlideDown(false,"","message", isTrue)
		if isTrue then
			goToHome()
		end
	end, 1 )
end

--registro de usuarios
function SignUp()
	local function trimString( s )
		return string.match( s,"^()%s*$") and "" or string.match(s,"^%s*(.*%S)" )
	end
	
		local textUser = trimString(txtSignUpUser.text)
		local textEmail = trimString(txtSignUpEmail.text)
		local textPass = txtSignUpPass.text
		local textRePass = txtSignUpRePass.text
		if textUser == "" or textEmail == "" or  textPass == "" or textRePass == "" then
			alertSlideDown(true,"Campos vacios","message", false)
			timeMarker = timer.performWithDelay( 2000, function()
				alertSlideDown(false,"","message", false)
				flag = 0
			end, 1 )
		elseif  textPass ~=  textRePass then
			alertSlideDown(true,"Contraseñas incorrectas","message", false)
			timeMarker = timer.performWithDelay( 2000, function()
				alertSlideDown(false,"","message", false)
				flag = 0
			end, 1 )
		elseif textUser ~= "" and textEmail ~= "" and  textPass ~= "" and textRePass ~= "" and textPass ==  textRePass then
			alertSlideDown(true,"Registrando usuario","loading", true)
			RestManager.createUser( textUser, textEmail, textPass, 0000 )
		end
	
	return true
end

--muestra el grupo de logIn
function showLogIn( event )
	transition.to( grpMain, { x = -480, time = 200 })
	transition.to( grpSignIn, { x = 0, time = 200 })
	return true
end

--muestra el grupo de logIn
function showMain( event )
	transition.to( grpSignIn, { x = 480, time = 200 })
	transition.to( grpSignUp, { x = 480, time = 200 })
	transition.to( grpMain, { x = 0, time = 200 })
	return true
end

function showSignUp( event )
	btnBack2.screen = "main"
	transition.to( grpMain, { x = -480, time = 200 })
	transition.to( grpSignUp, { x = 0, time = 200 })
	return true
end

function showSignUp2( event )
	btnBack2.screen = "SignUp"
	transition.to( grpSignIn, { x = -480, time = 200 })
	transition.to( grpSignUp, { x = 0, time = 200 })
	return true
end

function showMain2( event )
	if btnBack2.screen == "main" then
		transition.to( grpMain, { x = 0, time = 200 })
		transition.to( grpSignUp, { x = 480, time = 200 })
	else
		transition.to( grpSignIn, { x = 0, time = 200 })
		transition.to( grpSignUp, { x = 480, time = 200 })
	end
	return true
end

--[[
-- evento focus de los textField
--]]
function onTxtFocus( event )
	local t = event.target
	if ( event.phase == "began" ) then
		
    elseif ( event.phase == "ended" ) then
		--native.setKeyboardFocus( nil )
	elseif ( event.phase == "submitted" ) then
		if ( t.method == "signIn" ) then
			if t.name == "email" then
				native.setKeyboardFocus( txtLogInPass )
			else
				native.setKeyboardFocus( nil )
				SignIn()
			end
		elseif ( t.method == "signUp" ) then
			if t.name == "user" then
				native.setKeyboardFocus( txtSignUpEmail )
			elseif t.name == "email" then
				native.setKeyboardFocus( txtSignUpPass )
			elseif t.name == "pass" then
				native.setKeyboardFocus( txtSignUpRePass )
			else
				native.setKeyboardFocus( nil )
				SignIn()
			end
		end
    elseif ( event.phase == "editing" ) then
		
    end
end

---------------------------------------------------------------------------------
-- FUNCTIONS
---------------------------------------------------------------------------------

function goToHome()
	composer.removeScene( "src.Home" )
	composer.gotoScene( "src.Home", { time = 400, effect = "crossFade" })
end

---------------------------------------------------------------------------------
-- OVERRIDING SCENES METHODS
---------------------------------------------------------------------------------

function scene:create( event )
	screen = self.view
    screen.y = h
    
	--tools
	tools = Tools:new()
	
	--baground
    local bg = display.newRect( midW, midH + h, intW, intH )
    bg:setFillColor( 49/255, 120/255, 200/255 )   
    screen:insert(bg)
	
	--baground StatusBar
	local bgSB = display.newRect( midW, h / 2, intW, h )
	bgSB:setFillColor( 30/255, 74/255, 123/255 )   
    screen:insert(bgSB)
    
	--logo
    local logo = display.newImage( screen, "img/bg/logo-AP.png" )
    logo:translate( midW, (intH/4.5) )
	screen:insert(logo)
	logo.height = 180
	logo.width = 300
	
	-- Main options
    grpMain = display.newGroup()
    screen:insert(grpMain)
	grpMain.y = midH
	
	grpSignIn = display.newGroup()
    screen:insert(grpSignIn)
	grpSignIn.y = midH
	grpSignIn.x = 480
	
	grpSignUp = display.newGroup()
    screen:insert(grpSignUp)
	grpSignUp.y = midH - 30
	grpSignUp.x = 480
	
	--button facebook
	local btnFacebook = display.newRoundedRect( midW, 0, 366, 66, Rounded )
	btnFacebook:setFillColor( 54/255, 75/255, 123/255 )
	grpMain:insert(btnFacebook)
	
	local paint = {
		type = "gradient",
		color1 = { 109/255, 130/255, 173/255, 0.2 },
		color2 = {66/255, 92/255, 151/255, 0.6 },
		direction = "down"
	}
	
	local btnFacebook2  = display.newRoundedRect( midW, 0, 360, 60, Rounded )
	btnFacebook2:setFillColor( 66/255, 92/255, 151/255 )
	btnFacebook2.fill = paint
	grpMain:insert(btnFacebook2)
	
	local lineBtnFacebook  = display.newRect( 130, 0, 4, 56 )
	lineBtnFacebook:setFillColor( 54/255, 75/255, 123/255 )
	grpMain:insert(lineBtnFacebook)
	
	local imgFacebook = display.newImage( screen, "img/btn/facebook-48.png" )
    imgFacebook:translate( 95, 0 )
	grpMain:insert(imgFacebook)
	--imgFacebook.height = 180
	--imgFacebook.width = 300
	
	local lblFacebook = display.newText({
        text = "Entra con Facebook",     
        x = midW + 70, y = 0,
        font = fontBold,
		width = 280,
        fontSize = 24, align = "left"
    })
    lblFacebook:setFillColor( 1 )
    grpMain:insert(lblFacebook)
	
	--button facebook
	local btnShowlogIn = display.newRoundedRect( midW, 110, 366, 66, Rounded )
	btnShowlogIn:setFillColor( 40/255, 123/255, 12/255 )
	grpMain:insert(btnShowlogIn)
	btnShowlogIn:addEventListener( "tap", showLogIn )
	
	local paint = {
		type = "gradient",
		color1 = { 163/255, 189/255, 49/255, 0.2 },
		color2 = {53/255, 163/255, 16/255, 0.6 },
		direction = "down"
	}
	
	local btnShowlogIn2  = display.newRoundedRect( midW, 110, 360, 60, Rounded )
	btnShowlogIn2:setFillColor( 1 )
	btnShowlogIn2.fill = paint
	grpMain:insert(btnShowlogIn2)
	
	local lineBtnFacebook  = display.newRect( 130, 110, 4, 56 )
	lineBtnFacebook:setFillColor( 40/255, 123/255, 12/255 )
	grpMain:insert(lineBtnFacebook)
	
	local lblShowlogIn = display.newText({
        text = "Iniciar Sesión",     
        x = midW + 70, y = 110,
        font = fontBold,
		width = 280,
        fontSize = 24, align = "left"
    })
    lblShowlogIn:setFillColor( 1 )
    grpMain:insert(lblShowlogIn)
	
	local imgShowlogIn = display.newImage( screen, "img/btn/huella2.png" )
    imgShowlogIn:translate( 95, 110 )
	grpMain:insert(imgShowlogIn)
	
	local lblShowSignUp = display.newText({
        text = "¿Aún no tienes cuenta?",     
        x = midW, y = midH - 50,
        font = fontBold,
        fontSize = 24, align = "center"
    })
    lblShowSignUp:setFillColor( 1 )
    grpMain:insert(lblShowSignUp)
	lblShowSignUp:addEventListener( 'tap', showSignUp )
	
	----------------------------
	------ screen log in -------
	----------------------------
	
	lastY = 0
	
	local bgLogInEmail  = display.newRect( midW, lastY, 380, 60)
	bgLogInEmail:setFillColor( 1 )
	grpSignIn:insert(bgLogInEmail)
	
	local bgIconLogInEmail  = display.newRect( 80, lastY, 60, 60)
	bgIconLogInEmail:setFillColor( 30/255, 74/255, 123/255 )
	grpSignIn:insert(bgIconLogInEmail)
	
	local iconLogInEmail= display.newImage( screen, "img/btn/user-32.png" )
    iconLogInEmail:translate( 80, lastY )
	grpSignIn:insert(iconLogInEmail)
	
	txtLogInEmail = native.newTextField( midW + 30, lastY, 300, 55 )
    txtLogInEmail.inputType = "email"
    txtLogInEmail.hasBackground = false
	txtLogInEmail.placeholder = "Correo"
	txtLogInEmail.method = "signIn"
	txtLogInEmail.name = "email"
    txtLogInEmail:addEventListener( "userInput", onTxtFocus )
	grpSignIn:insert(txtLogInEmail)
	txtLogInEmail:resizeFontToFitHeight()
	txtLogInEmail:setReturnKey( "next" )
	
	lastY = lastY + 100
	
	-- password login
	local bgLogInPass  = display.newRect( midW, lastY, 380, 60)
	bgLogInPass:setFillColor( 1 )
	grpSignIn:insert(bgLogInPass)
	
	local bgIconLogInPass  = display.newRect( 80, lastY, 60, 60)
	bgIconLogInPass:setFillColor( 30/255, 74/255, 123/255 )
	grpSignIn:insert(bgIconLogInPass)
	
	local iconLogInPass = display.newImage( screen, "img/btn/lock-7-32.png" )
    iconLogInPass:translate( 80, lastY )
	grpSignIn:insert(iconLogInPass)
	
	txtLogInPass = native.newTextField( midW + 30, lastY, 300, 55 )
    txtLogInPass.inputType = "password"
    txtLogInPass.hasBackground = false
	txtLogInPass.isSecure = true
	txtLogInPass.placeholder = "Contraseña"
	txtLogInPass.method = "signIn"
	txtLogInPass.name = "pass"
    txtLogInPass:addEventListener( "userInput", onTxtFocus )
	grpSignIn:insert(txtLogInPass)
	txtLogInPass:resizeFontToFitHeight()
	txtLogInPass:setReturnKey( "go" )
	
	lastY = lastY + 110
	
	--button singIn
	
	local btnLogIn  = display.newRoundedRect( midW, lastY, 380, 74, Rounded )
	btnLogIn:setFillColor( 69/255, 97/255, 127/255 )
	--btnLogIn.fill = paint
	grpSignIn:insert(btnLogIn)
	btnLogIn:addEventListener( 'tap', SignIn )
	
	local btnLogIn2  = display.newRoundedRect( midW, lastY, 376, 70, Rounded )
	btnLogIn2:setFillColor( 30/255, 74/255, 123/255 )
	--btnLogIn.fill = paint
	grpSignIn:insert(btnLogIn2)
	
	local lblLogIn = display.newText({
        text = "Iniciar Sesión",     
        x = midW, y = lastY,
        font = fontBold,
		width = 380,
        fontSize = 30, align = "center"
    })
    lblLogIn:setFillColor( 1 )
    grpSignIn:insert(lblLogIn)
	
	local btnBack = display.newImage( screen, "img/btn/arrow-95-48.png" )
    btnBack:translate( 30, 35 + h - midH )
	grpSignIn:insert(btnBack)
	btnBack:addEventListener( 'tap', showMain )
	
	local lblShowSignUp2 = display.newText({
        text = "¿Aún no tienes cuenta?",     
        x = midW, y = midH - 50,
        font = fontBold,
        fontSize = 24, align = "center"
    })
    lblShowSignUp2:setFillColor( 1 )
    grpSignIn:insert(lblShowSignUp2)
	lblShowSignUp2:addEventListener( 'tap', showSignUp2 )
	
	--
	----------------------------
	------ screen Sing Up -------
	----------------------------
	
	lastY = 0
	
	-- sign up user
	local bgSignUpUser  = display.newRect( midW, lastY, 380, 60)
	bgSignUpUser:setFillColor( 1 )
	grpSignUp:insert(bgSignUpUser)
	
	local bgIconSignUpUser  = display.newRect( 80, lastY, 60, 60)
	bgIconSignUpUser:setFillColor( 30/255, 74/255, 123/255 )
	grpSignUp:insert(bgIconSignUpUser)
	
	local iconSignUpUser = display.newImage( screen, "img/btn/user-32.png" )
    iconSignUpUser:translate( 80, lastY )
	grpSignUp:insert(iconSignUpUser)
	
	txtSignUpUser = native.newTextField( midW + 30, lastY, 300, 55 )
    txtSignUpUser.inputType = "default"
    txtSignUpUser.hasBackground = false
	txtSignUpUser.placeholder = "Usuario"
	txtSignUpUser.method = "signUp"
	txtSignUpUser.name = "user"
    txtSignUpUser:addEventListener( "userInput", onTxtFocus )
	grpSignUp:insert(txtSignUpUser)
	txtSignUpUser:resizeFontToFitHeight()
	txtSignUpUser:setReturnKey( "next" )
	
	lastY = lastY + 75
	
	--email singUp
	local bgSignUpEmail  = display.newRect( midW, lastY, 380, 60)
	bgSignUpEmail:setFillColor( 1 )
	grpSignUp:insert(bgSignUpEmail)
	
	local bgIconSignUpEmail  = display.newRect( 80, lastY, 60, 60)
	bgIconSignUpEmail:setFillColor( 30/255, 74/255, 123/255 )
	grpSignUp:insert(bgIconSignUpEmail)
	
	local iconSignUpEmail = display.newImage( screen, "img/btn/inbox-8-32.png" )
    iconSignUpEmail:translate( 80, lastY )
	grpSignUp:insert(iconSignUpEmail)
	
	txtSignUpEmail = native.newTextField( midW + 30, lastY, 300, 55 )
    txtSignUpEmail.inputType = "email"
    txtSignUpEmail.hasBackground = false
	txtSignUpEmail.placeholder = "Correo"
	txtSignUpEmail.method = "signUp"
	txtSignUpEmail.name = "email"
    txtSignUpEmail:addEventListener( "userInput", onTxtFocus )
	grpSignUp:insert(txtSignUpEmail)
	txtSignUpEmail:resizeFontToFitHeight()
	txtSignUpEmail:setReturnKey( "next" )
	
	lastY = lastY + 75
	
	--password singUp
	local bgSignUpPass  = display.newRect( midW, lastY, 380, 60)
	bgSignUpPass:setFillColor( 1 )
	grpSignUp:insert(bgSignUpPass)
	
	local bgIconSignUpPass  = display.newRect( 80, lastY, 60, 60)
	bgIconSignUpPass:setFillColor( 30/255, 74/255, 123/255 )
	grpSignUp:insert(bgIconSignUpPass)
	
	local iconSignUpPass = display.newImage( screen, "img/btn/lock-7-32.png" )
    iconSignUpPass:translate( 80, lastY )
	grpSignUp:insert(iconSignUpPass)
	
	txtSignUpPass = native.newTextField( midW + 30, lastY, 300, 55 )
    txtSignUpPass.inputType = "password"
    txtSignUpPass.hasBackground = false
	txtSignUpPass.isSecure = true
	txtSignUpPass.method = "signUp"
	txtSignUpPass.name = "Pass"
	txtSignUpPass.placeholder = "Contraseña"
    txtSignUpPass:addEventListener( "userInput", onTxtFocus )
	grpSignUp:insert(txtSignUpPass)
	txtSignUpPass:resizeFontToFitHeight()
	txtSignUpPass:setReturnKey( "next" )
	
	lastY = lastY + 75
	
	--password 2 singUp
	local bgSignUpPass2  = display.newRect( midW, lastY, 380, 60)
	bgSignUpPass2:setFillColor( 1 )
	grpSignUp:insert(bgSignUpPass2)
	
	local bgIconSignUpPass2  = display.newRect( 80, lastY, 60, 60)
	bgIconSignUpPass2:setFillColor( 30/255, 74/255, 123/255 )
	grpSignUp:insert(bgIconSignUpPass2)
	
	local iconSignUpPass2 = display.newImage( screen, "img/btn/lock-7-32.png" )
    iconSignUpPass2:translate( 80, lastY )
	grpSignUp:insert(iconSignUpPass2)
	
	txtSignUpRePass = native.newTextField( midW + 30, lastY, 300, 55 )
    txtSignUpRePass.inputType = "password"
    txtSignUpRePass.hasBackground = false
	txtSignUpRePass.isSecure = true
	txtSignUpRePass.method = "signUp"
	txtSignUpRePass.name = "rePass"
	txtSignUpRePass.placeholder = "Repita Contraseña"
    txtSignUpRePass:addEventListener( "userInput", onTxtFocus )
	grpSignUp:insert(txtSignUpRePass)
	txtSignUpRePass:resizeFontToFitHeight()
	txtSignUpRePass:setReturnKey( "go" )
	
	--button singIn
	
	lastY= lastY + 80
	
	local btnSignUp  = display.newRoundedRect( midW, lastY, 380, 74, Rounded )
	btnSignUp:setFillColor( 69/255, 97/255, 127/255 )
	--btnLogIn.fill = paint
	grpSignUp:insert(btnSignUp)
	btnSignUp:addEventListener( 'tap', SignUp )
	
	local btnSignUp2  = display.newRoundedRect( midW, lastY, 376, 70, Rounded )
	btnSignUp2:setFillColor( 30/255, 74/255, 123/255 )
	--btnLogIn.fill = paint
	grpSignUp:insert(btnSignUp2)
	
	local lblSignUp = display.newText({
        text = "Registrarse",     
        x = midW, y = lastY,
        font = fontBold,
		width = 380,
        fontSize = 30, align = "center"
    })
    lblSignUp:setFillColor( 1 )
    grpSignUp:insert(lblSignUp)
	
	btnBack2 = display.newImage( screen, "img/btn/arrow-95-48.png" )
    btnBack2:translate( 30, 65 + h - midH )
	btnBack2.screen = "main"
	grpSignUp:insert(btnBack2)
	btnBack2:addEventListener( 'tap', showMain2 )
    
end	
-- Called immediately after scene has moved onscreen:
function scene:show( event )
end

-- Hide Scene
function scene:hide( event )
	native.setKeyboardFocus( nil )
	if grpSignIn then
		grpSignIn:removeSelf()
	end
	if grpSignUp then
		grpSignUp:removeSelf()
	end
	if grpMain then
		grpMain:removeSelf()
	end
end

-- Remove Scene
function scene:destroy( event )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene