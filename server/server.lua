local package_name = GetPackageName()
local i18n = ImportPackage( 'simplei18n' ) or error('simplei18n package is missing (https://github.com/sdieunidou/onset-i18n)!')
local whitelist = require( ( 'packages/%s/server/whitelist' ):format( package_name ) )

i18n.setFallbackLocale( "en" )

i18n.load({
  en = {
	not_authorized = 'You are not allowed to join this server!',
	invalid_config = 'Your %{path} has an invalid JSON format. Check it!',
	whitelist_empty = 'Whitelist is empty! Edit %{path}!',
  },
  fr = {
    not_authorized = 'Vous n\'êtes pas autorisé à rejoindre ce serveur!',
	invalid_config = 'Votre fichier %{path} ne respecte pas le format JSON. Corrigez la configuration!',
	whitelist_empty = 'Votre whitelist est vide! Éditez le fichier %{path}!'
  }
})

function OnPackageStart()
	whitelist.reload()
	
	print( ( 'Whitelist loaded - by mTxServ.com! (%d players in whitelist)' ):format(whitelist.count()) )
end
AddEvent( 'OnPackageStart', OnPackageStart )

function OnPlayerSteamAuth( player )
	local steam_id = tostring( GetPlayerSteamId( player ) )
	if ( not whitelist.isWhitelisted( steam_id ) ) then
		KickPlayer( player, i18n.trans( 'not_authorized', { locale = GetPlayerLocale(player) } ) )
	end
end
AddEvent( 'OnPlayerSteamAuth', OnPlayerSteamAuth )

AddCommand( 'whitelist-reload', function( player )
	if ( not IsPlayerAdmin( player ) ) then return end
	whitelist.reload()
end)
