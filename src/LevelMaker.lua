LevelMaker = Class{}

function LevelMaker.generate()
    local npcs = {}
    local obstacles = {}

    -- create NPCs
    -- create super
    local super = NPC({
        x = 150,
        y = 400,
        scale = 0.7,
        width = 155,
        height = 210,
        texture = 'super',
        text = 'Where is Snout?'
    })
    super.stateMachine = StateMachine({
        ['idle'] = function() return NPCIdleState(super) end,
        ['talk'] = function() return NPCTalkState(super) end
    })
    super:changeState('idle')

    table.insert(npcs, super)

    -- create barrels
    local previous = false
    for i = 500, FIELD_WIDTH - 500, 105 do
        if math.random(3) == 1 then
            if previous and math.random(2) == 1 then
                table.insert(obstacles, GameObject({
                    x = i,
                    y = 480,
                    texture = 'barrel',
                    solid = true,
                    scale = 0.8,
                    width = 140,
                    height = 141
                }))
            end

            table.insert(obstacles, GameObject({
                x = i,
                y = 572,
                texture = 'barrel',
                solid = true,
                scale = 0.8,
                width = 140,
                height = 141
            }))
            previous = true
        elseif previous then
            previous = false
        end
    end

    return GameLevel(npcs, obstacles)
end