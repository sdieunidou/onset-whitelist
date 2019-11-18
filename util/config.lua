local open = io.open

local config = {}

local function readFile(path)
    local file = open( path, "rb" )
	if not file then return nil end
	
    local content = file:read "*a"
	file:close()
	
    return content
end

function config.load(path, fallbackConfig)
	local content = readFile( path )
	if ( content == nil ) then
		return false
    end

    content = json_decode( content )

    if ( type( content ) ~= 'table' ) then
		return false
    end
    
    for k, v in pairs( content ) do
        fallbackConfig[k] = v
    end

    return fallbackConfig
end

return config
