PlayerIdleState = Class{__includes = BaseState}

function PlayerIdleState:init(player)
    self.player = player

    if self.player.snout then
        self.player.texture = 'zeke-snout'
    else
        self.player.texture = 'zeke'
    end

    self.animation = Animation {
        frames = {1},
        interval = 1
    }

    self.player.currentAnimation = self.animation
end

function PlayerIdleState:update(dt)
    self.player:checkBottomCollision()
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or 
    (gJoystick and gJoystick:isGamepadDown('dpleft')) or (gJoystick and gJoystick:isGamepadDown('dpright')) then
        self.player:changeState('walking')
    end

    if love.keyboard.wasPressed('space') or love.gamepadButtonsPressed['b'] then
        self.player:changeState('jump')
    end

    if love.keyboard.wasPressed('return') or love.gamepadButtonsPressed['a'] then
        for k, npc in pairs(self.player.level.npcs) do
            if self.player:checkProximity(npc, 150) then
                npc:changeState('talk')
            end
        end

        if not self.player.snout and self.player:checkProximity(self.player.level.snout, 100) then
            self.player:changeState('finds-snout')
        end
    end
end

function PlayerIdleState:render()
    love.graphics.draw(gTextures[self.player.texture], gFrames[self.player.texture][self.player.currentAnimation:getCurrentFrame()],
        self.player.x, self.player.y, 0, self.player.direction == 'right' and self.player.scale or -self.player.scale, self.player.scale, self.player.width)
end