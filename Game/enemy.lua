local Enemy = {}
Enemy.__index = Enemy
local Player = require("Game.player")

local ActiveEnemies = {}

function Enemy.removeAll()
   for i,v in ipairs(ActiveEnemies) do
      table.remove(ActiveEnemies, i)
      v.physics.body:destroy()
      
   end

   ActiveEnemies = {}
end

function Enemy.new(x,y)
   local instance = setmetatable({}, Enemy)
   instance.x = x
   instance.y = y
   instance.r = 0
   instance.speed = 50
   instance.xVel = instance.speed
   instance.damage = 1

   instance.state = "crawl"

   instance.animation = {timer = 0, rate = 0.1}
   instance.animation.crawl = {total = 4, current = 1, img = Enemy.crawlAnim}
   instance.animation.draw = instance.animation.crawl.img[1]
   instance.facingRight = true
   instance.physics = {}
   instance.physics.body = love.physics.newBody(World, instance.x, instance.y, "dynamic")
   instance.physics.body:setFixedRotation(true)
   instance.physics.shape = love.physics.newRectangleShape(instance.width * 0.4, instance.height * 0.75)
   instance.physics.fixture = love.physics.newFixture(instance.physics.body, instance.physics.shape)
   instance.physics.body:setMass(25)
   table.insert(ActiveEnemies, instance)
end

function Enemy.loadAssets()
    Enemy.crawlAnim = {}
    for i=1,4 do
        Enemy.crawlAnim[i] = love.graphics.newImage("Game/sprites/enemy/crawl/"..i..".png")
    end

    Enemy.width = Enemy.crawlAnim[1]:getWidth()
    Enemy.height = Enemy.crawlAnim[1]:getHeight()

end

function Enemy:update(dt)
   self:animate(dt)
   self:syncPhysics()
   self:changeDirection()
end

function Enemy:flipDirection()
   self.facingRight = not self.facingRight
   self.xVel = -self.xVel
 end

function Enemy:animate(dt)
   self.animation.timer = self.animation.timer + dt
   if self.animation.timer > self.animation.rate then
      self.animation.timer = 0
      self:setNewFrame()
   end
end

function Enemy:setNewFrame()
   local anim = self.animation[self.state]
   if anim.current < anim.total then
      anim.current = anim.current + 1
   else
      anim.current = 1
   end
   self.animation.draw = anim.img[anim.current]
end

function Enemy:syncPhysics()
   self.x, self.y = self.physics.body:getPosition()
   self.physics.body:setLinearVelocity(self.xVel , 100)
end

function Enemy:draw()
   local scaleX = 1
   if self.xVel < 0 then
      scaleX = -1
   end
   love.graphics.draw(self.animation.draw, self.x, self.y-15, self.r, 2*scaleX, 2, self.width / 2, self.height / 2)
end

function Enemy.updateAll(dt)
   for i,instance in ipairs(ActiveEnemies) do
      instance:update(dt)
   end
end

function Enemy.drawAll()
   for i,instance in ipairs(ActiveEnemies) do
      instance:draw()
   end
end

function Enemy.beginContact(a, b, collision)
   local playerFixture = Player.physics.fixture
   for i,instance in ipairs(ActiveEnemies) do
      if (a == instance.physics.fixture and b == playerFixture) or (a == playerFixture and b == instance.physics.fixture) then
         Player:takeDamage(instance.damage)
      end
   end
end

function Enemy:changeDirection()
   local enemyX, enemyY = self.physics.body:getPosition()
   if enemyX >= 820 and self.facingRight then
      self:flipDirection()
   elseif enemyX <=600 and not self.facingRight then
      self:flipDirection()
   end
end

return Enemy