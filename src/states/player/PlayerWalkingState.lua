PlayerWalkingState = Class{__includes = BaseState}

function PlayerWalkingState:init(player)
    self.player = player

    if self.player.snout then
        self.player.texture = 'zeke-snout'
    else
        self.player.texture = 'zeke'
    end

    self.animation = Animation {
        frames = {2, 3, 4, 5, 6, 7},
        interval = 0.1
    }
    self.player.currentAnimation = self.animation
end

function PlayerWalkingState:update(dt)
    self.player.currentAnimation:update(dt)
    self.player:checkBottomCollision()

    if self.player.y < self.player.level.floor then
        self.player:changeState('falling')
    end

    -- idle if we are not pressing anything
    if not love.keyboard.isDown('left') and not love.keyboard.isDown('right') and not 
        (gJoystick and gJoystick:isGamepadDown('dpleft')) and not (gJoystick and gJoystick:isGamepadDown('dpright')) then
        self.player:changeState('idle')
    elseif love.keyboard.isDown('left') or (gJoystick and gJoystick:isGamepadDown('dpleft')) then
        self.player.x = self.player.x - PLAYER_WALK_SPEED * dt
        self.player.direction = 'left'
        if self.player:checkObstacleCollision() then
            self.player.x = self.player.x + PLAYER_WALK_SPEED * dt
        end
    elseif love.keyboard.isDown('right') or (gJoystick and gJoystick:isGamepadDown('dpright')) then
        self.player.x = self.player.x + PLAYER_WALK_SPEED * dt
        self.player.direction = 'right'
        if self.player:checkObstacleCollision() then
            self.player.x = self.player.x - PLAYER_WALK_SPEED * dt
        end
    end

    if love.keyboard.wasPressed('space') or love.gamepadButtonsPressed['b'] then
        self.player:changeState('jump')
    end

    if love.keyboard.wasPressed('return') or love.gamepadButtonsPressed['a'] then
        for k, npc in pairs(self.player.level.npcs) do
            if self.player:checkProximity(npc, 100) then
                npc:changeState('talk')
            end
        end

        if not self.player.snout and self.player:checkProximity(self.player.level.snout, 50) then
            self.player:changeState('finds-snout')
        end
    end
end

function PlayerWalkingState:render()
    love.graphics.draw(gTextures[self.player.texture], gFrames[self.player.texture][self.player.currentAnimation:getCurrentFrame()],
        self.player.x, self.player.y, 0, self.player.direction == 'right' and self.player.scale or -self.player.scale, self.player.scale, self.player.width)
end
