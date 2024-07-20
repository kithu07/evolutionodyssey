_G.love = require("love")
local STI = require("Game.libraries/sti")
require ("Game.player")
require("Game.coin")
love.graphics.setDefaultFilter("nearest", "nearest")
require("Game.gui")
local Camera=require ("Game.camera")

function love.load()
    love.graphics.setBackgroundColor(0, 0.5, 0.5)
    Map = STI("Game/maps/final.lua", {"box2d"})
    World = love.physics.newWorld(0,0)
    World:setCallbacks(beginContact, endContact)
    Map:box2d_init(World)
    Map.layers.solids.visible = false
    MapWidth = Map.layers.elements.width  * 16
    love.graphics.setBackgroundColor(0, 0.5, 0.5)
    Player:load()

    GUI:load()

    Coin.new(440, 500)
    Coin.new(550, 300)
    Coin.new(660, 355)

end

function love.update(dt)
    World:update(dt)
    Player:update(dt)
    Coin: updateAll(dt)
    GUI:update(dt)
    Camera:setPosition(Player.x, 0)
end

function love.draw()
    Map:draw(-Camera.x, -Camera.y, Camera.scale, Camera.scale)
    Camera:apply()   
    Player:draw()
    Coin: drawAll()
    GUI:draw()
    Camera:clear()
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