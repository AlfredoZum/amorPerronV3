---------------------------------------------------------------------------------
-- Amorperron
---------------------------------------------------------------------------------

--Include sqlite
local dbManager = {}

	require "sqlite3"
	local path, db

	--Open rackem.db.  If the file doesn't exist it will be created
	local function openConnection( )
	    path = system.pathForFile("amorperron.db", system.DocumentsDirectory)
	    db = sqlite3.open( path )
	end

	local function closeConnection( )
		if db and db:isopen() then
			db:close()
		end     
	end
	 
	--Handle the applicationExit event to close the db
	local function onSystemEvent( event )
	    if( event.type == "applicationExit" ) then              
	        closeConnection()
	    end
	end
	
	--obtiene los datos del admin
	dbManager.getSettings = function()
		local result = {}
		openConnection( )
		for row in db:nrows("SELECT * FROM config;") do
			closeConnection( )
			return  row
		end
		closeConnection( )
		return 1
	end
	
	--actualiza la informacion de los usuarios
	dbManager.updateUser = function(idApp, email, name )
		openConnection( )
        local query = "UPDATE config SET id = '"..idApp.."', email = '"..email.."', name = '"..name.."';"
        db:exec( query )
		closeConnection( )
	end
	
	--limpia la tabla de config y filtro
    dbManager.clearUser = function()
        openConnection( )
        local query = "UPDATE config SET idApp = 0, user_email = '', display_name = '';"
        db:exec( query )
		local query = "delete from filter;"
        db:exec( query )
		local query = "INSERT INTO filter VALUES (1, '0', '0000-00-00', '0000-00-00', 1, 1, 18, 99, 'Sí');"
		db:exec( query )
		closeConnection( )
    end

	--Setup squema if it doesn't exist
	dbManager.setupSquema = function()
		openConnection( )
		
		local query = "CREATE TABLE IF NOT EXISTS config (id INTEGER, email TEXT, name TEXT, url TEXT);"
		db:exec( query )

		for row in db:nrows("SELECT id FROM config;") do
            closeConnection( )
            if row.id == 0 then
                return false
            else
                return true
            end
		end
		query = "INSERT INTO config VALUES (0, '', '', 'https://amorperron.com/appc/');"
		db:exec( query )

		closeConnection( )

        return false
	end
	
	--setup the system listener to catch applicationExit
	Runtime:addEventListener( "system", onSystemEvent )

return dbManager