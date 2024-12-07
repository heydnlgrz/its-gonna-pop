local class = require 'libraries.30log'
local enemyClass = require 'characters.enemy'
local EnemiesController = class("EnemiesController")

local function spawn(enemiesController)
  local side = love.math.random(1, 4)
  local x, y
  local spawnOffset = 50

  if side == 1 then
    x = love.math.random(0, love.graphics.getWidth())
    y = -spawnOffset
  elseif side == 2 then
    x = love.graphics.getWidth() + spawnOffset
    y = love.math.random(0, love.graphics.getHeight())
  elseif side == 3 then
    x = love.math.random(0, love.graphics.getWidth())
    y = love.graphics.getHeight() + spawnOffset
  else
    x = -spawnOffset
    y = love.math.random(0, love.graphics.getHeight())
  end

  local enemy = enemyClass:new()
  enemy:load(x, y)
  table.insert(enemiesController.enemies, enemy)
end

function EnemiesController:load()
  self.spawnInterval = 1
  self.maxEnemies = 25
  self.lastSpawnTime = love.timer.getTime()
  self.enemies = {}

  return self
end

function EnemiesController:update(deltaTime)
  local currentTime = love.timer.getTime()

  if currentTime - self.lastSpawnTime >= self.spawnInterval
      and #self.enemies < self.maxEnemies then
    spawn(self)
    self.lastSpawnTime = currentTime
  end

  for i, enemy in ipairs(self.enemies) do
    enemy:update(deltaTime)
  end
end

function EnemiesController:draw()
  for i, enemy in ipairs(self.enemies) do
    enemy:draw()
  end
end

return EnemiesController
