GUI = {}

function GUI:load()
   self.coins = {}
   self.coins.img = love.graphics.newImage("Game/sprites/Coin1.png")
   self.coins.width = self.coins.img:getWidth()
   self.coins.height = self.coins.img:getHeight()
   self.coins.scale = 2
   self.coins.x = 40
   self.coins.y = 40
   self.font = love.graphics.newFont(36)
   
end

function GUI:update()
    
end

function GUI:draw()
    self:displayCoins()
end

function GUI:displayCoins()
    love.graphics.draw(self.coins.img, self.coins.x, self.coins.y, 0, self.coins.scale, self.coins.scale )
    love.graphics.print(" : "..Player.coins, self.coins.x + self.coins.width * self.coins.scale, self.coins.y + self.coins.height/4 * self.coins.scale)
end