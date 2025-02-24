local luaxmlparser = {}

local TAG = '^([^<]*)<(%/?)([^>]-)(%/?)>'
local ENTITY = {
    ["&quot;"] = '"',
    ["&apos;"] = "'",
    ["&lt;"] = "<",
    ["&gt;"] = ">",
    ["&amp;"] = "&"
}

local function trim(s)
    local from = s:match "^%s*()"
    return from > #s and "" or s:match(".*%S", from)
end


local function parse_text(s)
    s = trim(s)
    for k, v in pairs(ENTITY) do
        s = s:gsub(k, v)
    end
    return s
end

function luaxmlparser.parse(xml)


end

return luaxmlparser
