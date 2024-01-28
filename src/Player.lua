--[[
    Wombat Platformer

    -- Player Class --
]]

Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
    
    -- flag to check if we are carrying snout
    self.snout = false
end

function Player:update(dt)
    Entity.update(self, dt)
end

function Player:render()
    Entity.render(self)
end

function Player:checkProximity(object, x)
    return math.abs(self.x - object.x - object.width / 2) < x
end

function Player:checkObstacleCollision()
    for k, obstacle in pairs(self.level.obstacles) do
        if (self.x  + self.width / 5 > obstacle.x) and (self.y + self.height > obstacle.y + 5) and
            (self.x - self.width / 5 < obstacle.x + obstacle.width)and obstacle.solid then
            return true
        end
    end
    return false
end

function Player:checkBottomCollision()
    local collided = false
    local floor = 1000
    for k, obstacle in pairs(self.level.obstacles) do
        if (self.x + self.width / 5 > obstacle.x) and (self.x - self.width / 5 < obstacle.x + obstacle.width) then
            collided = true
            floor = math.min(floor, obstacle.y + 5 - self.height)
        end
    end
    if collided then
        self.level.floor = floor
    else
        self.level.floor = 550
    end
end
