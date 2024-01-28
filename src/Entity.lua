Entity = Class{}

function Entity:init(def)
    -- position
    self.x = def.x
    self.y = def.y

    -- velocity
    self.dx = 0
    self.dy = 0

    -- scale
    self.scale = def.scale or 1

    -- dimensions
    self.width = def.width * self.scale
    self.height = def.height * self.scale

    self.texture = def.texture
    self.stateMachine = def.stateMachine

    self.direction = 'right'

    self.level = def.level
end

function Entity:changeState(state, params)
    self.stateMachine:change(state, params)
end

function Entity:update(dt)
    self.stateMachine:update(dt)
end

function Entity:collides(object)
    return not(self.x > object.x + object.width or object.x > self.x + self.width or
               self.y > object.y + object.height or object.y > self.y + self.height)
end

function Entity:render()
    self.stateMachine:render()
end