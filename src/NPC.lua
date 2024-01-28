NPC = Class{__includes = Entity}

function NPC:init(def)
    Entity.init(self, def)

    -- speech
    self.text = def.text
end

function NPC:update(dt)
    Entity.update(self, dt)
end

function NPC:render()
    Entity.render(self)
end