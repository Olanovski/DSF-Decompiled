taskSystem.registerTask("Zap to vehicle", nil, function(task)
  local hasCutToTarget = false
  local function endCallback()
    if task.forceZapToVehicle then
      if not localPlayer.inZap then
        localPlayer:SetZapLevel(1, nil, false, {forcedOut = true})
      end
      if task.forceMissionAccept then
        localPlayer:SetZapLevel(0, task.agent, true, {disableZapFlash = true})
      else
        localPlayer:SetZapLevel(0, task.agent, true, {disableZapFlash = true})
      end
    end
  end
  local function zoomHoldCallback()
    CutsceneFiles.tutorials.playTutorial("ID:245632", nil, function()
      feedbackSystem.menusMaster.primaryTextPrompt("ID:246342", false, true, false, false, localPlayer.buttonLayout.enterZap)
      localPlayer.simulationSupport.doWait(0.15, function()
        localPlayer:SetZapLevel(1)
      end)
    end, nil, task.agent)
    eventFeedback(localPlayer.currentVehicle, "Dealer")
  end
  local function callback(canSee)
    if canSee and not localPlayer.inZap and not isEventActive() then
      local taskObject = task.agent:getTaskObject()
      if taskObject and taskObject.coreData.instance.challenge.name == "Exposition 04 return to dealer" and not vehicleManager.previewVehicleManager.previewVehicle then
        iCamFlyToCam(task.agent.gameVehicle, nil, nil, 1, zoomHoldCallback)
      elseif taskObject.coreData.instance.challenge.name ~= "Exposition 04 return to dealer" then
        localPlayer.cameraSupport.zoomLookToAgent({
          agent = task.agent,
          endCallback = endCallback
        })
      end
      feedbackSystem.menusMaster.blockHintButton(false)
      localPlayer.cameraSupport.removeCanSeeCheck(callback)
      hasCutToTarget = true
    elseif not canSee then
      localPlayer.cameraSupport.removeCanSeeCheck(callback)
      localPlayer.cameraSupport.addCanSeeCheck(callback, task.agent, task.lookToVehicleTriggerRadius or 50)
    end
  end
  if task.lookToVehicle and vehicleManager.previewVehicleManager.previewVehicle ~= task.agent then
    localPlayer.cameraSupport.addCanSeeCheck(callback, task.agent, task.lookToVehicleTriggerRadius or 50)
  elseif task.forceZapToVehicle or task.forceZapToVehicleFromPlayerVehicle then
    endCallback()
  end
  local function cleanup()
    if not hasCutToTarget then
      localPlayer.cameraSupport.removeCanSeeCheck(callback)
    end
  end
  return nil, nil, cleanup
end)
