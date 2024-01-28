PlayerJumpState = Class{__includes = BaseState}

function PlayerJumpState:init(player, gravity)
    self.player = player
    self.gravity = gravity
    self.animation = Animation {
        frames = {8, 9, 10},
        interval = 0.1
    }

    self.player.currentAnimation = self.animation
end

function PlayerJumpState:enter(params)
    gSounds['jump']:play()
    self.player.dy = PLAYER_JUMP_VELOCITY
end

function PlayerJumpState:update(dt)
    self.player.currentAnimation:update(dt)
    self.player.dy = self.player.dy + self.gravity
    self.player.y = self.player.y + self.player.dy * dt

    -- once the y axis velocity turns positive change to falling state
    if self.player.dy >= 0 then
        self.player:changeState('falling')
    end

    if love.keyboard.isDown('left') or (gJoystick and gJoystick:isGamepadDown('dpleft')) then
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

function PlayerJumpState:render()
    love.graphics.draw(gTextures[self.player.texture], gFrames[self.player.texture][self.player.currentAnimation:getCurrentFrame()],
        self.player.x, self.player.y, 0, self.player.direction == 'right' and self.player.scale or -self.player.scale, self.player.scale, self.player.width)
end