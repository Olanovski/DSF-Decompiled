feedbackSystem.registerAudioPIP("Shake down the inside man", function(task)
  local playDialogue = function(sequenceName, inComment, callback, playType)
    feedbackSystem.eventFeedback(localPlayer.currentVehicle, sequenceName, callBack, playType)
  end
  if task.specialName == "Initial drive" or task.specialName == "Player has snook around the back" then
    playDialogue("GPMV01_SEQUENCE_R_1", "Speech right after intro scene", nil, "missionCritical")
  end
  local function goalComplete(conditionKey)
    if task.specialName == "commentary trigger" then
      if conditionKey == 1 then
        playDialogue("GPMV01_SEQUENCE_1B", "Looking for the inside man 30s loop", nil, "missionCritical")
      elseif conditionKey == 2 then
        playDialogue("GPMV01_SEQUENCE_R_1C", "2 minutes in...")
      elseif conditionKey == 3 then
        playDialogue("GPMV01_SEQUENCE_L_2", "Speech triggering when getting close to area")
      end
    elseif task.specialName == "zapped one" then
      playDialogue("GPZP01_ZAP_R_2", "zapped out during scare bit")
    elseif task.specialName == "zapped two" then
      playDialogue("GPZP01_ZAP_3", "zapped out during SUV bit")
    elseif task.specialName == "Scare section" then
      if conditionKey == 1 + #cardSystem.heartometerLogicTable then
        playDialogue("GPMV02_SEQUENCE_L_2A", "1/4 Scared", nil, "missionCritical")
      elseif conditionKey == 2 + #cardSystem.heartometerLogicTable then
        playDialogue("GPMV02_SEQUENCE_L_2B", "2/4 Scared", nil, "missionCritical")
      elseif conditionKey == 3 + #cardSystem.heartometerLogicTable then
        playDialogue("GPMV02_SEQUENCE_L_2C", "3/4 Scared", nil, "missionCritical")
      end
    elseif task.specialName == "Haines taking damage when not player controlled" then
      playDialogue("GPMV00_SEQUENCE_L_2", "inside man taking damage")
    end
  end
  local function taskComplete()
    if task.success then
      if task.specialName == "Shift into haines" then
        playDialogue("GPMV00_SEQUENCE_R_1", "Speech when finding the inside mans vehicle", nil, "missionCritical")
      elseif task.specialName == "Inside man waiting" then
        task.agent.iconsVisible = true
        if task.instance.taskObjectsByActorID.Tanner then
          zapcontroller.AddLockedVehicle({
            gameVehicle = task.instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle
          })
          task.instance.taskObjectsByActorID.Tanner.coreData.agent.iconsVisible = false
        end
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP01", nil, "missionCritical")
      elseif task.specialName == "Zap back to inside man" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_R_6", nil, "missionCritical")
      elseif task.specialName == "last audio prompt" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_R_5", nil, "missionCritical")
      end
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
