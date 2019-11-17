local log = require( 'packages/whitelist/util/log' )
local whitelist = require( 'packages/whitelist/server/whitelist' )

function OnPackageStart()
     log.info( 'whitelist by mTxServ.com!' )
     whitelist.reload()
end
AddEvent( 'OnPackageStart', OnPackageStart )

function OnPlayerSteamAuth( player )
    local steamId = tostring( GetPlayerSteamId( player ) )
    if ( not whitelist.isAuthorized( steamId ) ) then
            KickPlayer( player, 'You are not allowed to join this server!' )
    end
end
AddEvent( 'OnPlayerSteamAuth', OnPlayerSteamAuth )

AddCommand( 'whitelist-reload', function( player )
    if ( not IsPlayerAdmin( player ) ) then return end
    whitelist.reload()
end)
