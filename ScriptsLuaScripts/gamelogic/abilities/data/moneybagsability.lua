module("abilities", package.seeall)
moneyBags = {}
local active = false
moneyBags.settings = {
  [0] = true,
  [1] = true,
  [2] = true
}
function moneyBags.setLevel(level)
  if moneyBags.settings[level] then
    active = moneyBags.settings[level]
  end
end
function moneyBags.getLevel()
  return active
end
