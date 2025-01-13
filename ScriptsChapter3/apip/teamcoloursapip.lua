feedbackSystem.registerAudioPIP("Team colours APIP", function(task)
  local taskObject = localPlayer.currentVehicle:getTaskObject()
  local cars = 0
  for k, v in next, task.instance.taskObjectsByActorID, nil do
    cars = cars + 1
  end
  local checkpointNumber = 0
  local division = 7
  local range = 0
  if task.specialName == "Checkpoints" then
    if localPlayer.currentVehicle:getTaskObject() then
      checkpointNumber = #checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
    end
    division = 6
    range = (task.coreData.totalLaps + 1) * checkpointNumber / division
    if task.actor.ID == "Player team member 01" then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_1")
    end
  end
  local audioCheckpoints = {
    [4] = 1,
    [7] = 2,
    [10] = 3,
    [14] = 4,
    [17] = 5
  }
  local playedCheckpoint = {
    false,
    false,
    false,
    false,
    false,
    false
  }
  local audio = {
    {
      [1] = "GPMV01_SEQUENCE_L_1A",
      [2] = "GPMV01_SEQUENCE_L_1B",
      [3] = "GPMV01_SEQUENCE_L_1C",
      [4] = "GPMV01_SEQUENCE_L_1D",
      [5] = "GPMV02_SEQUENCE_L_1A",
      [6] = "GPMV02_SEQUENCE_L_1B",
      [7] = "GPMV02_SEQUENCE_L_1C",
      [8] = "GPMV02_SEQUENCE_L_1D",
      ["played"] = false
    },
    {
      [1] = "GPMV01_SEQUENCE_L_2A",
      [2] = "GPMV01_SEQUENCE_L_2B",
      [3] = "GPMV01_SEQUENCE_L_2C",
      [4] = "GPMV01_SEQUENCE_L_2D",
      [5] = "GPMV02_SEQUENCE_L_2A",
      [6] = "GPMV02_SEQUENCE_L_2B",
      [7] = "GPMV02_SEQUENCE_L_2C",
      [8] = "GPMV02_SEQUENCE_L_2D",
      ["played"] = false
    },
    {
      [1] = "GPMV01_SEQUENCE_L_3A",
      [2] = "GPMV01_SEQUENCE_L_3B",
      [3] = "GPMV01_SEQUENCE_L_3C",
      [4] = "GPMV01_SEQUENCE_L_3D",
      [5] = "GPMV02_SEQUENCE_L_3A",
      [6] = "GPMV02_SEQUENCE_L_3B",
      [7] = "GPMV02_SEQUENCE_L_3C",
      [8] = "GPMV02_SEQUENCE_L_3D",
      ["played"] = false
    },
    {
      [1] = "GPMV01_SEQUENCE_L_4A",
      [2] = "GPMV01_SEQUENCE_L_4B",
      [3] = "GPMV01_SEQUENCE_L_4C",
      [4] = "GPMV01_SEQUENCE_L_4D",
      [5] = "GPMV02_SEQUENCE_L_4A",
      [6] = "GPMV02_SEQUENCE_L_4B",
      [7] = "GPMV02_SEQUENCE_L_4C",
      [8] = "GPMV02_SEQUENCE_L_4D",
      ["played"] = false
    },
    {
      [1] = "GPMV01_SEQUENCE_L_5A",
      [2] = "GPMV01_SEQUENCE_L_5B",
      [3] = "GPMV01_SEQUENCE_L_5C",
      [4] = "GPMV01_SEQUENCE_L_5D",
      [5] = "GPMV02_SEQUENCE_L_5A",
      [6] = "GPMV02_SEQUENCE_L_5B",
      [7] = "GPMV02_SEQUENCE_L_5C",
      [8] = "GPMV02_SEQUENCE_L_5D",
      ["played"] = false
    }
  }
  local zapIntoAudio = {
    ["Race team 2 member 1"] = {
      first = "GPMV03_SEQUENCE_1",
      second = "GPMV03_SEQUENCE_2",
      last = "GPMV03_SEQUENCE_3"
    },
    ["Race team 2 member 2"] = {
      first = "GPMV04_SEQUENCE_1",
      second = "GPMV04_SEQUENCE_2",
      last = "GPMV04_SEQUENCE_3"
    }
  }
  local zapOutAudio = {
    first = "GPZP01_ZAP_2A",
    middle = "GPZP01_ZAP_2B",
    last = "GPZP01_ZAP_2C"
  }
  local function getPositionScenario()
    if task.agent:getTaskObject().coreData.instance.taskObjectsByActorID["Player team member 01"] and localPlayer.currentVehicle == task.agent:getTaskObject().coreData.instance.taskObjectsByActorID["Player team member 01"].coreData.agent then
      if task.agent:getTaskObject().coreData.instance.taskObjectsByActorID["Player team member 01"].coreData.rank < 3 then
        if task.agent:getTaskObject().coreData.instance.taskObjectsByActorID["Player team member 02"] and 3 > task.agent:getTaskObject().coreData.instance.taskObjectsByActorID["Player team member 02"].coreData.rank then
          return 3
        else
          return 1
        end
      elseif task.agent:getTaskObject().coreData.instance.taskObjectsByActorID["Player team member 02"] and 3 > task.agent:getTaskObject().coreData.instance.taskObjectsByActorID["Player team member 02"].coreData.rank then
        return 2
      else
        return 4
      end
    elseif task.instance.taskObjectsByActorID["Player team member 02"] and localPlayer.currentVehicle == task.instance.taskObjectsByActorID["Player team member 02"].coreData.agent then
      if 3 > task.agent:getTaskObject().coreData.instance.taskObjectsByActorID["Player team member 02"].coreData.rank then
        if task.agent:getTaskObject().coreData.instance.taskObjectsByActorID["Player team member 01"] and task.agent:getTaskObject().coreData.instance.taskObjectsByActorID["Player team member 01"].coreData.rank < 3 then
          return 7
        else
          return 5
        end
      elseif task.agent:getTaskObject().coreData.instance.taskObjectsByActorID["Player team member 01"] and task.agent:getTaskObject().coreData.instance.taskObjectsByActorID["Player team member 01"].coreData.rank < 3 then
        return 6
      else
        return 8
      end
    else
      return 0
    end
  end
  local update = function()
    if not localPlayer.inZap then
    else
    end
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
  local retriesCounter = 0
  local awaitingAudio = false
  local function playPositionAudio(checkpoints)
    local audioVehicle
    local positionScenario = getPositionScenario()
    if positionScenario ~= 0 then
      if positionScenario < 5 then
        audioVehicle = task.instance.taskObjectsByActorID["Player team member 01"].coreData.agent
      else
        audioVehicle = task.instance.taskObjectsByActorID["Player team member 02"].coreData.agent
      end
      feedbackSystem.eventFeedback(audioVehicle, audio[audioCheckpoints[checkpoints]][positionScenario], nil, "missionCritical")
    end
    playedCheckpoint[audioCheckpoints[checkpoints]] = true
  end
  local function tryPositionAudio(checkpoints)
    if (task.agent:getTaskObject().coreData.instance.taskObjectsByActorID["Player team member 01"] and localPlayer.currentVehicle == task.agent:getTaskObject().coreData.instance.taskObjectsByActorID["Player team member 01"].coreData.agent or task.instance.taskObjectsByActorID["Player team member 02"] and localPlayer.currentVehicle == task.instance.taskObjectsByActorID["Player team member 02"].coreData.agent) and not didRecentAudio(1) then
      doPrint("Retry " .. retriesCounter .. ": playing checkpoint audio now")
      removeUserUpdateFunction("tryPositionAudio")
      retriesCounter = 0
      awaitingAudio = false
      playPositionAudio(checkpoints)
    else
      retriesCounter = retriesCounter + 1
      doPrint("Delaying retried audio: " .. retriesCounter)
      if retriesCounter > 9 then
        removeUserUpdateFunction("tryPositionAudio")
        awaitingAudio = false
        doPrint("Giving up on retry audio")
        retriesCounter = 0
      end
    end
  end
  local checkPIPVehicle = function(task)
    if task.instance.taskObjectsByActorID["Player team member 01"].coreData.agent.controlled then
      if not feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP01") then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP01", nil, "missionCritical")
      end
    elseif task.instance.taskObjectsByActorID["Player team member 02"].coreData.agent.controlled and not feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP02") then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP02", nil, "missionCritical")
    end
    task.instance.playedPIPOnce = true
    removeUserUpdateFunction("stillInZap")
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Checkpoints" then
      local vehicleTaskObject = localPlayer.currentVehicle:getTaskObject()
      if vehicleTaskObject then
        local checkpoints = task.networkVars.checkpoints - 1 + task.networkVars.laps * checkpointNumber
        local index = math.floor(checkpoints / range)
        if audioCheckpoints[checkpoints] and (task.agent:getTaskObject().coreData.instance.taskObjectsByActorID["Player team member 01"] and localPlayer.currentVehicle == task.agent:getTaskObject().coreData.instance.taskObjectsByActorID["Player team member 01"].coreData.agent or task.instance.taskObjectsByActorID["Player team member 02"] and localPlayer.currentVehicle == task.instance.taskObjectsByActorID["Player team member 02"].coreData.agent) and not playedCheckpoint[audioCheckpoints[checkpoints]] then
          if didRecentAudio(1.5) then
            local stime = (math.random(6) / 2 + 2.5) * 120
            doPrint("delaying checkpoint audio 1s")
            awaitingAudio = true
            addUserUpdateFunction("tryPositionAudio", function()
              tryPositionAudio(checkpoints)
            end, 1 * updates.stepRate, true)
          elseif not awaitingAudio then
            playPositionAudio(checkpoints)
          end
        elseif checkpoints == 12 and not task.instance.playedPIPOnce and localPlayer.currentVehicle == task.agent then
          if not localPlayer.inZap then
            checkPIPVehicle(task)
          else
            addUserUpdateFunction("stillInZap", function()
              if not localPlayer.inZap then
                checkPIPVehicle(task)
              end
            end, 1 * updates.stepRate, true)
          end
        end
      else
      end
    elseif task.specialName == "zapped out of racer" then
      local firstZap = feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_1")
      if not firstZap then
        if task.instance.taskObjectsByActorID["Player team member 02"].coreData.rank < 3 and task.instance.taskObjectsByActorID["Player team member 01"].coreData.rank < 3 then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_2A")
        elseif task.instance.taskObjectsByActorID["Player team member 02"].coreData.rank < 3 and 2 < task.instance.taskObjectsByActorID["Player team member 01"].coreData.rank or task.instance.taskObjectsByActorID["Player team member 01"].coreData.rank < 3 and 2 < task.instance.taskObjectsByActorID["Player team member 02"].coreData.rank then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_2B")
        else
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_2C")
        end
      end
    elseif task.specialName == "in vehicle" then
      local ranking = task.instance.taskObjectsByActorID[task.goalFeedback.actorID].coreData.rank
      if ranking == 1 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, zapIntoAudio[task.goalFeedback.actorID].first)
      elseif ranking == cars then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, zapIntoAudio[task.goalFeedback.actorID].last)
      else
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, zapIntoAudio[task.goalFeedback.actorID].second)
      end
    elseif task.specialName == "hit actor" then
      if task.goalFeedback.actorID == "Race team 2 member 2" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV04_SEQUENCE_4A")
      elseif task.goalFeedback.actorID == "Race team 2 member 1" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV03_SEQUENCE_4A")
      end
    end
  end
  local function taskComplete(conditionKey)
    if task.specialName == "zapped into team colors racer" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_1")
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
