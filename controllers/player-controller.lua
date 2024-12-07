local class = require 'libraries.30log'
local flux = require "libraries.flux"
local PlayerController = class("PlayerController")

local function movePlayer(playerController)
  local x, y = love.mouse.getPosition()

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

  local oldScaleX = playerController.player.scaleX
  local oldScaleY = playerController.player.scaleY

  flux.to(playerController.player, playerController.player.transitionTime,
    { x = jumpOffsetX, y = jumpOffsetY, scaleX = 1, scaleY = 1 })
      :onstart(function()
        playerController.player.isJumping = true
      end)
      :oncomplete(function()
        flux.to(playerController.player, playerController.player.transitionTime,
          { x = x, y = y, scaleX = oldScaleX, scaleY = oldScaleY })
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
