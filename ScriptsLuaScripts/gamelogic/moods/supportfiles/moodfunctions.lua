module("moodSystem", package.seeall)
function createMood(t)
  return Mood.new(t)
end
moodStack = {n = 0}
function setupMoodTable(t)
  for k, moodName in next, t, nil do
    assert(moodGroups[moodName], "Mood " .. tostring(moodName) .. " does not exist in moodGroups.lua")
    t[k] = moodGroups[moodName]
  end
end
function initialise()
  print("======== Paradigm Moods initialised ========")
  moodList.default = moodList.ClearDay
  moodList.defaultCar = moodList.ClearDayCar
  for moodName, mood in next, moodList, nil do
    moodSystem[moodName] = createMood(mood.lighting)
  end
  for localID = 0, localPlayerManager.maxNumOfPlayers - 1 do
    Mood.addMoodUserDefined(moodSystem.default, "default", 1, 0.3, -1, localID)
    Mood.addMoodInCar(moodSystem.defaultCar, "defaultCar", 1, 0.3, -1, localID)
    Mood.addMoodPauseMenu(moodSystem.PauseMenu, "PauseMenu", 1, 0.4, localID)
  end
  if configSelector.launchConfig.Name == "Mood editor test" then
    Development:addGraphics(15194, "box", vec.vector(1, 0, 0, 1), vec.vector(-171.0303, 0, 1040.808, 1), vec.vector(1, 0, 0, 0), vec.vector(20, 1000, 20, 0), -1)
    Development:addGraphics(15195, "box", vec.vector(0, 1, 0, 1), vec.vector(-2638.135, 0, 4012.768, 1), vec.vector(1, 0, 0, 0), vec.vector(20, 1000, 20, 0), -1)
    Development:addGraphics(15196, "box", vec.vector(0, 0, 1, 1), vec.vector(903.743, 8.574247, 3531.45, 1), vec.vector(1, 0, 0, 0), vec.vector(20, 1000, 20, 0), -1)
    Development:addGraphics(15197, "box", vec.vector(1, 1, 0, 1), vec.vector(-2719.306, 0, -3167.759, 1), vec.vector(1, 0, 0, 0), vec.vector(20, 1000, 20, 0), -1)
    Development:addGraphics(15198, "box", vec.vector(0, 1, 1, 1), vec.vector(-2440.746, 0, 1122.412, 1), vec.vector(1, 0, 0, 0), vec.vector(20, 1000, 20, 0), -1)
    Development:addGraphics(15199, "box", vec.vector(1, 0, 1, 1), vec.vector(1091.678, 30.22504, -4106.963, 1), vec.vector(1, 0, 0, 0), vec.vector(20, 1000, 20, 0), -1)
  else
    for localID = 0, localPlayerManager.maxNumOfPlayers - 1 do
      Mood.addMoodZapLevel(Zap, "Zap", 1, 1, -1, localID)
      Mood.addMoodZapLevel(Zap, "TopZap1", 2, 1, -1, localId)
      Mood.addMoodZapLevel(TopZap2, "TopZap2", 3, 1, -1, localID)
      Mood.addMoodZapLevel(TopZap3, "TopZap3", 4, 1, -1, localID)
      Mood.addMoodZapLevel(TopZap4, "TopZap4", 5, 1, -1, localID)
    end
  end
  _G.moodList = nil
  createMoodGroups()
  local moodTables = {
    missionStartMoods,
    midMissionMoods,
    chapterMoods
  }
  for __, moodTable in ipairs(moodTables) do
    setupMoodTable(moodTable)
  end
  Mood.useMultiBlending(true)
end
addInitObject(initialise)
function addCutsceneMood(moodName, instanceName, startActivation)
  if moodSystem[moodName] then
    Mood.addMoodCutscene(moodSystem[moodName], instanceName, startActivation)
  end
end
_G.AddCutsceneMood = addCutsceneMood
function updateMood(moodName, attributeGroup, attribute, subAttribute, value)
  local currentMood = Mood.getMood(moodName)
  if currentMood then
    currentMood[attribute] = value
    Mood.addMoodUserDefined(currentMood, moodName, 1, 0, -1)
  end
end
function applyMood(moodName, timeToBlend, blendedCallback)
  local replayable = true
  local moodTable = moodSystem.chapterMoods[moodName] or moodSystem.missionStartMoods[moodName] or moodSystem.midMissionMoods[moodName] or moodGroups[moodName]
  if moodTable and moodTable ~= moodStack[moodStack.n] then
    local replayable = not moodSystem.nonreplayMoods[moodName]
    table.insert(moodStack, moodTable)
    moodStack.n = moodStack.n + 1
    for localID, plr in next, localPlayerManager.players, nil do
      if moodTable.sky then
        sky.requestSkyDome = moodTable.sky
      end
      Mood.addMoodUserDefined(moodTable.main, moodTable.name, 1, timeToBlend or 0, blendedCallback, localID, replayable)
      Mood.addMoodInCar(moodTable.incar, moodTable.name .. "IC", 1, 0, -1, localID, replayable)
    end
  else
    if not moodTable then
      print("Warning: Mood " .. tostring(moodName) .. " not found")
    end
    if blendedCallback then
      blendedCallback()
    end
  end
end
function removeMood(moodName, timeToBlend, blendedCallback)
  local moodTable = moodSystem.chapterMoods[moodName] or moodSystem.missionStartMoods[moodName] or moodSystem.midMissionMoods[moodName] or moodGroups[moodName]
  if moodTable then
    for localID, plr in next, localPlayerManager.players, nil do
      Mood.removeMood(moodTable.name, timeToBlend or 0, blendedCallback or function()
      end, localID)
      Mood.removeMood(moodTable.name .. "IC", timeToBlend or 0, nil, localID)
      for i = moodStack.n, 1, -1 do
        if moodStack[i] == moodTable then
          if i == moodStack.n and moodStack[moodStack.n - 1] and moodStack[moodStack.n - 1].sky and moodTable.sky then
            sky.requestSkyDome = moodStack[moodStack.n - 1].sky
          end
          table.remove(moodStack, i)
          moodStack.n = moodStack.n - 1
          break
        end
      end
    end
  end
end
function clearMoods()
  for i = moodStack.n, 1, -1 do
    removeMood(moodStack[i].name)
  end
end
function addMoodFlash(name, moodName, timeToBlendIn, timeToBlendOut)
  local function removeMood()
    Mood.removeMood(name, timeToBlendOut)
  end
  if moodSystem[moodName] then
    Mood.addMoodUserDefined(moodSystem[moodName], name, 1, timeToBlendIn, removeMood)
  end
end
_G.AddMoodFlash = addMoodFlash
