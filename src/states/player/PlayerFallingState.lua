PlayerFallingState = Class{__includes = BaseState}

function PlayerFallingState:init(player, gravity)
    self.player = player
    self.gravity = gravity
    self.animation = Animation {
        frames = {10, 11, 12},
        interval = 0.1
    }

    self.player.currentAnimation = self.animation
end

function PlayerFallingState:update(dt)
    self.player.currentAnimation:update(dt)
    self.player:checkBottomCollision()
    self.player.dy = self.player.dy + self.gravity
    self.player.y = self.player.y + self.player.dy * dt

    -- if we are at floor level go either into walking or idle
    if self.player.y > self.player.level.floor then
        self.player.y = self.player.level.floor
        self.player.dy = 0

        -- set the player to be walking or idle on landing depending on input
        if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
            self.player:changeState('walking')
        else
            self.player:changeState('idle')
        end

        if gJoystick then
            if gJoystick:isGamepadDown('dpleft') or gJoystick:isGamepadDown('dpright') then
                self.player:changeState('walking')
            else
                self.player:changeState('idle')
            end
        end

    elseif love.keyboard.isDown('left') or (gJoystick and gJoystick:isGamepadDown('dpleft')) then
        self.player.direction = 'left'
        self.player.x = self.player.x - PLAYER_WALK_SPEED * dt
        if self.player:checkObstacleCollision() then
            self.player.x = self.player.x + PLAYER_WALK_SPEED * dt
        end
    elseif love.keyboard.isDown('right') or (gJoystick and gJoystick:isGamepadDown('dpright')) then
        self.player.direction = 'right'
        self.player.x = self.player.x + PLAYER_WALK_SPEED * dt
        if self.player:checkObstacleCollision() then
            self.player.x = self.player.x - PLAYER_WALK_SPEED * dt
        end
    end
end

function PlayerFallingState:render()
    love.graphics.draw(gTextures[self.player.texture], gFrames[self.player.texture][self.player.currentAnimation:getCurrentFrame()],
        self.player.x, self.player.y, 0, self.player.direction == 'right' and self.player.scale or -self.player.scale, self.player.scale, self.player.width)
end