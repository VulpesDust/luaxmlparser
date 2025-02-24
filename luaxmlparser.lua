local luaxmlparser = {}

local TAG = '^([^<]*)<(%/?)([^>]-)(%/?)>'

local function trim(s)
    local from = s:match "^%s*()"
    return from > #s and "" or s:match(".*%S", from)
end

return luaxmlparser
