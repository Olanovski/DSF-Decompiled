module("localPlayer.controllerInterface", package.seeall)
parent = localPlayer
local pauseMusic = function()
  Music.TogglePause()
end
local skipMusic = function()
  Music.Skip()
end
local rewindMusic = function()
  Music.ReloadRewind()
end
local playerListCallback = function(state, value, localID)
  if gameStatus.onlineSession then
    onlineSideBar.toggleSideBar()
  end
end
local zapButtonPressedCallback = function(state, value, localID)
  local self = localPlayerManager.players[localID].controllerInterface
  local zappedOk = false
  if self.parent:getAbilityAvailable("zap") and (not gameStatus.onlineSession or gameStatus.onlineSession and scoreSystem.enoughAbilityToUseShift(localID) and packageManager.playerNotLockedInPackage(localID)) and not self.parent.inZap and not self.parent.zapTransition and not self.parent.inCutscene and not self.parent.inCutsceneOrIcam and not self.parent.selfRighting and not garage.isGaragePurchaseScreenActive() and self.parent:isZapLevel() ~= 0 and (not phaseManager.inMission() or gameStatus.onlineSession) then
    self.parent:SetZapLevel(1)
    scoreSystem.enteringZap(localID)
    zappedOk = true
  end
  if zappedOk == false then
    if localPlayer:getAbilityAvailable("zap") or isAbilityUnlocked("zap") and localPlayer.blockedAbilities.zap then
      OneShotSound.Play("HUD_Gen_Ability_NoFuel_Shift_OneShot", false)
    end
    if not gameStatus.splitscreenSession and scoreSystem.blockedFeedbackOn and isAbilityUnlocked("zap") and localPlayer.blockedAbilities.zap then
      feedbackSystem.menusMaster.currentHUDSetVariable("iShift_Blocked", 1)
    end
    if not scoreSystem.enoughAbilityToUseShift(localID) and not localPlayer.blockedAbilities.zap then
      GameplayTracking.OnZapOutFail()
    end
  end
end
function zapReturnButtonPressedCallback(state, value, localID)
  local self = localPlayerManager.players[localID].controllerInterface
  if not self.parent.inCutscene and not self.parent.zapReturning and not self.parent.selfRighting and not self.parent.zapTransition and not garage.isGaragePurchaseScreenActive() then
    if not gameStatus.onlineSession and localPlayer:getAbilityAvailable("zapReturn") and not self.parent.blockRapidShiftPress then
      self.parent:doZapReturn()
    else
      MPZapToAction.trigger(localID)
    end
  end
end
local zapReturnMultiplayerBusCallback = function(state, value, localID)
  if not vehicleManager.multiplayerBusManager.playerInMultiplayerBus and vehicleManager.multiplayerBusManager.multiplayerBusActive then
    vehicleManager.multiplayerBusManager.zapReturnToMultiplayerBus()
  end
end
function focusButtonCallback(state, value, localID)
  if not gameStatus.onlineSession then
    if state == "JustPressed" then
      if not dareSystem.promptingDareRetry and feedbackSystem.previewScreen.activityBeingPrompted and not localPlayer.inCutscene and not localPlayer.zapTransition then
        if feedbackSystem.previewScreen.activityBeingPrompted.hotspotType and feedbackSystem.previewScreen.activityBeingPrompted.hotspotType == "garage" then
          if garage.locations[feedbackSystem.previewScreen.activityBeingPrompted.ID] then
            local garageID = false
            if localPlayer.inZap then
              garageID = feedbackSystem.previewScreen.activityBeingPrompted.ID
            else
              garageID = garage.currentGarageID
            end
            if garageID then
              if not ProfileSettings.GetGarageOwned(garageID) then
                garage.purchaseGaragePrompt(garageID)
                if localPlayer.inZap and feedbackSystem.previewScreen.missionButtonPrompt then
                  feedbackSystem.previewScreen.buttonPressed()
                else
                  feedbackSystem.previewScreen.hideButton()
                end
              else
                garage.enterGarage(garageID)
              end
            end
          end
        else
          activeChallenges.triggerActivity()
          if localPlayer.inZap and feedbackSystem.previewScreen.missionButtonPrompt then
            feedbackSystem.previewScreen.buttonPressed()
          else
            feedbackSystem.previewScreen.hideButton()
          end
        end
        felony_suspiciousVehicleManager.enableSuspiciousVehicles(false)
        felony_patrollingVehicleManager.enablePatrollingVehicles(false)
      elseif dareSystem.promptingDareRetry then
        dareSystem.promptingDareRetry = false
        dareSystem.resettingDare = true
        OneShotSound.Play("Menu_Select", false)
        feedbackSystem.menusMaster.clearPrimaryTextPrompt()
        dareSystem.reactivateSuspendedDare()
        feedbackSystem.menusMaster.updateFreedriveHintText()
        feedbackSystem.menusMaster.blockHintButton(false)
        removeUserUpdateFunction("endDare")
        dareSystem.checkIfInHotspot()
      end
      feedbackSystem.menusMaster.focusHintPromptState(true)
    elseif feedbackSystem.menusMaster.focusHintPromptActive then
      feedbackSystem.menusMaster.focusHintPromptState(false)
    end
  end
