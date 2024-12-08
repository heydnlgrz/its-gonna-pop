local flux                = require "libraries.flux"
local player              = require 'characters.player'
local timer               = require 'ui.timer'
local enemiesController   = require 'controllers.enemies-controller'
local collisionController = require 'libraries.collision'

local gameOverCanvas
local gameStopped         = false

function love.load()
  gameOverCanvas = love.graphics.newCanvas()

  math.randomseed(os.time())
  love.mouse.setGrabbed(true)

  player:load()
  enemiesController:load()
  timer:load()
  collisionController:load()
end

function love.update(deltaTime)
  enemiesController:update(deltaTime)

  if gameStopped then
    return
  end

  player:update(deltaTime)
  flux.update(deltaTime)
  timer:update(deltaTime)

  if collisionController:update(deltaTime, player, enemiesController.enemies, gameOverCanvas) then
    gameStopped = true
  end
end

function love.draw()
  love.graphics.clear(1, 1, 1)

  enemiesController:draw()
  player:draw()
  timer:draw()
  love.graphics.draw(gameOverCanvas, 0, 0)
end
