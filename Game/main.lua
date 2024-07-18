_G.love = require("love")
local STI = require("Game.libraries/sti")
require ("Game.player")
require("Game.coin")
function love.load()
    love.graphics.setBackgroundColor(0, 0.5, 0.5)
    Map = STI("Game/maps/lvl1.lua", {"box2d"})
    World = love.physics.newWorld(0,0)
    World:setCallbacks(beginContact, endContact)
    Map:box2d_init(World)
    Map.layers.solids.visible = false
    love.graphics.setBackgroundColor(0, 0.5, 0.5)

    Player:load()

    Coin.new(440, 500)
    Coin.new(550, 300)
    Coin.new(660, 355)

end

function love.update(dt)
    World:update(dt)
    Player:update(dt)
    Coin: updateAll(dt)
    
end

function love.draw()
    Map:draw(0, 0)
    
    Player:draw()

    Coin: drawAll()
    
end

function love.keypressed(key)
    Player:jump(key)
end

function beginContact(a, b, collision)
    if Coin.beginContact(a, b, collision) then return end
    Player:beginContact(a, b, collision)
end

function endContact(a, b, collision)
    Player:endContact(a, b, collision)
end