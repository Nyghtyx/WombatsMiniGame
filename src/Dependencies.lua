--[[
    Wombats Platformer
]]

-- libraries
Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

-- utility
require 'src/constants'
require 'src/LevelMaker'
require 'src/StateMachine'
require 'src/Util'

-- game states
require 'src/states/BaseState'
require 'src/states/game/PlayState'

-- player states
require 'src/states/player/PlayerIdleState'
require 'src/states/player/PlayerWalkingState'
require 'src/states/player/PlayerJumpState'
require 'src/states/player/PlayerFallingState'
require 'src/states/player/PlayerFindsSnoutState'

-- npc states
require 'src/states/npc/NPCIdleState'
require 'src/states/npc/NPCTalkState'

-- general classes
require 'src/Animation'
require 'src/Entity'
require 'src/GameLevel'
require 'src/GameObject'
require 'src/NPC'
require 'src/Player'

-- gui classes
require 'src/gui/SpeechBubble'
require 'src/gui/TextBox'

gFonts = {
    ['medium'] = love.graphics.newFont('fonts/bubblegum.woff', 24)
}

gTextures = {
    ['backgrounds'] = love.graphics.newImage('graphics/background/tree-background-large.png'),
    ['field'] = love.graphics.newImage('graphics/background/field.png'),
    ['zeke'] = love.graphics.newImage('graphics/zeke/zeke.png'),
    ['zeke-snout'] = love.graphics.newImage('graphics/zeke/zeke-snout.png'),
    ['super'] = love.graphics.newImage('graphics/super/super.png'),
    ['speech-bubble'] = love.graphics.newImage('graphics/gui/speech-bubble.png'),
    ['barrel'] = love.graphics.newImage('graphics/obstacles/barrel.png'),
    ['snout'] = love.graphics.newImage('graphics/snout/snout.png'),
    ['zeke-finds-snout'] = love.graphics.newImage('graphics/zeke/zeke-finds-snout.png')
}

gFrames = {
    ['zeke'] = GenerateQuads(gTextures['zeke'], 190, 243),
    ['zeke-snout'] = GenerateQuads(gTextures['zeke-snout'], 190, 243),
    ['super'] = GenerateQuads(gTextures['super'], 221, 300),
    ['zeke-finds-snout'] = {love.graphics.newQuad(0, 0, 236, 243, gTextures['zeke-finds-snout']:getDimensions())}
}

gSounds = {
    ['theme'] = love.audio.newSource('sounds/theme.mp3', 'static'),
    ['jump'] = love.audio.newSource('sounds/jump.wav', 'static'),
    ['snout'] = love.audio.newSource('sounds/snout.mp3', 'static')
}