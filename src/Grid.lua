Grid = Class{}

function Grid:init(cols, rows)
    self.cols = cols
    self.rows = rows

    self:makeGrid(self.cols, self.rows)
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

function Grid:update(dt)
    for i = 1, self.cols do
        for j = 1, self.rows do
            self.tiles[i][j]:update(dt)
        end
    end
end

function Grid:render()
    for y = 1, self.cols do
        for x = 1, self.rows do
            self.tiles[y][x]:render()
        end
    end
end