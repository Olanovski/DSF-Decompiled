module("engineCutscene", package.seeall)
local finalCutscene = "ch9_finale_03"
local credits = "ch9_credits"
function GetCutsceneId(name)
  assert(CutsceneDirectory[name], [[
EngineCutscenes GetCutsceneId:
 Cutscene not found with name = ]] .. name)
  return CutsceneDirectory[name]
end
CutscenePreloadTable = {
  [GetCutsceneId("ch0_introduction_01")] = GetCutsceneId("ch0_introduction_02")
}
function GetNextCutsceneId(id)
  return CutscenePreloadTable[id]
end
function DisposeCutsceneManually(sceneName, Callback)
  print("DisposeCutsceneManually")
  local sceneId = GetCutsceneId(sceneName)
  Cutscene.Stop(sceneId, function()
    Callback()
  end)
end
local preCutsceneCleanup = function(sceneName)
  if sceneName == "ch0_crash1_02" then
    propSystem.reenableAllPropTypes()
    propSystem.disablePropType("DO_NOT_USE_shutter_A", "DO_NOT_USE_shutter_B", "DO_NOT_USE_Wall_A")
  end
  localPlayer.inCutsceneOrIcam = true
  Commentary.StopCommentary()
  Commentary.BlockAI(true)
  vehicleManager.removeAllHighLODOccupants()
  feedbackSystem.menusMaster.allowUnlockPanel(false)
  activeChallenges.disableCollectables()
  local playerTaskObject = localPlayer:getTaskObject()
  if not playerTaskObject and vehicleManager.previewVehicleManager.previewVehicle then
    playerTaskObject = vehicleManager.previewVehicleManager.previewVehicle:getTaskObject()
  end
  if Chase.IsAChaseActive() then
    Chase.StopAll()
  elseif Getaway.IsAGetawayActive() then
    Getaway.StopAll()
  end
  if localPlayer.currentVehicle and (localPlayer.inZap or vehicleManager.previewVehicleManager.previewVehicle) then
    local vehicleWithAIDelay = vehicleManager.getVehicleWithAIDelay()
    if vehicleWithAIDelay then
      vehicleWithAIDelay:removeAIDelay()
    elseif vehicleManager.previewVehicleManager.previewVehicle then
      localPlayer.currentVehicle:delete()
    else
      localPlayer.currentVehicle:stopHighSpeedDriving()
    end
  end
  if playerTaskObject then
    for actorID, taskObject in next, playerTaskObject.coreData.instance.taskObjectsByActorID, nil do
      local agent = taskObject.coreData.agent
      if agent.gameVehicle then
        if vehicleManager.chasingGameVehiclesByChasedGameVehicle[agent.gameVehicle] then
          for chasingGameVehicle, bool in next, vehicleManager.chasingGameVehiclesByChasedGameVehicle[agent.gameVehicle], nil do
            if vehicleManager.vehiclesByGameVehicle[chasingGameVehicle] then
              vehicleManager.vehiclesByGameVehicle[chasingGameVehicle]:stopHighSpeedDriving()
            end
          end
        end
        if agent.gameVehicle and agent.gameVehicle.parentVehicle and not vehicleManager.getAgentFromGameVehicle(agent.gameVehicle.parentVehicle) then
          GameVehicleResource.detachVehicle(agent.gameVehicle)
        end
        agent:stopHighSpeedDriving()
      end
    end
  end
  vehicleManager.clearOrphanage()
end
local postCustsceneCleanup = function(sceneName)
  if sceneName == "ch0_crash1_02" then
    propSystem.reenableAllPropTypes()
    propSystem.disablePropType("DO_NOT_USE_shutter_B", "DO_NOT_USE_Wall_A")
  end
  vehicleManager.reapplyAllHighLODOccupants()
  if localPlayer.currentVehicle then
    if localPlayer.inZap then
      localPlayer.currentVehicle:randomWander()
    else
      localPlayer.currentVehicle:clearTrafficAheadOfVehicle()
      localPlayer.currentVehicle:addTemporaryInvulnerability()
    end
  end
  Commentary.BlockAI(false)
  localPlayer.inCutsceneOrIcam = false
  feedbackSystem.menusMaster.allowUnlockPanel(true)
  activeChallenges.enableCollectables()
end
function triggerCutsceneWithEndScreen(sceneName, startCallback, endCallBack, cannotBeSkipped)
  local sceneId = GetCutsceneId(sceneName)
  local skipIconVisible = false
  local function disposeCutScene(sceneId)
    if blendCutsceneBillBoard and blendCutsceneBillBoardID then
      BillboardManager.BlendBillBoardIn(blendCutsceneBillBoardID, 0.5, 0.5)
    end
    Cutscene.Dispose()
    postCustsceneCleanup()
  end
  local function playScene(sceneId)
    preCutsceneCleanup()
    if startCallback then
      startCallback()
    end
    Cutscene.Play(sceneId, function()
      disposeCutScene(sceneId)
    end, true, function()
      endCallBack()
    end)
  end
  Cutscene.Request(sceneId, function()
    playScene(sceneId)
  end)
