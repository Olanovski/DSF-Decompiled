local currentStuntTable
feedbackSystem.registerHUD("Breaking news 2 hud", function(task, settings)
end, function(task, settings)
  printTable(settings)
  local objective = {slot = 1}
  local timer = {
    slot = 2,
    startTime = 45,
    timerFlash = 15
  }
  if task.specialName == "Hit cop" then
    timer.startTime = 60
  else
    timer.startTime = 45
  end
  local endTimer, inRadius
  local stuntFeedback = {
    stuntText = "",
    stuntFail = nil,
    stuntSlotPass = nil,
    stuntHide = true
  }
  local updateStuntFeedback = false
  local function failedStunt()
    if g_NetworkTime - endTimer > 2 then
      removeUserUpdateFunction("failedStunt")
      stuntFeedback.stuntHide = true
      feedbackSystem.updateStuntFeedback(stuntFeedback)
    end
  end
  if task.specialName == "Sped" or task.specialName == "Sped oncoming" then
    stuntFeedback.stuntText = "ID:242735"
  elseif task.specialName == "Drifted" then
    stuntFeedback.stuntText = "ID:245410"
  end
  local function update()
    if not gameStatus.simulationPaused and (task.specialName == "Smash oncoming" or task.specialName == "Sped" or task.specialName == "Sped oncoming" or task.specialName == "Hit cop" or task.specialName == "Drifted") then
      feedbackSystem.stepTimer(timer)
      if currentStuntTable and not localPlayer.inCutsceneOrIcam then
        if task.specialName == "Drifted" and task.goalFeedback.Drifting and task.goalFeedback["Drift distance"] and localPlayer.scoring.isDrifting or task.specialName == "Sped" and task.goalFeedback.Radius or task.specialName == "Sped oncoming" and task.goalFeedback.Radius and task.goalFeedback.Oncoming then
          inRadius = true
          if userUpdateFunctions.failedStunt then
            removeUserUpdateFunction("failedStunt")
          end
          stuntFeedback.stuntFail = false
          inRadius = true
        elseif inRadius then
          inRadius = false
          if stuntFeedback.stuntTextValue then
            stuntFeedback.stuntFail = true
            endTimer = g_NetworkTime
            addUserUpdateFunction("failedStunt", failedStunt, 4)
            updateStuntFeedback = true
          end
        end
        if inRadius then
          if (task.specialName == "Sped" or task.specialName == "Sped oncoming") and localPlayer.currentVehicle then
            local playerSpeed = localPlayer.currentVehicle.gameVehicle.displayedSpeed
            local playerSpeedInMph = math.floor(playerSpeed * 2.236)
            if playerSpeedInMph < settings.speedToHit and not localPlayer.inZap then
              stuntFeedback.stuntTextValue = feedbackSystem.localiseSpeedFromMetersASecond(playerSpeed)
              stuntFeedback.stuntHide = false
              updateStuntFeedback = true
            elseif not stuntFeedback.stuntHide then
              stuntFeedback.stuntHide = true
              updateStuntFeedback = true
            end
          elseif task.specialName == "Drifted" then
            local activeDrift = localPlayer.scoring:getCurrentDriftDistance()
            if localPlayer.scoring.isDrifting and activeDrift < settings.amountToDrift and not localPlayer.inZap then
              if userUpdateFunctions.failedStunt then
                removeUserUpdateFunction("failedStunt")
              end
              stuntFeedback.stuntFail = false
              stuntFeedback.stuntHide = false
              stuntFeedback.stuntTextValue = activeDrift
              updateStuntFeedback = true
            elseif not localPlayer.scoring.isDrifting and activeDrift < settings.amountToDrift and not stuntFeedback.stuntFail and not stuntFeedback.stuntHide and not localPlayer.inZap then
              stuntFeedback.stuntFail = true
              endTimer = g_NetworkTime
              addUserUpdateFunction("failedStunt", failedStunt, 4)
              updateStuntFeedback = true
            elseif localPlayer.scoring.isDrifting and activeDrift >= settings.amountToDrift and not stuntFeedback.stuntHide or localPlayer.inZap and not stuntFeedback.stuntHide then
              stuntFeedback.stuntHide = true
              updateStuntFeedback = true
            end
          end
        end
        if updateStuntFeedback then
          feedbackSystem.updateStuntFeedback(stuntFeedback)
          updateStuntFeedback = false
        end
      end
    end
  end
  local prompts = {
    ["Wait to display drift prompt"] = "ID:184493",
    ["Wait to display speed prompt"] = "ID:243579",
    ["Wait to display cop prompt"] = "ID:246339",
    ["Wait to display oncoming prompt"] = "ID:221802",
    ["Wait to display smash prompt"] = "ID:184491"
  }
  local vehicles
  local function goalComplete(conditionKey)
    if task.specialName == "Lost felony" then
      felony_patrollingVehicleManager.enablePatrollingVehicles(true)
      vehicles = {
        {VehicleModelUID = 271},
        {VehicleModelUID = 280},
        {VehicleModelUID = 269},
        {VehicleModelUID = 265}
      }
      minimap.AddHighlightedVehicleModelUIDs(vehicles)
      localPlayer.minimapSupport.setHighlightedVehicleModelType("smash")
      minimap.SetHighlightedVehicles(true)
    end
    if conditionKey == 1 then
      if task.specialName == "Drifted" then
        feedbackSystem.menusMaster.primaryTextPrompt(prompts["Wait to display drift prompt"])
      elseif task.specialName == "Sped" then
        feedbackSystem.menusMaster.primaryTextPrompt(prompts["Wait to display speed prompt"], settings.targetDisplaySpeed)
      elseif task.specialName == "Hit cop" then
        feedbackSystem.menusMaster.primaryTextPrompt(prompts["Wait to display cop prompt"])
      elseif task.specialName == "Sped oncoming" then
        feedbackSystem.menusMaster.primaryTextPrompt(prompts["Wait to display oncoming prompt"], settings.targetDisplaySpeed)
      elseif task.specialName == "Smash oncoming" then
        feedbackSystem.menusMaster.primaryTextPrompt(prompts["Wait to display smash prompt"])
      elseif task.specialName == "In felony" then
        minimap.SetHighlightedVehicles(false)
        minimap.RemoveAllHighlightedVehicleModelUIDs()
        localPlayer:blockAbility("zapReturn", false)
        localPlayer:setPreviousVehicle(localPlayer.currentVehicle)
        localPlayer:overrideZapReturn(localPlayer.currentVehicle)
        PatrollingVehicleManager.EnableHud(false)
        localPlayer:buildZapReturn()
      end
    elseif conditionKey == 2 and (task.specialName == "Drifted" or task.specialName == "Sped" or task.specialName == "Hit cop" or task.specialName == "Sped oncoming" or task.specialName == "Smash oncoming") then
      feedbackSystem.menusMaster.primaryTextPrompt("ID:245723")
    end
  end
  local scoreHUD, scoreCompleteHUD, stuntUpdates
  local restartScoreCompleteHUD = {
    ["Wait to display smash prompt"] = {
      slot = 1,
      icon1 = "drift",
      icon1State = 2,
      audio = 2
    },
    ["Wait to display speed prompt"] = {
      slot = 1,
      icon1 = "drift",
      icon1State = 4,
      icon2 = "smash",
      icon2State = 2,
      audio = 2
    },
    ["Wait to display oncoming prompt"] = {
      slot = 1,
      icon1 = "drift",
      icon1State = 4,
      icon2 = "smash",
      icon2State = 4,
      icon3 = "speed",
      icon3State = 2,
      audio = 2
    },
    ["Wait to display cop prompt"] = {
      slot = 1,
      icon1 = "oncoming",
      icon1State = 2,
      audio = 2
    }
  }
  if restartScoreCompleteHUD[task.specialName] and task.instance.taskObjectsByActorID["Van 1 Actor"].coreData.actor.onRestart then
    task.instance.taskObjectsByActorID["Van 1 Actor"].coreData.actor.onRestart = false
    feedbackSystem.updateChecklist(restartScoreCompleteHUD[task.specialName])
  end
  function triggerTheIcam()
    Sound.EnterAudioState("FilmRolling", "Film_Rolling_Play", "Film_Rolling_Stop")
    localPlayer:enterCutsceneMode()
    feedbackSystem.showHUDPanels(false)
    feedbackSystem.menusMaster.masterSetVariable("iTV_Cam", 1)
    feedbackSystem.menusMaster.setNextFocusString()
    local targetOffset = vec.vector(1, 1, 3, 0)
    local cameraOffset = vec.vector(5, 4, 3, 0)
    scoreCompleteHUD = {
      ["Drifted"] = {
        slot = 1,
        icon1 = "drift",
        icon1State = 2,
        audio = 2
      },
      ["Smash oncoming"] = {
        slot = 1,
        icon1 = "drift",
        icon1State = 4,
        icon2 = "smash",
        icon2State = 2,
        audio = 2
      },
      ["Sped"] = {
        slot = 1,
        icon1 = "drift",
        icon1State = 4,
        icon2 = "smash",
        icon2State = 4,
        icon3 = "speed",
        icon3State = 2,
        audio = 2
      },
      ["Sped oncoming"] = {
        slot = 1,
        icon1 = "oncoming",
        icon1State = 2,
        audio = 2
      },
      ["Hit cop"] = {
        slot = 1,
        icon1 = "oncoming",
        icon1State = 4,
        icon2 = "cops",
        icon2State = 2,
        audio = 2
      }
    }
    local iCamParams = {
      cameraTargets = {
        localPlayer.currentVehicle.gameVehicle
      },
      duration = 3.5,
      speed = 0.3,
      framing = "close",
      fixedCameras = {
        task.agent.gameVehicle.position + cameraOffset
      },
      callbackFunction = function()
        localPlayer:exitCutsceneMode()
        feedbackSystem.showHUDPanels(true)
        feedbackSystem.removeSlot(timer.slot)
        feedbackSystem.updateChecklist(scoreCompleteHUD[task.specialName])
        feedbackSystem.menusMaster.masterSetVariable("iTV_Cam", 0)
        Sound.ExitAudioState("FilmRolling")
      end
    }
    iCamActivationTableInput(iCamParams)
  end
  local startTime
  local function removeStunt()
    if g_NetworkTime - startTime > 1 and currentStuntTable and not currentStuntTable.stuntSlotPass then
      if task.specialName == "Drifted" or task.specialName == "Sped oncoming" then
        currentStuntTable.stuntSlotPass = 1
        feedbackSystem.updateStuntFeedback(currentStuntTable)
      elseif task.specialName == "Sped" then
        currentStuntTable.stuntSlotPass = 2
        feedbackSystem.updateStuntFeedback(currentStuntTable)
      end
    elseif g_NetworkTime - startTime > 2 and currentStuntTable then
      removeUserUpdateFunction("removeStunt")
      currentStuntTable.stuntHide = true
      feedbackSystem.updateStuntFeedback(currentStuntTable)
    elseif not currentStuntTable then
      removeUserUpdateFunction("removeStunt")
    end
  end
  local function taskComplete()
    feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    if task.success then
      if task.specialName == "Smash oncoming" or task.specialName == "Sped" or task.specialName == "Sped oncoming" or task.specialName == "Hit cop" or task.specialName == "Drifted" then
        feedbackSystem.menusMaster.blockHintButton(true)
        if task.specialName == "Hit cop" then
          minimap.SetHighlightedVehicles(false)
          minimap.RemoveAllHighlightedVehicleModelUIDs()
        elseif task.specialName == "Smash oncoming" then
          localPlayer.currentVehicle:set_damageMultiplier(5)
        end
        if currentStuntTable then
          if task.specialName == "Drifted" then
            currentStuntTable.stuntText = "30+"
          elseif task.specialName == "Sped" or task.specialName == "Sped oncoming" then
            currentStuntTable.stuntText = tostring(settings.targetDisplaySpeed) .. "+"
          end
          currentStuntTable.stuntFail = false
          feedbackSystem.menusMaster.masterSetVariable("iScore_Feedback_Stunt_Global", 1)
          feedbackSystem.updateStuntFeedback(currentStuntTable)
          startTime = g_NetworkTime
          addUserUpdateFunction("removeStunt", removeStunt, 30, true)
        end
        triggerTheIcam()
      elseif string.find(task.specialName, "Wait to display") then
        stuntUpdates = {
          ["Wait to display drift prompt"] = {
            stuntText = "ID:242923",
            stuntIcon = "drift",
            stuntSlotPass = nil,
            stuntHide = false,
            stuntFail = true
          },
          ["Wait to display speed prompt"] = {
            stuntText = "ID:242735",
            stuntIcon = "overtake",
            stuntSlotPass = nil,
            stuntHide = false,
            stuntFail = true
          },
          ["Wait to display oncoming prompt"] = {
            stuntText = "ID:242735",
            stuntIcon = "oncoming",
            stuntSlotPass = nil,
            stuntHide = false,
            stuntFail = true
          }
        }
        scoreHUD = {
          ["Wait to display drift prompt"] = {
            slot = 1,
            icon1 = "drift",
            icon1State = 1
          },
          ["Wait to display smash prompt"] = {
            slot = 1,
            icon2 = "smash",
            icon2State = 1
          },
          ["Wait to display speed prompt"] = {
            slot = 1,
            icon3 = "speed",
            icon3State = 1
          },
          ["Wait to display oncoming prompt"] = {
            slot = 1,
            icon1 = "oncoming",
            icon1State = 1,
            reset = true
          },
          ["Wait to display cop prompt"] = {
            slot = 1,
            icon2 = "cops",
            icon2State = 1
          }
        }
        currentStuntTable = false
        feedbackSystem.menusMaster.blockHintButton(false)
        if settings.targetDisplaySpeed then
          feedbackSystem.menusMaster.primaryTextPrompt(prompts[task.specialName], settings.targetDisplaySpeed, false, false, false, false, function()
            currentStuntTable = stuntUpdates[task.specialName]
          end)
        else
          feedbackSystem.menusMaster.primaryTextPrompt(prompts[task.specialName], nil, false, false, false, false, function()
            currentStuntTable = stuntUpdates[task.specialName]
          end)
        end
        if task.specialName == "Wait to display cop prompt" then
          vehicles = {
            {VehicleModelUID = 271},
            {VehicleModelUID = 280},
            {VehicleModelUID = 269},
            {VehicleModelUID = 265}
          }
          minimap.AddHighlightedVehicleModelUIDs(vehicles)
          localPlayer.minimapSupport.setHighlightedVehicleModelType("smash")
          minimap.SetHighlightedVehicles(true)
          PatrollingVehicleManager.EnableHud(false)
          feedbackSystem.menusMaster.setCurrentFocusString(3)
          localPlayer.feloniesBlocked = nil
        elseif task.specialName == "Wait to display oncoming prompt" then
          feedbackSystem.removeSlot(scoreHUD[task.specialName].slot)
          feedbackSystem.menusMaster.setCurrentFocusString(4)
        elseif task.specialName == "Wait to display drift prompt" then
          feedbackSystem.menusMaster.setCurrentFocusString(1)
        elseif task.specialName == "Wait to display speed prompt" then
          feedbackSystem.menusMaster.setCurrentFocusString(2)
        elseif task.specialName == "Wait to display smash prompt" then
          feedbackSystem.menusMaster.setCurrentFocusString(5)
        end
        feedbackSystem.updateChecklist(scoreHUD[task.specialName])
      elseif task.specialName == "Zap out" then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:183943", nil, false, false, false)
      elseif task.specialName == "Wait For Stunt Prompt" then
        feedbackSystem.menusMaster.primaryTextPrompt("ID:243699", nil, false, false, false)
      end
    end
  end
  local cleanup = function()
    if userUpdateFunctions.failedStunt then
      removeUserUpdateFunction("failedStunt")
    end
  end
  return update, goalComplete, taskComplete, cleanup
end)
