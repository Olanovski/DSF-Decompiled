module("cardSystem", package.seeall)
taskCompleteData = taskCompleteData or {}
taskCompleteData["Team checkpoint race"] = {}
taskCompleteData["Team checkpoint race"].taskComplete = function(taskObject, task)
  local damage = 0
  local params = {
    vehicle = localPlayer.currentVehicle,
    cameraShots = cameraShots[task.instance.challenge.taskCompleteData["Camera shots"]],
    successReason = task.instance.challenge.taskCompleteData["Success reason"],
    failReason = task.instance.challenge.taskCompleteData["Failure reason"],
    hint = "ID:235495",
    hintIcon1 = localPlayer.buttonLayout.zapReturn,
    dialogue = ""
  }
  local function completeTask()
    progressionSystem.challengeComplete(task.instance, task.agent.matrix)
  end
  local function failTask()
    progressionSystem.challengeFailed(task.instance, task.agent.matrix)
  end
  local playerTeam, playerTask
  local leftStanding = {}
  for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
    if taskObject.coreData.actor.team then
      leftStanding[taskObject.coreData.actor.team] = leftStanding[taskObject.coreData.actor.team] or 0
      if taskObject.playerTask then
        playerTeam = taskObject.coreData.actor.team
        playerTask = taskObject
      end
      if taskObject.coreData.agent.damage < 1 then
        leftStanding[taskObject.coreData.actor.team] = leftStanding[taskObject.coreData.actor.team] + 1
      end
    end
  end
  if task.specialName == "Checkpoints" then
    if taskObject.playerTask and not task.success then
      if task.condition == 2 or task.condition == 4 then
        params.failReason = "ID:182731"
        params.reason = "Wrecked"
        if 1 <= task.instance.taskObjectsByActorID["Player team member 01"].coreData.agent.damage then
          if localPlayer.currentVehicle == task.instance.taskObjectsByActorID["Player team member 01"].coreData.agent then
            params.dialogue = "GPMV01_FAILURE_L_1"
          elseif localPlayer.currentVehicle == task.instance.taskObjectsByActorID["Player team member 02"].coreData.agent then
            params.dialogue = "GPMV02_FAILURE_L_2"
          end
        elseif 1 <= task.instance.taskObjectsByActorID["Player team member 02"].coreData.agent.damage then
          if localPlayer.currentVehicle == task.instance.taskObjectsByActorID["Player team member 01"].coreData.agent then
            params.dialogue = "GPMV01_FAILURE_L_2"
          elseif localPlayer.currentVehicle == task.instance.taskObjectsByActorID["Player team member 02"].coreData.agent then
            params.dialogue = "GPMV02_FAILURE_L_1"
          end
        end
      elseif task.condition == 3 then
        params.failReason = "ID:186264"
        params.reason = "Busted"
      end
      params.callback = failTask
      params.rating = "FAIL"
      localPlayer.challenge.endScreen(taskObject, params)
    elseif leftStanding["Race team 2"] == 0 then
      params.successReason = "ID:186280"
      params.rating = "PASS"
      params.callback = completeTask
      localPlayer.challenge.endScreen(taskObject, params)
    else
      RaceManager.RacerCrossedFinishLine(task.instance.raceId, taskObject.coreData.agent.gameVehicle)
      if taskObject.coreData.actor.team == playerTeam then
        if taskObject.coreData.agent.damage >= 1 then
          if task.actor.ID == "Player team member 01" then
            if localPlayer.currentVehicle == task.instance.taskObjectsByActorID["Player team member 01"].coreData.agent then
              params.dialogue = "GPMV01_FAILURE_L_1"
            elseif localPlayer.currentVehicle == task.instance.taskObjectsByActorID["Player team member 02"].coreData.agent then
              params.dialogue = "GPMV02_FAILURE_L_2"
            end
          elseif task.actor.ID == "Player team member 02" then
            if localPlayer.currentVehicle == task.instance.taskObjectsByActorID["Player team member 02"].coreData.agent then
              params.dialogue = "GPMV02_FAILURE_L_1"
            elseif localPlayer.currentVehicle == task.instance.taskObjectsByActorID["Player team member 01"].coreData.agent then
              params.dialogue = "GPMV01_FAILURE_L_2"
            end
          end
          params.reason = "Wrecked"
          params.callback = failTask
          params.failReason = "ID:182731"
          params.rating = "FAIL"
          localPlayer.challenge.endScreen(taskObject, params)
        else
          taskObject.coreData.agent.finishedRace = true
          local teamMateAgent, teamMateTaskObject
          for actorID, tO in next, task.instance.taskObjectsByActorID, nil do
            if tO.coreData.actor.team == playerTeam and taskObject ~= tO then
              teamMateTaskObject = tO
              teamMateAgent = tO.coreData.agent
              break
            end
          end
          if not teamMateAgent.finishedRace then
            if taskObject.coreData.agent == localPlayer.currentVehicle then
              localPlayer:zapToAgent(teamMateAgent)
              localPlayer.missionSupport:setMainTaskObject(teamMateTaskObject)
              damage = taskObject.coreData.agent.damage
              feedbackSystem.menusMaster.primaryTextPrompt("ID:182717", nil, false, false, false)
            else
              if teamMateAgent ~= localPlayer.currentVehicle then
                localPlayer.missionSupport:setMainTaskObject(teamMateTaskObject)
              end
              feedbackSystem.menusMaster.primaryTextPrompt("ID:182718", nil, false, false, false)
            end
            taskObject.coreData.agent.iconsVisible = false
            taskObject.coreData.agent.blockReturnZap = true
          else
            if taskObject.coreData.rank == 1 then
              taskObject.coreData.rank = 2
            end
            if localPlayer.currentVehicle == task.instance.taskObjectsByActorID["Player team member 01"].coreData.agent then
              params.vehicle = task.instance.taskObjectsByActorID["Player team member 01"].coreData.agent
              params.dialogue = "GPMV01_SUCCESS_L_1"
            elseif localPlayer.currentVehicle == task.instance.taskObjectsByActorID["Player team member 02"].coreData.agent then
              params.vehicle = task.instance.taskObjectsByActorID["Player team member 02"].coreData.agent
              params.dialogue = "GPMV02_SUCCESS_L_2"
            end
            params.driverIsTanner = true
            params.rating = "PASS"
            params.successReason = "ID:182719"
            params.callback = completeTask
            localPlayer.challenge.endScreen(taskObject, params)
          end
        end
      elseif taskObject.coreData.actor.team ~= playerTeam then
        if taskObject.coreData.agent.damage >= 1 then
          iCamCrashCam(taskObject.coreData.agent.gameVehicle)
          feedbackSystem.menusMaster.minimapTextPrompt("ID:183974")
          RaceManager.RemoveRacer(taskObject.coreData.agent.raceId, taskObject.coreData.agent.gameVehicle)
        elseif 3 > taskObject.coreData.rank then
          if localPlayer.currentVehicle == task.instance.taskObjectsByActorID["Player team member 01"].coreData.agent then
            params.dialogue = "GPMV00_FAILURE_L_3"
          elseif localPlayer.currentVehicle == task.instance.taskObjectsByActorID["Player team member 02"].coreData.agent then
            params.dialogue = "GPMV00_FAILURE_L_4"
          end
          params.reason = "Lost race"
          params.vehicle = taskObject.coreData.agent
          params.failReason = "ID:182607"
          params.callback = failTask
          params.rating = "FAIL"
          localPlayer.challenge.endScreen(taskObject, params)
        end
      end
    end
  elseif task.specialName == "Team Colours - timer" and not task.instance.timedPromptShown and task.instance.challenge.name == "Team colours 01" then
    task.instance.timedPromptShown = true
    feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    feedbackSystem.menusMaster.clearSecondaryTextPrompt()
    feedbackSystem.menusMaster.primaryTextPrompt("ID:182594", nil, false, false, false, localPlayer.buttonLayout.zapReturn)
  elseif task.specialName == "First prompt" and task.agent.controlled and task.instance.challenge.name == "Team colours 01" then
    local prompt = {
      prompt = "ID:182606",
      delay = true,
      priority = 1
    }
    feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
  end
end
