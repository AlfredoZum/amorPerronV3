--Include RestInfoMenuProfile
local RestInfoMenuProfile = {}

	local mime = require("mime")
	local json = require("json")
	local crypto = require("crypto")
	require('src.resources.Globals')
	local DBManager = require('src.resources.DBManager')
	
	local settings = DBManager.getSettings()
	
	---------------------------------- Pantalla Menu ----------------------------------
	
	--------------------------
	-- valida el logueo
	-------------------------
	RestManager.getInfoUser = function( )
		local settings = DBManager.getSettings()
        -- Set url
		local url = settings.url
		url = url .. "getInfoUser"
	
        local function callback(event)
            if ( event.isError ) then
			print('errora')
				--returnSignIn( "Error intentelo mas tarde", false )
            else
				
                local data = json.decode(event.response)
				if data then
					if data.success then
						--print(event.response)
						local item = data.item[1]
						DBManager.updateUser(item.id, item.email, item.nombre)
						loadImageUser(item)
						--loadImage({idx = 0, name = "menuAvatar", path = "https://amorperron.com/usuarios_perfil/perfil_", items = data.items})
					else
						if data.error then
						--	returnSignIn( data.error, false )
						else
							--returnSignIn( data.message, false )
						end
						print('errorc')
					end
				else
					print('errors')
					--returnSignIn( "Error intentelo mas tarde", false )
				end
            end
            return true
        end
        -- Do request

		local headers = {}

		headers["Content-Type"] = "application/x-www-form-urlencoded"
		headers["Accept-Language"] = "en-US"
	
		local strSend = "id=" .. settings.id

		local params = {}
		params.headers = headers
		params.body = strSend

		network.request( url, "POST", callback, params )
		
	end
	
	function loadImageUser(item)
		
		local url = ""
		
		local path2 = system.pathForFile( "prueba.jpg", system.TemporaryDirectory )
		local fhd = io.open( path2 )
		if fhd then
			fhd:close()
			print('existe')
			-- Existe la imagen
			local destDir = system.TemporaryDirectory  -- Location where the file is stored
			local result, reason = os.remove( system.pathForFile( "prueba.jpg", destDir ) )

			if result then
				print( "File removed" )
			else
				print( "File does not exist", reason )  --> File does not exist    apple.txt: No such file or directory
			end
			
		end
		
		
		local function networkListener( event )
			print(event.phase)
			if ( event.isError ) then
				print( "Network error - download failed: ", event.response )
			elseif ( event.phase == "began" ) then
				print( "Progress Phase: began" )
			elseif ( event.phase == "ended" ) then
				print(event.response.filename)
				print( "Displaying response image file" )
				local myImage = display.newImage( event.response.filename, event.response.baseDirectory, 60, 40 )
				print(json.encode(event.response))
			end
		end

		local params = {}
		params.progress = true

		network.download(
			url,
			"GET",
			networkListener,
			params,
			"userAvatar.jpg",
			system.TemporaryDirectory
		)
		
	end

	--------------------------------------------
    -- comprueba si existe conexion a internet
    --------------------------------------------
	function networkConnection()
		local netConn = require('socket').connect('www.google.com', 80)
		if netConn == nil then
			return false
		end
		netConn:close()
		return true
	end
	
return RestInfoMenuProfile