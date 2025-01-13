feedbackSystem.registerAudioPIP("Exposition zap mission", function(task)
  local inShiftIdleSpeech = function()
    eventFeedback(localPlayer.currentVehicle, "GPZP01_SEQUENCE_L_6")
  end
  local chopShopAudioTriggered = false
  local function goalComplete(conditionKey)
    if task.specialName == "PlayerInTanner" then
      localPlayer:blockAbility("zap", true)
      GameVehicleResource.ClearAreaOfVehicles(task.instance.taskObjectsByActorID.Tanner.coreData.agent.gameVehicle.position, 60)
      eventFeedback(localPlayer.currentVehicle, "PIP01")
    elseif task.specialName == "On route" then
      if conditionKey == 1 then
        eventFeedback(localPlayer.currentVehicle, "PIP02")
      elseif conditionKey == 2 then
        BillboardManager.LoadNarrativeBillboard("DO_IT_TANNER")
      elseif conditionKey >= 3 and not chopShopAudioTriggered then
        eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_5")
        chopShopAudioTriggered = true
      end
    elseif task.specialName == "In zap speech" then
      eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_2")
    elseif task.specialName == "Contiune prompt" then
      if conditionKey == 1 or conditionKey == 2 then
        eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_L_1")
      elseif conditionKey == 3 then
        eventFeedback(localPlayer.currentVehicle, "GPZP01_SEQUENCE_L_5")
      end
    elseif task.specialName == "PlayerZappedIntoCar02" then
      if conditionKey == 1 then
        localPlayer:blockAbility("zap", true)
        local ZapCar02 = localPlayer.currentVehicle
        local actor = task.instance.challenge.actorPool["Zap Car 02"]
        challengeSystem.createActor(task.instance, ZapCar02, actor)
        Commentary.ForceEventChange()
        if task.instance.taskObjectsByActorID["Zap Car 02"] then
          zapcontroller.AddLockedVehicle({
            gameVehicle = task.instance.taskObjectsByActorID["Zap Car 02"].coreData.agent.gameVehicle
          })
        end
      elseif conditionKey == 2 or conditionKey == 6 then
        eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_L_1", nil, "missionCritical")
      elseif conditionKey == 5 then
        inShiftIdleSpeech()
      end
    elseif task.specialName == "PlayerZappedIntoCar03" then
      if conditionKey == 1 then
        localPlayer:blockAbility("zap", true)
        local ZapCar03 = localPlayer.currentVehicle
        local actor = task.instance.challenge.actorPool["Zap Car 03"]
        challengeSystem.createActor(task.instance, ZapCar03, actor)
        Commentary.ForceEventChange()
        if task.instance.taskObjectsByActorID["Zap Car 03"] then
          zapcontroller.AddLockedVehicle({
            gameVehicle = task.instance.taskObjectsByActorID["Zap Car 03"].coreData.agent.gameVehicle
          })
        end
      elseif conditionKey == 2 or conditionKey == 6 then
        eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_L_2", nil, "missionCritical")
      elseif conditionKey == 5 then
        inShiftIdleSpeech()
      end
    elseif task.specialName == "PlayerZappedIntoATaxi" then
      if conditionKey == 1 then
        localPlayer:blockAbility("zap", true)
      elseif conditionKey == 2 or conditionKey == 6 then
        eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_L_3", nil, "missionCritical")
        feedbackSystem.menusMaster.setNextFocusString()
        localPlayer:clearCurrentVehicle()
      elseif conditionKey == 3 then
        inShiftIdleSpeech()
      elseif conditionKey == 5 then
        local TrafficConverter = localPlayer.currentVehicle
        local actor = task.instance.challenge.actorPool.TrafficConverter
        challengeSystem.createActor(task.instance, TrafficConverter, actor)
        Commentary.ForceEventChange()
      end
    elseif task.specialName == "PlayerInZap02" or task.specialName == "PlayerInZap03" then
      eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_R_2", nil, "missionCritical")
    end
  end
  local function taskComplete()
    if task.specialName == "Speech 01" then
      eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_2")
    elseif task.specialName == "Speech 02" then
      eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_3")
    elseif task.specialName == "At the billboard" then
      OneShotSound.Play("HUD_Play_Waypoint")
    elseif task.specialName == "PlayerInZap01" then
      zapcontroller.AddLockedVehicle({
        gameVehicle = task.agent.gameVehicle
      })
      scoreSystem.tutorialMode(localPlayer.localID, true, true)
    elseif task.specialName == "PlayerZappedIntoCar01" then
      eventFeedback(localPlayer.currentVehicle, "GPMV02_SEQUENCE_R_1", nil, "missionCritical")
      if task.instance.taskObjectsByActorID["Zap Car 01"] then
        zapcontroller.AddLockedVehicle({
          gameVehicle = task.instance.taskObjectsByActorID["Zap Car 01"].coreData.agent.gameVehicle
        })
      end
    elseif task.specialName == "PlayerInZap02" then
      Commentary.ForceEventChange()
    elseif task.specialName == "PlayerZappedIntoCar02" then
      eventFeedback(localPlayer.currentVehicle, "GPMV03_SEQUENCE_R_1", nil, "missionCritical")
    elseif task.specialName == "PlayerInZap03" then
      Commentary.ForceEventChange()
    elseif task.specialName == "PlayerZappedIntoCar03" then
      eventFeedback(localPlayer.currentVehicle, "GPMV04_SEQUENCE_R_1", nil, "missionCritical")
    elseif task.specialName == "PlayerZappedIntoATaxi" then
      Commentary.ForceEventChange()
      eventFeedback(localPlayer.currentVehicle, "PIP03", nil, "missionCritical")
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
