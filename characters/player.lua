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
  self.shader = love.graphics.newShader("shaders/light.glsl")
  self.lightSpread = 5
end

function Player:update(deltaTime)
  self.playerController:update(deltaTime)
end

function Player:draw()
  love.graphics.setShader(self.shader)

  self.shader:send("lightPosition", { self.x - self.radius, self.y - self.radius })
  self.shader:send("radius", self.radius * self.lightSpread)

  love.graphics.setColor(1, 1, 1)
  love.graphics.circle(self.mode, self.x, self.y, self.radius)
end

return Player
