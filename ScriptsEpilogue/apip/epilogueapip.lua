feedbackSystem.registerAudioPIP("Epilogue APIP", function(task)
  local pressedCount = 4
  local function andTheNextSample()
    feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_R_4", nil, "missionCritical")
  end
  local function nextSample()
    feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_R_3A", andTheNextSample, "missionCritical")
  end
  local function goalComplete(goalConditionKey)
    if task.specialName == "Button press" then
      pressedCount = pressedCount + 1
      if pressedCount % 5 == 0 then
        feedbackSystem.eventFeedback(task.agent, "GPZP01_ZAP_R_1", nil, "missionCritical")
      end
    end
    if task.instance.challenge.name == "Epilogue" then
      if task.specialName == "Hospital drive" then
        if goalConditionKey == 2 then
          feedbackSystem.eventFeedback(task.agent, "PIP02", nil, "missionCritical")
        end
      elseif task.specialName == "Trigger dialogue and events" then
        if goalConditionKey == 1 then
          feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_R_2", nil, "missionCritical")
        elseif goalConditionKey == 2 then
          feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_R_3", nil, "missionCritical")
        elseif goalConditionKey == 3 then
          feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_R_3A", nextSample, "missionCritical")
        elseif goalConditionKey == 4 then
          Sfx.SetBlastCloud(true)
          OneShotSound.Play("HUGE_Explosion_OneShot")
          Explosion.Init("COM:fmv\\explosion.bik")
          Explosion.SetPosition(vec.vector(720.652, -200.3122, 1242.811, 1))
          Explosion.SetSize(1900, 1100)
          Explosion.Play()
        elseif goalConditionKey == 5 then
          local removeBlast = function()
            Explosion.Stop()
          end
          moodSystem.applyMood("Epilogue pre pt 2", 6, removeBlast)
          Sound.OverrideAmbience("WakingNightmare")
        end
      elseif task.specialName == "Convicts sample" then
        if goalConditionKey == 2 then
          feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_5A", nil, "missionCritical")
        end
      elseif task.specialName == "Horns and alarms" then
        if goalConditionKey == 1 then
          GameVehicleResource.setHornActivation(false)
          GameVehicleResource.setAlarmActivation(true)
        elseif goalConditionKey == 2 then
          GameVehicleResource.setHornActivation(true)
          GameVehicleResource.setAlarmActivation(false)
        end
      elseif task.specialName == "Initial drive" then
        moodSystem.removeMood("Epilogue pre pt 2", 6)
        moodSystem.applyMood("Epilogue pt 2", 6, nil)
      end
    end
    if task.instance.challenge.name == "Epilogue pt 2" then
      if task.specialName == "PIP 01 trigger & jones radio 1" then
        feedbackSystem.eventFeedback(task.agent, "PIP01", nil, "missionCritical")
      elseif task.specialName == "Hit tanner" then
        if task.actor.ID == "Headon1" then
          feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_4")
        end
      elseif task.specialName == "Chase jericho" then
        if goalConditionKey == 2 then
          feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_L_2A", nil, "missionCritical")
        end
      elseif task.specialName == "tanner hit jericho" then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_5")
      end
    end
  end
  local function taskComplete()
    if task.instance.challenge.name == "Epilogue" then
      if task.specialName == "In tanner" then
        feedbackSystem.eventFeedback(task.agent, "PIP01", function()
          feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_R_1")
        end)
      elseif task.specialName == "Convicts sample" then
        feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_5A", nil, "missionCritical")
      end
    end
    if task.instance.challenge.name == "Epilogue pt 2" then
      if task.specialName == "Chase tanker" then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_4A")
      elseif task.specialName == "Approaching warehouse" then
        feedbackSystem.eventFeedback(task.agent, "PIP02")
      elseif task.specialName == "Remove blast cloud and trigger the audio" then
        Sfx.SetBlastCloud(false)
        moodSystem.removeMood("Epilogue pt 2", 6)
      elseif task.specialName == "collision check for speech" then
        feedbackSystem.eventFeedback(task.agent, "GPMV01_SEQUENCE_4B")
      elseif task.specialName == "PIP 01 trigger & jones radio 1" or task.specialName == "jones on radio2" then
        feedbackSystem.eventFeedback(task.agent, "GPMV00_SEQUENCE_R_6", nil, "missionCritical")
      end
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
