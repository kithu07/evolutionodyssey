_G.love = require("love")
local STI = require("Game.libraries/sti")
require ("Game.player")
require("Game.coin")
love.graphics.setDefaultFilter("nearest", "nearest")
require("Game.gui")
local Camera=require ("Game.camera")
local Enemy=require ("Game.enemy")

function love.load()
    love.graphics.setBackgroundColor(0, 0.5, 0.5)
    Map = STI("Game/maps/final.lua", {"box2d"})
    World = love.physics.newWorld(0,2000)
    World:setCallbacks(beginContact, endContact)
    Map:box2d_init(World)
    Map.layers.solids.visible = false
    Map.layers.entity.visible = false
    MapWidth = Map.layers.elements.width  * 16
    love.graphics.setBackgroundColor(0, 0.5, 0.5)
    Player:load()
    Enemy.loadAssets()
    GUI:load()

    Coin.new(408, 367)
    Coin.new(552, 109)
    Coin.new(773, 410)
    Coin.new(875, 141)
    Coin.new(1084, 32)
    Coin.new(1308, 144)
    Coin.new(1194, 400)
    Coin.new(1372, 312)
    Coin.new(1502, 445)
    Coin.new(1697, 449)
    Coin.new(1828, 329)
    Coin.new(2169.5, 432.5)
    Coin.new(2416.67, 172)
    Coin.new(2558.67, 432.67)
    Coin.new(3052, 420)
    Coin.new(3071, 104)
    Coin.new(3599.33, 104)
    Coin.new(3529, 472)
    Coin.new(3903.33, 302.67)
    Coin.new(3982.67, 476.67)
    Coin.new(4278.67, 410.67)
    Coin.new(4629, 314)

    Enemy.new(700,430)

end

function love.update(dt)
    World:update(dt)
    Player:update(dt)
    Coin: updateAll(dt)
    Enemy.updateAll(dt)
    GUI:update(dt)
    Camera:setPosition(Player.x, 0)
end

function love.draw()
    Map:draw(-Camera.x, -Camera.y, Camera.scale, Camera.scale)
    Camera:apply()   
    Player:draw()
    Coin: drawAll()
    Enemy.drawAll()
    GUI:draw()
    Camera:clear()
end

function love.keypressed(key)
    Player:jump(key)
end

function beginContact(a, b, collision)
    if Coin.beginContact(a, b, collision) then return end
    Enemy.beginContact(a, b, collision)
    Player:beginContact(a, b, collision)
end

function endContact(a, b, collision)
    Player:endContact(a, b, collision)
end