end
function abilityStopCallback()
end
local currentVehicle = false
local currentInterface = false
minTimeBetweenActivate = 0.5
minInputToActivate = 0.8
minInputToDeactivate = 0.2
noPointsTriggerAllowed = true
releaseTime = -1
releaseRequired = {boost = false, ram = false}
function getAbilityReleaseRequired(self, ability)
  return self.releaseRequired[ability]
end
function setAbilityReleaseRequired(self, ability, state)
  self.releaseRequired[ability] = state
end
function resetAbilityInput(self, ability)
  self.noPointsTriggerAllowed = true
  self:setAbilityReleaseRequired(ability, false)
end
function BoostAbilityTrigger(state, inputValue, localID)
  currentInterface = localPlayerManager.players[localID].controllerInterface
  currentVehicle = currentInterface.parent.currentVehicle
  if currentVehicle then
    if not currentVehicle.abilityActive then
      if abilities.ram.getState(localID) == 0 and (g_NetworkTime - currentInterface.releaseTime > currentInterface.minTimeBetweenActivate or currentInterface.releaseTime > g_NetworkTime) then
        if state ~= "JustReleased" and AbilityController.boostAbilityInput(localID) > currentInterface.minInputToActivate then
          if not currentInterface:getAbilityReleaseRequired("nitro") then
            if scoreSystem.getAbility(localID) >= abilities.getPointsToUseAbility("nitro") then
              currentVehicle:triggerAbility(abilityStopCallback, "nitro", localID)
              Sound.OnAbilityButtonPressed(currentVehicle.gameVehicle, currentVehicle.abilityActive, "Nitro", localID)
              currentInterface:setAbilityReleaseRequired("nitro", true)
            elseif currentInterface.noPointsTriggerAllowed then
              OneShotSound.Play("HUD_Gen_Ability_NoFuel_Boost_OneShot", false)
              AbilityController.noAbilityPoints("nitro", localID)
              currentInterface.noPointsTriggerAllowed = false
            end
          end
        else
          currentInterface:resetAbilityInput("nitro")
        end
      end
    elseif currentVehicle.activeAbilityName == "nitro" and (state == "JustReleased" or AbilityController.boostAbilityInput(localID) < currentInterface.minInputToDeactivate) then
      if not abilities.getUseDurationBoost() then
        currentVehicle:stopAbility(localID)
      end
      currentInterface:resetAbilityInput("nitro")
    end
  end
end
function RamAbilityTrigger(state, inputValue, localID)
  currentInterface = localPlayerManager.players[localID].controllerInterface
  currentVehicle = currentInterface.parent.currentVehicle
  if currentVehicle then
    if not currentVehicle.abilityActive then
      if abilities.ram.getState(localID) == 0 and g_NetworkTime - currentInterface.releaseTime > currentInterface.minTimeBetweenActivate then
        if AbilityController.ramAbilityInput(localID) > currentInterface.minInputToActivate then
          if not currentInterface:getAbilityReleaseRequired("ram") then
            if scoreSystem.getAbility(localID) >= abilities.getPointsToUseAbility("ram") and (abilities.getAllowRamOnDrift() or not currentInterface.parent.scoring.isDrifting) then
              currentVehicle:triggerAbility(abilityStopCallback, "ram", localID)
              Sound.OnAbilityButtonPressed(currentVehicle.gameVehicle, currentVehicle.abilityActive, "Ram", localID)
              currentInterface:setAbilityReleaseRequired("ram", true)
            elseif currentInterface.noPointsTriggerAllowed then
              OneShotSound.Play("HUD_Gen_Ability_NoFuel_Ram_OneShot", false)
              AbilityController.noAbilityPoints("ram", localID)
              currentInterface.noPointsTriggerAllowed = false
            end
          end
        else
          currentInterface:resetAbilityInput("ram")
        end
      end
    elseif currentVehicle.activeAbilityName == "ram" and (state == "JustReleased" or AbilityController.ramAbilityInput(localID) < currentInterface.minInputToDeactivate) then
      currentVehicle:stopAbility(localID)
      currentInterface:resetAbilityInput("ram")
    end
  end
