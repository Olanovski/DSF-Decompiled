feedbackSystem.registerAudioPIP("Test Drive APIP", function(task)
  local triggeredQuarter1 = true
  local triggeredQuarter2 = true
  local triggeredQuarter3 = true
  if task.specialName == "Initial drive" and not localPlayer.challenge.retryingMission then
    feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_1")
  end
  local update = function()
  end
  local goalComplete = function()
  end
  local function taskComplete()
    if not task.success or task.specialName == "Initial drive" then
    elseif task.specialName == "Tanner zap out" then
      feedbackSystem.eventFeedback(task.agent, "GPZP01_ZAP_1")
    elseif task.specialName == "Pause before race" then
      feedbackSystem.eventFeedback(task.agent, "PIP01")
    elseif task.specialName == "Trigger commentary 1" then
      feedbackSystem.eventFeedback(task.agent, "GPMV02_SEQUENCE_1", nil, "missionCritical")
    elseif task.specialName == "Race countdown" then
      feedbackSystem.startMusic("Uid12496_CH05_TJ_TestDrive_Play")
    elseif task.specialName == "Race" then
      feedbackSystem.stopMusic("Uid12496_CH05_TJ_TestDrive_Stop")
      feedbackSystem.eventFeedback(task.agent, "PIP02")
    elseif task.specialName == "Trigger chase commentary" then
      feedbackSystem.eventFeedback(task.agent, "GPMV02_FAILURE_L_3")
    elseif task.specialName == "Trigger time commentary 1" then
      feedbackSystem.eventFeedback(task.agent, "GPMV02_SEQUENCE_L_2")
    elseif task.specialName == "Trigger time commentary 2" then
      feedbackSystem.eventFeedback(task.agent, "GPMV02_SEQUENCE_L_3")
    elseif task.specialName == "Trigger time commentary 3" then
      feedbackSystem.eventFeedback(task.agent, "GPMV02_SEQUENCE_L_4")
    end
  end
  local cleanup = function()
  end
  return nil, nil, taskComplete, cleanup
end)
