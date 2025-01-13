module("vehicleManager", package.seeall)
selfRightingSettings = {
  singlePlayer = {
    timeoutSliding = 4,
    timeoutStopped = 1,
    preFlashTime = 2,
    preFlashPeriod = 0.2,
    postFlashTime = 2,
    postFlashperiod = 0.1,
    retryDelay = 3
  },
  multiPlayer = {
    timeoutSliding = 4,
    timeoutStopped = 1,
    preFlashTime = 2,
    preFlashPeriod = 0.2,
    postFlashTime = 2,
    postFlashperiod = 0.1,
    retryDelay = 3
  }
}
function setSelfRightParameters(key)
  selfRightVehicleList.setTiming(selfRightingSettings[key])
end
local selfRighting = {}
local preAllocatedSelfRightTable = {}
local preAllocatedColourFadeOut = vec.vector(0, 0, 0, 1)
local preAllocatedColourFadeIn = vec.vector(0, 0, 0, 0)
local selfRightCorrectingMissions = {
  ["Generic checkpoint race"] = "Checkpoints",
  ["Test drive"] = "Race",
  ["Exposition part 4"] = "Checkpoint race",
  ["Race away"] = "race",
  ["Avoid the cars"] = "Chase",
  ["Big break 2"] = "Destruction",
  ["Generic challenge race"] = "Checkpoints",
  ["Generic chase challenge"] = "Evader",
  ["Relay race"] = "racerTask",
  ["Generic race activity"] = "Checkpoints",
  ["Generic smash activity"] = "Smash props",
  ["Race away challenge"] = "race",
  ["Relay race activity"] = "racerTask",
  ["Team colours activity"] = "Checkpoints",
  ["Generic checkpoint activity"] = "Checkpoints",
  ["Multiplayer pure race"] = "checkpoints",
  ["Multiplayer sprint race"] = "checkpoints",
  ["Multiplayer checkpoint rush"] = "gateTracking",
  ["Multiplayer team circuit race"] = "gateTracking",
  ["Multiplayer circuit race"] = "checkpoints",
  ["Multiplayer burning rubber"] = "checkpoints"
}
function vehicleTemplate:forceSelfRight()
  local gameVehicle = self.gameVehicle
  local plr = localPlayerManager.getPlayerByGameVehicle(gameVehicle)
  local keepAudio = gameStatus.splitscreenSession
  spooling.fadeIn(preAllocatedColourFadeIn, 0, nil, keepAudio, plr.localID)
  selfRighting[gameVehicle] = nil
  plr:setSelfRighting(nil)
