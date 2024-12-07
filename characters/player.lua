local playerController = require 'controllers.player-controller'
local class = require 'libraries.30log'
local Player = class("Player")

function Player:load()
  self.mode = "fill"
  self.x = love.graphics.getWidth() / 2
  self.y = love.graphics.getHeight() / 2
  self.radius = 15
  self.radiusMultiplier = 1.5
  self.isJumping = false
  self.transitionTime = .5
  self.jumpOffset = 15
  self.playerController = playerController:load(self)
end

function Player:update(deltaTime)
  self.playerController:update(deltaTime)
end

function Player:draw()
  love.graphics.setColor(0, 0, 0)
  love.graphics.circle(self.mode, self.x, self.y, self.radius)
end

return Player
