feedbackSystem.registerAudioPIP("Race away", function(task)
  local instance = task.instance
  local taskObject = task.agent:getTaskObject()
  local timeSensitive = "timeSensitive"
  local sectionPlayed = {
    false,
    false,
    false,
    false,
    false
  }
  local update = function()
  end
  local printCounter = 1
  local function doPrint(text)
    if Commentary.InDebugMode() then
      Development:add2DText(printCounter, text, vec.vector(0.4, 0.75 + printCounter / 33, 0, 0), vec.vector(1, 1, 1, 1), 1, 3)
      printCounter = printCounter + 1
      if printCounter == 5 then
        printCounter = 1
      end
    end
  end
  local function getCurrentRankAudio()
    local ranking = 0
    local carsLeft = 0
    ranking = taskObject.coreData.rank
    for k, v in next, task.instance.taskObjectsByActorID, nil do
      if v.coreData.agent.damage < 1 then
        carsLeft = carsLeft + 1
      end
    end
    if ranking == 1 then
      return "A", index
    elseif ranking == carsLeft and carsLeft > 2 then
      return "C", index
    else
      return "B", index
    end
  end
  local function doRankedAudio()
    local checkpoints = task.networkVars.checkpoints - 1
    local rankLetter = getCurrentRankAudio()
    local multiplier = 6
    if checkpoints > 5 and not sectionPlayed[math.floor(checkpoints / 6)] and (rankLetter ~= "A" or math.floor(checkpoints / 6) ~= 4) then
      sectionPlayed[math.floor(checkpoints / 6)] = feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_" .. math.floor(checkpoints / 6) + 1 .. rankLetter, nil, "missionCritical")
      doPrint("playing " .. "GPMV01_SEQUENCE_L_" .. math.floor(checkpoints / 6) + 1 .. rankLetter)
    elseif not sectionPlayed[math.floor(checkpoints / 6)] and rankLetter == "A" and math.floor(checkpoints / 6) == 4 then
      sectionPlayed[4] = feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP01", nil, "missionCritical")
    end
  end
  local function tryPositionAudio()
    removeUserUpdateFunction("tryPositionAudio")
    if taskObject == localPlayer:getTaskObject() and task.agent.controlled and not didRecentAudio(1) then
      doRankedAudio()
    else
      doPrint("tried audio again -- gave up")
    end
  end
  local function goalComplete(conditionKey)
    if taskObject == localPlayer:getTaskObject() then
      if task.specialName == "race" then
        if conditionKey == 1 then
          local checkpoints = task.networkVars.checkpoints - 1
          if checkpoints > 5 and not sectionPlayed[math.floor(checkpoints / 6)] then
            if not didRecentAudio(2) then
              doRankedAudio()
            else
              local stime = (math.random(6) / 2 + 2.5) * 120
              doPrint("delaying checkpoint audio " .. stime / 120 .. "s")
              addUserUpdateFunction("tryPositionAudio", tryPositionAudio, stime, true)
            end
          end
        else
          instance.taskObjectsByActorID["player Actor"].coreData.agent.desiredSpeed = 90
        end
      elseif task.specialName == "zapped out of enemy racer" then
        local currentRanking = taskObject.coreData.rank
        if currentRanking == 1 then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_2A")
        elseif currentRanking == 2 or currentRanking == 3 then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_2B")
        elseif currentRanking == 4 then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_2C")
        end
      elseif task.specialName == "zap" and (taskObject.namedTasks.race.networkVars.checkpoints - 1 < 7 or taskObject.namedTasks.race.networkVars.checkpoints - 1 > 8) then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_1")
      end
    elseif task.specialName == "Trigger ram cops audio" then
      if localPlayer.currentVehicle == task.instance.taskObjectsByActorID.racer1.coreData.agent then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_4B", nil, timeSensitive)
      elseif localPlayer.currentVehicle == task.instance.taskObjectsByActorID.racer2.coreData.agent then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV03_SEQUENCE_4B", nil, timeSensitive)
      elseif localPlayer.currentVehicle == task.instance.taskObjectsByActorID.racer3.coreData.agent then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV04_SEQUENCE_4B", nil, timeSensitive)
      end
    end
  end
  local function taskComplete(conditionKey)
    if taskObject == localPlayer:getTaskObject() then
      if task.specialName == "race" then
        if conditionKey == 4 then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_8")
        end
      elseif task.specialName == "in player car" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_1", nil, "missionCritical")
      elseif task.specialName == "spotted" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_6")
      elseif task.specialName == "zapped into racer1" then
        local currentRanking = instance.taskObjectsByActorID.racer1.coreData.rank
        if currentRanking == 1 then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_1", nil, "missionCritical")
        elseif currentRanking == 2 or currentRanking == 3 then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_2", nil, "missionCritical")
        elseif currentRanking == 4 then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_3", nil, "missionCritical")
        end
      elseif task.specialName == "zapped into racer2" then
        local currentRanking = instance.taskObjectsByActorID.racer2.coreData.rank
        if currentRanking == 1 then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV03_SEQUENCE_1", nil, "missionCritical")
        elseif currentRanking == 2 or currentRanking == 3 then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV03_SEQUENCE_2", nil, "missionCritical")
        elseif currentRanking == 4 then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV03_SEQUENCE_3", nil, "missionCritical")
        end
      elseif task.specialName == "zapped into racer3" then
        local currentRanking = instance.taskObjectsByActorID.racer3.coreData.rank
        if currentRanking == 1 then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV04_SEQUENCE_1", nil, "missionCritical")
        elseif currentRanking == 2 then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV04_SEQUENCE_2", nil, "missionCritical")
        elseif currentRanking == 4 then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV04_SEQUENCE_3", nil, "missionCritical")
        end
      elseif task.specialName == "lost cops" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_9")
      end
    elseif task.specialName == "Trigger ram racer audio" then
      if localPlayer.currentVehicle == task.instance.taskObjectsByActorID.racer1.coreData.agent then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_4A", nil, timeSensitive)
      elseif localPlayer.currentVehicle == task.instance.taskObjectsByActorID.racer2.coreData.agent then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV03_SEQUENCE_4A", nil, timeSensitive)
      elseif localPlayer.currentVehicle == task.instance.taskObjectsByActorID.racer3.coreData.agent then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV04_SEQUENCE_4A", nil, timeSensitive)
      end
    end
  end
  local cleanup = function()
  end
  return nil, goalComplete, taskComplete, nil
end)
