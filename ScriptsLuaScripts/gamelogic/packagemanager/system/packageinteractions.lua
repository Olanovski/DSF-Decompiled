module("packageManager")
local requestFlagID = 1
local dropFlagID = 2
messageID = 1
local currentRequest = {
  timeStamp = false,
  lastSentTimeStamp = false,
  requestType = false,
  message = false,
  active = false,
  SNOID = false,
  messageID = false
}
local latestRequest = {
  timeStamp = false,
  requestType = false,
  message = false,
  active = false,
  SNOID = false,
  messageID = false
}
local resendTime = 1
function cancelMessage()
  currentRequest.timeStamp = false
  currentRequest.lastSentTimeStamp = false
  currentRequest.requestType = false
  currentRequest.message = false
  currentRequest.active = false
  currentRequest.SNOID = false
  currentRequest.messageID = false
  localPlayer:blockAbility("zap", false)
  localPlayer.zapBlockedFromPackageInteractions = false
  if latestRequest.active then
    if packagesBySNOID[latestRequest.SNOID] then
      currentRequest.timeStamp = latestRequest.timeStamp
      currentRequest.lastSentTimeStamp = g_NetworkTime
      currentRequest.requestType = latestRequest.requestType
      currentRequest.message = latestRequest.message
      currentRequest.active = true
      currentRequest.SNOID = latestRequest.SNOID
      currentRequest.messageID = latestRequest.messageID
      if currentRequest.requestType == requestFlagID then
        localPlayer:blockAbility("zap", true)
        localPlayer.zapBlockedFromPackageInteractions = true
      end
      latestRequest.timeStamp = false
      latestRequest.requestType = false
      latestRequest.message = false
      latestRequest.active = false
      latestRequest.SNOID = false
      latestRequest.messageID = false
      sendMessage(packagesBySNOID[currentRequest.SNOID], currentRequest.requestType, currentRequest.message)
    else
      latestRequest.timeStamp = false
      latestRequest.requestType = false
      latestRequest.message = false
      latestRequest.active = false
      latestRequest.SNOID = false
      latestRequest.messageID = false
    end
  end
end
function sendFlagRequest(SNOID, vehicle, player)
  if not vehicle then
    return
  end
  local package = packagesBySNOID[SNOID]
  assert(package, "packageInteractions nil package " .. tostring(SNOID))
  local timeStamp = g_NetworkTime
  local requestType = requestFlagID
  local SNVID = vehicle.SNVID
  local message = tostring(SNVID) .. "," .. tostring(timeStamp) .. "," .. tostring(messageID) .. ","
  if currentRequest.active then
    latestRequest.timeStamp = timeStamp
    latestRequest.requestType = requestType
    latestRequest.message = message
    latestRequest.active = true
    latestRequest.messageID = messageID
    latestRequest.SNOID = SNOID
    messageID = messageID + 1
  else
    currentRequest.timeStamp = timeStamp
    currentRequest.lastSentTimeStamp = g_NetworkTime
    currentRequest.requestType = requestType
    currentRequest.message = message
    currentRequest.active = true
    currentRequest.messageID = messageID
    currentRequest.SNOID = SNOID
    localPlayer:blockAbility("zap", true)
    localPlayer.zapBlockedFromPackageInteractions = true
    sendMessage(package, requestType, message)
    messageID = messageID + 1
  end
end
function sendFlagDropRequest(SNOID)
  local package = packagesBySNOID[SNOID]
  assert(package, "packageInteractions nil package " .. tostring(SNOID))
  local timeStamp = g_NetworkTime
  local requestType = dropFlagID
  local message = tostring(timeStamp) .. "," .. tostring(messageID) .. ","
  if currentRequest.active then
    latestRequest.timeStamp = timeStamp
    latestRequest.requestType = requestType
    latestRequest.message = message
    latestRequest.active = true
    latestRequest.messageID = messageID
    latestRequest.SNOID = SNOID
    messageID = messageID + 1
  else
    currentRequest.timeStamp = timeStamp
    currentRequest.lastSentTimeStamp = g_NetworkTime
    currentRequest.requestType = requestType
    currentRequest.message = message
    currentRequest.active = true
    currentRequest.messageID = messageID
    currentRequest.SNOID = SNOID
    sendMessage(package, requestType, message)
    messageID = messageID + 1
  end
