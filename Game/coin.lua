_G.love = require("love")
Coin = {}
Coin.__index = Coin

CollectableCoins={}
function Coin.new(x, y)
    local instance = setmetatable({}, Coin)  
    instance.x = x
    instance.y = y
    instance.img = love.graphics.newImage("sprites/Coin1.png")
    instance.width = instance.img:getWidth()
    instance.height = instance.img:getHeight()
    instance.rotationValue=1
    instance.toRemove = false
    instance.physics ={
        body = love.physics.newBody(World, instance.x, instance.y, "static"),
        shape = love.physics.shape.newRectangleShape(instance.width, instance.height),
        fixture= love.physics.newFixture(instance.physics.body, instance.physics.shape)
    }
    instance.physics.fixture: setSensor(true)
    table.insert(CollectableCoins, instance)
end

function Coin:update(dt)
    self:rotate(dt)
    self:checkRemove()
end

function Coin:checkRemove()
    if toRemove then
        self:collect()
    end
end

function Coin:draw()
    love.graphics.draw(self.img, self.x, self.y, 0, self.rotationValue,1, self.width/2, self.height/2)
end

function Coin.rotate(dt)
    self.rotationValue=math.sin(love.timer.getTime + math.random(0,50))
end

function Coin.updateAll(dt)
    for i, instance in ipairs(CollectableCoins) do
        instance.update(dt)
    end
end

function Coin.drawAll()
    for i, instance in ipairs(CollectableCoins) do
        instance.draw()
    end
end

function Coin.beginContact(a,b,collision)
    for i, instance in ipairs(CollectableCoins) do
        if a==instance.physics.fixture or b== instance.physics.fixture then
            if a==Player.physics.fixture or PLayer.physics.fixture then
                instance.toRemove = true
                return true
            end
        end
    end
end

function Coin: collect()
    for i, instance in ipairs(CollectableCoins) do
        if instance == self then
            Player: incrementCoins()
            self.physics:destroy()
            table.remove(CollectableCoins, i)
        end
    end
end