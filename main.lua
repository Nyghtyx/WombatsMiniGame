--[[
    Wombats Platformer
]]

require 'src/Dependencies'

function love.load()
    love.window.setTitle('Work It Out Wombats!')
    math.randomseed(os.time())
    local windowWith, windowHeight = love.graphics.getDimensions()

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, windowWith, windowHeight, {
        fullscreen = true,
        vsync = true,
        resizable = true
    })

    gStateMachine = StateMachine {
        ['play'] = function() return PlayState() end
    }
    gStateMachine:change('play')

    -- empty tables that will be filled with keys we pressed each frame
    love.keyboard.keysPressed = {}
    love.gamepadButtonsPressed = {}

    -- gamepad support
    local joysticks = love.joystick.getJoysticks()
    gJoystick = joysticks[1]
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end

function love.gamepadpressed(joystick, button)
    love.gamepadButtonsPressed[button] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    Timer.update(dt)
    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
    love.gamepadButtonsPressed = {}
end

function love.draw()
    push:start()
    gStateMachine:render()
    push:finish()
end