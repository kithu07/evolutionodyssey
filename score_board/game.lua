-- game.lua

function love.load()
    love.window.setTitle("Game Screen")
    love.window.setMode(800, 600)
end

function love.draw()
    love.graphics.print("Game Screen", 320, 240)
end
