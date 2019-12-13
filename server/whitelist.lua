local package_name = GetPackageName()
local config = require( ( 'packages/%s/util/config' ):format( package_name ) )
local config_path = ( 'packages/%s/config.json' ):format( package_name )
local i18n = ImportPackage( 'simplei18n' )

local whitelist = {}

whitelist.config = {
	is_enabled = true,
	locale = "en",
	whitelist = {}
}

whitelist.player_list = {}
whitelist.player_count = 0

function whitelist.reload()
	local data = config.load( config_path , whitelist.config)

	i18n.setLocale( data.locale )

	if (type(data) ~= 'table') then
		error( i18n.trans( 'invalid_config', {path = config_path} )  )
		return false
	end

	if ( #data.whitelist < 1 ) then
		error( i18n.trans('whitelist_empty', {path = config_path}) )
		return false
	end

	whitelist.player_list = {}
	whitelist.player_count = #data.whitelist

	for i = 1, #data.whitelist do
		whitelist.player_list[ tostring( data.whitelist[ i ] ) ] = true
	end

	whitelist.config = data

	return true
end

function whitelist.count()
	return whitelist.player_count
end

function whitelist.isWhitelisted( steam_id )
	return (not whitelist.config.is_enabled) or whitelist.player_list[ tostring( steam_id ) ]
end

AddFunctionExport( 'isWhitelisted', whitelist.isWhitelisted )
AddFunctionExport( 'reloadWhitelist', whitelist.reload )

return whitelist
