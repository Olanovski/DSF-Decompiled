module("cardSystem", package.seeall)
taskCompleteData = taskCompleteData or {}
taskCompleteData["Generic checkpoint race"] = {}
taskCompleteData["Generic checkpoint race"].taskComplete = function(taskObject, task)
  local playerVehicle
  for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
    if taskObject.playerTask then
      playerVehicle = taskObject.coreData.agent
      break
    end
  end
  local params = {
    vehicle = playerVehicle or taskObject.coreData.agent,
    driverIsTanner = true,
    cameraShots = cameraShots[task.instance.challenge.taskCompleteData["Camera shots"]],
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    passCondition = task.instance.challenge.taskCompleteData["Pass condition"],
    hint = "ID:235494"
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  local stopMusic = function()
    feedbackSystem.stopFreeDriveMusic()
  end
  local count = 0
  local leftStanding = 0
  local numberFinished = 0
  for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
    count = count + 1
    if 1 > taskObject.coreData.agent.damage then
      leftStanding = leftStanding + 1
    end
    if taskObject.coreData.raceFinished then
      numberFinished = numberFinished + 1
    end
  end
  if task.success and task.specialName == "Checkpoints" then
    RaceManager.RacerCrossedFinishLine(task.agent.raceId, taskObject.coreData.agent.gameVehicle)
    if taskObject.playerTask then
      if count > 2 then
        if taskObject.coreData.rank == 1 and leftStanding > 1 then
          params.successReason = "ID:184690"
          params.rating = "PASS"
          params.dialogue = "GPMV01_SUCCESS_L_1"
          params.callback = completeTask
        elseif taskObject.coreData.rank == 2 or leftStanding == 1 then
          params.rating = "PASS"
          if leftStanding == 1 then
            params.successReason = "ID:186280"
            params.passCondition = "ID:186281"
            params.dialogue = "GPMV01_SUCCESS_L_1"
            params.callback = completeTask
          elseif leftStanding == 0 then
            params.dialogue = "GPMV01_FAILURE_L_1"
            params.callback = failTask
            params.failReason = "ID:184015"
            params.reason = "Wrecked"
            params.rating = "FAIL"
          else
            params.dialogue = "GPMV01_SUCCESS_L_2"
            params.successReason = task.instance.challenge.taskCompleteData["Success reason"]
            params.callback = completeTask
          end
        else
          params.dialogue = "GPMV01_FAILURE_L_2"
          params.callback = failTask
          params.reason = "Lost race"
          params.rating = "FAIL"
        end
      else
        params.rating = "PASS"
        if leftStanding == 1 then
          params.successReason = "ID:186280"
          params.passCondition = "ID:186281"
        else
          params.successReason = task.instance.challenge.taskCompleteData["Success reason"]
        end
        params.callback = completeTask
      end
      stopMusic()
      localPlayer.challenge.endScreen(taskObject, params)
    else
      if taskObject.coreData.rank == 1 then
        taskObject.coreData.actor.markerType = "None"
        feedbackSystem.taskSupport.instanceUpdateEvent()
        if count > 2 and leftStanding == 2 then
          params.rating = "PASS"
          params.dialogue = "GPMV01_SUCCESS_L_2"
          params.successReason = task.instance.challenge.taskCompleteData["Success reason"]
          params.callback = completeTask
          stopMusic()
          localPlayer.challenge.endScreen(taskObject, params)
        else
          local prompt = {
            prompt = "ID:184952",
            delay = false,
            priority = 2
          }
          feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
        end
      end
      if task.condition == 1 and (count == 2 or count > 2 and taskObject.coreData.rank == 2) then
        params.dialogue = "GPMV01_FAILURE_L_2"
        params.callback = failTask
        params.reason = "Lost race"
        params.rating = "FAIL"
        stopMusic()
        localPlayer.challenge.endScreen(taskObject, params)
      end
    end
  elseif task.specialName == "Checkpoints" then
    if taskObject.playerTask then
      if task.condition == 2 then
        params.dialogue = "GPMV01_FAILURE_L_1"
        params.failReason = "ID:184015"
        params.reason = "Wrecked"
      else
        params.failReason = "ID:186264"
        params.reason = "Busted"
      end
      params.callback = failTask
      params.rating = "FAIL"
      stopMusic()
      localPlayer.challenge.endScreen(taskObject, params)
    elseif leftStanding == 1 then
      params.rating = "PASS"
      params.successReason = "ID:186280"
      params.passCondition = "ID:186280"
      params.callback = completeTask
      stopMusic()
      localPlayer.challenge.endScreen(taskObject, params)
    elseif leftStanding == 2 and numberFinished == 1 then
      params.rating = "PASS"
      params.dialogue = "GPMV01_SUCCESS_L_2"
      params.successReason = task.instance.challenge.taskCompleteData["Success reason"]
      params.callback = completeTask
      stopMusic()
      localPlayer.challenge.endScreen(taskObject, params)
    elseif task.condition == 2 then
      iCamCrashCam(task.agent.gameVehicle, function()
        feedbackSystem.menusMaster.minimapTextPrompt("ID:183974")
        RaceManager.RemoveRacer(task.agent.raceId, task.agent.gameVehicle)
      end)
    elseif task.condition == 3 then
      feedbackSystem.menusMaster.minimapTextPrompt("ID:232268")
      RaceManager.RemoveRacer(task.agent.raceId, task.agent.gameVehicle)
    end
  end
end
