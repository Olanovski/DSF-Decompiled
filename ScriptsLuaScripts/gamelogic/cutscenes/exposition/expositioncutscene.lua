module("CutsceneFiles.Exposition", package.seeall)
felonyTutorialActive = false
local returnToGameAfterTutorial = function(params)
  local enableZap = function()
    localPlayer:blockAbility("zap", false)
  end
  controlHandler:resetState("missionComplete")
  controlHandler:removeState("missionComplete", localPlayer.localID)
  CameraSystem.ClearScene()
  if params and params.callback then
    params.callback()
  end
  simulation.setSpeed(0)
  if localPlayer.cameraMode == "DriverEye" then
    CameraSystem.SetClippingPlanesForKidnappedBootShot(false)
  end
  localPlayer:exitCutsceneMode()
  localPlayer.simulationSupport.doSpeedUp(enableZap, 1.5, 1)
  felonyTutorialActive = false
end
function felonyTutorial(params)
  local function doFelonyCutscene()
    localPlayer:enterCutsceneMode(false)
    local felonySceneTutorial = {
      {
        action = "behaviour",
        type = "Existing",
        camera = game_camera,
        duration = 0.01
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
            feedbackSystem.updateTutorialPanel({
              panelState = 1,
              title = "ID:236306",
              string1 = "ID:233201",
              string2 = "ID:236307",
              string3 = "ID:236308"
            })
            localPlayer.minimapSupport:show()
          end,
          afterDuration = 0.01
        },
        {duration = 5}
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
                    feedbackSystem.updateTutorialPanel({panelState = 0, continueState = 0})
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
          returnToGameAfterTutorial(params)
        end
      }
    }
    CameraSystem.AddScene(felonySceneTutorial)
  end
  if localPlayer.cameraMode == "DriverEye" then
    CameraSystem.SetClippingPlanesForKidnappedBootShot(true)
  end
  felonyTutorialActive = true
  localPlayer.simulationSupport.doSlowDown(doFelonyCutscene, 1, 0.1, true)
end
