local package_name = GetPackageName()
local log = require( ( 'packages/%s/util/log' ):format( package_name ) )
local whitelist = require( ( 'packages/%s/server/whitelist' ):format( package_name ) )

function OnPackageStart()
	 log.info( 'whitelist by mTxServ.com!' )
	 whitelist.reload()
end
AddEvent( 'OnPackageStart', OnPackageStart )

function OnPlayerSteamAuth( player )
	local steam_id = tostring( GetPlayerSteamId( player ) )
	if ( not whitelist.isAuthorized( steam_id ) ) then
		KickPlayer( player, 'You are not allowed to join this server!' )
	end
end
AddEvent( 'OnPlayerSteamAuth', OnPlayerSteamAuth )

AddCommand( 'whitelist-reload', function( player )
	if ( not IsPlayerAdmin( player ) ) then return end
	whitelist.reload()
end)

AddFunctionExport( 'isWhitelisted', whitelist.isAuthorized )
AddFunctionExport( 'reloadWhitelist', whitelist.reload )
