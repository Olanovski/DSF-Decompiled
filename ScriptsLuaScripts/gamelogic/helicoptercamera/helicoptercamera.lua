module("helicopterCamera", package.seeall)
local scanInfo = {
  firstNames = {
    [1] = "ID:245730",
    [2] = "ID:245733",
    [3] = "ID:245735",
    [4] = "ID:245736",
    [5] = "ID:245737",
    [6] = "ID:245738",
    [7] = "ID:245739",
    [8] = "ID:245742",
    [9] = "ID:245747",
    [10] = "ID:245748",
    [11] = "ID:245749",
    [12] = "ID:245751",
    [13] = "ID:245752",
    [14] = "ID:245724",
    [15] = "ID:245725",
    [16] = "ID:245726",
    [17] = "ID:245727",
    [18] = "ID:245728",
    [19] = "ID:245729",
    [20] = "ID:245731",
    [21] = "ID:245732",
    [22] = "ID:245734",
    [23] = "ID:245740",
    [24] = "ID:245741",
    [25] = "ID:245743"
  },
  surnames = {
    "ID:245744",
    "ID:245745",
    "ID:245746",
    "ID:245750",
    "ID:245753",
    "ID:245754",
    "ID:245755",
    "ID:245756",
    "ID:245757",
    "ID:245758",
    "ID:245759",
    "ID:245760",
    "ID:245761"
  }
}
local specialVehicleIDs = {
  [186] = true,
  [267] = true,
  [185] = true,
  [276] = true,
  [267] = true,
  [271] = true,
  [280] = true,
  [269] = true,
  [265] = true,
  [118] = true,
  [277] = true
}
local specialVehicleinfo = {
  ["Real enemy"] = {
    dialogueFeedback = "GPMV00_SEQUENCE_R_22",
    firstName = "ID:243482",
    surname = "ID:246419",
    DOB = "05/17/1982",
    licence = "7G5768S",
    numFelonies = 2,
    helicopterTextState = 2,
    infoDisplayTime = 8
  },
  ["Tanner Actor"] = {
    firstName = "ID:248756",
    surname = "ID:184130",
    DOB = "08/03/1973",
    licence = "88J68YT",
    numFelonies = 0,
    helicopterTextState = 1
  }
}
local scannedVehicles = {}
local helicopterTextStartTime
local displayTimeForOccupantData = 3
local scanReleased = false
local outofRange = false
local audioCallback = function()
  HeliCam.SoundStopped()
end
function watchForScanRelease()
  controlHandler:registerState(localPlayer.localID, "watchForScanRelease", {
    Zap_In = {
      JustReleased = {
        function()
          scanReleased = true
          feedbackSystem.menusMaster.masterSetVariable("iHelicopter_Static", 0)
          OneShotSound.Play("Mis_Scan_OutOfRange_Stop")
          controlHandler:resetState("watchForScanRelease")
          controlHandler:removeState("watchForScanRelease", localPlayer.localID)
        end
      }
    }
  })
  controlHandler:setState("watchForScanRelease")
end
local function pruneScannedVehicleList()
  for index, data in next, scannedVehicles, nil do
    if g_NetworkTime - data.scanTime >= 15 then
      scannedVehicles[index] = nil
    end
  end
end
local function waitForTextRemoval(displayTime)
  return function()
    if g_NetworkTime - helicopterTextStartTime > displayTime and scanReleased or outofRange then
      feedbackSystem.menusMaster.masterSetVariable("iHelicopter_Text", 0)
      scanReleased = false
      outofRange = false
      removeUserUpdateFunction("heliText")
    end
  end
end
function StartingToLoseVehicle()
  feedbackSystem.menusMaster.masterSetVariable("iHelicopter_Static", 1)
  OneShotSound.Play("Mis_Scan_OutOfRange_Play")
