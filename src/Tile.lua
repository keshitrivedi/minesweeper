Tile = Class{}

function Tile:init(i, j, w)
    self.i = i
    self.j = j
    self.w = w

    local offsetX = 121
    local offsetY = 9

    self.gridX = i * w
    self.gridY = j * w

    self.x = self.gridX + offsetX
    self.y = self.gridY + offsetY

    self.revealed = false
    self.treasure = false

    self.totalTreasure = 0
    if math.random(6) == 1 then
        self.treasure = true
        self.totalTreasure = self.totalTreasure + 1
    end

    self.mouseActive = false
    self.neighbouringTreasure = 0
end

function Tile:contains(x, y)
    return (x > self.x and x < self.x + self.w and y > self.y and y < self.y + self.w)
end

function Tile:revealTile()
    local click = love.mouse.wasPressed(1)
    if click and self:contains(click.x, click.y) then
        self.revealed = true
    end
end

function Tile:update(dt)
    self:revealTile()
    self.mouseActive = self:contains(MOUSEX, MOUSEY)
end

function Tile:render()
    love.graphics.setColor(1 ,1, 1)

    if self.revealed then
        if self.treasure then
            love.graphics.setColor(1, 1, 0, 1)
        else
            love.graphics.setColor(0, 1, 0, 1)
        end
    end
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.w)
    if self.revealed and (not self.treasure) then
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf(tostring(self.neighbouringTreasure), self.x, self.y, VIRTUAL_WIDTH)
    end

    if self.mouseActive then
        love.graphics.setColor(0, 0, 0 ,1)
        love.graphics.rectangle('line', self.x - 0.5, self.y - 0.5, self.w, self.w)
    end
end