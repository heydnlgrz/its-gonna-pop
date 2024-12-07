local class = require 'libraries.30log'
local flux = require "libraries.flux"
local PlayerController = class("PlayerController")

local function movePlayer(playerController)
  local x, y = love.mouse.getPosition()

  local oldRadius = playerController.player.radius
  local newRadius = playerController.player.radius * playerController.player.radiusMultiplier

  local jumpOffsetX, jumpOffsetY

  if x > playerController.player.x then
    jumpOffsetX = playerController.player.x - playerController.player.jumpOffset
  else
    jumpOffsetX = playerController.player.x + playerController.player.jumpOffset
  end

  if y > playerController.player.y then
    jumpOffsetY = playerController.player.y - playerController.player.jumpOffset
  else
    jumpOffsetY = playerController.player.y + playerController.player.jumpOffset
  end

  flux.to(playerController.player, playerController.player.transitionTime,
    { x = jumpOffsetX, y = jumpOffsetY, radius = newRadius })
      :onstart(function()
        playerController.player.isJumping = true
      end)
      :oncomplete(function()
        flux.to(playerController.player, playerController.player.transitionTime, { x = x, y = y, radius = oldRadius })
            :oncomplete(function()
              playerController.player.isJumping = false
            end)
      end)
end

function PlayerController:load(player)
  self.player = player

  return self
end

function PlayerController:update(deltaTime)
  if not love.mouse.isDown(1) or self.player.isJumping then
    return
  end

  movePlayer(self)
end

return PlayerController
