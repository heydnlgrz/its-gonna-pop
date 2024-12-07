local playerController = require 'controllers.player-controller'
local class = require 'libraries.30log'
local Player = class("Player")

function Player:load()
  self.mode = "fill"
  self.x = love.graphics.getWidth() / 2
  self.y = love.graphics.getHeight() / 2
  self.isJumping = false
  self.transitionTime = .5
  self.jumpOffset = 15
  self.playerController = playerController:load(self)
  self.sprite = love.graphics.newImage('sprites/basketball.png')
  self.scaleX = .75
  self.scaleY = .75
end

function Player:update(deltaTime)
  self.playerController:update(deltaTime)
end

function Player:draw()
  love.graphics.setColor(1, 1, 1)

  love.graphics.draw(
    self.sprite,
    self.x,
    self.y,
    0,
    self.scaleX,
    self.scaleY,
    self.sprite:getWidth() / 2,
    self.sprite:getHeight() / 2
  )
end

return Player
