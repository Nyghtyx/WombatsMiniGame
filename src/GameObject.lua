GameObject = Class{}

function GameObject:init(def)
    self.texture = def.texture

    -- whether it acts as an obstacle or not
    self.solid = def.solid or false

    -- whether it can be interacted with or not
    self.interactable = def.interactable or false

    -- whether it can be consumed or not
    self.consumable = def.consumable or false

    -- dimensions
    self.x = def.x
    self.y = def.y
    self.scale = def.scale
    self.width = def.width * self.scale
    self.height = def.height * self.scale
    

    -- default empty collision callback
    self.onCollide = function() end

    -- default empty interaction callback
    self.onInteract = function() end

    -- default empty consume callback
    self.onConsume = function() end
end

function GameObject:update(dt)
end

function GameObject:render()
    love.graphics.draw(gTextures[self.texture], self.x, self.y, 0, self.scale)
end
