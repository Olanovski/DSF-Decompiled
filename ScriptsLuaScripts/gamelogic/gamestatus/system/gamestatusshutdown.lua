module("gameStatus")
shutDownEvents = {}
function exitSession()
  local playerTask = localPlayer:getTaskObject()
  if playerTask and playerTask.coreData.instance then
    local mission, potID, subType, type = progressionSystem.findMissionInProgression(playerTask.coreData.instance.challenge.name)
    GameplayTracking.OnObjectiveStop(missionInfo[cards.ReverseMissionNetworkLookup[playerTask.coreData.instance.challenge.name]].challengeTitle, type, "QUIT", "QUIT")
  end
  if dareSystem.activeDare then
    GameplayTracking.OnObjectiveStop(dareSystem.activeDare.uid, "dare", "QUIT", "QUIT")
  end
  GameplayTracking.OnLevelStop()
  OnlineModeSettings.onlineDisableAssert = true
  if phaseManager.returnToBusWindowOpen then
    feedbackSystem.menusMaster.onlineHUDSetVariable("iMulti_Reminder_Display", 2)
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_contine", "ID:221041")
    feedbackSystem.menusMaster.onlineHUDSetTextVariable("mission_complete_continue_button", localPlayer.buttonLayout.accept)
    phaseManager.returnToBusWindowOpen = nil
  end
  phaseManager.playlistSupport.clearAllPlayerLists()
  Getaway.StopAll()
  Chase.StopAll()
  TrafficEventsManager.SetEnable(false)
  MPZapToAction.purge()
  removeUserUpdateFunction("networkTime")
  zapcontroller.EnableZapInput(true)
  if gameStatus.onlineSession then
    CityLockManager.CityLockState = "CityLockingLevel4"
    CityLockManager.CityLockActive = true
    CityLockManager.FadeInDistance = 80
    for localID, player in next, localPlayerManager.players, nil do
      zapcontroller.setSpoolerAttached(false, localID)
      zapcontroller.setZapCameraLocks(localID, {
        missile = false,
        low = true,
        mid = false,
        high = false,
        top = false
      })
      if not player.inZap or zapcontroller.getTargetZapLevel(localID) ~= 5 then
        player:SetZapLevel(5, nil, false, {forcedOut = true})
      end
    end
  end
  CameraSystem.ClearScene()
  Menu.SetVariable("Loading", "iCutscene_Skip", 0)
  for localID, plr in next, localPlayerManager.players, nil do
    player.setAttachment(plr.localID, plr.camera)
    plr.controls:setState("zap")
  end
  if localPlayerManager.numberOfPlayers > 1 then
    for localID, plr in next, localPlayerManager.players, nil do
      zapcontroller.EnableZapInput(false, localID)
      zapcontroller.setRenderTarget(false, localID)
      enableAbilities(localID, false)
      localPlayerManager.players[localID].minimapSupport:hide()
      localPlayerManager.players[localID].minimapSupport.hideSS(localID)
    end
  end
  scriptSystems.runPurges()
  if userUpdateFunctions.chunkLoadWait then
    removeUserUpdateFunction("chunkLoadWait")
  end
  if userUpdateFunctions.waitForModePackageLoad then
    removeUserUpdateFunction("waitForModePackageLoad")
  end
  OnlineModeSettings.onlineDisableAssert = false
  collectgarbage("collect")
end
_G.ExitSession = exitSession
function shutDownScripts()
  if performance ~= nil then
    performance.DeactivateHighFPS()
  end
  spooling.unrequestAllObjects()
  stopUserUpdates()
  if game_camera then
    game_camera.matrix = vec.matrix()
  end
  if cameraController ~= nil then
    cameraController.stop()
  end
end
_G.stopScriptController = shutDownScripts
