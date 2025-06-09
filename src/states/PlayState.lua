PlayState = Class{_includes = BaseState}

function PlayState:enter()
end

function PlayState:init()
    self.grid = Grid(16, 16)
    self.gridTiles = self.grid.tiles
end

function PlayState:update(dt)
    self.grid:update(dt)

    if love.keyboard.wasPressed('r') then
        self.grid = Grid(16, 16)
    end

end

function PlayState:yay()
    for i = 1, 16 do
        for j = 1, 16 do
            if self.gridTiles[i][j].revealed and self.gridTiles[i][j].flagged then
                gSounds['yay']:play()
            end
        end
    end
end

function PlayState:render()
    self.grid:render()

    local x = 55
    local y = 84

    for i = 1, 8 do
        love.graphics.draw(villagers, villagersQuads[i], x, y)
        y = y + 15
    end
end