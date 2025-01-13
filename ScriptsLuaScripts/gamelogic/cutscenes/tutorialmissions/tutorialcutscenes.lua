module("CutsceneFiles.tutorials", package.seeall)
tutorialActive = false
local zapBlocked = false
localPlayerManagerReflection.setTutorialActive(tutorialActive)
local tutorialStrings = {
  ["TEST"] = {
    "TEST1",
    "TEST2",
    "TEST3"
  },
  ["ID:245632"] = {
    "ID:245633",
    "ID:245634",
    "ID:245635"
  },
  ["ID:245640"] = {
    "ID:245641",
    "ID:245642",
    "ID:245643"
  },
  ["ID:245644"] = {
    "ID:245645",
    "ID:245646",
    "ID:245647"
  },
  ["ID:245648"] = {
    "ID:245649",
    "ID:245646",
    "ID:245647"
  },
  ["ID:245651"] = {
    "ID:245652",
    "ID:245653",
    "ID:245654"
  },
  ["ID:243884"] = {
    "ID:243885",
    "ID:243886",
    "ID:243887"
  },
  ["ID:243880"] = {
    "ID:243881",
    "ID:243882",
    "ID:243883"
  },
  ["ID:243894"] = {
    "ID:243895",
    "ID:243896",
    "ID:243893"
  },
  ["ID:243890"] = {
    "ID:245173",
    "ID:243891",
    "ID:245150"
  },
  ["ID:243888"] = {
    "ID:243889",
    "ID:245658",
    "ID:245659"
  },
  ["ID:178494"] = {"ID:178506"},
  ["ID:234446"] = {
    "ID:234447",
    "ID:245136",
    "ID:245137",
    "ID:234447",
    "ID:178477",
    "ID:245140",
    "ID:245141",
    "ID:234447",
    "ID:245142"
  },
  ["ID:236222"] = {"ID:234456", "ID:234457"},
  ["ID:236223"] = {"ID:234456", "ID:234457"},
  ["ID:236224"] = {"ID:234456", "ID:234457"},
  ["ID:243165"] = {
    "ID:243166",
    "ID:243169",
    "ID:243172"
  },
  ["ID:243694"] = {
    "ID:243695",
    "ID:243698",
    "ID:243696"
  },
  ["ID:243968"] = {
    "ID:243971",
    "ID:243970",
    "ID:243969"
  },
  ["ID:236714"] = {"ID:234453", "ID:234454"},
  ["ID:245636"] = {
    "ID:245637",
    "ID:245638",
    "ID:245639"
  },
  ["ID:246057"] = {
    "ID:246058",
    "ID:246059",
    "ID:246060"
  },
  ["ID:246205"] = {
    "ID:246206",
    "ID:246207",
    "ID:246208"
  },
  ["ID:246333"] = {
    "ID:246337",
    "ID:246338",
    "ID:246336",
    "ID:246334",
    "ID:246335",
    "ID:246336"
  },
  ["ID:186314"] = {
    "ID:246422",
    "ID:246423",
    "ID:246424"
  }
}
local outStrings = {
  ["ID:234446"] = {
    "ID:183939",
    "ID:234447",
    nil,
    "ID:178477",
    "ID:234447",
    nil,
    "ID:234447"
  },
  ["ID:243165"] = {"ID:243168", "ID:243294"}
}
local function playTutorialMain(tutorial, offset, callback, addPanelAsHUD, vehicle)
  local tutorialButtons = {
    ["ID:178494"] = {
      localPlayer.buttonLayout.boostAbility
    },
    ["ID:234446"] = {
      localPlayer.buttonLayout.zapReturn,
      [3] = nil,
      nil,
      [4] = localPlayer.buttonLayout.zapReturn,
      [5] = localPlayer.buttonLayout.enterZap,
      [6] = localPlayer.buttonLayout.zapReturn,
      [7] = nil,
      [8] = localPlayer.buttonLayout.zapReturn
    },
    ["ID:236714"] = {
      localPlayer.buttonLayout.ramAbility,
      localPlayer.buttonLayout.ramAbility
    },
    ["ID:236222"] = {
      localPlayer.buttonLayout.zapUp,
      localPlayer.buttonLayout.zapDown
    },
    ["ID:236223"] = {
      localPlayer.buttonLayout.zapUp,
      localPlayer.buttonLayout.zapDown
    },
    ["ID:236224"] = {
      localPlayer.buttonLayout.zapUp,
      localPlayer.buttonLayout.zapDown
    },
    ["ID:243880"] = {
      iconsTable.willpower,
      iconsTable.willpower
    },
    ["ID:243888"] = {
      [2] = nil,
      nil,
      [3] = localPlayer.buttonLayout.focusButton
    },
    ["ID:243884"] = {
      [2] = nil,
      nil,
      [3] = iconsTable.willpower
    },
    ["ID:243890"] = {
      iconsTable.willpower
    },
    ["ID:245640"] = {
      [2] = nil,
      nil,
      [3] = iconsTable.willpower
    },
    ["ID:245648"] = {
      [2] = nil,
      nil,
      [3] = iconsTable.willpower
    }
  }
  local titleIcon = {
    ["ID:243890"] = iconsTable.garage
  }
  local outButtons = {
    ["ID:234446"] = {
      localPlayer.buttonLayout.enterZap,
      localPlayer.buttonLayout.zapReturn,
      nil,
      localPlayer.buttonLayout.enterZap,
      localPlayer.buttonLayout.zapReturn,
      nil,
      localPlayer.buttonLayout.zapReturn
    }
  }
  local offset = (offset or 0) * 3
  local function playTutorialCutscene()
    local fromThrillCam = false
    if localPlayer.cameraMode == "DriverEye" or localPlayer.cameraMode == "Bonnet" or tutorial == "ID:186314" then
      CameraSystem.SetClippingPlanesForKidnappedBootShot(true)
    end
    local tutorialCutscene = {
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
            local getIcon1, getIcon2, getIcon3
            if tutorialButtons[tutorial] then
              getIcon1 = tutorialButtons[tutorial][1 + offset]
              getIcon2 = tutorialButtons[tutorial][2 + offset]
              getIcon3 = tutorialButtons[tutorial][3 + offset]
            end
            local panel = {
              panelState = 1,
              title = tutorial,
              titleIcon = titleIcon[tutorial],
              string1 = tutorialStrings[tutorial][1 + offset],
              textIcon1 = getIcon1,
              string2 = tutorialStrings[tutorial][2 + offset],
              textIcon2 = getIcon2,
              string3 = tutorialStrings[tutorial][3 + offset],
              textIcon3 = getIcon3
            }
            local config = feedbackSystem.menusMaster.getControllerPreset(localPlayer.localID)
            if tutorial == "ID:236714" and config == 2 then
              panel.string1 = "ID:242703"
            end
            feedbackSystem.updateTutorialPanel(panel)
          end
        },
        {duration = 3.5}
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
          if addPanelAsHUD then
            if not outStrings[tutorial] then
              feedbackSystem.updateTutorialPanel({panelState = 2, title = ""})
            else
              local getIcon1, getIcon2, getIcon3
              if outButtons[tutorial] then
                getIcon1 = outButtons[tutorial][1 + offset]
                getIcon2 = outButtons[tutorial][2 + offset]
                getIcon3 = outButtons[tutorial][3 + offset]
              end
              local panel = {
                panelState = 2,
                title = "",
                string1 = outStrings[tutorial][1 + offset],
                textIcon1 = getIcon1,
                string2 = outStrings[tutorial][2 + offset],
                textIcon2 = getIcon2,
                string3 = outStrings[tutorial][3 + offset],
                textIcon3 = getIcon3
              }
              feedbackSystem.updateTutorialPanel(panel)
            end
          else
            feedbackSystem.updateTutorialPanel({panelState = 0})
          end
          if fromThrillCam then
            setActiveCamera("ThrillCam", localPlayer.localID)
          end
          if localPlayer.inZap then
            simulation.setSpeed(zap.singlePlayerZapSlowDownMultiplier)
          else
            simulation.setSpeed(1)
          end
          tutorialActive = false
          if zapBlocked then
            localPlayer:blockAbility("zap", false)
            zapBlocked = false
          end
          zapcontroller.EnableZapInput(true)
          localPlayerManagerReflection.setTutorialActive(tutorialActive)
          localPlayer:exitCutsceneMode()
          feedbackSystem.menusMaster.allowUnlockPanel(true)
          if tutorial == "ID:245632" then
            IntelligentCamera.SetFlyToWait(0)
          end
          if callback then
            callback()
          end
          if localPlayer.cameraMode == "DriverEye" or localPlayer.cameraMode == "Bonnet" then
            CameraSystem.SetClippingPlanesForKidnappedBootShot(false)
          end
        end
      }
    }
    if localPlayer.cameraMode == "ThrillCam" and not localPlayer.inZap then
      fromThrillCam = true
      setActiveCamera("Normal", localPlayer.localID)
    end
    CameraSystem.AddScene(tutorialCutscene)
  end
  localPlayer:enterCutsceneMode(nil, false)
  zapcontroller.EnableZapInput(false)
  if not localPlayer.blockedAbilities.zap then
    localPlayer:blockAbility("zap", true)
    zapBlocked = true
  end
  if feedbackSystem.previewScreen.activityBeingPrompted and localPlayer.inZap then
    feedbackSystem.previewScreen.hideZapPreview()
  end
  feedbackSystem.menusMaster.allowUnlockPanel(false)
  if tutorial == "ID:245632" then
    playTutorialCutscene()
  else
    localPlayer.simulationSupport.doSlowDown(playTutorialCutscene, 0.1, 0.1, true)
  end
