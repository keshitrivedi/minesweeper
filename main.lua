love.graphics.setDefaultFilter('nearest', 'nearest')
require 'src/Dependencies'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

villagers = love.graphics.newImage('graphics/villagers.png')
villagersQuads = GenerateQuads(villagers, 15, 15)

function love.load()
    math.randomseed(os.time())

    love.window.setTitle('minesweeperr')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true,
        canvas = true
    })

    gStateMachine = StateMachine {
        ['play'] = function() return PlayState() end
    }
    gStateMachine:change('play')

    gSounds = {
        ['hover'] = love.audio.newSource('sounds/hover.mp3', 'static'),
        ['assign'] = love.audio.newSource('sounds/assign.mp3', 'static'),
        ['flag'] = love.audio.newSource('sounds/flag.mp3', 'static'),
        ['treasure'] = love.audio.newSource('sounds/treasure.mp3', 'static'),
        ['yay'] = love.audio.newSource('sounds/yay.mp3', 'static')
    }

    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.mousepressed(x, y, button)
    local mx, my = push:toGame(x, y)
    if mx and my then
        love.mouse.buttonsPressed[button] = {x = mx, y = my}
    end
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.mouse.wasPressed(button)
    return love.mouse.buttonsPressed[button]
end

function love.update(dt)
    local x, y = love.mouse.getPosition()
    MOUSEX, MOUSEY = push:toGame(x, y)

    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}
end

function love.draw()
    push:start()
    gStateMachine:render()
    push:finish()
end