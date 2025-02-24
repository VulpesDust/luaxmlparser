local luaxmlparser = require('luaxmlparser')

local function readAll(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("*all")
    f:close()
    return content
end

local xml = readAll('test/test.xml')
luaxmlparser.parse(xml)