end
function LostVehicle()
  feedbackSystem.menusMaster.masterSetVariable("iHelicopter_Static", 0)
  OneShotSound.Play("Mis_Scan_OutOfRange_Stop")
  outofRange = true
end
function ScanAvailable()
  OneShotSound.Play("Mis_Cursor_Highlight_OneShot")
  removeUserUpdateFunction("StopHelicamScanAudio")
end
function ScanNotAvailable()
end
function ScanningStarted(gameVehicle)
  OneShotSound.Play("Mis_Scan_InProgress_Play")
  feedbackSystem.menusMaster.masterSetVariable("iHelicopter_Text", 0)
  scanReleased = false
  helicopterCamera.watchForScanRelease()
end
function ScanningStopped(gameVehicle)
  OneShotSound.Play("Mis_Scan_Interrupt_Stop")
  scanReleased = false
end
function StopScanningAudio(gameVehicle)
  if gameVehicle.model_id ~= 239 then
    OneShotSound.Play("Mis_Scan_InProgress_Stop")
  else
    OneShotSound.Play("Mis_Scan_Match")
  end
end
function ZapIn(gameVehicle, zapInFlag)
  if zapInFlag then
    HeliCam.SoundStarted()
    local zapInTime = g_NetworkTime
    feedbackSystem.menusMaster.masterSetVariable("iHelicopter_Scan_Prompt", 0)
    local function shiftInFailSafe()
      if g_NetworkTime - zapInTime > 10 and not isEventActive() then
        helicopterCamera.queueCommentary = false
        HeliCam.SoundStopped()
        removeUserUpdateFunction("shiftInFailSafe")
      elseif isEventActive() then
        removeUserUpdateFunction("shiftInFailSafe")
      end
    end
    addUserUpdateFunction("shiftInFailSafe", shiftInFailSafe, 5)
    feedbackSystem.menusMaster.masterSetVariable("iHelicopter_Text", 0)
    OneShotSound.Play("Mis_Helicopter_Exterior_Play")
    OneShotSound.Play("Mis_Helicopter_Interior_Stop")
    vehicleManager.takeOwnership({gameVehicle = gameVehicle})
    local vehicleAgent = vehicleManager.vehiclesByGameVehicle[gameVehicle]
    VehicleLodSpooler.RequestVehicle(gameVehicle.model_id)
    HeliCam.Stop()
    zapcontroller.ZapCameraSetTargetPos(vehicleAgent.position.x, vehicleAgent.position.z, 0)
    localPlayer:SetZapLevel(0, vehicleAgent)
    localPlayer:exitCutsceneMode()
    return true
  else
    local vehicle = vehicleManager.vehiclesByGameVehicle[gameVehicle]
    if gameVehicle.damage < 1 and vehicle and vehicle.heliCamAllowZapInto then
      vehicle.heliCamAllowZapInto = false
      return true
    else
      return false
    end
  end
