# Whitelist package

Simple whitelist package for your Onset Server

# Requirement

* https://github.com/sdieunidou/onset-i18n

# Install

Add package in `onset/packages/whitelist`, enable it in `server_config.json` and restart your Onset server.

Edit `packages/whitelist/config.json` with the list of steamIDs allowed to join our server and set the locale used by default for the plugin.

Add `whitelist` in `packages` section of `server_config.json` file.

# Reload configuration

You have added new players in your whitelist? Reload plugin configuration with `/whitelist-reload` command. You need to be an administrator to run it.

# Functions

```
AddFunctionExport( 'isWhitelisted', whitelist.isWhitelisted )
AddFunctionExport( 'reloadWhitelist', whitelist.reload )
```

# Configuration example

```
{
    "is_enabled": true,
    "locale": "en",
    "whitelist": [
        "123451234512345",
        "123451234512343"
    ]
}
```

#  Credits

* Onset Server Hosting: https://mtxserv.com/host-server/onset
* Thanks to GCA: https://g-ca.fr/
