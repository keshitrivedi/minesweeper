Grid = Class{}

function Grid:init(cols, rows)
    self.cols = cols
    self.rows = rows

    self.totalTreasure = 40

    self:makeGrid(self.cols, self.rows)
    self:assignTreasure()
    self:NeighbouringTreasure()
end

function Grid:makeGrid(cols, rows)
    self.tiles = {}
    for i = 1, cols do
        table.insert(self.tiles, {})
        for j = 1, rows do
            table.insert(self.tiles[i], Tile(j, i, 15))
        end
    end
end

function Grid:assignTreasure()
    local assigned = {}

    while #assigned < self.totalTreasure do
        local i = math.random(self.cols)
        local j = math.random(self.rows)

        local isTreasure = false

        for n = 1, #assigned do
            if assigned[n].x == i and assigned[n].y == j then
                isTreasure = true
            end
        end

        if not isTreasure then
            table.insert(assigned, {x = i, y = j})
            self.tiles[i][j].treasure = true
        end
    end
end

function Grid:NeighbouringTreasure()
    for i = 1, self.cols do
        for j = 1, self.rows do
            local tile = self.tiles[i][j]
            if tile.treasure then
                tile.neighbouringTreasure = -1
            else
                local n = 0
                for k = -1, 1 do
                    for l = -1, 1 do
                        local ni = i + k
                        local nj = j + l
                        if (not (k == 0 and l == 0)) and ni >= 1 and ni <= self.cols and nj >= 1 and nj <= self.rows then
                            local neighbor = self.tiles[ni][nj]
                            if neighbor.treasure then
                                n = n + 1
                            end
                        end
                    end
                end
                tile.neighbouringTreasure = n
            end
        end
    end
end

function Grid:uhoh()
    for i = 1, self.cols do
        for j = 1, self.rows do
            self.tiles[i][j].revealed = true
        end
    end
    gSounds['treasure']:play()
end

function Grid:revealTile()
    local clickL = love.mouse.wasPressed(1)
    if clickL then
        for i = 1, self.cols do
            for j = 1, self.rows do
                if self.tiles[i][j]:contains(clickL.x, clickL.y) then
                    if not self.tiles[i][j].treasure then
                        self:floodFill(i, j)
                    else
                        self.tiles[i][j].revealed = true
                    end

                    if self.tiles[i][j].treasure then
                        self:uhoh()
                    end
                end
            end
        end
        gSounds['assign']:play()
    end
end

function Grid:floodFill(i, j)
    local tile = self.tiles[i][j]
    if tile.revealed or tile.treasure then
        return
    end
    tile.revealed = true

    if tile.neighbouringTreasure == 0 then
        for k = -1, 1 do
            for l = -1, 1 do
                local ni = i + k
                local nj = j + l
                if (not (k == 0 and l == 0)) and ni >= 1 and ni <= self.cols and nj >= 1 and nj <= self.rows then
                    self:floodFill(ni, nj)
                end
            end
        end
    end
end

function Grid:flagTile()
    local clickR = love.mouse.wasPressed(2)
    if clickR then
        for i = 1, self.cols do
            for j = 1, self.rows do
                if self.tiles[i][j]:contains(clickR.x, clickR.y) then
                    self.tiles[i][j].flagged = not self.tiles[i][j].flagged
                end
            end
        end
        gSounds['flag']:play()
    end
end

function Grid:update(dt)
    for i = 1, self.cols do
        for j = 1, self.rows do
            self.tiles[i][j]:update(dt)
        end
    end
    self:revealTile()
    self:flagTile()
end

function Grid:render()
    for i = 1, self.cols do
        for j = 1, self.rows do
            self.tiles[i][j]:render()
        end
    end
end