end
function _G.vehicleSelfRight(gameVehicle)
  if not vehicleManager.vehiclesByGameVehicle[gameVehicle] then
    return true
  end
  local fadeTime = 1
  if selfRighting[gameVehicle] or transitions.isInTransition() then
    return false
  else
    local plr = localPlayerManager.getPlayerByGameVehicle(gameVehicle)
    if plr and plr.currentVehicle.controlled then
      local keepAudio = gameStatus.splitscreenSession
      local function fadedBack()
        selfRighting[gameVehicle] = nil
        plr:setSelfRighting(nil)
      end
      function fadedOut()
        local playerTask = plr:getTaskObject()
        if playerTask then
          local challenge = playerTask.coreData.instance.challenge
          local majorOrder = 0
          for k, v in next, playerTask.taskList, nil do
            if k > majorOrder then
              majorOrder = k
            end
          end
          if selfRightCorrectingMissions[challenge.missionType] then
            local target = false
            if not gameStatus.onlineSession and playerTask.namedTasks[selfRightCorrectingMissions[challenge.missionType]] and playerTask.namedTasks[selfRightCorrectingMissions[challenge.missionType]].majorOrder == majorOrder then
              target = playerTask.namedTasks[selfRightCorrectingMissions[challenge.missionType]].dynamicTargets[1].position
            else
              local instance = playerTask.coreData.instance
              if instance then
                if #playerTask.taskList == 1 and (challenge.missionType == "Multiplayer pure race" or challenge.missionType == "Multiplayer sprint race") then
                  local playerObjTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[localPlayer.playerID + 1]]
                  if playerObjTO and playerObjTO.namedTasks[selfRightCorrectingMissions[challenge.missionType]] and playerObjTO.namedTasks[selfRightCorrectingMissions[challenge.missionType]].dynamicTargets then
                    target = playerObjTO.namedTasks[selfRightCorrectingMissions[challenge.missionType]].dynamicTargets[1].position
                  end
                elseif challenge.missionType == "Multiplayer checkpoint rush" or challenge.missionType == "Multiplayer team circuit race" then
                  local package = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
                  if package and package.namedTasks[selfRightCorrectingMissions[challenge.missionType]] and package.namedTasks[selfRightCorrectingMissions[challenge.missionType]] then
                    local allCheckpoints = checkpointSystem.getNoneSyncronisedCheckpoints(instance.instanceID, 1)
                    target = allCheckpoints[package.namedTasks[selfRightCorrectingMissions[challenge.missionType]].networkVars.leadCheckPoint].position
                  end
                elseif challenge.missionType == "Multiplayer circuit race" then
                  if playerTask.namedTasks[selfRightCorrectingMissions[challenge.missionType]] and playerTask.namedTasks[selfRightCorrectingMissions[challenge.missionType]].majorOrder == majorOrder and playerTask.namedTasks[selfRightCorrectingMissions[challenge.missionType]].dynamicTargets then
                    target = playerTask.namedTasks[selfRightCorrectingMissions[challenge.missionType]].dynamicTargets[1].position
                  end
                elseif challenge.missionType == "Multiplayer burning rubber" then
                  local teamTorchTO = false
                  if PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 1 then
                    teamTorchTO = instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[1]]
                  elseif PlayerGamePlay.getPlayerTeam(localPlayer.playerID) == 2 then
                    teamTorchTO = instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
                  end
                  if teamTorchTO and teamTorchTO.namedTasks[selfRightCorrectingMissions[challenge.missionType]] and teamTorchTO.coreData.agent.gameVehicle == gameVehicle and teamTorchTO.namedTasks[selfRightCorrectingMissions[challenge.missionType]].dynamicTargets then
                    target = teamTorchTO.namedTasks[selfRightCorrectingMissions[challenge.missionType]].dynamicTargets[1].position
                  end
                end
              end
            end
            if target then
              local heading = target - plr.position:normalise()
              local currentMatrix = plr.currentVehicle.gameVehicle.matrix
              currentMatrix[2] = heading
              local newMatrix = Reorthonormalise(currentMatrix, 1, 2)
              plr.currentVehicle.gameVehicle.matrix = newMatrix
            end
          end
        end
        if vehicleManager.vehiclesByGameVehicle[gameVehicle] then
          preAllocatedSelfRightTable.gameVehicle = gameVehicle
          GameVehicleResource.selfRight(preAllocatedSelfRightTable)
        end
        if plr.currentVehicle then
          plr:resetCameraMode()
        end
        if Network.isSplitScreenMode() then
          spooling.fadeIn(preAllocatedColourFadeIn, fadeTime, fadedBack, keepAudio, plr.localID, false, nil, true)
        else
          spooling.fadeIn(preAllocatedColourFadeIn, fadeTime, fadedBack, keepAudio, plr.localID, nil, nil, true)
        end
      end
      selfRighting[gameVehicle] = true
      plr:setSelfRighting(true)
      plr.currentVehicle:addTemporaryInvulnerability(3)
      if Network.isSplitScreenMode() then
        spooling.fadeOut(preAllocatedColourFadeOut, fadeTime, fadedOut, keepAudio, plr.localID, false, nil, nil, true)
      else
        spooling.fadeOut(preAllocatedColourFadeOut, fadeTime, fadedOut, keepAudio, plr.localID, nil, nil, nil, true)
      end
      return false
    end
  end
  return true
end
