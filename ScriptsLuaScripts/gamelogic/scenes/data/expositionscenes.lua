cutsceneManager.registerScene("ExpositionBillboard", {
  Text = "This is some test text"
}, function(params)
  local enableBillboard = function()
    BillboardManager.Enable()
    OneShotSound.Play("GUI_Billboard_OneShot")
  end
  local function drawText()
    feedbackSystem.menusMaster.masterSetTextVariable("prompt_primary", params.Text)
    feedbackSystem.menusMaster.masterSetVariable("iPrompt_Primary_Display", 1)
  end
  local billboardDiscovery = {
    {
      action = "callback",
      callback = function()
        player.setAttachment(localPlayer.localID, CameraSystem.GetCamera())
        spoolsystem.EnableCameraTracking()
        localPlayer.currentVehicle:highSpeedDrive(params.AIBehaviour)
      end
    },
    {
      {
        action = "spline",
        SplineBuffer = {
          {
            cameraMatrix = vec.matrix(-0.8392117, -0.05763803, -0.5407417, -474.3972, 0, 0.9943672, -0.1059903, 26.03435, 0.5438049, -0.08894829, -0.8344845, 737.3923, 0, 0, 0, 1),
            duration = 0,
            fov = 1.412783
          },
          {
            cameraMatrix = vec.matrix(0.2554697, -0.04842871, -0.9656034, -474.3972, 0, 0.9987447, -0.05009088, 26.03435, 0.9668171, 0.0127967, 0.2551489, 737.3923, 0, 0, 0, 1),
            duration = 5,
            fov = 1.312783
          }
        }
      },
      {
        action = "callback",
        callback = function()
          eventFeedback(localPlayer.currentVehicle, "Billboard")
        end,
        afterDuration = 0.5
      }
    },
    {action = "callback", callback = enableBillboard},
    {
      {
        action = "blend",
        blendFunction = "nonLinear",
        lookFrom = vec.vector(-474.3972, 26.03435, 737.3923, 1),
        lookAt = vec.vector(-469.6997, 26.65871, 735.7962, 1),
        fov = 0.5461171,
        duration = 1.5
      },
      {
        action = "callback",
        callback = function()
          eventFeedback(params.targets.MainAgent, "Billboard_2")
        end,
        afterDuration = 0.3
      }
    },
    {action = "callback", callback = drawText},
    {
      {duration = 6.25},
      {
        action = "callback",
        callback = function()
          eventFeedback(params.targets.MainAgent, "Billboard_3")
        end,
        afterDuration = 0.5
      }
    },
    {
      action = "callback",
      callback = function()
        localPlayer.currentVehicle:stopHighSpeedDriving()
        player.setAttachment(localPlayer.localID, localPlayer.currentVehicle.gameVehicle)
        spoolsystem.SetSpoolCentreAttachment(localPlayer.localID, localPlayer.currentVehicle.gameVehicle)
      end
    },
    {
      action = "blend",
      blendFunction = "slerp",
      type = localPlayer.cameraMode == "Normal" and "Dynamic_Vehicle_Chase" or localPlayer.cameraMode == "DriverEye" and "Driver_Eye" or localPlayer.cameraMode == "Bumper" and "Dynamic_Vehicle_Bumper",
      gameVehicle = params.targets.MainAgent.gameVehicle,
      duration = 2
    },
    {
      action = "callback",
      callback = function()
        feedbackSystem.menusMaster.masterSetVariable("iPrompt_Primary_Display", 0)
      end
    }
  }
  billboardDiscovery[2][1].SplineBuffer[1].cameraMatrix = game_camera.matrix
  return billboardDiscovery, nil
end)
