local allowBPMUpdate = false
local updateInterval = 3
feedbackSystem.registerHUD("Something weird hud", nil, function(task, settings)
  local heartMonitor
  local pointsParams = {pointsText = "ID:243778", pointsSlotPass = 1}
  local heartRateModifier = 0.9473684
  local flashActive, buildPromptShown, prompt1Trigger, prompt2Trigger
  local prompts = {
    ["Chase ambulance 1"] = "ID:243769",
    ["Chase ambulance 2"] = "ID:243660",
    ["Getting away"] = "ID:184947",
    ["Keep charging"] = "ID:243775",
    ["Stay above 30"] = "ID:184814",
    ["prompt1Trigger"] = "ID:246389",
    ["prompt2Trigger"] = "ID:246390"
  }
  if task.specialName == "Chase ambulance" then
    heartMonitor = {
      slot = 1,
      value = heartRateModifier * 95,
      bpm = 180
    }
    feedbackSystem.updateHeartMonitor(heartMonitor)
  elseif task.specialName == "Chase ambulance 2" then
    heartMonitor = {
      slot = 1,
      value = heartRateModifier * 70,
      bpm = 155
    }
    feedbackSystem.updateHeartMonitor(heartMonitor)
  end
  local function updateSpeed(coreData, speed)
    coreData.actor.desiredSpeed = speed
    local behaviour = {
      traits = taskSystem.buildDriveTraits({
        actor = coreData.actor,
        instance = task.instance
      }),
      roadRoute = routes[coreData.actor.routeName].roads,
      routeName = coreData.actor.routeName
    }
    coreData.agent:highSpeedDrive(behaviour)
  end
  local barrier1 = 160
  local barrier2 = 140
  local function evaluateLevelPrompts(currentPayload, previousLevel)
    if previousLevel >= barrier1 and currentPayload < barrier1 then
    elseif not (previousLevel >= barrier2) or currentPayload < barrier2 then
    end
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Respawn" then
      local function removeVehicle()
        local function respawn()
          challengeSystem.spawnActors(task.instance, "Never", {
            ["Ambulance 2"] = true
          })
          updateSpeed(task.instance.taskObjectsByActorID["Ambulance 2"].coreData, 95)
          GameVehicleResource.setVehicleIsGhost(task.instance.taskObjectsByActorID["Ambulance 2"].coreData.agent.gameVehicle, true)
          GameVehicleResource.setVehicleOccupantDraw(task.instance.taskObjectsByActorID["Ambulance 2"].coreData.agent.gameVehicle, 0, false)
          removeUserUpdateFunction("Respawn")
        end
        addUserUpdateFunction("Respawn", respawn, 120, true)
        task.instance.taskObjectsByActorID["Ambulance 2"]:delete(true)
      end
      ZapAIPresence.Settings({
        Height = 5,
        Radius = 0.085,
        TransitionInTime = 0.5,
        Color = vec.vector(40, 40, 40, 1)
      })
      ZapAIPresence.SetCallback({TransitionCallback = removeVehicle})
      ZapAIPresence.StartTransition(nil, task.instance.taskObjectsByActorID["Ambulance 2"].coreData.agent.gameVehicle)
    elseif task.specialName == "Respawn2" then
      local function removeVehicle()
        local function respawn()
          challengeSystem.spawnActors(task.instance, "Never", {
            ["Ambulance 1"] = true
          })
          removeUserUpdateFunction("Respawn")
          feedbackSystem.eventFeedback(task.instance.taskObjectsByActorID.Tanner.coreData.agent, "GPMV01_SEQUENCE_R_6")
          GameVehicleResource.setVehicleOccupantDraw(task.instance.taskObjectsByActorID["Ambulance 1"].coreData.agent.gameVehicle, 0, false)
        end
        addUserUpdateFunction("Respawn", respawn, 120, true)
        task.instance.taskObjectsByActorID["Ambulance 1"]:delete(true)
      end
      ZapAIPresence.Settings({
        Height = 5,
        Radius = 0.085,
        TransitionInTime = 0.5,
        Color = vec.vector(40, 40, 40, 1)
      })
      ZapAIPresence.SetCallback({TransitionCallback = removeVehicle})
      ZapAIPresence.StartTransition(nil, task.instance.taskObjectsByActorID["Ambulance 1"].coreData.agent.gameVehicle)
    elseif task.specialName == "Chase ambulance" or task.specialName == "Chase ambulance 2" then
      local activeAmbulance
      for k, v in next, task.instance.taskObjectsByActorID, nil do
        if string.find(k, "Ambulance") then
          activeAmbulance = v
        end
      end
      if conditionKey == 1 or (conditionKey == 6 or conditionKey == 7) and task.specialName == "Chase ambulance 2" then
        if allowBPMUpdate then
          if task.networkVars.payload <= heartMonitor.bpm - updateInterval then
            evaluateLevelPrompts(task.networkVars.payload, heartMonitor.bpm)
            pointsParams.pointsText = "ID:246399"
            pointsParams.pointsValue = updateInterval
            feedbackSystem.updatePointsFeedback(pointsParams)
            heartMonitor.value = heartRateModifier * (task.networkVars.payload - 85)
            heartMonitor.bpm = math.ceil(task.networkVars.payload)
            feedbackSystem.updateHeartMonitor(heartMonitor)
            if not buildPromptShown then
              if task.instance.taskObjectsByActorID["Ambulance 1"] then
                feedbackSystem.menusMaster.primaryTextPrompt(prompts["Keep charging"])
                feedbackSystem.menusMaster.setNextFocusString()
              end
              buildPromptShown = true
            end
          end
          if not flashActive and activeAmbulance then
            activeAmbulance.coreData.agent:overRideFlashColour(OnlineModeSettings.yellow32, OnlineModeSettings.yellow128)
            flashActive = true
          end
          if not prompt1Trigger and heartMonitor.value < 60 then
            feedbackSystem.menusMaster.primaryTextPrompt(prompts.prompt1Trigger)
            prompt1Trigger = true
          elseif not prompt2Trigger and heartMonitor.value < 30 then
            feedbackSystem.menusMaster.primaryTextPrompt(prompts.prompt2Trigger)
            prompt2Trigger = true
          end
        else
          task.networkVars.payload = task.specialName == "Chase ambulance" and 180 or task.specialName == "Chase ambulance 2" and 155
        end
      elseif conditionKey == 2 and flashActive and activeAmbulance then
        if task.networkVars.payload < heartMonitor.bpm then
          evaluateLevelPrompts(task.networkVars.payload, heartMonitor.bpm)
          pointsParams.pointsText = "ID:246399"
          pointsParams.pointsValue = heartMonitor.bpm - math.ceil(task.networkVars.payload)
          feedbackSystem.updatePointsFeedback(pointsParams)
          heartMonitor.value = heartRateModifier * (task.networkVars.payload - 85)
          heartMonitor.bpm = math.ceil(task.networkVars.payload)
          feedbackSystem.updateHeartMonitor(heartMonitor)
          if not buildPromptShown then
            if task.specialName == "Chase ambulance" then
              feedbackSystem.menusMaster.primaryTextPrompt(prompts["Keep charging"])
              feedbackSystem.menusMaster.setCurrentFocusString(3)
            end
            buildPromptShown = true
          end
        end
        flashActive = false
        activeAmbulance.coreData.agent:removeFlashColourOverRide()
      elseif conditionKey == 3 and task.specialName == "Chase ambulance 2" then
        updateSpeed(task.instance.taskObjectsByActorID["Ambulance 2"].coreData, 85)
      elseif conditionKey == 4 and task.specialName == "Chase ambulance 2" then
        updateSpeed(task.instance.taskObjectsByActorID["Ambulance 2"].coreData, 90)
      elseif conditionKey == 5 and task.specialName == "Chase ambulance 2" then
        updateSpeed(task.instance.taskObjectsByActorID["Ambulance 2"].coreData, 100)
      elseif conditionKey == 3 and task.specialName == "Chase ambulance" then
        updateSpeed(task.instance.taskObjectsByActorID["Ambulance 1"].coreData, 80)
      elseif conditionKey == 4 and task.specialName == "Chase ambulance" then
        updateSpeed(task.instance.taskObjectsByActorID["Ambulance 1"].coreData, 90)
      elseif conditionKey > 5 and task.specialName == "Chase ambulance" then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:243661")
      elseif conditionKey > 7 and task.specialName == "Chase ambulance 2" then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:243661")
      end
    end
  end
  local function taskComplete()
    if task.specialName == "Prompt start chase" then
      allowBPMUpdate = false
      feedbackSystem.menusMaster.primaryTextPrompt(prompts["Chase ambulance 1"])
    elseif task.specialName == "Prompt bpm level" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:243776", nil, nil, nil, nil, nil, function()
        allowBPMUpdate = true
      end)
      feedbackSystem.menusMaster.setCurrentFocusString(2)
    elseif task.specialName == "Losing ambulance warning" or task.specialName == "Losing ambulance warning2" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:184947")
    elseif task.specialName == "Prompt start chase 2" then
      allowBPMUpdate = false
      feedbackSystem.menusMaster.setCurrentFocusString(4)
      feedbackSystem.menusMaster.primaryTextPrompt("ID:243768", nil, nil, nil, nil, nil, function()
        allowBPMUpdate = true
      end)
    elseif task.specialName == "Chase ambulance" or task.specialName == "Chase ambulance 2" then
      OneShotSound.Play("HUD_Play_Waypoint")
      if task.networkVars.payload < heartMonitor.bpm then
        pointsParams.pointsText = "ID:246399"
        pointsParams.pointsValue = heartMonitor.bpm - math.ceil(task.networkVars.payload)
        feedbackSystem.updatePointsFeedback(pointsParams)
        heartMonitor.value = heartRateModifier * (task.networkVars.payload - 85)
        heartMonitor.bpm = math.ceil(task.networkVars.payload)
        feedbackSystem.updateHeartMonitor(heartMonitor)
        flashActive = false
      end
    elseif task.specialName == "Begin scoring 2" or task.specialName == "Begin scoring" then
      allowBPMUpdate = true
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
