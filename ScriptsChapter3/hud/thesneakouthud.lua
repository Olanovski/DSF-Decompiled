feedbackSystem.registerHUD("The Sneakout HUD", function(task, settings)
end, function(task)
  local prevSuspicion = -1
  local currentSuspicion = 0
  local suspicionBar = {
    slot = 1,
    title = "ID:243850",
    barTitle = "ID:184544",
    value = 0,
    percentValue = 100
  }
  local timer = {slot = 2, startTime = 120}
  local showTimer = false
  local tutorialPanel = function(params)
    local doTutorialPanel = function(params)
      localPlayer:enterCutsceneMode(nil, false)
      if localPlayer.cameraMode == "DriverEye" then
        CameraSystem.SetClippingPlanesForKidnappedBootShot(true)
      end
      local tutorialPanel = {
        {
          action = "behaviour",
          type = "Existing",
          camera = game_camera,
          duration = 0.1
        },
        {
          action = "pauseSimulation",
          audioPauseEvent = "Simulation_Pause",
          audioResumeEvent = "Simulation_Resume"
        },
        {
          {
            action = "callback",
            callback = function()
              localPlayer.cameraSupport.miniSceneCamera()
              feedbackSystem.updateTutorialPanel({
                panelState = 1,
                title = "ID:243906 ",
                string1 = "ID:243905",
                string2 = "ID:243908",
                string3 = "ID:243909"
              })
              localPlayer.minimapSupport:show()
            end,
            afterDuration = 0.01
          },
          {
            {
              action = "attach",
              lookAt = params.vehicle.gameVehicle,
              lookFrom = params.vehicle.gameVehicle,
              duration = 5,
              lookFromOffset = vec.vector(0.2994057, 1.159006, 3.930443, 0),
              lookAtOffset = vec.vector(-2.834576, -1.28991, -5.24401, 0),
              fov = 1.3
            }
          }
        },
        {
          {
            action = "callback",
            callback = function()
              feedbackSystem.updateTutorialPanel({continueState = 1})
              controlHandler:registerState(localPlayer.localID, "missionComplete", {
                Menu_Select = {
                  JustPressed = {
                    [1] = function()
                      CameraSystem.ContinueScene()
                      feedbackSystem.updateTutorialPanel({continueState = 2})
                      controlHandler:resetState("missionComplete")
                      controlHandler:removeState("missionComplete", localPlayer.localID)
                    end
                  }
                }
              })
              controlHandler:setState("missionComplete")
            end,
            afterDuration = 0.01
          },
          {infiniteLength = true}
        },
        {
          {duration = 0.01}
        },
        {
          action = "resumeSimulation"
        },
        {
          action = "callback",
          callback = function()
            feedbackSystem.updateTutorialPanel({panelState = 3})
            simulation.setSpeed(1)
            localPlayer:exitCutsceneMode()
            localPlayer:blockAbility("zap", false)
            localPlayer:resetCameraMode()
            if localPlayer.cameraMode == "DriverEye" then
              CameraSystem.SetClippingPlanesForKidnappedBootShot(false)
            end
          end
        }
      }
      CameraSystem.AddScene(tutorialPanel)
    end
    localPlayer.simulationSupport.doSlowDown(doTutorialPanel(params), 0.1, 0.1, true)
  end
  local function update()
    if task.specialName == "First suspicion" or task.specialName == "Second suspicion" then
      currentSuspicion = task.agent:getTaskObject().namedTasks[task.specialName].networkVars.payload or 0
      if prevSuspicion ~= currentSuspicion then
        if currentSuspicion <= 100 then
          suspicionBar.value = currentSuspicion
          Sound.SetRTPC("Paranoia_Meter", currentSuspicion)
        else
          suspicionBar.value = 100
        end
        feedbackSystem.updateDangerBar(suspicionBar)
        if prevSuspicion > currentSuspicion then
          Sound.SetState("Suspicion_State", "Off")
        else
          Sound.SetState("Suspicion_State", "On")
        end
        prevSuspicion = currentSuspicion
      end
    elseif task.specialName == "Mission feedback" and showTimer then
      feedbackSystem.stepTimer(timer)
    end
  end
  local avoidAlleywaysPromptShowing = false
  local function goalComplete(conditionKey)
    if task.specialName == "First suspicion" or task.specialName == "Second suspicion" then
      if conditionKey == 3 then
        local prompt = {
          prompt = "ID:184547",
          delay = false,
          priority = 2
        }
        feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
        avoidAlleywaysPromptShowing = true
      elseif conditionKey == 2 then
        if feedbackSystem.menusMaster.primaryPromptActive and avoidAlleywaysPromptShowing then
          feedbackSystem.menusMaster.clearPrimaryTextPrompt()
          avoidAlleywaysPromptShowing = false
        end
      elseif conditionKey == 8 then
        local prompt = {
          prompt = "ID:243908",
          delay = false,
          priority = 2
        }
        feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
      elseif conditionKey == 6 then
        local prompt = {
          prompt = "ID:245324",
          delay = false,
          priority = 2
        }
        feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
        avoidAlleywaysPromptShowing = true
      end
    elseif task.specialName == "Mission feedback" then
      if conditionKey == 1 then
        local prompt = {
          prompt = "ID:184549",
          delay = false,
          priority = 1
        }
        feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
      elseif conditionKey == 3 or conditionKey == 4 then
        local prompt = {
          prompt = "ID:184550",
          delay = true,
          priority = 2
        }
        feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
      elseif conditionKey == 5 then
        showTimer = true
      end
    end
  end
  local function taskComplete()
    if task.specialName == "Trigger gameplay section 1" then
      local prompt = {
        prompt = "ID:184545",
        delay = false,
        priority = 1
      }
      feedbackSystem.menusMaster.primaryTextPromptParam(prompt)
      feedbackSystem.menusMaster.blockHintButton(false)
    elseif task.specialName == "Tutorial trigger" then
      tutorialPanel({
        vehicle = localPlayer.currentVehicle
      })
    elseif task.specialName == "SoftSave" then
      feedbackSystem.removeSlot(1)
      Sound.SetState("Suspicion_State", "Off")
    end
  end
  return update, goalComplete, taskComplete, nil
end)
