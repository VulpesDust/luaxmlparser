local Node = {}

function Node:new(tag, attributes)
    local o = {
        tag = tag,
        attributes = attributes or {},
        children = {}
    }

    setmetatable(o, self)
    self.__index = self
    return o
end

return Node
