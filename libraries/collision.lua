local class               = require 'libraries.30log'
local CollisionController = class("CollisionController")

local function checkCollision(collisionController, player, enemies, gameOverCanvas)
  local hasCollided = false

  for i, enemy in ipairs(enemies) do
    local playerRadius = player.sprite:getHeight() / 2
    local enemyHalfHeight = enemy.height / 2

    local squaredDistance = math.pow(player.x - enemy.x, 2) + math.pow(player.y - enemy.y, 2)

    if math.sqrt(squaredDistance) <= playerRadius + enemyHalfHeight and not player.isJumping then
      love.graphics.setCanvas(gameOverCanvas)
      love.graphics.setFont(collisionController.font)
      love.graphics.setColor(1, 0, 0)
      love.graphics.print("Game over!", love.graphics.getWidth() / 2 - 200, love.graphics.getHeight() / 2 - 50)
      love.graphics.setCanvas()

      hasCollided = true

      break
    end
  end

  return hasCollided
end

function CollisionController:load(player)
  self.font = love.graphics.newFont(72)

  return self
end

function CollisionController:update(deltaTime, player, enemies, gameOverCanvas)
  print(player.isJumping)
  if checkCollision(self, player, enemies, gameOverCanvas) then
    return true
  end
end

return CollisionController
