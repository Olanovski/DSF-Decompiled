feedbackSystem.registerAudioPIP("All clubbed out APIP", function(task)
  if task.specialName == "First text prompt" then
    feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_R_1")
  end
  local function taskComplete()
    if task.specialName == "1/3 complete" then
      feedbackSystem.eventFeedback(task.agent, "PIP01")
    elseif task.specialName == "75% complete" then
      feedbackSystem.eventFeedback(task.agent, "PIP02")
      feedbackSystem.menusMaster.primaryTextPrompt("ID:243493")
    elseif task.specialName == "100% complete" then
      feedbackSystem.taskSuccessAudio()
    elseif task.specialName == "Saboteur route" and task.condition == 1 then
      OneShotSound.Play("HUD_Play_Waypoint")
    elseif task.specialName == "Time running out 1" then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_L_2B")
    elseif task.specialName == "Time running out 2" then
      feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_L_3B")
    end
  end
  return nil, nil, taskComplete, nil
end)
