NPCIdleState = Class{__includes = BaseState}

function NPCIdleState:init(npc)
    self.npc = npc

    self.animation = Animation {
        frames = {1},
        interval = 1
    }

    self.npc.currentAnimation = self.animation
end

function NPCIdleState:render()
    love.graphics.draw(gTextures[self.npc.texture], gFrames[self.npc.texture][self.npc.currentAnimation:getCurrentFrame()],
        self.npc.x, self.npc.y, 0, self.npc.direction == 'right' and self.npc.scale or -self.npc.scale, self.npc.scale, self.npc.width)
end