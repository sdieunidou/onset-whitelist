local package_name = GetPackageName()
local log = require( ( 'packages/%s/util/log' ):format( package_name ) )
local open = io.open
local whitelist_path = ( 'packages/%s/whitelist.json' ):format( package_name )

local whitelist = {}
whitelist.data = {}

local function read_whitelist_file( path )
	local file = open( path, 'rb')
	if ( not file ) then return nil end
	local content = file:read( '*a' )
	file:close()
	return content
end

function whitelist.reload()
	local content = read_whitelist_file( whitelist_path )

	if ( content == nil ) then
		log.info( ( 'Whitelist reloaded but there is not player allowed to join the server! Edit %s !' ):format( whitelist_path ) )
		return false
	end

	local data = json_decode( content )
	if ( data == nil ) then return false end

	for i = 1, #data do
		whitelist.data[ data[ i ] ] = true
	end

	return true
end

function whitelist.isAuthorized( steam_id )
	return whitelist.data[ steam_id ]
end

return whitelist