end
function ScanningComplete(gameVehicle)
  feedbackSystem.menusMaster.masterSetVariable("iHelicopter_Cursor_State", 1)
  if not scannedVehicles[gameVehicle.uid] then
    local vehicle = vehicleManager.vehiclesByGameVehicle[gameVehicle]
    if vehicle then
      vehicle.scannedInHeliCam = true
    end
    local taskObjectsInMission = localPlayer.missionSupport:getMainTaskObject().coreData.instance.taskObjectsByActorID
    local specialActorScanned
    for actorName, taskObject in next, taskObjectsInMission, nil do
      if taskObject.coreData.agent.gameVehicle == gameVehicle then
        specialActorScanned = actorName
        break
      end
    end
    local firstNameIndex = framework.random(1, #scanInfo.firstNames)
    scannedVehicles[gameVehicle.uid] = scannedVehicles[gameVehicle.uid] or {}
    scannedVehicles[gameVehicle.uid].firstName = specialVehicleinfo[specialActorScanned] and specialActorScanned and scanInfo.firstNames[firstNameIndex]
    if not specialActorScanned or not specialVehicleinfo[specialActorScanned] or not specialVehicleinfo[specialActorScanned].surname then
    end
    scannedVehicles[gameVehicle.uid].surname = scanInfo.surnames[framework.random(1, #scanInfo.surnames)]
    if not specialActorScanned or not specialVehicleinfo[specialActorScanned] or not specialVehicleinfo[specialActorScanned].DOB then
    end
    scannedVehicles[gameVehicle.uid].DOB = tostring(framework.random(1, 12)) .. "/" .. tostring(framework.random(1, 29)) .. "/" .. tostring(framework.random(1970, 1992))
    if not specialActorScanned or not specialVehicleinfo[specialActorScanned] or not specialVehicleinfo[specialActorScanned].licence then
    end
    scannedVehicles[gameVehicle.uid].licence = tostring(framework.random(1, 9)) .. string.char(framework.random(65, 90)) .. tostring(framework.random(1000, 9999)) .. string.char(framework.random(65, 90))
    scannedVehicles[gameVehicle.uid].numFelonies = specialVehicleinfo[specialActorScanned] and specialActorScanned and 0
    scannedVehicles[gameVehicle.uid].helicopterTextState = specialVehicleinfo[specialActorScanned] and specialActorScanned and 1
    scannedVehicles[gameVehicle.uid].infoDisplayTime = specialVehicleinfo[specialActorScanned] and specialActorScanned and displayTimeForOccupantData
    scannedVehicles[gameVehicle.uid].scanTime = g_NetworkTime
    if specialActorScanned and specialVehicleinfo[specialActorScanned] and specialVehicleinfo[specialActorScanned].dialogueFeedback then
      Commentary.StopCommentary()
      HeliCam.SoundStarted()
      feedbackSystem.eventFeedback(localPlayer.currentVehicle, specialVehicleinfo[specialActorScanned].dialogueFeedback, function()
        audioCallback()
        if not scanReleased then
          scanReleased = true
          ZapIn(gameVehicle, true)
        end
      end, "missioncritical")
    elseif specialActorScanned and string.find(specialActorScanned, "Streetracer") then
      if not isEventActive() then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_R_21", audioCallback, "missioncritical")
      end
    elseif specialVehicleIDs[gameVehicle.model_id] then
      if not isEventActive() then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_L_17A", audioCallback, "timeSensitive")
      end
    elseif not isEventActive() then
      if firstNameIndex <= 13 then
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_L_17B", audioCallback, "timeSensitive")
      else
        feedbackSystem.eventFeedback(localPlayer.currentVehicle, "GPMV00_SEQUENCE_L_17C", audioCallback, "timeSensitive")
      end
    end
  end
  feedbackSystem.menusMaster.masterSetTextVariable("helicopter_line_1", "ID:214888", scannedVehicles[gameVehicle.uid].firstName, nil, nil, scannedVehicles[gameVehicle.uid].surname)
  feedbackSystem.menusMaster.masterSetTextVariable("helicopter_line_2", "ID:214889", scannedVehicles[gameVehicle.uid].DOB)
  feedbackSystem.menusMaster.masterSetTextVariable("helicopter_line_3", "ID:214890", scannedVehicles[gameVehicle.uid].licence)
  feedbackSystem.menusMaster.masterSetTextVariable("helicopter_line_4", "")
  feedbackSystem.menusMaster.masterSetTextVariable("helicopter_line_5", "ID:214893", scannedVehicles[gameVehicle.uid].numFelonies)
  feedbackSystem.menusMaster.masterSetVariable("iHelicopter_Text", scannedVehicles[gameVehicle.uid].helicopterTextState)
  helicopterTextStartTime = g_NetworkTime
  addUserUpdateFunction("heliText", waitForTextRemoval(scannedVehicles[gameVehicle.uid].infoDisplayTime), 5)
  pruneScannedVehicleList()
end
