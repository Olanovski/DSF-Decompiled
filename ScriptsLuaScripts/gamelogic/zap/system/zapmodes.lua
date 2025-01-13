module("zap")
local createZapReturnMultiplayerBusCallback = function(modeTable)
  return function()
    if gameStatus.onlineSession and vehicleManager.multiplayerBusManager.multiplayerBusActive and not vehicleManager.multiplayerBusManager.playerInMultiplayerBus then
      vehicleManager.multiplayerBusManager.zapReturnInZapToMultiplayerBus()
    end
  end
end
local activeVehicleTwo = function(state)
  if gameStatus.onlineSession and state == "JustPressed" then
    vehicleManager.activeVehicles.setActiveVehicleSlot(1)
  end
end
local activeVehicleOne = function(state)
  if gameStatus.onlineSession and state == "JustPressed" then
    vehicleManager.activeVehicles.setActiveVehicleSlot(0)
  end
end
modes = {
  [1] = {
    stateName = "Missile",
    zapControllerName = "Missile",
    oneShotSoundStarts = {
      [1] = "Play_Enter_Zap_State"
    },
    oneShotSoundStops = {
      [1] = "Play_Exit_Zap_State"
    }
  }
}
for i, modeTable in ipairs(modes) do
  modeTable.mode = i
  modeTable.zapReturnMultiplayerBusFunction = createZapReturnMultiplayerBusCallback(modeTable)
end
local zapButtonJustPressedOverride
function setZapButtonJustPressedOverride(overrideFunction)
  zapButtonJustPressedOverride = overrideFunction
end
local function zapJustPressedCallback(state, inputValue, localID)
  if zapButtonJustPressedOverride then
    zapButtonJustPressedOverride()
  end
end
local zapToAction = function(state, inputValue, localID)
  MPZapToAction.trigger(localID)
end
local instructionScreenOnCallback = function()
  if gameStatus.onlineSession and onlineScreenManager.isIntroScreenShowing() and onlineScreenManager.isInstructionButtonActivated() and not onlineScreenManager.isInstructionScreenOn() then
    onlineScreenManager.displayInstructionScreen()
  end
end
local instructionScreenOffCallback = function()
  if gameStatus.onlineSession and onlineScreenManager.isIntroScreenShowing() and onlineScreenManager.isInstructionScreenOn() then
    onlineScreenManager.turnOffInstructionScreen()
  end
end
local toggleTeamCallback = function()
  if gameStatus.onlineSession and onlineScreenManager.isIntroScreenShowing() and onlineScreenManager.isTeamSwapButtonActivated() then
    onlineScreenManager.onTeamSwapToggle()
  end
end
local playerListCallback = function()
  if gameStatus.onlineSession and phaseManager.inMission() then
    onlineSideBar.toggleSideBar()
  end
end
local onlineGamerCardHighlightUp = function()
  if gameStatus.onlineSession then
    onlineScreenManager.moveGamerCardHighlight("up")
  end
end
local onlineGamerCardHighlightDown = function()
  if gameStatus.onlineSession then
    onlineScreenManager.moveGamerCardHighlight("down")
  end
end
local onlineShowGamerCard = function()
  if gameStatus.onlineSession then
    onlineScreenManager.showPlayerGamerCard()
  end
end
local onlineRewardProgressCallback = function()
  if gameStatus.onlineSession and onlineScreenManager.isCompleteScreenShowing() then
    onlineScreenManager.progressRewardScreen()
  end
end
local onlineRewardToggleCallback = function()
  if gameStatus.onlineSession and onlineScreenManager.isCompleteScreenShowing() then
    onlineScreenManager.toggleRewardScreen()
  end
end
local onlineCancelCallback = function(state, inputValue, localID)
  if gameStatus.onlineSession and localID == 0 then
    onlineScreenManager.screenManagerOnCancelButton()
  end
