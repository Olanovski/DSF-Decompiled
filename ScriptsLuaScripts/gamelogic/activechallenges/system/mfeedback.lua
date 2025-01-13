module("activeChallenges")
activeLivesMarkers = {
  minimapMissionIcon = {
    type = "Minimap",
    gadgetID = 199,
    colour = vec.vector(255, 255, 255, 255),
    scale = vec.vector(0.5, 0.5, 0.5, 0.5),
    radius = 40,
    visible = false,
    canrotate = false,
    nofade = true
  },
  missionIcon = {
    type = "World",
    gadgetID = 66,
    scale = vec.vector(1, 1, 1, 0),
    colour = vec.vector(255, 255, 255, 255),
    visible = false,
    facing = true,
    facinginzap = false,
    isoffsetinzap = false
  },
  facingInZapMissionIcon = {
    type = "World",
    gadgetID = 66,
    scale = vec.vector(0.3, 0.3, 0.3, 0.3),
    colour = vec.vector(255, 255, 255, 255),
    radius = 50,
    visible = false,
    facing = true,
    facinginzap = true,
    isoffsetinzap = false
  },
  target = {
    type = "Target",
    gadgetID = 199,
    colour = vec.vector(255, 255, 255, 255),
    radius = 50,
    visible = false,
    twoDMarker = false,
    twoDMarkerRadius = 0,
    flashes = false,
    showDistance = false,
    proximityFlash = true,
    zapBackPrompt = false,
    zapBackPromptAboveCar = false
  }
}
local iconSettings = {
  hideIcons = {
    minimapMissionIcon = false,
    missionIcon = false,
    target = false,
    facingInZapMissionIcon = false
  },
  missileZapMissionIcons = {
    minimapMissionIcon = true,
    missionIcon = true,
    target = false,
    facingInZapMissionIcon = false
  },
  lowZapMissionIcons = {
    minimapMissionIcon = true,
    missionIcon = true,
    target = false,
    facingInZapMissionIcon = true
  },
  highZapMissionIcons = {
    minimapMissionIcon = true,
    missionIcon = false,
    target = true,
    facingInZapMissionIcon = false
  }
}
local missionTypes = {
  premiumRace = {
    worldIcon = 295,
    minimapIcon = 296,
    scale = vec.vector(0.7, 0.7, 0.7, 0)
  },
  premiumAction = {
    worldIcon = 294,
    minimapIcon = 298,
    scale = vec.vector(0.7, 0.7, 0.7, 0)
  },
  premiumStunt = {
    worldIcon = 293,
    minimapIcon = 297,
    scale = vec.vector(0.7, 0.7, 0.7, 0)
  },
  story = {
    worldIcon = 292,
    minimapIcon = 299,
    scale = vec.vector(0.7, 0.7, 0.7, 0)
  },
  locked = {
    worldIcon = 83,
    minimapIcon = 85,
    scale = vec.vector(0.7, 0.7, 0.7, 0)
  }
}
function initialise()
  zapcontroller.setZapIconSizes({
    low = 50,
    mid = 50,
    high = 50,
    top = 50
  })
end
addInitObject(initialise)
drawnInstances = {}
local startUID = function()
  local startUID = 40000
  local range = 1000
  local uidSteps = 1
  local uid = startUID - uidSteps
  return function()
    uid = uid + uidSteps
    if uid >= startUID + range then
      uid = startUID
    end
    return uid
  end