end
local function waitForTransition(tutorial, offset, callback, addPanelAsHUD, vehicle)
  tutorialActive = true
  localPlayerManagerReflection.setTutorialActive(tutorialActive)
  return function()
    if not localPlayer.zapTransition then
      playTutorialMain(tutorial, offset, callback, addPanelAsHUD, vehicle)
      removeUserUpdateFunction("waitForTransition")
    end
  end
end
function playTutorial(tutorial, offset, callback, addPanelAsHUD, vehicle)
  addUserUpdateFunction("waitForTransition", waitForTransition(tutorial, offset, callback, addPanelAsHUD, vehicle), 1)
end
function playCityMissionTutorial(zapTaskObject, previewVehicle, callback)
  if not localPlayer.inCutscene then
    CutsceneFiles.tutorials.playTutorial("ID:246205", nil, function()
      if zapTaskObject then
        if localPlayer.inZap then
          feedbackSystem.previewScreen.showPreview("shiftMissionPreview", zapTaskObject.coreData.instance.challenge.name, true)
          if not feedbackSystem.previewScreen.missionButtonPrompt and not feedbackSystem.previewScreen.missionLocked then
            feedbackSystem.previewScreen.showButton()
          end
        else
          zap.previewVehicle(localPlayer.currentVehicle)
        end
      else
        zap.previewVehicle(previewVehicle)
        simulation.setSpeed(1)
      end
      if callback then
        callback()
      end
      ProfileSettings.SetToolTipShown(toolTipLookupTable["City Mission"])
    end)
  end
end
