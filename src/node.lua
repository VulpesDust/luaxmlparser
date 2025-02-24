local Node = {}

function Node:new()
    local node = {
        tag = nil,
        children = {},
        attributes = {}
    }

    setmetatable(node, self)
    self.__index = self
    return node
end

return Node
