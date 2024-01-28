TextBox = Class{}

function TextBox:init(def)
    self.x = def.x
    self.y = def.y
    self.width = def.width
    self.height = def.height

    self.text = def.text
    self.font = def.font

    self.lineHeight = self.font:getHeight()
    _, self.wrappedText = self.font:getWrap(self.text, self.width - 20)
    self.totalLines = #self.wrappedText
    self.textHeight = self.lineHeight * self.totalLines
end

function TextBox:render()
    love.graphics.setFont(self.font)
    love.graphics.setColor(0, 0, 0, 1)

    for i, textLine in pairs(self.wrappedText) do
        local textWidth = self.font:getWidth(textLine)
        love.graphics.print(textLine, self.x + 5 - textWidth / 2, self.y - self.textHeight / 4 + (i - 1) * self.lineHeight)
    end
    
    love.graphics.setColor( 1, 1, 1, 1)
end
