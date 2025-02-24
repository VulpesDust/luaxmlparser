local test_err = {}

function test_err.test(luaxmlparser)
    local f = assert(io.open('test/test_err.xml', "rb"))
    local xml = f:read("*all")
    f:close()
    luaxmlparser.parse(xml)
end

return test_err
