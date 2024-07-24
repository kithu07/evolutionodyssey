Enemy_3 = {}
Enemy_3.__index = Enemy_3
local Player = require("Game.player")

local ActiveEnemies = {}

function Enemy_3.removeAll()
   for i,v in ipairs(ActiveEnemies) do
      table.remove(ActiveEnemies, i)
      v.physics.body:destroy()
      
   end

   ActiveEnemies = {}
end

function Enemy_3.new(x,y)
   local instance = setmetatable({}, Enemy_3)
   instance.x = x
   instance.y = y
   instance.r = 0
   instance.speed = -50
   instance.xVel = instance.speed
   instance.damage = 1
   instance.directionTimer = 0

   instance.state = "crawl"

   instance.animation = {timer = 0, rate = 0.1}
   instance.animation.crawl = {total = 4, current = 1, img = Enemy_3.crawlAnim}
   instance.animation.draw = instance.animation.crawl.img[1]
   instance.facingRight = false
   instance.physics = {}
   instance.physics.body = love.physics.newBody(World, instance.x, instance.y, "dynamic")
   instance.physics.body:setFixedRotation(true)
   instance.physics.shape = love.physics.newRectangleShape(instance.width * 0.4, instance.height * 0.75)
   instance.physics.fixture = love.physics.newFixture(instance.physics.body, instance.physics.shape)
   instance.physics.body:setMass(25)
   table.insert(ActiveEnemies, instance)
end

function Enemy_3.loadAssets()
    Enemy_3.crawlAnim = {}
    for i=1,4 do
        Enemy_3.crawlAnim[i] = love.graphics.newImage("Game/sprites/enemy/crawl/"..i..".png")
    end

    Enemy_3.width = Enemy_3.crawlAnim[1]:getWidth()
    Enemy_3.height = Enemy_3.crawlAnim[1]:getHeight()

end

function Enemy_3:update(dt)
   self:animate(dt)
   self:syncPhysics()
   self:changeDirection(dt)
   
end

function Enemy_3:flipDirection()
   self.facingRight = not self.facingRight
   self.xVel = -self.xVel
 end

function Enemy_3:animate(dt)
   self.animation.timer = self.animation.timer + dt
   if self.animation.timer > self.animation.rate then
      self.animation.timer = 0
      self:setNewFrame()
   end
end

function Enemy_3:setNewFrame()
   local anim = self.animation[self.state]
   if anim.current < anim.total then
      anim.current = anim.current + 1
   else
      anim.current = 1
   end
   self.animation.draw = anim.img[anim.current]
end

function Enemy_3:syncPhysics()
   self.x, self.y = self.physics.body:getPosition()
   self.physics.body:setLinearVelocity(self.xVel , 100)
end

function Enemy_3:draw()
   local scaleX = 1
   if self.xVel < 0 then
      scaleX = -1
   end
   love.graphics.draw(self.animation.draw, self.x, self.y-15, self.r, 2*scaleX, 2, self.width / 2, self.height / 2)
end

function Enemy_3.updateAll(dt)
   for i,instance in ipairs(ActiveEnemies) do
      instance:update(dt)
   end
end

function Enemy_3.drawAll()
   for i,instance in ipairs(ActiveEnemies) do
      instance:draw()
   end
end

function Enemy_3.beginContact(a, b, collision)
   local playerFixture = Player.physics.fixture
   for i,instance in ipairs(ActiveEnemies) do
      if (a == instance.physics.fixture and b == playerFixture) or (a == playerFixture and b == instance.physics.fixture) then
         Player:takeDamage(instance.damage)
      end
   end
end

function Enemy_3:changeDirection(dt)
   self.directionTimer = self.directionTimer + dt
   if self.directionTimer >= 3 then
      self:flipDirection()
      self.directionTimer = 0
   end
end
return Enemy_3