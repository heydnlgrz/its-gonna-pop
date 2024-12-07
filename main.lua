local player = require 'characters.player'
local flux = require "libraries.flux"

function love.load()
  love.mouse.setGrabbed(true)
  player:load()
end

function love.update(deltaTime)
  player:update(deltaTime)
  flux.update(deltaTime)
end

function love.draw()
  love.graphics.clear(1, 1, 1)
  player:draw()
end