end
local position = vec.vector()
local unlocked = vec.vector(1, 2, 0, 1)
local locked = vec.vector(1, 0, 0, 1)
local offset = vec.vector(0, 3, 0, 0)
local stepsTaken = 0
local stepsToTake = 2 * updates.stepRate
local vehicleHeight
local promptStepsToTake = 1 * updates.stepRate
local promptStepsTaken = 0
local currentMissionName
local getUID = startUID()
local function drawMissionWarmupMarker(drawData)
  local taskObject = drawData.agent:getTaskObject()
  local mission, potID, subType, type = progressionSystem.findMissionInProgression(taskObject.coreData.instance.challenge.name)
  local iconsType = mission.iconType
  if progressionSystem.missionsRemainingBeforeUnlock(subType) and (ProfileSettings.IsTakedownUnlocked() or progressionSystem.getCurrentChapter() > 0) then
    iconsType = "locked"
  end
  if not drawData.agent.controlled and missionTypes[mission.iconType] then
    drawData.markers = drawData.markers or {}
    if drawData.agent.gameVehicle then
      vehicleHeight = drawData.agent.gameVehicle.height
      for k, v in next, activeLivesMarkers, nil do
        if k == "minimapMissionIcon" or k == "target" or k == "facingInZapMissionIcon" then
          v.gadgetID = missionTypes[mission.iconType].minimapIcon
          if iconsType == "locked" then
            v.gadgetID = missionTypes[iconsType].minimapIcon
          end
        else
          if k == "missionIcon" then
            v.offset = vec.vector(0, vehicleHeight + 1.6, 0, 0)
          end
          v.gadgetID = missionTypes[iconsType].worldIcon
          v.scale = missionTypes[iconsType].scale
        end
        v.gameVehicle = drawData.agent.gameVehicle
        drawData.markers[k] = Marker:create(v)
      end
      drawData.iconStatus = hideIcons
    end
  end
  updateMissionWarmupMarkers(zap.getZapLevel())
end
function createMissionWarmupMarker(instance)
  drawnInstances[instance.challenge.name] = {}
  for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
    if taskObject.coreData.actor.previewMovie and taskObject.coreData.agent.isVehicle then
      drawnInstances[instance.challenge.name][actorID] = {
        agent = taskObject.coreData.agent,
        worldID = getUID()
      }
      drawMissionWarmupMarker(drawnInstances[instance.challenge.name][actorID])
    end
  end
end
function updateMissionWarmupMarkers(zapLevel)
  for instanceID, instanceTargets in next, activeChallenges.drawnInstances, nil do
    for actorID, drawData in next, instanceTargets, nil do
      local taskObject = drawData.agent:getTaskObject()
      if taskObject and drawData.markers then
        if zapLevel == 0 then
          currentIconStatus = iconSettings.missileZapMissionIcons
        elseif zapLevel == 1 then
          currentIconStatus = iconSettings.missileZapMissionIcons
        elseif zapLevel > 3 then
          currentIconStatus = iconSettings.highZapMissionIcons
        elseif zapLevel > 1 then
          currentIconStatus = iconSettings.lowZapMissionIcons
        end
        if drawData.iconStatus ~= currentIconStatus then
          drawData.iconStatus = currentIconStatus
          for k, v in next, currentIconStatus, nil do
            if drawData.markers[k] then
              drawData.markers[k].visible = v
            else
              print("Warning: icon " .. tostring(k) .. " not created")
            end
          end
        end
      end
    end
  end
end
function deleteMissionWarmupMarker(instance, instantDelete)
  if drawnInstances[instance.challenge.name] then
    for instanceID, instanceTargets in next, drawnInstances, nil do
      for actorID, drawData in next, instanceTargets, nil do
        if drawnInstances[instance.challenge.name][actorID] then
          if drawData.markers then
            for k, v in next, drawData.markers, nil do
              if instantDelete then
                Marker:delete(v, instantDelete)
              else
                Marker:delete(v)
              end
              drawData.markers[k] = nil
            end
          end
          drawData.markers = nil
        end
      end
    end
    drawnInstances[instance.challenge.name] = nil
  end
end
local playedBillboardLockedCutscene
local triggerCutsceneCallback = function()
  local cutsceneFinished = function()
    local missions = challengeProgressionTable[progressionSystem.currentProgression].missions
    if missions then
      for i, mission in next, missions, nil do
        if mission.doNotSpawn then
          for instanceID, instance in next, challengeSystem.instances, nil do
            if instance.challenge.name == "The debrief" then
              deleteMissionWarmupMarker(instance, false)
            end
          end
          activeChallenges.addMissionToSpawnList(mission, true)
          tannerNarration.playTannerNarration("PostCarDlr4")
          progressionSystem.saveGame("When you unlock Take down")
          feedbackSystem.menusMaster.primaryTextPrompt("ID:245806", false, true, true, false)
          zapcontroller.setActionPoinTracking(vec.vector(-493.9713, 25.62823, 1240.688, 1), 0, 0, localPlayer.localID)
        end
      end
    end
  end
  engineCutscene.playCutscene("ch0_gp_Billboard_Locked", nil, cutsceneFinished)
