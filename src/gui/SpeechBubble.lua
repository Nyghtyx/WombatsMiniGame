SpeechBubble = Class{}

function SpeechBubble:init(def)
    self.text = def.text
    self.font = def.font

    self.x = def.x
    self.y = def.y
    self.scale = def.scale

    self.textBox = TextBox({
        x = self.x + 70,
        y = self.y + 40,
        width = 160,
        height = 100,
        text = self.text,
        font = self.font
    })
end

function SpeechBubble:render()
    love.graphics.draw(gTextures['speech-bubble'], self.x, self.y, 0, self.scale)

    self.textBox:render()
end