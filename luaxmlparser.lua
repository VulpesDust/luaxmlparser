local luaxmlparser = {}

local Node = require('src/node')

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

local function stack_remove(f)
    if #f.stack == 1 then
        table.insert(f.root.children, f.stack[#f.stack])
    end
    table.remove(f.stack)
end

local function parse_xml_tag(xml, f)
    if f.close ~= '/' then
        local tag_name = string.gsub(f.tag, '^(.-)%s.*', '%1')

        local attributes = {}
        local parse_func = function(k, v) attributes[k] = parse_text(v) end
        f.tag:gsub('([%w-:_]+)%s*=%s*"(.-)"', parse_func)
        f.tag:gsub('([%w-:_]+)%s*=%s*\'(.-)\'', parse_func)
        
        local node = Node:new(tag_name, attributes)

        if #f.stack ~= 0 then
            table.insert(f.stack[#f.stack].children, node)
        end
        table.insert(f.stack, node)
        if (f.selfclose == "/") then
            stack_remove(f)
        end
    else
        stack_remove(f)
    end
end

local function parse_tag(xml, f)

    local c = f.tag:sub(1, 1)
    if c ~= '?' and c ~= '!' then
        parse_xml_tag(xml, f)
    end


end

local function get_tag(xml, f)
    f.start_match, f.end_match, f.text, f.close, f.tag, f.selfclose =
        xml:find('^([^<]*)<(%/?)([^>]-)(%/?)>', f.position)
    return f.end_match ~= nil
end

function luaxmlparser.parse(xml)

    local f = {
        stack = {},
        root = {
            children = {}
        },
        position = 0,
        start_match = 0,
        end_match = 0,
    }

    while f.start_match do
        if not get_tag(xml, f) then
            break
        end

        f.text = parse_text(f.text)

        if f.text ~= '' then
            f.stack[#f.stack].text = f.text
        end

        parse_tag(xml, f)

        f.position = f.end_match + 1
    end

end

return luaxmlparser
