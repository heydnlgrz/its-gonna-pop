local class = require 'libraries.30log'
local Enemy = class("Enemy")

local function setVertices(enemy)
  local secondY = enemy.y + (1 / 3) * enemy.height

  local x1, y1 = enemy.x, enemy.y - (2 / 3) * enemy.height
  local x2, y2 = enemy.x - enemy.sideLenght / 2, secondY
  local x3, y3 = enemy.x + enemy.sideLenght / 2, secondY

  enemy.vertices = { x1 = x1, y1 = y1, x2 = x2, y2 = y2, x3 = x3, y3 = y3 }
end

local function getRandomSpeed()
  return math.random(25, 175)
end

local function move(enemy, deltaTime)
  if not enemy.insideCanvas then
    if (enemy.x >= enemy.sideLenght / 2
          or enemy.x <= love.graphics.getWidth() - enemy.sideLenght / 2)
        and (enemy.y >= enemy.sideLenght / 2
          or enemy.y <= love.graphics.getHeight() - enemy.sideLenght / 2)
    then
      enemy.insideCanvas = true
    end
  else
    enemy.x = enemy.x + enemy.speedX * deltaTime
    enemy.y = enemy.y + enemy.speedY * deltaTime

    if enemy.x - enemy.height / 2 <= 0
        or enemy.x + enemy.height / 2 >= love.graphics.getWidth()
    then
      enemy.speedX = -enemy.speedX
    end

    if enemy.y - enemy.height / 2 <= 0
        or enemy.y + enemy.height / 2 >= love.graphics.getHeight()
    then
      enemy.speedY = -enemy.speedY
    end
  end

  setVertices(enemy)
end

function Enemy:load(x, y)
  self.mode = "fill"
  self.x = x
  self.y = y
  self.sideLenght = 25
  self.insideCanvas = false
  self.height = (math.sqrt(3) / 2) * self.sideLenght

  setVertices(self)

  local speedX = getRandomSpeed()
  local speedY = getRandomSpeed()

  self.speedX = self.x >= love.graphics.getWidth() and -speedX or speedX
  self.speedY = self.y >= love.graphics.getHeight() and -speedY or speedY

  return self
end

function Enemy:update(deltaTime)
  move(self, deltaTime)
end

function Enemy:draw()
  love.graphics.setColor(1, 0, 0)

  love.graphics.polygon(
    self.mode,
    self.vertices.x1, self.vertices.y1,
    self.vertices.x2, self.vertices.y2,
    self.vertices.x3, self.vertices.y3
  )
end

return Enemy