end
function updateFeedback()
  if feedbackSystem.previewScreen.missionButtonPrompt and feedbackSystem.previewScreen.missionDescription and zapcontroller.ZapInPressed(localPlayer.localID) then
    if not userUpdateFunctions.zapPreviewButtonDelay and feedbackSystem.previewScreen.missionButtonPrompt then
      feedbackSystem.previewScreen.buttonPressed()
    elseif feedbackSystem.previewScreen.missionButtonPrompt then
      feedbackSystem.previewScreen.hideButton()
    end
  end
  if localPlayer.inZap and not vehicleManager.previewVehicleManager.previewVehicle and not feedbackSystem.previewScreen.activityBeingPrompted then
    if not localPlayer:getTaskObject() then
      local gameVehicleSelected = zapcontroller.GetTargetedGameVehicle(localPlayer.localID)
      local agent = vehicleManager.vehiclesByGameVehicle[gameVehicleSelected]
      local zapTaskObject
      if agent then
        zapTaskObject = agent:getTaskObject()
      end
      if zapTaskObject and gameVehicleSelected and zapcontroller.IsVehicleZappable(gameVehicleSelected, localPlayer.localID) then
        if zapTaskObject.coreData.instance.challenge.name == "The debrief" and not ProfileSettings.GetMissionCompleted(cards.ReverseMissionNetworkLookup["Exposition 06 Law Breaker (cop)"]) then
          if zapcontroller.ZapInPressed(localPlayer.localID) and not ProfileSettings.IsTakedownUnlocked() then
            tannerNarration.playTannerNarration("PostCarDlr3")
            CutsceneFiles.tutorials.playTutorial("ID:245636", nil, triggerCutsceneCallback)
            zapcontroller.ShowZapInLockedIcon(localPlayer.localID, true)
            feedbackSystem.previewScreen.hideZapPreview("mission")
            ProfileSettings.SetTakedownUnlocked()
          end
          if ProfileSettings.IsTakedownUnlocked() and not ProfileSettings.GetMissionCompleted(cards.ReverseMissionNetworkLookup["Exposition 06 Law Breaker (cop)"]) then
            return
          end
        end
        if zapTaskObject.coreData.actor.previewMovie and (not feedbackSystem.previewScreen.missionDescription or currentMissionName ~= zapTaskObject.coreData.instance.challenge.name) then
          if progressionSystem.currentProgression == 10 and zapTaskObject.coreData.instance.missionType == "mission" and zapTaskObject.coreData.instance.challenge.name ~= "Tanner & Jones Mission 1" and not ProfileSettings.GetToolTipShown(toolTipLookupTable["City Mission"]) and not ProfileSettings.GetStoryModeComplete() then
            CutsceneFiles.tutorials.playCityMissionTutorial(zapTaskObject, nil, function()
              promptStepsTaken = 0
            end)
          else
            currentMissionName = zapTaskObject.coreData.instance.challenge.name
            feedbackSystem.previewScreen.showPreview("shiftMissionPreview", zapTaskObject.coreData.instance.challenge.name, true)
            if not feedbackSystem.previewScreen.missionButtonPrompt and not feedbackSystem.previewScreen.missionLocked then
              feedbackSystem.previewScreen.showButton()
            end
            promptStepsTaken = 0
          end
        end
        if not feedbackSystem.previewScreen.missionLocked and feedbackSystem.previewScreen.missionDescription and not feedbackSystem.previewScreen.missionButtonPrompt and not feedbackSystem.previewScreen.missionButtonPressed and not userUpdateFunctions.zapPreviewButtonDelay then
          feedbackSystem.previewScreen.showButton(true)
          promptStepsTaken = 0
        end
      elseif feedbackSystem.previewScreen.missionDescription then
        promptStepsTaken = promptStepsTaken + 1
        if feedbackSystem.previewScreen.missionButtonPrompt and not feedbackSystem.previewScreen.missionButtonPressed then
          feedbackSystem.previewScreen.hideButton()
        end
        if promptStepsTaken >= promptStepsToTake then
          feedbackSystem.previewScreen.hideZapPreview("mission")
          currentMissionName = false
        end
      end
    end
  elseif feedbackSystem.previewScreen.missionDescription then
    if userUpdateFunctions.zapPreviewButtonDelay then
      removeUserUpdateFunction("zapPreviewButtonDelay")
    end
    feedbackSystem.previewScreen.missionDescription = false
    feedbackSystem.previewScreen.missionButtonPrompt = false
    currentMissionName = false
  end
end
