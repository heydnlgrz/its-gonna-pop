local class = require 'libraries.30log'
local Enemy = class("Enemy")

local function setVertices(enemy)
  local halfSideLenght = enemy.sideLenght / 2
  local height = enemy.height

  local x1, y1 = 0, -(2 / 3) * height
  local x2, y2 = -halfSideLenght, (1 / 3) * height
  local x3, y3 = halfSideLenght, (1 / 3) * height

  local function rotatePoint(x, y)
    local cosTheta = math.cos(enemy.rotation)
    local sinTheta = math.sin(enemy.rotation)

    return x * cosTheta - y * sinTheta, x * sinTheta + y * cosTheta
  end

  x1, y1 = rotatePoint(x1, y1)
  x2, y2 = rotatePoint(x2, y2)
  x3, y3 = rotatePoint(x3, y3)

  x1, y1 = x1 + enemy.x, y1 + enemy.y
  x2, y2 = x2 + enemy.x, y2 + enemy.y
  x3, y3 = x3 + enemy.x, y3 + enemy.y

  enemy.vertices = {
    x1 = x1,
    y1 = y1,
    x2 = x2,
    y2 = y2,
    x3 = x3,
    y3 = y3
  }
end

local function getRandomSpeed()
  return math.random(25, 175)
end

local function updatePosition(enemy, deltaTime)
  enemy.x = enemy.x + enemy.speedX * deltaTime
  enemy.y = enemy.y + enemy.speedY * deltaTime
end

local function move(enemy, deltaTime)
  if not enemy.insideCanvas then
    updatePosition(enemy, deltaTime)
    setVertices(enemy)

    if
        enemy.x >= enemy.sideLenght / 2
        and enemy.x <= love.graphics.getWidth() - enemy.sideLenght / 2
        and enemy.y >= enemy.sideLenght / 2
        and enemy.y <= love.graphics.getHeight() - enemy.sideLenght / 2
    then
      enemy.insideCanvas = true
    end
  else
    updatePosition(enemy, deltaTime)

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
  self.speedX = getRandomSpeed()
  self.speedY = getRandomSpeed()
  self.rotation = 0
  self.rotationSpeed = math.rad(math.random(-360, 360))

  if self.x > love.graphics.getWidth() then
    self.speedX = -self.speedX
  end

  if self.y > love.graphics.getHeight() then
    self.speedY = -self.speedY
  end

  setVertices(self)

  return self
end

function Enemy:update(deltaTime)
  self.rotation = self.rotation + self.rotationSpeed * deltaTime
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
