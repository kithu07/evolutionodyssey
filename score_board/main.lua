-- main.lua

function love.load()
    background = love.graphics.newImage("assets/background.jpg")
    font = love.graphics.newFont(24)
    boardBackground = love.graphics.newImage("assets/brick_wall.jpg")
    
    boardColor = {1, 0.84, 0}  
    -- Placeholder scores
    highScore = 100
    yourScore = 75

    playAgainButton = {
        x = love.graphics.getWidth() / 2 - 175,
        y = love.graphics.getHeight()/ 1.33 - 150,
        width = 150,
        height = 50
    }

    homeButton = {
        x = love.graphics.getWidth() / 2 + 20,
        y = love.graphics.getHeight() / 1.33 - 150,
        width = 150,
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

    local boardX = love.graphics.getWidth() / 4
    local boardY = love.graphics.getHeight() / 4
    local boardWidth = love.graphics.getWidth() / 2
    local boardHeight = love.graphics.getHeight() / 2
    love.graphics.draw(boardBackground, boardX, boardY, 0, boardWidth / boardBackground:getWidth(), boardHeight / boardBackground:getHeight())
    

    love.graphics.setColor(0, 0, 0) 
    love.graphics.setFont(font)
    love.graphics.printf("High Score: " .. highScore, 0, love.graphics.getHeight() / 3, love.graphics.getWidth(), "center")
    love.graphics.printf("Your Score: " .. yourScore, 0, love.graphics.getHeight() / 2.5, love.graphics.getWidth(), "center")


    love.graphics.setColor(0.4, 0.4, 1)  
    love.graphics.rectangle("fill", playAgainButton.x, playAgainButton.y, playAgainButton.width, playAgainButton.height)
    love.graphics.setColor(1, 1, 1) 
    love.graphics.printf("PLAY AGAIN", playAgainButton.x, playAgainButton.y + 15, playAgainButton.width, "center")

    love.graphics.setColor(0.4, 0.4, 1)
    love.graphics.rectangle("fill", homeButton.x, homeButton.y, homeButton.width, homeButton.height)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("HOME", homeButton.x, homeButton.y + 15, homeButton.width, "center")
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 and x >= playAgainButton.x and x <= playAgainButton.x + playAgainButton.width and
       y >= playAgainButton.y and y <= playAgainButton.y + playAgainButton.height then
        goToGamePage()
        
    elseif x >= homeButton.x and x <= homeButton.x + homeButton.width and y >= homeButton.y and y <= homeButton.y + homeButton.height then
        goToHomePage()
    end
end