end
function stepRequests()
  if currentRequest.active and currentRequest.lastSentTimeStamp + resendTime < g_NetworkTime then
    currentRequest.lastSentTimeStamp = g_NetworkTime
    if packagesBySNOID[currentRequest.SNOID] then
      if currentRequest.requestType == requestFlagID then
        localPlayer:blockAbility("zap", true)
        localPlayer.zapBlockedFromPackageInteractions = true
      end
      sendMessage(packagesBySNOID[currentRequest.SNOID], currentRequest.requestType, currentRequest.message)
    else
      cancelMessage()
    end
  end
end
function requestDenied(fromPlayerID, messageType, message)
  if currentRequest.active and tonumber(message) == currentRequest.messageID then
    currentRequest.timeStamp = false
    currentRequest.lastSentTimeStamp = false
    currentRequest.requestType = false
    currentRequest.message = false
    currentRequest.active = false
    currentRequest.SNOID = false
    currentRequest.messageID = false
    localPlayer:blockAbility("zap", false)
    localPlayer.zapBlockedFromPackageInteractions = false
    if latestRequest.active then
      if packagesBySNOID[latestRequest.SNOID] then
        currentRequest.timeStamp = latestRequest.timeStamp
        currentRequest.lastSentTimeStamp = g_NetworkTime
        currentRequest.requestType = latestRequest.requestType
        currentRequest.message = latestRequest.message
        currentRequest.active = true
        currentRequest.SNOID = latestRequest.SNOID
        currentRequest.messageID = latestRequest.messageID
        if currentRequest.requestType == requestFlagID then
          localPlayer:blockAbility("zap", true)
          localPlayer.zapBlockedFromPackageInteractions = true
        end
        latestRequest.timeStamp = false
        latestRequest.requestType = false
        latestRequest.message = false
        latestRequest.active = false
        latestRequest.SNOID = false
        latestRequest.messageID = false
        sendMessage(packagesBySNOID[currentRequest.SNOID], currentRequest.requestType, currentRequest.message)
      else
        latestRequest.timeStamp = false
        latestRequest.requestType = false
        latestRequest.message = false
        latestRequest.active = false
        latestRequest.SNOID = false
        latestRequest.messageID = false
      end
    end
  end
end
function packageHasBeenDropped(SNOID)
  if currentRequest.active and currentRequest.requestType == dropFlagID and currentRequest.SNOID == SNOID then
    currentRequest.timeStamp = false
    currentRequest.lastSentTimeStamp = false
    currentRequest.requestType = false
    currentRequest.message = false
    currentRequest.active = false
    currentRequest.SNOID = false
    currentRequest.messageID = false
    if latestRequest.active and latestRequest.requestType == dropFlagID and latestRequest.SNOID == SNOID then
      latestRequest.timeStamp = false
      latestRequest.requestType = false
      latestRequest.message = false
      latestRequest.active = false
      latestRequest.SNOID = false
      latestRequest.messageID = false
    end
  end
end
function clearPackageInteractions()
  currentRequest.timeStamp = false
  currentRequest.lastSentTimeStamp = false
  currentRequest.requestType = false
  currentRequest.message = false
  currentRequest.active = false
  currentRequest.SNOID = false
  currentRequest.messageID = false
  latestRequest.timeStamp = false
  latestRequest.requestType = false
  latestRequest.message = false
  latestRequest.active = false
  latestRequest.SNOID = false
  latestRequest.messageID = false
  messageID = 1
  updateZapToActionType = 1
  playerLeftPackageDropType = 1
  lockOwnerInPackage = false
  for localPlayerID, player in next, localPlayerManager.players, nil do
    player.zapBlockedFromPackageInteractions = false
  end
end
