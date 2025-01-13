local storedSteamID
feedbackSystem.registerHUD("Tanker on fire activity hud", function(task, settings)
end, function(task, settings)
  local waterLevelStart = 115
  local waterActive = false
  local temperatureTable = {
    slot = 1,
    title = "ID:178432",
    barTitle = "ID:178433",
    value = 0
  }
  local waterBarParams = {
    barText = "ID:178435",
    barValue = 0,
    barIcon = " ",
    barHide = true
  }
  local location1 = task.agent.SNVID * 3
  local location2 = task.agent.SNVID * 3 + 1
  local location3 = task.agent.SNVID * 3 + 2
  local fLoc1_z = 4.232
  local fLoc2_z = -0.273
  local fLoc3_z = -4.766
  local previousValue = 3
  local fire1 = "EParticleEvent_Fiire_stage_01"
  local fire2 = "EParticleEvent_Fiire_stage_02"
  local offset = vec.vector(0, 3.5, fLoc2_z, 1)
  local baseSteamParams = {
    alpha = 1,
    eventName = "EParticleEvent_Fiire_steam",
    offset = vec.vector(0, 3.5, fLoc2_z, 1)
  }
  if task.actor.team == "Tanker team" then
    baseSteamParams.id = task.agent.SNVID
  end
  local tankerAgent
  local baseParams = {
    id = location1,
    eventName = fire1,
    offset = vec.vector(0, 3.5, fLoc1_z, 1),
    gameVehicle = task.agent.gameVehicle.towedVehicle
  }
  local function setBaseParams(location, fireLevel)
    if location == 1 then
      baseParams.id = location1
      baseParams.offset.z = fLoc1_z
    elseif location == 2 then
      baseParams.id = location2
      baseParams.offset.z = fLoc2_z
    elseif location == 3 then
      baseParams.id = location3
      baseParams.offset.z = fLoc3_z
    end
    if fireLevel == 1 then
      baseParams.eventName = fire1
    elseif fireLevel == 2 then
      baseParams.eventName = fire2
    end
  end
  local function turnOffEffects(ventOne, ventTwo, ventThree)
    if ventOne then
      ParticleEditor.StopEvent(location1)
    end
    if ventTwo then
      ParticleEditor.StopEvent(location2)
    end
    if ventThree then
      ParticleEditor.StopEvent(location3)
    end
  end
  if task.specialName == "Tanker payload" then
    ParticleEditor.TriggerEvent(baseParams)
    baseParams.id = location2
    baseParams.offset.z = fLoc2_z
    ParticleEditor.TriggerEvent(baseParams)
    baseParams.id = location3
    eventName = fire2
    baseParams.offset.z = fLoc3_z
    ParticleEditor.TriggerEvent(baseParams)
    if task.actor.ID == "Tanker1" then
      temperatureTable.title = "ID:184646"
      temperatureTable.slot = 2
    elseif task.actor.ID == "Tanker3" then
      temperatureTable.title = "ID:184647"
      temperatureTable.slot = 3
    elseif task.actor.ID == "Tanker4" then
      temperatureTable.title = "ID:184646"
      temperatureTable.slot = 2
    elseif task.actor.ID == "Tanker6" then
      temperatureTable.title = "ID:184646"
      temperatureTable.slot = 2
    end
  end
  local function goalComplete(conditionKey)
    if task.specialName == "Tanker payload" then
      if conditionKey >= 2 and conditionKey < 6 then
        if task.actor.ID == "Tanker1" then
          feedbackSystem.removeSlot(temperatureTable.slot)
          if not task.instance.taskObjectsByActorID.Tanker2 then
            temperatureTable.slot = 1
          end
        elseif task.actor.ID == "Tanker3" or task.actor.ID == "Tanker4" then
          feedbackSystem.removeSlot(temperatureTable.slot)
          if task.actor.ID == "Tanker4" and not task.instance.taskObjectsByActorID.Tanker5 then
            temperatureTable.slot = 1
          elseif task.actor.ID == "Tanker3" and not task.instance.taskObjectsByActorID.Tanker4 and not task.instance.taskObjectsByActorID.Tanker5 then
            temperatureTable.slot = 1
          elseif task.actor.ID == "Tanker3" and (not task.instance.taskObjectsByActorID.Tanker4 or not task.instance.taskObjectsByActorID.Tanker5) then
            temperatureTable.slot = 2
          end
        elseif task.actor.ID == "Tanker6" then
          feedbackSystem.removeSlot(temperatureTable.slot)
          if not task.instance.taskObjectsByActorID.Tanker7 then
            temperatureTable.slot = 1
          end
        end
      end
      local value = math.floor(task.networkVars.payload / 10)
      if value < previousValue then
        if value == 0 then
          turnOffEffects(true, true, true)
        elseif value == 1 then
          turnOffEffects(false, true, false)
        elseif value == 2 then
          turnOffEffects(true, false, false)
        elseif value == 3 then
          turnOffEffects(false, true, false)
          setBaseParams(2, 1)
          ParticleEditor.TriggerEvent(baseParams)
        elseif value == 5 then
          turnOffEffects(false, false, true)
          setBaseParams(3, 1)
          ParticleEditor.TriggerEvent(baseParams)
        elseif value == 7 then
          turnOffEffects(true, false, false)
          setBaseParams(1, 1)
          ParticleEditor.TriggerEvent(baseParams)
        end
        previousValue = value
      elseif value > previousValue then
        if value == 1 then
          setBaseParams(3, 1)
          ParticleEditor.TriggerEvent(baseParams)
        elseif value == 2 then
          setBaseParams(2, 1)
          ParticleEditor.TriggerEvent(baseParams)
        elseif value == 3 then
          setBaseParams(1, 1)
          ParticleEditor.TriggerEvent(baseParams)
        elseif value == 4 then
          turnOffEffects(false, true, false)
          setBaseParams(2, 2)
          ParticleEditor.TriggerEvent(baseParams)
        elseif value == 6 then
          turnOffEffects(false, false, true)
          setBaseParams(3, 2)
          ParticleEditor.TriggerEvent(baseParams)
        elseif value == 8 then
          turnOffEffects(true, false, false)
          setBaseParams(1, 2)
          ParticleEditor.TriggerEvent(baseParams)
        end
        previousValue = value
      end
      if task.networkVars.payload > 0 then
        temperatureTable.value = task.networkVars.payload
        feedbackSystem.updateDangerBar(temperatureTable)
      else
        feedbackSystem.removeSlot(1)
      end
      if conditionKey == 6 then
        feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:246283", priority = 2})
      end
    elseif task.specialName == "Fireman" then
      if conditionKey <= 2 then
        if task.goalFeedback.Vehicle and task.goalFeedback.Vehicle ~= tankerAgent and not waterActive and 1 >= zapcontroller.getZapLevel() then
          waterActive = true
          tankerAgent = task.goalFeedback.Vehicle
          baseSteamParams.id = tankerAgent.SNVID
          baseSteamParams.gameVehicle = tankerAgent.gameVehicle.towedVehicle
          localPlayer.simulationSupport.doWait(0.6, function()
            ParticleEditor.TriggerEvent(baseSteamParams)
          end, "delaySteam")
          storedSteamID = baseSteamParams.id
          GameVehicleResource.setGunTarget(task.agent.gameVehicle, tankerAgent.gameVehicle.towedVehicle, offset)
          Sound.RegisterTargetVehicle(tankerAgent.gameVehicle, "Play_Tanker_Hosed", "Stop_Tanker_Hosed")
          Sound.AddSourceVehicle(task.agent.gameVehicle, "Play_Fire_Hose")
        end
      else
        waterActive = false
        ParticleEditor.StopEvent(baseSteamParams.id)
        baseSteamParams.gameVehicle = nil
        tankerAgent = nil
        GameVehicleResource.setGunTarget(task.agent.gameVehicle)
        waterBarParams.barHide = true
        feedbackSystem.updateBarFeedback(waterBarParams)
        Sound.RemoveSourceVehicle(task.agent.gameVehicle, "Stop_Fire_Hose")
      end
    elseif task.specialName == "Fire engine water level" then
      if task.networkVars.payload > 0 then
        local value = 1 - task.networkVars.payload * (1 / waterLevelStart)
        waterBarParams.barValue = 100 - value * 100
      end
      if not task.agent.controlled or task.networkVars.payload <= 0 then
        waterBarParams.barHide = true
      else
        waterBarParams.barHide = false
      end
      feedbackSystem.updateBarFeedback(waterBarParams)
    elseif task.specialName == "First tanker" then
      task.instance.taskObjectsByActorID["Fire team member 1"].coreData.actor.spawn.relativeToVehicle.actor = "Tanker1"
    elseif task.specialName == "Third tanker" then
      task.instance.taskObjectsByActorID["Fire team member 3"].coreData.actor.spawn.relativeToVehicle.actor = "Tanker6"
    end
  end
  local function taskComplete(conditionKey)
    if task.specialName == "Fire engine water level" or task.specialName == "Fireman" then
      ParticleEditor.StopEvent(storedSteamID)
      baseSteamParams.gameVehicle = nil
      Sound.RemoveSourceVehicle(task.agent.gameVehicle, "Stop_Fire_Hose")
      GameVehicleResource.setGunTarget(task.agent.gameVehicle)
      if task.condition == 1 then
        feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:245393", priority = 2})
      elseif task.condition == 2 then
        feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:246065", priority = 2})
      end
      zapcontroller.AddLockedVehicle({
        gameVehicle = task.agent.gameVehicle
      })
    elseif task.specialName == "Tanker payload" then
      ParticleEditor.StopEvent(location1)
      ParticleEditor.StopEvent(location2)
      ParticleEditor.StopEvent(location3)
      ParticleEditor.StopEvent(task.agent.SNVID)
      feedbackSystem.removeSlot(temperatureTable.slot)
      feedbackSystem.updateBarFeedback(waterBarParams)
      turnOffEffects(true, true, true)
    end
  end
  local cleanup = function()
    removeUserUpdateFunction("delaySteam")
  end
  return nil, goalComplete, taskComplete, cleanup
end)
