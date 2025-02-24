local luaxmlparser = {}

local TAG = '^([^<]*)<(%/?)([^>]-)(%/?)>'

local function trim(str)
    return str:match "^%s*(.-)%s*$"
end

return luaxmlparser
