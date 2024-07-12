_G.love = require("love")

function love.load()
    anim8 = require "libraries/anim8"
    love.graphics.setDefaultFilter("nearest", "nearest")

    player = {}
    player.x = 400
    player.y = 200
    player.speed = 3
    
    player.spritesheet = love.graphics.newImage("sprites/characters.png")
    player.grid = anim8.newGrid(32, 30, player.spritesheet:getWidth(), player.spritesheet:getHeight())


    player.animations = {}
    player.animations.right = anim8.newAnimation(player.grid('1-4', 1), 0.1)
    player.animations.left = player.animations.right:clone():flipH()

    player.anim = player.animations.right
end

function love.update(dt)
    local ismoving = false

    if love.keyboard.isDown("right") then
        player.x = player.x + player.speed
        player.anim = player.animations.right
        ismoving = true
    end
    
    if love.keyboard.isDown("left") then
        player.x = player.x - player.speed
        player.anim = player.animations.left
        ismoving = true
    end

    if ismoving == false then
        player.anim:gotoFrame(1)
    end
    player.anim:update(dt)
    
end

function love.draw()
        player.anim:draw(player.spritesheet, player.x, player.y, nil, 5, 5)

end