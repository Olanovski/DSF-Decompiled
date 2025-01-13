local warningProximity = false
local warningZap = false
local eyeMarker = false
local previousHealth
local previousValue = 0
feedbackSystem.registerHUD("Tanner and Jones 4 hud", function(task, settings)
end, function(task, settings)
  local instance = task.instance
  local taskObject = instance.taskObjectsByActorID["Tanner and Jones"]
  local suspicionTable, recordingTable, goonCounter, krugHealthBar
  local payloadSwitch = false
  local allowMarkerSwitch = false
  if task.specialName == "Tail suspicion 1" or task.specialName == "Tail suspicion CHASE" or task.specialName == "Tail suspicion  before Jericho calls" or task.specialName == "Tail suspicion 1 PART DUEX" then
    suspicionTable = {
      slot = 1,
      title = "ID:184756",
      barTitle = "ID:184765",
      value = 0
    }
  elseif task.specialName == "Tracking Player Position 1" or task.specialName == "Tracking Player Position  before Jericho calls" or task.specialName == "Tracking Player Position 1 PART DUEX" then
    recordingTable = {slot = 2, recordingState = 0}
  elseif task.specialName == "CHASE during attack" then
    krugHealthBar = {
      slot = 1,
      title = "ID:184756",
      value = 0
    }
    goonCounter = {
      slot = 2,
      barIcon = "smash",
      barTitle = "ID:214894",
      value = 0,
      numericValue = 0
    }
  end
  if string.find(task.specialName, "Tail warning") then
    allowMarkerSwitch = true
  end
  local previousDamage
  if suspicionTable then
    if instance.payload then
      suspicionTable.value = instance.payload
      task.networkVars.payload = instance.payload
    end
    feedbackSystem.updateDangerBar(suspicionTable)
  end
  if recordingTable and not localPlayer.inCutsceneOrIcam then
    feedbackSystem.updateAudioRecorder(recordingTable)
  end
  if task.specialName == "Drive to Krug" then
    feedbackSystem.removeSlot(1)
    feedbackSystem.removeSlot(2)
  elseif task.specialName == "CHASE during attack" then
    feedbackSystem.removeSlot(2)
    krugHealthBar.value = task.instance.taskObjectsByActorID.Krug.coreData.agent.damage
    feedbackSystem.updateProgressBar(goonCounter)
    task.instance.KrugHealthBarOn = true
  end
  local function update()
    if not gameStatus.simulationPaused then
      if krugHealthBar then
        if recordingTable then
          feedbackSystem.removeSlot(2)
          recordingTable = nil
        end
        if task.instance.taskObjectsByActorID.Krug.coreData.agent.damage ~= previousDamage then
          krugHealthBar.value = task.instance.taskObjectsByActorID.Krug.coreData.agent.damage
          feedbackSystem.updateHealthBar(krugHealthBar)
          previousDamage = task.instance.taskObjectsByActorID.Krug.coreData.agent.damage
        end
        krugHealthBar.value = task.instance.taskObjectsByActorID.Krug.coreData.agent.damage
        feedbackSystem.updateHealthBar(krugHealthBar)
      end
      if suspicionTable then
        if not previousValue or previousValue ~= task.networkVars.payload then
          if task.specialName == "Tail suspicion 2" and not payloadSwitch then
            task.networkVars.payload = previousValue
            payloadSwitch = true
          end
          suspicionTable.value = task.networkVars.payload
          if suspicionTable.value < 0 then
            suspicionTable.value = 0
          elseif suspicionTable.value == 5 then
            feedbackSystem.menusMaster.clearPrimaryTextPrompt()
            feedbackSystem.menusMaster.clearSecondaryTextPrompt()
            feedbackSystem.menusMaster.primaryTextPrompt("ID:246235")
          end
          feedbackSystem.updateDangerBar(suspicionTable)
          Sound.SetRTPC("Paranoia_Meter", suspicionTable.value)
          previousValue = suspicionTable.value
        end
        if task.instance.taskObjectsByActorID.Krug and localPlayer.currentVehicle then
          local krug = task.instance.taskObjectsByActorID.Krug.coreData.agent
          local TanerAndJ = task.instance.taskObjectsByActorID["Tanner and Jones"].coreData.agent
          if TanerAndJ.controlled then
            Sound.SetRTPC("DistanceToTarget", distance)
          else
            Sound.SetRTPC("DistanceToTarget", 0)
          end
        end
      end
      if goonCounter then
        local attackersLeft = 0
        for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
          if taskObject.coreData.actor.team == "Attacking team" and taskObject.coreData.agent.damage < 1 then
            attackersLeft = attackersLeft + 1
          end
        end
        if 3 - attackersLeft ~= goonCounter.numericValue then
          goonCounter.value = (3 - attackersLeft) * 33.33333
          goonCounter.numericValue = 3 - attackersLeft
          feedbackSystem.updateProgressBar(goonCounter)
        end
      end
    end
  end
  local endDriveTo = vec.vector(-1432.984, 40.66459, 1065.028, 1)
  local marker
  local rapidShiftPromptActive = false
  local function goalComplete(conditionKey)
    if recordingTable and not string.find(task.specialName, "CHASE") then
      if task.majorOrder == 6 then
        recordingTable.recordingState = 0
        feedbackSystem.updateAudioRecorder(recordingTable)
      elseif string.find(task.specialName, "Tracking Player Position") then
        if conditionKey == 1 then
          recordingTable.recordingState = 1
          feedbackSystem.updateAudioRecorder(recordingTable)
        elseif conditionKey == 2 then
          recordingTable.recordingState = 2
          feedbackSystem.updateAudioRecorder(recordingTable)
        end
      end
    end
    if allowMarkerSwitch then
      if conditionKey == 1 then
        if not eyeMarker and task.instance.taskObjectsByActorID.Krug then
          eyeMarker = feedbackSystem.newTarget(task.instance.taskObjectsByActorID.Krug.coreData.agent, "Spotted marker")
          Sound.SetState("Suspicion_State", "On")
          local krug = task.instance.taskObjectsByActorID.Krug.coreData.agent
          if krug.markers and krug.markers.radius then
            krug.markers.radius.colour = vec.vector(255, 0, 0, 150)
          end
        end
      elseif conditionKey == 3 then
        if warningProximity then
          feedbackSystem.menusMaster.clearSecondaryTextPrompt()
          warningProximity = false
        end
        if eyeMarker then
          Sound.SetState("Suspicion_State", "Off")
          feedbackSystem.clearTarget(eyeMarker)
          eyeMarker = false
          local krug = task.instance.taskObjectsByActorID.Krug.coreData.agent
          if krug.markers and krug.markers.radius then
            krug.markers.radius.colour = vec.vector(0, 0, 255, 150)
          end
        end
      end
    end
    if string.find(task.specialName, "shift warning") then
      if conditionKey == 1 then
        if not warningZap then
          feedbackSystem.menusMaster.secondaryTextPrompt("ID:184768", false, false, false, false)
          warningZap = true
        end
      elseif conditionKey == 2 and warningZap then
        feedbackSystem.menusMaster.clearSecondaryTextPrompt()
        warningZap = false
      end
    end
    if task.specialName == "Tracking Player Position CHASE" or task.specialName == "Player back in recording range" then
      if conditionKey == 2 then
        if not rapidShiftPromptActive then
          feedbackSystem.menusMaster.secondaryTextPrompt("ID:184768", false, false, false, false)
          rapidShiftPromptActive = true
        end
      elseif rapidShiftPromptActive then
        feedbackSystem.menusMaster.clearSecondaryTextPrompt()
        rapidShiftPromptActive = false
      end
    end
    if task.specialName == "In zap PART DUEX" then
      if conditionKey == 1 then
        if not rapidShiftPromptActive then
          feedbackSystem.menusMaster.secondaryTextPrompt("ID:184768", false, false, false, false)
          rapidShiftPromptActive = true
        end
      elseif rapidShiftPromptActive then
        feedbackSystem.menusMaster.clearSecondaryTextPrompt()
        rapidShiftPromptActive = false
      end
    end
    if task.specialName == "Wait for Tanner" then
      if conditionKey == 1 then
        if marker then
          feedbackSystem.clearTarget(marker)
          marker = nil
          OneShotSound.Play("HUD_Play_Waypoint")
        end
      elseif conditionKey == 2 and not marker then
        marker = feedbackSystem.newTarget({position = endDriveTo}, "Hotspot")
      end
    end
  end
  local function taskComplete()
    if task.specialName == "Instructions 1" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:184760")
      feedbackSystem.menusMaster.secondaryTextPrompt("ID:248732")
    elseif task.specialName == "Tail section 01" then
      feedbackSystem.menusMaster.clearSecondaryTextPrompt()
      feedbackSystem.removeSlot(1)
      feedbackSystem.removeSlot(2)
      feedbackSystem.removeSlot(3)
    elseif task.specialName == "Spawn Attacker Wave" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:243774")
    elseif task.specialName == "Use shift to take them down prompt" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:248734")
    elseif task.specialName == "Tail suspicion 1" or task.specialName == "Tail suspicion 2" and not task.success then
      if eyeMarker then
        feedbackSystem.clearTarget(eyeMarker)
        eyeMarker = false
      end
    elseif task.specialName == "CHASE during attack" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:243772")
      instance.KrugHealthBarOn = false
      feedbackSystem.removeSlot(3)
    elseif task.specialName == "Drive to prompt" then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:245543")
    end
  end
  local function cleanup()
    if task.networkVars.payload and task.networkVars.payload < 100 then
      instance.payload = task.networkVars.payload
    end
    if eyeMarker and allowMarkerSwitch then
      feedbackSystem.clearTarget(eyeMarker)
      eyeMarker = false
      allowMarkerSwitch = false
    end
    if marker then
      feedbackSystem.clearTarget(marker)
    end
    instance.KrugHealthBarOn = false
    if suspicionTable then
      suspicionTable = nil
    end
    if recordingTable then
      recordingTable = nil
    end
    if goonCounter then
      goonCounter = nil
    end
    if krugHealthBar then
      krugHealthBar = nil
    end
  end
  return update, goalComplete, taskComplete, cleanup
end)