end
ZapInOverrideFunction = nil
targetGameVehicle = false
local player
local locked = false
local showLockedFeedback = {
  [0] = false,
  [1] = false
}
local showLockedFeedbackStartTime = {
  [0] = 0,
  [1] = 0
}
function AttemptZapIntoVehicle(state, inputValue, localID)
  player = localPlayerManager.players[localID]
  shouldZapIn = zapcontroller.ZapInPressed(localID) and (not player.zapTransition or zapcontroller.getTargetZapLevel() ~= 0 and zapcontroller.getZapLevel() ~= 0)
  targetGameVehicle = zapcontroller.GetTargetedGameVehicle(localID)
  if not gameStatus.onlineSession and targetGameVehicle then
    local targetModelID = targetGameVehicle.model_id
    local targetAgent = vehicleManager.vehiclesByGameVehicle[targetGameVehicle]
    locked = false
    if targetAgent then
      local targetTaskObject = targetAgent:getTaskObject()
      local playerTaskObject = localPlayer:getTaskObject()
      if targetTaskObject then
        locked = targetTaskObject.coreData.actor.lockedToPlayer
        if not locked then
          local mission = progressionSystem.findMissionInProgression(targetTaskObject.coreData.instance.challenge.name)
          local chapter = progressionSystem.getCurrentChapter()
          if not mission.spawn or mission.unlocked or playerTaskObject and targetTaskObject.coreData.instance.challenge.name == playerTaskObject.coreData.instance.challenge.name or chapter == 0 and targetTaskObject.coreData.instance.challenge.name == "The debrief" and not ProfileSettings.IsTakedownUnlocked() then
          else
            locked = true
          end
        end
      end
    end
  end
  if shouldZapIn then
    if ZapInOverrideFunction ~= nil then
      ZapInOverrideFunction(localID)
    elseif (gameStatus.onlineSession or not locked) and zapcontroller.IsVehicleZappable(targetGameVehicle, localID) and not player.blockedAbilities.zap then
      player:SetZapLevel(0, {gameVehicle = targetGameVehicle}, false, {playerInstigated = true})
      targetGameVehicle = false
      locked = false
    else
      OneShotSound.Play("ZAP_ZapIn_Unavailable")
    end
  end
  if gameStatus.onlineSession then
    if shouldZapIn then
      if not showLockedFeedback[localID] and targetGameVehicle and (not zapcontroller.IsVehicleZappable(targetGameVehicle, localID) or locked) then
        zapcontroller.ShowZapInLockedIcon(localID, true)
        showLockedFeedback[localID] = true
        showLockedFeedbackStartTime[localID] = g_NetworkTime
      else
        zapcontroller.ShowZapInLockedIcon(localID, false)
        showLockedFeedbackStartTime[localID] = 0
        showLockedFeedback[localID] = false
      end
    elseif showLockedFeedback[localID] and g_NetworkTime - showLockedFeedbackStartTime[localID] > 0.5 then
      zapcontroller.ShowZapInLockedIcon(localID, false)
      showLockedFeedback[localID] = false
    end
  elseif not showLockedFeedback[localID] and targetGameVehicle and (not zapcontroller.IsVehicleZappable(targetGameVehicle, localID) or locked) then
    zapcontroller.ShowZapInLockedIcon(localID, true)
    showLockedFeedback[localID] = true
  elseif showLockedFeedback[localID] and targetGameVehicle and zapcontroller.IsVehicleZappable(targetGameVehicle, localID) and not locked or not targetGameVehicle then
    zapcontroller.ShowZapInLockedIcon(localID, false)
    showLockedFeedback[localID] = false
  end
end
function SetZapInOverride(overrideFunction)
  ZapInOverrideFunction = overrideFunction
end
ZapCallbacks = {
  Zap_Return = {
    JustPressed = {
      [1] = modes[1].zapReturnMultiplayerBusFunction,
      [2] = localPlayer.controllerInterface.zapReturnButtonPressedCallback,
      [3] = zapToAction
    }
  },
  Zap_In = {
    JustPressed = {
      [1] = zapJustPressedCallback
    },
    NotPressed = {
      [1] = AttemptZapIntoVehicle
    }
  },
  Menu_ExtraFirst = {
    JustPressed = {
      [1] = toggleTeamCallback
    }
  },
  Menu_ExtraSecond = {
    JustPressed = {
      [1] = instructionScreenOnCallback,
      [2] = onlineRewardToggleCallback
    }
  },
  Player_List = {
    JustPressed = {
      [1] = playerListCallback
    }
  },
  Menu_Select = {
    JustPressed = {
      [1] = onlineShowGamerCard,
      [2] = instructionScreenOffCallback,
      [3] = onlineCancelCallback,
      [4] = onlineRewardProgressCallback
    }
  },
  Menu_Up = {
    JustPressed = {
      [1] = onlineGamerCardHighlightUp
    }
  },
  Menu_Down = {
    JustPressed = {
      [1] = onlineGamerCardHighlightDown
    }
  },
  Zap_ActiveVehicle_Two = {
    JustPressed = {
      [1] = activeVehicleTwo
    }
  },
  Zap_ActiveVehicle_One = {
    JustPressed = {
      [1] = activeVehicleOne
    }
  },
  Zoom_Minimap = {
    JustPressed = {
      [1] = localPlayer.controllerInterface.ZoomOutMinimap
    },
    JustReleased = {
      [1] = localPlayer.controllerInterface.ZoomInMinimap
    }
  },
  Focus = {
    JustPressed = {
      [1] = localPlayer.controllerInterface.focusButtonCallback
    },
    JustReleased = {
      [1] = localPlayer.controllerInterface.focusButtonCallback
    }
  }
}
controlHandler:registerState(0, modes[1].stateName, ZapCallbacks)
controlHandler:registerState(1, modes[1].stateName, ZapCallbacks)
