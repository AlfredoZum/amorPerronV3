--Include sqlite
local RestManager = {}

	local mime = require("mime")
	local json = require("json")
	local crypto = require("crypto")
	require('src.resources.Globals')
	local DBManager = require('src.resources.DBManager')
	
	local settings = DBManager.getSettings()
	--local site = settings.url

	------------------------------------------------
    -- codifica los mensajes para mandarlo por url
	-- @param str mensaje a codificar
    ------------------------------------------------
	function urlencode(str)
          if (str) then
              str = string.gsub (str, "\n", "\r\n")
              str = string.gsub (str, "([^%w ])",
              function ( c ) return string.format ("%%%02X", string.byte( c )) end)
              str = string.gsub (str, " ", "%%20")
          end
          return str    
    end
	
	---------------------------------- Pantalla Login ----------------------------------
	---------------------------------------------
    -- da de alta un nuevo usuario por facebook
    ---------------------------------------------
	
	
	---------------------------------- Pantalla Login ----------------------------------
	-------------------------------------
    -- da de alta un nuevo usuario
    -------------------------------------
	RestManager.createUser = function(user, email, password, playerId)
		print('entro create')
		local settings = DBManager.getSettings()
        -- Set url
        password = crypto.digest(crypto.md5, password)
		local url = settings.url
		url = url .. "createUserApp"
	
        local function callback(event)
            if ( event.isError ) then
				returnSignIn( "Error intentelo mas tarde", false )
            else
                local data = json.decode(event.response)
				if data then
					if data.success then
						local item = data.item[1]
						DBManager.updateUser(item.id, item.email, item.nombre)
						returnSignIn( data.message, true )
					else
						if data.error then
							returnSignIn( data.error, false )
						else
							returnSignIn( data.message, false )
						end
					end
				else
					returnSignIn( "Error intentelo mas tarde", false )
				end
            end
            return true
        end
        -- Do request

		local headers = {}

		headers["Content-Type"] = "application/x-www-form-urlencoded"
		headers["Accept-Language"] = "en-US"
	
		local strSend = "id=" .. settings.id ..
			"&user=" .. user ..
			"&email=" .. email ..
			"&password=" .. password
	

		local params = {}
		params.headers = headers
		params.body = strSend

		network.request( url, "POST", callback, params )
		
    end
	
	--------------------------
	-- valida el logueo
	-------------------------
	RestManager.validateUser = function( email, password, playerId )
	
		local settings = DBManager.getSettings()
        -- Set url
        password = crypto.digest(crypto.md5, password)
		local url = settings.url
		url = url .. "loginApp"
	
        local function callback(event)
            if ( event.isError ) then
				returnSignIn( "Error intentelo mas tarde", false )
            else
                local data = json.decode(event.response)
				if data then
					if data.success then
						local item = data.item[1]
						DBManager.updateUser(item.id, item.email, item.nombre)
						returnSignIn( data.message, true )
					else
						if data.error then
							returnSignIn( data.error, false )
						else
							returnSignIn( data.message, false )
						end
					end
				else
					returnSignIn( "Error intentelo mas tarde", false )
				end
            end
            return true
        end
        -- Do request

		local headers = {}

		headers["Content-Type"] = "application/x-www-form-urlencoded"
		headers["Accept-Language"] = "en-US"
	
		local strSend = "id=" .. settings.id ..
			"&email=" .. email ..
			"&password=" .. password
	

		local params = {}
		params.headers = headers
		params.body = strSend

		network.request( url, "POST", callback, params )
		
	end
	
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
	
    
	
    ---------------------------------- Metodos Comunes ----------------------------------
    -------------------------------------
    -- Redirije al metodo de la escena
    -- @param obj registros de la consulta
    -------------------------------------
    function goToMethod(obj)
        if obj.name == "HomeAvatars" then
            getFirstCards(obj.items)
		elseif  obj.name == "UserAvatars" then
			getUserPerfil(obj.items[1])
		elseif  obj.name == "MessagesAvatars" then
			setItemsListMessages(obj.items)
		elseif  obj.name == "MessageAvatars" then
			setImagePerfilMessage(obj.items[1])
        elseif  obj.name == "ProfileAvatars" then
			setImagePerfil(obj.items)
        end
    end 
	
	function loadImageUser(item)
		
		local url = ""
		
		local path = "https://amorperron.com/usuarios_perfil/perfil_";
		url = path .. 123354 .. ".jpg";
		--url = path .. item.id .. ".jpg";
		item.image = item.image .. ".jpg"
		
		if item.image == "persona-default" then
			url = "https://amorperron.com/images/persona-default.png";
		else
			local path = "https://amorperron.com/usuarios_perfil/perfil_";
			url = path .. item.id .. ".jpg";
			item.image = item.image .. ".jpg"
		end
		
		--local url = "http://coronalabs.com/images/coronalogogrey.png"
		--local url = "asdsad"
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

    -------------------------------------
    -- Carga de la imagen del servidor o de TemporaryDirectory
    -- @param obj registros de la consulta con la propiedad image
    ------------------------------------- 
    function loadImage(obj)
        -- Next Image
        if obj.idx < #obj.items then
			
            -- actualizamos index
            obj.idx = obj.idx + 1
            -- Determinamos si la imagen existe
           -- local img = obj.items[obj.idx].image
			local img = obj.items[obj.idx].image
            local path = system.pathForFile( img, system.TemporaryDirectory )
            local fhd = io.open( path )
            if fhd then
                -- Existe la imagen
                fhd:close()
                loadImage(obj)
            else
                local function imageListener( event )
                    if ( event.isError ) then
                    else
                        -- Eliminamos la imagen creada
						if event.target then
							event.target:removeSelf()
							event.target = nil
							loadImage(obj)
						else
							obj.items[obj.idx].image = "avatar.png"
							obj.idx = obj.idx - 1
							loadImage(obj)
						end
                    end
                end
                -- Descargamos de la nube
				local url
					
						url = obj.path .. obj.items[obj.idx].id
				
                display.loadRemoteImage( url ,"GET", imageListener, img, system.TemporaryDirectory ) 
            end
        else
            -- Dirigimos al metodo pertinente
            goToMethod(obj)
        end
    end
	
	-------------------------------------
    -- obiene la fecha y hora actual
    -------------------------------------
	RestManager.getDate = function()
		local date = os.date( "*t" )    -- Returns table of date & time values
		local year = date.year
		local month = date.month
		local month2 = date.month
		local day = date.day
		local hour = date.hour
		local minute = date.min
		local segunds = date.sec 
		
		if month < 10 then
			month = "0" .. month
		end
		
		if day < 10 then
			day = "0" .. day
		end
		
		local date1 = year .. "-" .. month .. "-" .. day .. " " .. hour .. ":" .. minute .. ":" .. segunds
		
		local months = {'Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'}
		date2 = day .. " de " .. months[month2] .. " del " .. year
		
		local datesArray = {day = day,month = month,year = year}
		
		return {date1,date2,datesArray}
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
	
return RestManager