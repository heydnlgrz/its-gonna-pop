local class = require 'libraries.30log'
local PlayerController = class("PlayerController")
local flux = require "libraries.flux"

function PlayerController:load(player)
  self.player = player
  return self
end

function PlayerController:update(deltaTime)
  if love.mouse.isDown(1) and not self.player.isJumping then
    local x, y = love.mouse.getPosition()

    local oldRadius = self.player.radius
    local newRadius = self.player.radius * self.player.radiusMultiplier

    local jumpOffsetX, jumpOffsetY

    if x > self.player.x then
      jumpOffsetX = self.player.x - self.player.jumpOffset
    else
      jumpOffsetX = self.player.x + self.player.jumpOffset
    end

    if y > self.player.y then
      jumpOffsetY = self.player.y - self.player.jumpOffset
    else
      jumpOffsetY = self.player.y + self.player.jumpOffset
    end

    flux.to(self.player, self.player.transitionTime,
      { x = jumpOffsetX, y = jumpOffsetY, radius = newRadius })
        :onstart(function()
          self.player.isJumping = true
        end)
        :oncomplete(function()
          flux.to(self.player, self.player.transitionTime, { x = x, y = y, radius = oldRadius })
              :oncomplete(function()
                self.player.isJumping = false
              end)
        end)
  end
end

return PlayerController
