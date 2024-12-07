local class = require 'libraries.30log'
local Timer = class("Timer")

function Timer:load()
  self.font = love.graphics.newFont(32)
  self.elapsedTime = 0
end

function Timer:update(deltaTime)
  self.elapsedTime = self.elapsedTime + deltaTime
end

function Timer:draw()
  local minutes = math.floor(self.elapsedTime / 60)
  local seconds = math.floor(self.elapsedTime % 60)
  local timeString = string.format("%02d:%02d", minutes, seconds)

  love.graphics.setFont(self.font)
  love.graphics.setColor(0, 0, 1)
  love.graphics.print(timeString, love.graphics.getWidth() - 110, 10)
end

return Timer
