Grid = Class{}

function Grid:init(cols, rows)
    self.cols = cols
    self.rows = rows

    self:makeGrid(self.cols, self.rows)
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