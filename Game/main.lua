_G.love = require("love")
local STI = require("libraries/sti")
require "player"
function love.load()
    love.graphics.setBackgroundColor(0, 0.5, 0.5)
    Map = STI("maps/lvl1.lua", {"box2d"})
    World = love.physics.newWorld(0,0)
    World:setCallbacks(beginContact, endContact)
    Map:box2d_init(World)
    Map.layers.solids.visible = false
    love.graphics.setBackgroundColor(0, 0.5, 0.5)

    Player:load()

end

function love.update(dt)
    World:update(dt)
    Player:update(dt)
    
end

function love.draw()
    Map:draw(0, 0)
    
    Player:draw()
    
end

function love.keypressed(key)
    Player:jump(key)
end

function beginContact(a, b, collision)
    Player:beginContact(a, b, collision)
end

function endContact(a, b, collision)
    Player:endContact(a, b, collision)
end