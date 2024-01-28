NPCTalkState = Class{__includes = BaseState}

function NPCTalkState:init(npc)
    self.npc = npc

    self.animation = Animation {
        frames = {2},
        interval = 1
    }

    self.npc.currentAnimation = self.animation

    self.speechBubble = SpeechBubble({
        text = self.npc.text,
        font = gFonts['medium'],
        x = self.npc.x,
        y = self.npc.y - 70,
        scale = 0.3
    })

    Timer.after(1.5, function() self.npc:changeState('idle') end)
end

function NPCTalkState:render()
    love.graphics.draw(gTextures[self.npc.texture], gFrames[self.npc.texture][self.npc.currentAnimation:getCurrentFrame()],
        self.npc.x, self.npc.y, 0, self.npc.direction == 'right' and self.npc.scale or -self.npc.scale, self.npc.scale, self.npc.width)

    self.speechBubble:render()
end