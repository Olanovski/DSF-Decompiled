local backToTheGame = function()
  localPlayer:blockAbility("zap", true)
  if localPlayer.currentVehicle then
    player.setAttachment(localPlayer.localID, localPlayer.currentVehicle.gameVehicle)
    spoolsystem.SetSpoolCentreAttachment(localPlayer.localID, localPlayer.currentVehicle.gameVehicle)
  end
  controlHandler:resetState("missionComplete")
  controlHandler:removeState("missionComplete", localPlayer.localID)
  localPlayer:exitCutsceneMode()
end
cutscenes = cutscenes or {}
cutscenes.ExpositionZapStartIGCS = {
  {
    action = "callback",
    callback = function()
      transitions.fadeto(vec.vector(0, 0, 0, 0), 1, 0.1)
      localPlayer:enterCutsceneMode()
      player.setAttachment(localPlayer.localID, CameraSystem.GetCamera())
      spoolsystem.EnableCameraTracking()
    end
  },
  {
    {
      action = "spline",
      SplineBuffer = {
        {
          cameraMatrix = vec.matrix(-0.7699322, 0.06252581, -0.6350549, 1205.704, -0.009963964, 0.993889, 0.1099355, 10.12782, 0.6380488, 0.09097047, -0.764603, 1276.444, 0, 0, 0, 1),
          duration = 0,
          fov = 1.412783
        },
        {
          cameraMatrix = vec.matrix(-0.798043, 0.09314556, 0.5953588, 1204.863, -0.009963964, 0.9858071, -0.1675888, 20.60017, -0.6025191, -0.1396747, -0.785787, 1281.818, 0, 0, 0, 1),
          duration = 5,
          fov = 1.312783
        }
      }
    },
    {
      action = "callback",
      callback = function()
      end,
      afterDuration = 0.5
    }
  },
  {
    {
      action = "blend",
      blendFunction = "nonLinear",
      lookFrom = vec.vector(1196.278, 23.71365, 1299.479, 1),
      lookAt = vec.vector(1192.744, 24.55159, 1302.915, 1),
      fov = 1.308,
      duration = 1.5
    }
  },
  {
    action = "callback",
    callback = function()
      eventFeedback(localPlayer.currentVehicle, "billboard")
      feedbackSystem.menusMaster.masterSetTextVariable("accept_button", localPlayer.buttonLayout.accept)
      feedbackSystem.menusMaster.masterSetTextVariable("preview_accept_description", "ID:173943")
      feedbackSystem.menusMaster.masterSetVariable("iMission_Preview_Buttons", 1)
      controlHandler:registerState(localPlayer.localID, "missionComplete", {
        MissionComplete_Continue = {
          JustPressed = {
            [1] = function()
              input = "continue"
              CameraSystem.ContinueScene()
            end
          }
        }
      })
      controlHandler:setState("missionComplete")
    end
  },
  {infiniteLength = true},
  {duration = 0.01},
  {
    action = "resumeSimulation"
  },
  {
    action = "callback",
    callback = function()
      if input == "continue" then
        feedbackSystem.menusMaster.masterSetVariable("iMission_Preview_Buttons", 0)
        backToTheGame()
      end
    end
  }
}
