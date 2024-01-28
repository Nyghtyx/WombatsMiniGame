--[[
    Wombats Platformer
]]

PlayState = Class{__includes = BaseState}

function PlayState:init()
    -- camera position
    self.camX = 0
    self.camY = 0
    
    self.backgroundX = 0
    self.fieldX = 0

    self.gravityOn = true
    self.gravityAmount = 12
end

function PlayState:enter(params)
    gSounds['theme']:setLooping(true)
    gSounds['theme']:setVolume(0.4)
    gSounds['theme']:play()

    -- generate the level
    self.level = LevelMaker.generate()

    -- create player
    self.player = Player({
        x = 400,
        y = 150,
        scale = 0.5,
        width = 190,
        height = 243,
        texture = 'zeke',
        level = self.level,
        stateMachine = StateMachine {
            ['idle'] = function() return PlayerIdleState(self.player) end,
            ['walking'] = function() return PlayerWalkingState(self.player) end,
            ['jump'] = function() return PlayerJumpState(self.player, self.gravityAmount) end,
            ['falling'] = function() return PlayerFallingState(self.player, self.gravityAmount) end,
            ['finds-snout'] = function() return PlayerFindsSnoutState(self.player) end
        }
    })

    self.player:changeState('falling')
end  

function PlayState:update(dt)
    self.level:update(dt)
    self.player:update(dt)
    self:updateCamera()

    if self.player.x <= 0 + self.player.width / 2 then
        self.player.x = 0 + self.player.width / 2
    elseif self.player.x > FIELD_WIDTH - self.player.width / 2 then
        self.player.x = FIELD_WIDTH - self.player.width / 2
    end 
end

function PlayState:render()
    love.graphics.draw(gTextures['backgrounds'], math.floor(-self.backgroundX), -802)

    love.graphics.draw(gTextures['field'], (-self.fieldX), 300)

    -- translate the entire view of the scene to emulate a camera
    love.graphics.translate(-math.floor(self.camX), -math.floor(self.camY))

    self.level:render()
    if not self.player.snout then
        self.level.snout:render()
    end

    self.player:render() 
end

-- function that adjust the camera movement depending on the players position
function PlayState:updateCamera()
    -- clamp movement of the camera's X between 0 and the map bounds
    -- setting it half the screen to the left of the player so they are in the center
    self.camX = math.max(0, math.min(FIELD_WIDTH - VIRTUAL_WIDTH, self.player.x - (VIRTUAL_WIDTH / 2)))

    -- adjust background X to move a third the rate of the camera for parallax
    self.backgroundX = (self.camX / 3)
    -- adjust field X to move at the same speed as the camera
    self.fieldX = self.camX
end