end
function cancelAbilityOnBrake(state, inputValue, localID)
  currentInterface = localPlayerManager.players[localID].controllerInterface
  currentVehicle = currentInterface.parent.currentVehicle
  if currentVehicle and currentVehicle.abilityActive then
    currentVehicle:cancelAbility(localID)
    if currentInterface.parent.controls:getStatus("Activate_Boost") == "NotPressed" then
      currentInterface:resetAbilityInput("nitro")
    end
    if currentInterface.parent.controls:getStatus("Activate_Ram") == "NotPressed" then
      currentInterface:resetAbilityInput("ram")
    end
  end
end
local carSwapTrigger = function(state, inputValue, localID)
  if zap.zapSwap.isSwapAvailable() then
    zap.zapSwap.carSwapTriggered(localPlayer)
  end
end
local activeVehicleOne = function(state, inputValue, localID)
  if gameStatus.onlineSession then
    vehicleManager.activeVehicles.setActiveVehicleSlot(0)
  end
end
local activeVehicleTwo = function(state, inputValue, localID)
  if gameStatus.onlineSession then
    vehicleManager.activeVehicles.setActiveVehicleSlot(1)
  end
end
local splitscreenContinueCallback = function()
  if gameStatus.splitscreenSession and onlineScreenManager.isSplitscreenIntroOn() and phaseManager.splitscreenModeLoaded and GameModeManager.GetSplitScreenMissionMode() == 1 and SplitScreen.getControllerConnected(0) and SplitScreen.getControllerConnected(1) then
    onlineScreenManager.splitscreenContinuPressed = true
    OneShotSound.Play("Menu_Select")
  end
end
function ZoomOutMinimap(state, inputValue, localID)
  if minimap.GetOn(localID) then
    plr = localPlayerManager.players[localID]
    plr.minimapSupport:zoomOut()
  end
end
function ZoomInMinimap(state, inputValue, localID)
  if minimap.GetOn(localID) then
    plr = localPlayerManager.players[localID]
    plr.minimapSupport:zoomIn()
  end
end
local controlState
local changeCamera = function(state, value, localID, recursionLength)
  if cycleActiveCamera(state, value, localID, recursionLength) then
    print("play camera change sound")
    OneShotSound.Play("Menu_Move", false)
  end
end
function createCallbacks(self)
  self.controlState = {
    Camera_Change = {
      JustPressed = {changeCamera}
    },
    Zoom_Minimap = {
      JustPressed = {ZoomOutMinimap},
      JustReleased = {ZoomInMinimap}
    },
    Zap_In = {
      JustPressed = {zapButtonPressedCallback}
    }
  }
  if isAbilityUnlocked("zapReturn") or gameStatus.onlineSession then
    self.controlState.Zap_Return = {
      JustPressed = {zapReturnButtonPressedCallback}
    }
  end
  if isAbilityUnlocked("nitro") then
    self.controlState.Activate_Boost = {
      Pressed = {BoostAbilityTrigger},
      JustReleased = {BoostAbilityTrigger}
    }
    self:setAbilityReleaseRequired("boost", false)
  end
  if isAbilityUnlocked("ram") then
    self.controlState.Activate_Ram = {
      Pressed = {RamAbilityTrigger},
      JustReleased = {RamAbilityTrigger}
    }
    self:setAbilityReleaseRequired("ram", false)
  end
  if gameStatus.onlineSession then
    self:createMultiplayerCallbacks()
  else
    self:createSinglePlayerCallbacks()
  end
  self.parent.controls:registerState(self.parent.localID, "Player", self.controlState)
  self.parent.controls:setState("Player", 1, self.parent.localID)
