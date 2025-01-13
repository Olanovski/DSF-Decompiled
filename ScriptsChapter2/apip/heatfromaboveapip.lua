feedbackSystem.registerAudioPIP("Heat from above", function(task)
  local function playDialogue(inID)
    feedbackSystem.eventFeedback(task.instance.taskObjectsByActorID["Real enemy"].coreData.agent, inID, nil, "missioncritical")
  end
  if task.specialName == "Start" then
    feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP01", nil, "missioncritical")
  end
  if task.specialName == "Spawn streetrace vehicles" then
    feedbackSystem.eventFeedback(task.instance.taskObjectsByActorID["Real enemy"].coreData.agent, "PIP02", nil, "missioncritical")
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Spawn emergency services" then
      playDialogue("GPMV00_SEQUENCE_R_2")
    elseif task.specialName == "Trigger crashsite commentary" then
      playDialogue("GPMV00_SEQUENCE_R_3")
    elseif task.specialName == "Trigger crashsite explosion" then
      playDialogue("GPMV00_SEQUENCE_R_4")
    elseif task.specialName == "Enemy scanned" then
      playDialogue("GPMV00_SEQUENCE_R_16")
    end
  end
  local function taskComplete()
    if task.success then
      if task.specialName == "Trigger crashsite explosion" then
        playDialogue("GPMV00_SEQUENCE_R_5")
      elseif task.specialName == "Trigger streetrace commentary" then
        playDialogue("GPMV00_SEQUENCE_R_13")
      elseif task.specialName == "Trigger low building commentary" then
        playDialogue("GPMV00_SEQUENCE_R_9", "Speech before flying over the tall building")
      elseif task.specialName == "Notice you see the wreckless driver" then
        playDialogue("GPMV00_SEQUENCE_R_12", "Speech upon seeing the wreckless driver")
      elseif task.specialName == "Enemy controlled by player" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_R_1")
      elseif task.specialName == "Trigger truck speech" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV03_SEQUENCE_R_1")
      elseif task.specialName == "Audio - 1st Damage" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV03_SEQUENCE_2")
      elseif task.specialName == "Spawn Front Smasher 1" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV03_SEQUENCE_3")
      elseif task.specialName == "Spawn Front Smasher 3" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV03_SEQUENCE_4")
      elseif task.specialName == "In Tanner Vehicle" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SUCCESS_L_1")
      end
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
