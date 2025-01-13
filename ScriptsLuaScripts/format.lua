module("format", package.seeall)
local powArray = {}
for i = 0, 31 do
  powArray[i] = 2 ^ i
end
function binaryListToNumber(list)
  assert(#list < 32, "binaryListToNumber - List size exceeds 32bit int limit")
  local num = powArray[#list]
  for i, value in ipairs(list) do
    if value then
      num = num + powArray[i - 1]
    end
  end
  return num
end
function binaryNumberToList(num, list)
  local list = list or {}
  local max = 1
  while num > powArray[max + 1] do
    max = max + 1
  end
  num = num - powArray[max]
  for i = max, 1, -1 do
    if num - powArray[i - 1] >= 0 then
      num = num - powArray[i - 1]
      list[i] = true
    else
      list[i] = false
    end
  end
  return list
end
function secondsToClock(totalSeconds, formatRule)
  local minutes, seconds, milliseconds
  formatRule = formatRule or "%02d"
  seconds, milliseconds = math.modf(totalSeconds)
  minutes = string.format(formatRule, math.floor(seconds / 60))
  seconds = string.format(formatRule, math.floor(seconds - minutes * 60))
  milliseconds = string.format(formatRule, math.floor(milliseconds * 100))
  return minutes, seconds, milliseconds
end
function rankToString(rank)
  local rankLength = string.len(rank)
  local digit = tonumber(string.sub(rank, rankLength))
  local deca = tonumber(string.sub(rank, rankLength - 1, rankLength - 1))
  if deca ~= 1 and digit < 4 then
    if digit == 1 then
      return rank .. "ST"
    elseif digit == 2 then
      return rank .. "ND"
    else
      return rank .. "RD"
    end
  else
    return rank .. "TH"
  end
end
