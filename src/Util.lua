function GenerateQuads(atlas, spriteWidth, spriteHeight)

    local sheetSegmentsX = atlas:getWidth()/spriteWidth
    local sheetSegmentsY = atlas:getHeight()/spriteHeight

    local spriteCounter = 1
    local spriteSheet = {}

    for y = 0, sheetSegmentsY - 1 do
        for x = 0, sheetSegmentsX - 1 do
            spriteSheet[spriteCounter] = love.graphics.newQuad(x*spriteWidth, y*spriteHeight, spriteWidth, spriteHeight, atlas:getDimensions())

            spriteCounter = spriteCounter + 1
        end
    end
    return spriteSheet
end