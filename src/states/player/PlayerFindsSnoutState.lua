PlayerFindsSnoutState = Class{__includes = BaseState}

function PlayerFindsSnoutState:init(player)
    self.player = player
    self.player.snout = true
    self.player.texture = 'zeke-finds-snout'
    self.animation = Animation {
        frames = {1},
        interval = 1
    }

    self.player.currentAnimation = self.animation
end

function PlayerFindsSnoutState:enter(params)
    gSounds['snout']:play()

    self.player.level.npcs[1].text = "You found Snout!"

    Timer.after(2, function() self.player:changeState('idle') end)
end

function PlayerFindsSnoutState:render()
    love.graphics.draw(gTextures[self.player.texture], gFrames[self.player.texture][self.player.currentAnimation:getCurrentFrame()],
        self.player.x, self.player.y, 0, self.player.direction == 'right' and self.player.scale or -self.player.scale, self.player.scale, self.player.width)
end
