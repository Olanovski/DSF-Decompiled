module("tutorialLoading", package.seeall)
state = "inactive"
local debugOutput = function(output)
  print("[tutorialLoading] : " .. tostring(output))
end
function purge()
  if state ~= "inactive" then
    removeUserUpdateFunction("tutorialLoading")
  end
end
function handleTutorialLoading(ability, level)
  state = "fadeDown"
  loadingSystem.loadingStart()
  print("handleTutorialLoading")
  callStack()
  felony_patrollingVehicleManager.enablePatrollingVehicles(false)
  felony_suspiciousVehicleManager.enableSuspiciousVehicles(false)
  progressionSystem.setTrafficEvents(false)
  activeChallenges.deleteAllInstances()
  local f = handleTutorialLoading_update(ability, level)
  addUserUpdateFunction("tutorialLoading", f, 1)
end
function handleTutorialLoading_update(ability, level)
  local positionToSpool
  local challenge = progressionSystem.abilityHasTutorial(ability, level)
  local tutorial, potID, subType, missionType
  return function()
    if state == "fadeDown" then
      debugOutput("Fade Down")
      state = "fadeDown - active"
      local nextState
      if challenge then
        nextState = "settings"
      else
        nextState = "fadeUp"
      end
      fades.down(function()
        state = nextState
      end)
    elseif state == "settings" then
      tutorial, potID, subType, missionType = progressionSystem.findMissionInProgression(challenge.ID)
      if not localPlayer.inZap and zap.currentUnlockedZapLevel > 0 then
        localPlayer:SetZapLevel(zap.currentUnlockedZapLevel, nil, false, {forcedOut = true})
      end
      for instanceID, instance in next, challengeSystem.instances, nil do
        instance:delete()
      end
      positionToSpool = getSettings(tutorial)
      state = "loadData"
    elseif state == "loadData" then
      state = "loadData - active"
      if positionToSpool then
        loadingSystem.requestSpoolPosition(positionToSpool, headingForSpool)
      end
      loadingSystem.triggerLoadRequest("Loading Challenge Data", function()
        state = "fadeUp"
      end)
    elseif state == "fadeUp" then
      initialise.allLoadingComplete()
      state = "inactive"
      removeUserUpdateFunction("tutorialLoading")
      progressionSystem.applyingChapterSettings = false
      if zap.currentUnlockedZapLevel > 0 then
        localPlayer:SetZapLevel(zap.currentUnlockedZapLevel, nil, false, {forcedOut = true})
      end
      local function callback()
        loadingSystem.loadingComplete()
        presenceSystem.setPresence(10, 143)
        if tutorial and tutorial.ID then
          shop.purchaseAbility(abilities.abilitySlots[ability], level, true)
          progressionSystem.forceStartMission(tutorial.ID)
        else
          progressionSystem.saveGame("When you unlock an ability (" .. name .. ") which doesn't have a tutorial")
        end
      end
      fades.up(callback)
    end
  end
end
function getSettings(tutorial)
  local missionID = tutorial.ID
  local positionToSpool
  if missionID == "Tutorial Mission 01 Boost" then
    positionToSpool = vec.vector(1238.019, 6.166164, 786.8473, 1)
  elseif missionID == "Tutorial Mission 02 Ram" then
    positionToSpool = vec.vector(-173.6287, 18.28612, 1034.217, 1)
  elseif missionID == "Tutorial Mission Rapid Shift" then
    positionToSpool = vec.vector(-3086.812, 2.364358, -317.5791, 1)
  end
  return positionToSpool
end