end
function triggerCutscene(sceneName, startCallback, endCallBack, cannotBeSkipped, preRequested, blendCutsceneBillBoard, blendCutsceneBillBoardID)
  local sceneId = GetCutsceneId(sceneName)
  local skipIconVisible = false
  local cutsceneSkipDelayActive = true
  local function disposeCutScene(sceneId)
    if blendCutsceneBillBoard and blendCutsceneBillBoardID then
      BillboardManager.BlendBillBoardIn(blendCutsceneBillBoardID, 0.5, 0.5)
    end
    Cutscene.Dispose()
    if skipIconVisible then
      Menu.SetVariable("Loading", "iCutscene_Skip", 2)
    end
    local nextSceneId = GetNextCutsceneId(sceneId)
    if nextSceneId ~= nil then
      Cutscene.HintNext(nextSceneId)
    end
    postCustsceneCleanup(sceneName)
    if endCallBack then
      endCallBack()
    end
    if sceneName == finalCutscene then
      Credits.request()
    end
    feedbackSystem.stopMusic()
    if not cannotBeSkipped then
      controlHandler:resetState("skipMovie")
      controlHandler:removeState("skipMovie", localPlayer.localID)
    end
    if userUpdateFunctions.waitForCutsceneSkip then
      removeUserUpdateFunction("waitForCutsceneSkip")
    end
  end
  local function stopCutscene(sceneID)
    return function()
      Cutscene.Stop(sceneId)
    end
  end
  local function fadeToStopCutscene(sceneId)
    spooling.fadeOut(nil, 0, stopCutscene())
  end
  local function playScene(sceneId)
    preCutsceneCleanup(sceneName)
    if startCallback then
      startCallback()
    end
    if blendCutsceneBillBoard and blendCutsceneBillBoardID then
      local delay = 0.1
      local fadeTime = 0.1
      BillboardManager.BlendBillBoardOut(blendCutsceneBillBoardID, delay, fadeTime)
    end
    Cutscene.Play(sceneId, function()
      disposeCutScene(sceneId)
    end)
    if not cannotBeSkipped then
      controlHandler:registerState(localPlayer.localID, "skipMovie", {
        Menu_Select = {
          JustPressed = {
            [1] = function()
              if Cutscene.CanBeSkipped() and not cutsceneSkipDelayActive then
                if skipIconVisible then
                  fadeToStopCutscene(sceneId)
                  Menu.SetVariable("Loading", "iCutscene_Skip", 2)
                  skipIconVisible = false
                else
                  Menu.SetTextVariableIcon("Loading", "Cutscene_Skip", "ID:236758", buttonsTable[localPlayer.buttonLayout.accept.button])
                  Menu.SetVariable("Loading", "iCutscene_Skip", 1)
                  skipIconVisible = true
                end
              end
            end
          }
        }
      })
      controlHandler:setState("skipMovie")
      local function allowSkip()
        cutsceneSkipDelayActive = false
        removeUserUpdateFunction("cutsceneSkipDelayActive")
      end
      addUserUpdateFunction("cutsceneSkipDelayActive", allowSkip, 240, true)
    end
  end
  Cutscene.Request(sceneId, function()
    playScene(sceneId)
  end)
end
local fadeFromBlack = function(fadeInEndCallback, fadeInTime)
  spooling.fadeIn(nil, fadeInTime, fadeInEndCallback)
end
function playCutscene(cutscene, cutsceneStartCallback, cutsceneEndCallback, fadeInEndCallback, fadeOutTime, fadeInTime, cannotBeSkipped)
  local function callback()
    engineCutscene.triggerCutscene(cutscene, function()
      if cutsceneStartCallback then
        cutsceneStartCallback()
      end
    end, function()
      if cutsceneEndCallback then
        cutsceneEndCallback()
      end
      fadeFromBlack(fadeInEndCallback, fadeInTime)
    end, cannotBeSkipped)
  end
  localPlayer.inCutsceneOrIcam = true
  spooling.fadeOut(nil, fadeOutTime, callback)
  Cutscene.HintNext(engineCutscene.GetCutsceneId(cutscene))
end
function activateCutsceneEditor()
  localPlayer.inCutscene = true
end
function deactivateCutsceneEditor()
  localPlayer.inCutscene = false
end
_G.activateCutsceneEditor = activateCutsceneEditor
_G.deactivateCutsceneEditor = deactivateCutsceneEditor
