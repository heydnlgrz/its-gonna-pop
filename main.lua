local flux = require "libraries.flux"
local player = require 'characters.player'
local timer = require 'ui.timer'
local enemiesController = require 'controllers.enemies-controller'

function love.load()
  love.mouse.setGrabbed(true)
  player:load()
  enemiesController:load()
  timer:load()
end

function love.update(deltaTime)
  player:update(deltaTime)
  flux.update(deltaTime)
  timer:update(deltaTime)
  enemiesController:update(deltaTime)
end

function love.draw()
  love.graphics.clear(1, 1, 1)
  player:draw()
  enemiesController:draw()
  timer:draw()
end
