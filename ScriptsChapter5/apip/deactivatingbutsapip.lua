feedbackSystem.registerAudioPIP("DeactivatingBUT APIP", function(task)
  if task.specialName == "pip finished" then
    feedbackSystem.startMusic("Uid07502_CH07_Standard_TickingClock_Play")
  end
  local function goalComplete(conditionKey)
    if task.specialName == "get first bomb" then
      if conditionKey == 2 then
        if task.networkVars.laps == 0 then
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_4", nil, "missionCritical")
        else
          feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_7", nil, "missionCritical")
        end
      elseif task.networkVars.laps == 1 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_6", nil, "missionCritical")
      end
    elseif task.specialName == "police task" then
      if conditionKey ~= 1 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_L_3", nil, "missionCritical")
      end
    elseif task.specialName == "Vehicle time feedback" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_L_4", nil, "missionCritical")
    elseif task.specialName == "In zap 1" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_L_1", nil, "missionCritical")
    elseif string.find(task.specialName, "Vehicle size feedback") then
      if conditionKey == 1 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_L_1")
      else
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_L_2")
      end
    elseif task.specialName == "In zap 2" then
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_L_2", nil, "missionCritical")
    end
  end
  local function taskComplete()
    if task.success then
      if task.specialName == "Play PIP01" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP01", nil, "missionCritical")
      elseif task.specialName == "Play GPMV01_SEQUENCE_L_1" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_1")
      elseif task.specialName == "Play PLAN audio" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_2")
      elseif task.specialName == "Play HERE GOES audio" then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_L_3", nil, "timeSensitive")
      elseif task.specialName == "softsave1" then
        feedbackSystem.updateBarFeedback({barHide = true})
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "PIP02", function()
          feedbackSystem.menusMaster.primaryTextPrompt("ID:184867")
        end)
      elseif task.specialName == "get going reminder" and task.condition == 2 then
        local function shiftUp()
          local timer1 = g_NetworkTime
          local function timeCheck()
            if g_NetworkTime - timer1 >= 3 or localPlayer.inZap then
              if task.instance.taskObjectsByActorID.Supercop and task.instance.taskObjectsByActorID.Supercop.coreData.agent == localPlayer.currentVehicle and not localPlayer.inZap then
                localPlayer:SetZapLevel(zap.currentUnlockedZapLevel or 1, nil)
              end
              feedbackSystem.menusMaster.setCurrentFocusString(4)
              removeUserUpdateFunction("shiftUp")
            end
          end
          addUserUpdateFunction("shiftUp", timeCheck, 4, true)
        end
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_8", shiftUp)
      end
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
