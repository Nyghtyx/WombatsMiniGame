--[[
    Wombats Platformer

    Helper functions
]]

--[[
    Given an "atlas" (a texture with multiple sprites), as well as a width and a height for the sprites therein,
    split the texture into all of the quads by simply dividing it evenly. Useful for equally spaced spritesheets.
]]
function GenerateQuads(atlas, spritewidth, spriteheight)
    local sheetWidth = atlas:getWidth() / spritewidth
    local sheetHeight = atlas:getHeight() / spriteheight

    local sheetCounter = 1
    local spriteSheet = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            spriteSheet[sheetCounter] =
                love.graphics.newQuad(x * spritewidth, y * spriteheight, 
                spritewidth, spriteheight, atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end

    return spriteSheet
end

