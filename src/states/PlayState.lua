PlayState = Class{_includes = BaseState}

currGame = 1
totalGames = 5
levels = {14, 20, 24, 30, 40}

function PlayState:enter()
end

function PlayState:init()
    self.grid = Grid(16, 16, levels[currGame])
    self.gridTiles = self.grid.tiles
end

function PlayState:update(dt)
    self.grid:update(dt)

    if love.keyboard.wasPressed('r') then
        self.grid = Grid(16, 16, levels[currGame])
    end

    if not self.grid.mineClicked then
        self:yay()
    end

end

function PlayState:yay()
    local allSafeTilesRevealed = true

    for i = 1, 16 do
        for j = 1, 16 do
            local tile = self.gridTiles[i][j]
            if not tile.treasure and not tile.revealed then
                allSafeTilesRevealed = false
                break
            end
        end
        if not allSafeTilesRevealed then
            break
        end
    end

    if allSafeTilesRevealed then
        gSounds['yay']:play()

        if currGame < totalGames then
            currGame = currGame + 1
        else
            currGame = 1
        end

        self.grid = Grid(16, 16, levels[currGame])
        self.gridTiles = self.grid.tiles
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