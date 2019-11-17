local log = require('packages/'..GetPackageName()..'/util/log')
local open = io.open

local whitelist = {}
whitelist.data= {}

local function read_whitelist_file(path)
    local file = open(path, "rb")
    if not file then return nil end
    local content = file:read "*a"
    file:close()
    return content
end

function whitelist.reload()
  local content = read_whitelist_file('packages/'..GetPackageName()..'/whitelist.json');
  
  if content == nil then
      log.info('whitelist reloaded but there is not player allowed to join the server! Edit packages/'..GetPackageName()..'/whitelist.json !')
      return
  end
  
  local data = json_decode(content)

   for k,v in pairs(data) do
      whitelist.data[v] = v
   end
end

function whitelist.isAuthorized(steamId)
    if whitelist.data[steamId] == nil then
        return false
    end
  
    return true
end

return whitelist
