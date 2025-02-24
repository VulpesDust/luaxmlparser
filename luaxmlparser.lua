local luaxmlparser = {}

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

local function parse_xml_tag(xml, f)
end
local function parse_tag(xml, f)

    local c = f.tagstr:sub(1, 1)
    if c ~= '?' and c ~= '!' then
        parse_xml_tag(xml, f)
    end

end

local function parse_text(s)
    s = trim(s)
    for k, v in pairs(ENTITY) do
        s = s:gsub(k, v)
    end
    return s
end

local function get_tag(xml, f)
    f.start_match, f.end_match, f.text, f.close, f.tag, f.selfclose =
        xml:find('^([^<]*)<(%/?)([^>]-)(%/?)>', f.position)
    return f.end_match ~= nil
end

function luaxmlparser.parse(xml)

    local f = {
        stack = {},
        position = 0,
        start_match = 0,
        end_match = 0,
    }

    while f.start_match do
        if not get_tag(xml, f) then
            break
        end

        f.text = parse_text(f.text)
        parse_tag(xml, f)

        f.position = f.end_match + 1
    end

end

return luaxmlparser
