GameLevel = Class{}

function GameLevel:init(npcs, obstacles)
    self.npcs = npcs
    self.obstacles = obstacles
    self.floor = 550

    -- create snout
    self.snout = GameObject({
        x = 4400,
        y = 640,
        texture = 'snout',
        scale = 1,
        width = 80,
        height = 49
    })
end

function GameLevel:update(dt)
    for k, npc in pairs(self.npcs) do
        npc:update(dt)
    end

    for k, obstacle in pairs(self.obstacles) do
        obstacle:update(dt)
    end
end

function GameLevel:render()
    for k, npc in pairs(self.npcs) do
        npc:render()
    end

    for k, obstacle in pairs(self.obstacles) do
        obstacle:render()
    end
end