end
function createSinglePlayerCallbacks(self)
  self.controlState.Jukebox_Pause = {
    JustPressed = {pauseMusic}
  }
  self.controlState.Jukebox_NextTrack = {
    JustPressed = {skipMusic}
  }
  self.controlState.Jukebox_PrevTrack = {
    JustPressed = {rewindMusic}
  }
  self.controlState.Focus = {
    JustPressed = {focusButtonCallback},
    JustReleased = {focusButtonCallback}
  }
  if self.parent.currentVehicle and self.parent.currentVehicle.beingTowed then
    self.controlState.Vehicle_Detach_Waggle_Horz = {
      Pressed = {unhookPlayerVehicleWithWaggle}
    }
    self.controlState.Vehicle_Detach_Waggle_Vert = {
      Pressed = {unhookPlayerVehicleWithWaggle}
    }
  end
end
function createMultiplayerCallbacks(self)
  self.controlState.Player_List = {
    JustPressed = {playerListCallback}
  }
  if not vehicleManager.multiplayerBusManager.playerInMultiplayerBus and vehicleManager.multiplayerBusManager.multiplayerBusActive then
    self.controlState.Zap_Return = {
      JustPressed = {zapReturnMultiplayerBusCallback}
    }
  end
  if onlineProgressionSystem.onlineWeaponData[1].unlocked or onlineProgressionSystem.onlineWeaponData[3].unlocked then
    self.controlState.Car_Swap = {
      JustPressed = {carSwapTrigger}
    }
    self.controlState.Zap_ActiveVehicle_One = {
      JustPressed = {activeVehicleOne}
    }
    self.controlState.Zap_ActiveVehicle_Two = {
      JustPressed = {activeVehicleTwo}
    }
  end
  self.controlState.Menu_Select = {
    JustPressed = {splitscreenContinueCallback}
  }
  self.controlState.Vehicle_Reverse = {
    JustPressed = {cancelAbilityOnBrake}
  }
  self.controlState.Vehicle_HandBrake = {
    JustPressed = {cancelAbilityOnBrake}
  }
end
function removeCallbacks(self)
  self.parent.controls:resetState("Player", 1, self.parent.localID)
  self.parent.controls:removeState("Player", self.parent.localID)
end
function resetCallbacks(self)
  self:removeCallbacks()
  self:createCallbacks()
end
function registerPlayerControl(self)
  if not self.parent.isInControl and not self.parent.inZap and player.getAttachment(self.parent.localID) then
    self.parent.isInControl = true
    self.parent.currentVehicle:stopHighSpeedDriving()
    player.setAttachment(self.parent.localID, self.parent.currentVehicle.gameVehicle)
    if configSelector.launchConfig.Name == [[
Multiplayer
Play Test]] then
      self.parent.currentVehicle:highSpeedDrive({
        desiredSpeed = 40,
        wanderType = "random",
        avoidAlleyways = 0,
        driveOnPavements = 0.5,
        driveInOncoming = 0.5,
        collisionResilience = "Very tough",
        drivingSkill = "Professional"
      })
      self.parent.currentVehicle:set_damageMultiplier(0)
      PatrollingVehicleManager.Enable(false)
    else
      player.registerController(self.parent.localID)
    end
  end
end
function removePlayerControl(self, AIbehaviour)
  if self.parent.isInControl then
    self.parent.isInControl = false
  end
  player.removeController(self.parent.localID)
  if self.parent.currentVehicle and self.parent.currentVehicle.controlled then
    if self.parent.currentVehicle.abilityActive then
      self.parent.currentVehicle:stopAbility(self.parent.localID)
    end
    if AIbehaviour then
      local behaviour
      if type(AIbehaviour) == "table" then
        behaviour = AIbehaviour
      else
        behaviour = {
          personality = "civ",
          traits = {
            desiredSpeed = self.parent.currentVehicle.gameVehicle.speed,
            wanderType = "preferStraight",
            avoidedByCivilianTraffic = true
          }
        }
      end
      self.parent.currentVehicle:randomWander(behaviour)
    elseif AIbehaviour == false then
      self.parent.currentVehicle:stopHighSpeedDriving()
    end
  end
end
