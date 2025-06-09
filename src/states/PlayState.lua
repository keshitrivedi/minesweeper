PlayState = Class{_includes = BaseState}

function PlayState:enter()
end

function PlayState:init()
    self.grid = Grid(16, 16)
end

function PlayState:update(dt)
    self.grid:update(dt)
end

function PlayState:render()
    self.grid:render()
end