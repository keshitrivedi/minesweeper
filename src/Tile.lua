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

    if math.random(6) == 1 then
        self.treasure = true
    end
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
end

function Tile:render()
    love.graphics.setColor(1 ,1, 1)

    if self.revealed then
        if self.treasure then
            love.graphics.setColor(1, 1, 0)
        else
            love.graphics.setColor(0, 1, 0)
        end
    end
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.w)
end