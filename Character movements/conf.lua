function love.conf(t)
--[[    t.identity = "data/saves"           --save file  'data/saves'
    t.version = "1.0"
    t.console = false
    t.externalstorage = true          --save file in sd card
    t.gammacorrect = true 
]]
    t.window.title = "Practice"
  --t.window.icon = path name for icon
    t.window.width = 700
    t.window.height = 700
    t.window.vsync = 0
    
end
