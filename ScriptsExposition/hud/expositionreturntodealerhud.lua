feedbackSystem.registerHUD("Exposition Return To Dealer HUD", function(task, settings)
end, function(task, settings)
  local hudExceptions = {hudPanels = true}
  local counterTable = {
    slot = 1,
    title = "ID:220014",
    barTitle = " ",
    value = 0,
    flipFeedback = true,
    numericValue = 10
  }
  local checkListTable = {
    slot = 1,
    icon1 = "jump",
    icon1Title = 10,
    icon1State = 1
  }
  local timer = {
    slot = 1,
    startTime = 90,
    flashTime = 30,
    promptTime = 30
  }
  if task.specialName == "pauseBeforeDriveToSection" then
    if feedbackSystem.menusMaster.primaryPromptActive then
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    end
  elseif task.specialName == "Checkpoint race" then
    feedbackSystem.menusMaster.setCurrentFocusString(4)
  end
  local overtakes = 0
  local previousOvertakes = 0
  local driftPromptDisplayed = false
  local shiftPromptDisplayed = false
  local signTimeBonus = 1
  local pointsParams = {pointsText = "ID:220014", pointsSlotPass = 1}
  local overTakesHUD = false
  local function update()
    if not gameStatus.simulationPaused then
      if task.goalFeedback.Timer and task.specialName == "Checkpoint race" then
        timer.startTime = 90
        feedbackSystem.stepTimer(timer)
        if not driftPromptDisplayed and not feedbackSystem.menusMaster.primaryPromptActive then
          feedbackSystem.menusMaster.primaryTextPromptParam({
            prompt = "ID:242319",
            delay = true,
            icon1 = localPlayer.buttonLayout.handbrake,
            priority = 1
          })
          feedbackSystem.menusMaster.secondaryTextPrompt("ID:242320", false, false, true)
          driftPromptDisplayed = true
        end
      end
      if task.specialName == "Overtakes" and not task.complete and task.agent.controlled then
        if task.goalFeedback.Overtakes then
          counterTable.value = task.goalFeedback.Overtakes * 10
          overtakes = task.goalFeedback.Overtakes
          if task.goalFeedback.Overtakes > previousOvertakes then
            previousOvertakes = overtakes
            OneShotSound.Play("HUD_Mis_PointsAdd_OneShot", false)
            pointsParams.pointsText = "+" .. tostring(signTimeBonus)
            if not feedbackSystem.menusMaster.primaryPromptActive then
              feedbackSystem.updatePointsFeedback(pointsParams)
            end
          end
        else
          counterTable.value = 0
        end
        if not overTakesHUD then
          overTakesHUD = true
        end
        feedbackSystem.updateProgressBar(counterTable)
      elseif not task.agent.controlled and overTakesHUD then
        feedbackSystem.removeSlot(1)
        overTakesHUD = false
      end
    end
  end
  local function clearHUD()
    localPlayer.inCutscene = false
    checkListTable.icon1State = 0
    feedbackSystem.updateChecklist(checkListTable)
    feedbackSystem.removeSlot(1)
    eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_5")
  end
  local playerCollisionsDuringLombardStreet = 0
  local useTheMissionVehicleYouDoylePrompt = false
  local function goalComplete(conditionKey)
    if task.specialName == "Destination prompt" and conditionKey == 2 then
      feedbackSystem.menusMaster.primaryTextPromptParam({
        prompt = "ID:236468",
        delay = true,
        priority = 1
      })
      feedbackSystem.menusMaster.blockHintButton(false)
    elseif string.find(task.specialName, "PlayerInZap") then
      if conditionKey == 1 then
        if not useTheMissionVehicleYouDoylePrompt then
          feedbackSystem.menusMaster.primaryTextPromptParam({
            prompt = "ID:242109",
            priority = 2,
            permanent = true
          })
          useTheMissionVehicleYouDoylePrompt = true
        end
        eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_1")
      elseif conditionKey == 2 and useTheMissionVehicleYouDoylePrompt then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
        useTheMissionVehicleYouDoylePrompt = false
      end
    elseif task.specialName == "Overtakes" then
      if conditionKey == 1 then
        if feedbackSystem.menusMaster.primaryPromptActive then
          feedbackSystem.menusMaster.clearPrimaryTextPrompt()
        end
      else
        eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_2")
      end
    elseif task.specialName == "Turn the player around before the race" then
      if conditionKey == 1 then
        localPlayer.currentVehicle:teleportToPositionAndHeading(vec.vector(-321.0854, 69.97898, 4.279378, 1), 1.875607, function()
          print("faded out")
        end, function()
          print("start fade in")
        end, function()
          print("faded in")
        end, true)
      end
    elseif task.specialName == "Handbrake prompt reminder" then
      playerCollisionsDuringLombardStreet = playerCollisionsDuringLombardStreet + 1
      if playerCollisionsDuringLombardStreet == 3 then
        feedbackSystem.menusMaster.primaryTextPromptParam({
          prompt = "ID:242319",
          icon1 = localPlayer.buttonLayout.handbrake,
          priority = 2
        })
        feedbackSystem.menusMaster.secondaryTextPrompt("ID:242320")
      end
    end
  end
  local musicTrigger = function()
    localPlayer:blockAbility("zap", false)
    feedbackSystem.startMusic("Uid01783_Exp_GoForASpin_Play")
  end
  local function taskComplete()
    if task.specialName == "Is player controlled" then
      feedbackSystem.menusMaster.blockHintButton(true)
    elseif task.specialName == "Mission start" then
      eventFeedback(localPlayer.currentVehicle, "PIP01", musicTrigger)
    elseif task.specialName == "pauseBeforeOvertakesSection" then
      feedbackSystem.updateProgressBar(counterTable)
      feedbackSystem.menusMaster.blockHintButton(false)
      feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:173955", priority = 1})
    elseif task.specialName == "Remove overtake prompt" then
      if feedbackSystem.menusMaster.primaryPromptActive then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      end
    elseif task.specialName == "Overtakes" then
      counterTable.value = 100
      pointsParams.pointsText = "+" .. tostring(signTimeBonus)
      OneShotSound.Play("HUD_Gen_Positive", false)
      feedbackSystem.updatePointsFeedback(pointsParams)
      feedbackSystem.updateProgressBar(counterTable)
    elseif task.specialName == "PIP 02 trigger" then
      if feedbackSystem.menusMaster.primaryPromptActive then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      end
      local nextSample = function()
        eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_3")
      end
      eventFeedback(localPlayer.currentVehicle, "PIP03", nextSample)
      feedbackSystem.menusMaster.blockHintButton(true)
      feedbackSystem.menusMaster.setNextFocusString()
    elseif task.specialName == "clear the overtakes HUD panel" then
      feedbackSystem.removeSlot(1)
    elseif task.specialName == "Destination" then
      feedbackSystem.menusMaster.setNextFocusString()
      feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:173950", priority = 1})
      feedbackSystem.menusMaster.blockHintButton(false)
    elseif task.specialName == "Jump" and task.success then
      eventFeedback(localPlayer.currentVehicle, "GPMV01_SEQUENCE_R_1")
      checkListTable.icon1State = 2
      feedbackSystem.updateChecklist(checkListTable)
      local hudExceptions = {hudPanels = true}
      localPlayer.inCutscene = true
      local iCamParams = {
        cameraTargets = {
          task.instance.taskObjectsByActorID.Lamborghini.coreData.agent.gameVehicle
        },
        duration = 5,
        speed = 0.1,
        framing = "mid",
        angleYaw = "profile",
        callbackFunction = clearHUD,
        hudParams = hudExceptions
      }
      iCamActivationTableInput(iCamParams)
      feedbackSystem.menusMaster.setNextFocusString()
    elseif task.specialName == "Jump HUD panel" then
      feedbackSystem.updateChecklist(checkListTable)
    elseif task.specialName == "Jump" then
      feedbackSystem.menusMaster.setNextFocusString()
      if feedbackSystem.menusMaster.primaryPromptActive then
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      end
    elseif task.specialName == "PIP04" then
      eventFeedback(localPlayer.currentVehicle, "PIP04")
    elseif task.specialName == "Pause before checkpoint section" then
      feedbackSystem.menusMaster.primaryTextPromptParam({
        prompt = "ID:245513",
        delay = true,
        priority = 1
      })
    elseif task.specialName == "Damage prompt 01" or task.specialName == "Damage prompt 02" or task.specialName == "Damage prompt 03" or task.specialName == "Damage prompt 04" then
      feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:218810", priority = 2})
    elseif string.find(task.specialName, "PlayerInZap") then
      eventFeedback(localPlayer.currentVehicle, "GPZP01_ZAP_1")
    end
  end
  local function cleanup()
    if task.specialName == "Checkpoint race" then
      feedbackSystem.removeSlot(1)
    end
  end
  return update, goalComplete, taskComplete, cleanup
end)
