feedbackSystem.registerAudioPIP("Bad medicine 2", function(task)
  local firstZapSpeechPlayed = false
  local function playDialogue(inID, inComment)
    if task.instance.taskObjectsByActorID["Attacker1 (Actor)"].coreData.agent.controlled then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, inID)
    end
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Initial drive intermittent chatter" then
      playDialogue("GPMV01_SEQUENCE_L_2", "Speech sequences while driving to the target area")
    elseif task.specialName == "Initial drive zap out" then
      if not firstZapSpeechPlayed then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_1", nil, "missionCritical")
        firstZapSpeechPlayed = true
      else
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_3", nil, "missionCritical")
      end
    elseif task.specialName == "Smash boxes zap out part 1" or task.specialName == "Smash boxes zap out part 2" or task.specialName == "Smash boxes zap out part 3" or task.specialName == "Smash boxes zap out part 4" or task.specialName == "Smash boxes zap out part 5" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_2", nil, "missionCritical")
    elseif task.specialName == "Chase part 1" then
      playDialogue("GPMV01_SEQUENCE_R_4", "Player destroys the 1st enemy")
    end
  end
  local function taskComplete()
    if task.success then
      if task.specialName == "First PiP" then
        playDialogue("PIP01", "Speech at start of the mission")
      elseif task.specialName == "Smash boxes first audio" then
        playDialogue("GPMV01_SEQUENCE_R_3A", "Speech once you destroy the first box of medicine")
      elseif task.specialName == "Smash boxes 2nd audio" then
        playDialogue("GPMV01_SEQUENCE_R_3B", "Speech once you destroy 5 boxes of medicine")
      elseif task.specialName == "Smash boxes 3rd audio" then
        playDialogue("GPMV01_SEQUENCE_R_4A", "Speech once you destroy 15 boxes of medicine")
      elseif task.specialName == "Smash boxes 4th audio" then
        playDialogue("GPMV01_SEQUENCE_R_5A", "Speech once you destroy 20 boxes of medicine")
      elseif task.specialName == "Audio - 1 truck down then smash" then
        playDialogue("GPMV01_SEQUENCE_R_5D", "Speech once you destroy 1 truck then smash a box")
      elseif task.specialName == "Hold position" then
        task.instance.truckCount = task.instance.truckCount + 1
        if task.instance.truckCount == 1 then
          playDialogue("GPMV01_SEQUENCE_R_4C", "Speech once you see the first truck")
        elseif task.instance.truckCount == 2 then
          playDialogue("PIP02", "Speech once you see the 2nd truck")
        end
      end
    elseif task.specialName == "Hold position" then
      task.instance.truckCount = task.instance.truckCount + 1
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
