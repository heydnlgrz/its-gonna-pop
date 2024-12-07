local flux = require "libraries.flux"
local player = require 'characters.player'
local timer = require 'ui.timer'

function love.load()
  love.mouse.setGrabbed(true)
  player:load()
  timer:load()
end

function love.update(deltaTime)
  player:update(deltaTime)
  flux.update(deltaTime)
  timer:update(deltaTime)
end

function love.draw()
  love.graphics.clear(1, 1, 1)
  player:draw()
  timer:draw()
end
