local Node = {}

function Node:new(tag, attributes)
    local node = {
        tag = tag,
        attributes = attributes or {},
        children = {}
    }

    setmetatable(node, self)
    self.__index = self
    return node
end

return Node
