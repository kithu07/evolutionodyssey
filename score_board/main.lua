-- main.lua

function love.load()
    background = love.graphics.newImage("home/assets/background.jpg")
    font = love.graphics.newFont(24)
    
    boardColor = {1, 0.84, 0}  
    -- Placeholder scores
    highScore = 100
    yourScore = 75

    playAgainButton = {
        x = love.graphics.getWidth() / 2 - 100,
        y = love.graphics.getHeight()/ 1.33 - 150,
        width = 200,
        height = 50
    }
end

function love.update(dt)
    -- No update logic needed for the scoreboard
end

function love.draw()
    local scaleX = love.graphics.getWidth() / background:getWidth()
    local scaleY = love.graphics.getHeight() / background:getHeight()
    love.graphics.draw(background, 0, 0, 0, scaleX, scaleY)
    love.graphics.setColor(boardColor)
    love.graphics.rectangle("fill", love.graphics.getWidth() / 4, love.graphics.getHeight() / 4, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
    

    love.graphics.setColor(0, 0, 0) 
    love.graphics.setFont(font)
    love.graphics.printf("High Score: " .. highScore, 0, love.graphics.getHeight() / 3, love.graphics.getWidth(), "center")
    love.graphics.printf("Your Score: " .. yourScore, 0, love.graphics.getHeight() / 2.5, love.graphics.getWidth(), "center")


    love.graphics.setColor(0.4, 0.4, 1)  
    love.graphics.rectangle("fill", playAgainButton.x, playAgainButton.y, playAgainButton.width, playAgainButton.height)
    love.graphics.setColor(1, 1, 1) 
    love.graphics.printf("PLAY AGAIN", playAgainButton.x, playAgainButton.y + 15, playAgainButton.width, "center")
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 and x >= playAgainButton.x and x <= playAgainButton.x + playAgainButton.width and
       y >= playAgainButton.y and y <= playAgainButton.y + playAgainButton.height then
        -- Call the game screen
        love.filesystem.load("game.lua")()
        love.load()
    end
end
