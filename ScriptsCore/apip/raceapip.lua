feedbackSystem.registerAudioPIP("Race audio", function(task)
  local taskObject = localPlayer.currentVehicle:getTaskObject()
  local checkpointNumber = 0
  local division = 7
  local range = 0
  local audio, zapOutAudio
  if task.specialName == "Checkpoints" then
    if task.instance.challenge.name == "Marin County race" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP01")
    end
    checkpointNumber = #checkpointSystem.getCheckpoints(task.instance, taskObject.coreData.actor.checkpointGroup)
    if task.instance.challenge.name == "1 Downtown race" or task.instance.challenge.name == "Easy Street" then
      division = 6
    end
    range = (task.coreData.totalLaps + 1) * checkpointNumber / division
    audio = {
      {
        first = "GPMV01_SEQUENCE_L_2A",
        second = "GPMV01_SEQUENCE_L_2B",
        last = "GPMV01_SEQUENCE_L_2C",
        played = false
      },
      {
        first = "GPMV01_SEQUENCE_L_3A",
        second = "GPMV01_SEQUENCE_L_3B",
        last = "GPMV01_SEQUENCE_L_3C",
        played = false
      },
      {
        first = "GPMV01_SEQUENCE_L_4A",
        second = "GPMV01_SEQUENCE_L_4B",
        last = "GPMV01_SEQUENCE_L_4C",
        played = false
      },
      {
        first = "GPMV01_SEQUENCE_L_5A",
        second = "GPMV01_SEQUENCE_L_5B",
        last = "GPMV01_SEQUENCE_L_5C",
        played = false
      },
      {
        first = "GPMV01_SEQUENCE_L_6A",
        second = "GPMV01_SEQUENCE_L_6B",
        last = "GPMV01_SEQUENCE_L_6C",
        played = false
      },
      {
        first = "GPMV01_SEQUENCE_L_7A",
        second = "GPMV01_SEQUENCE_L_7B",
        last = "GPMV01_SEQUENCE_L_7C",
        played = false
      }
    }
    if task.instance.challenge.name == "Easy Street" then
      audio[2].last = "PIP01"
      audio[4].first = "PIP02"
    elseif task.instance.challenge.name == "1 Downtown race" then
      audio[4].last = "PIP01"
      audio[5].second = "PIP02"
    elseif task.instance.challenge.name == "High plains drifter" then
      audio[4].first = "GPMV01_SEQUENCE_5A"
      audio[6].first = "PIP02"
    elseif task.instance.challenge.name == "Marin County race" then
      audio[5].first = "PIP02"
    elseif task.instance.challenge.name == "Speed Race" then
      audio[6].first = "PIP02"
    end
  end
  if task.specialName == "zapped out of racer" then
    zapOutAudio = {
      first = "GPZP01_ZAP_2A",
      middle = "GPZP01_ZAP_2B",
      last = "GPZP01_ZAP_2C"
    }
  end
  local SpeedRace_secondTimeAtDrop
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
  local function getRankPosition()
    local index = 0
    local checkpoints = 0
    local ranking = 0
    local carsLeft = 0
    checkpoints = task.networkVars.checkpoints - 1 + task.networkVars.laps * checkpointNumber
    ranking = taskObject.coreData.rank
    index = math.floor(checkpoints / range)
    for k, v in next, task.instance.taskObjectsByActorID, nil do
      if 1 > v.coreData.agent.damage then
        carsLeft = carsLeft + 1
      end
    end
    if index > 0 and index <= division and audio[index] and not audio[index].played then
      if ranking == 1 then
        return "first", index
      elseif ranking == carsLeft and carsLeft > 2 then
        return "last", index
      else
        return "second", index
      end
    else
      return 0, 0
    end
  end
  local function playRankAudio(index, ranking)
    audio[index].played = feedbackSystem.eventFeedback(localPlayer.currentVehicle, audio[index][ranking])
  end
  local function tryPositionAudio()
    local index, ranking
    removeUserUpdateFunction("tryPositionAudio")
    if task.agent.controlled and not didRecentAudio(1) then
      ranking, index = getRankPosition()
      if index > 0 then
        playRankAudio(index, ranking)
      end
    end
  end
  local lastZapOutTime = 0
  local zapCounter = 0
  local function goalComplete(conditionKey)
    local ranking, index
    if task.specialName == "Checkpoints" and task.agent.controlled then
      ranking, index = getRankPosition()
      if index > 0 then
        if not didRecentAudio(2) then
          playRankAudio(index, ranking)
        else
          local stime = (math.random(6) / 2 + 2.5) * 120
          addUserUpdateFunction("tryPositionAudio", tryPositionAudio, stime, true)
        end
      end
    end
    local carsLeft = 0
    for k, v in next, task.instance.taskObjectsByActorID, nil do
      if v.coreData.agent.damage < 1 then
        carsLeft = carsLeft + 1
      end
    end
    if task.specialName == "zapped out of racer" then
      if not task.instance.playedFirstZapAudio then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_1")
        task.instance.playedFirstZapAudio = true
      else
        if lastZapOutTime < g_NetworkTime - 15 or zapCounter % 3 == 0 then
          lastZapOutTime = g_NetworkTime
          if taskObject.coreData.rank == 1 then
            feedbackSystem.eventFeedback(localPlayer.currentVehicle, zapOutAudio.first, nil, "missionCritical")
          elseif taskObject.coreData.rank == carsLeft and carsLeft > 2 then
            feedbackSystem.eventFeedback(localPlayer.currentVehicle, zapOutAudio.last, nil, "missionCritical")
          else
            feedbackSystem.eventFeedback(localPlayer.currentVehicle, zapOutAudio.middle, nil, "missionCritical")
          end
        end
        zapCounter = zapCounter + 1
      end
    end
  end
  local function taskComplete(conditionKey)
    if task.specialName == "start of race" then
      if task.instance.challenge.name == "Speed Race" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP01")
      elseif task.instance.challenge.name == "High plains drifter" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP01")
      else
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_1")
      end
    end
  end
  local function cleanup()
    SpeedRace_secondTimeAtDrop = nil
  end
  return nil, goalComplete, taskComplete, cleanup
end)
