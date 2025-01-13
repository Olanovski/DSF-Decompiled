initaliseObject = {}
function addInitObject(functionToCall)
  initaliseObject[#initaliseObject + 1] = functionToCall
end
function initialiseObjects()
  print("======== initialising objects ========")
  for k, v in next, initaliseObject, nil do
    v()
  end
  initaliseObject = {}
end
module("gameStatus")
initialiseEvents = {}
preLaunchEvents = {}
launchEvents = {}
local previousSession = false
function loadScripts()
  if configSelector.launchConfig.initialiseEvent then
    assert(initialiseEvents[configSelector.launchConfig.initialiseEvent], "GAMESTATUS EVENTS - initialiseTrigger: Initialise event '" .. tostring(configSelector.launchConfig.initialiseEvent) .. "' not found")
    initialiseEvents[configSelector.launchConfig.initialiseEvent]()
  end
  initialise.scriptsLoaded()
end
function initialiseScripts()
  print("<< GAMESTATUS - INITIALISING >>")
  if configSelector.launchConfig.initialiseEvent then
    assert(initialiseEvents[configSelector.launchConfig.initialiseEvent], "GAMESTATUS EVENTS - initialiseTrigger: Initialise event '" .. tostring(configSelector.launchConfig.initialiseEvent) .. "' not found")
    initialiseEvents[configSelector.launchConfig.initialiseEvent]()
  end
  if configSelector.launchConfig.preLaunchEvent then
    assert(preLaunchEvents[configSelector.launchConfig.preLaunchEvent], "GAMESTATUS EVENTS - initialiseTrigger: PreLaunch event '" .. tostring(configSelector.launchConfig.preLaunchEvent) .. "' not found")
    print("<< GAMESTATUS - PRELAUNCH REGISTERED AND RUNNING >>")
    preLaunchEvents[configSelector.launchConfig.preLaunchEvent]()
  else
    print("<< GAMESTATUS - SKIPPING PRELAUNCH >>")
    preLaunchComplete()
  end
end
function preLaunchComplete()
  print("<< GAMESTATUS - PRELAUNCH COMPLETE >>")
  initialise.scriptsReady()
  GameLauncher.SetGameState("Game Running")
end
function enterSession()
  local newSession = not previousSession
  previousSession = true
  onlineSession = Network.isOnlineGame() or Network.isSplitScreenMode()
  onlineSessionType = false
  onlineIsLan = false
  if onlineSession then
    splitscreenSession = Network.isSplitScreenMode()
    if not splitscreenSession then
      onlineIsLan = Network.isLANGame()
      if Network.isPartyMode() then
        onlineSessionType = onlineSessionID.partyMode
      elseif Network.isPublicMatch() then
        onlineSessionType = onlineSessionID.public
      elseif Network.isPrivateMatch() then
        onlineSessionType = onlineSessionID.private
      elseif Network.isLANParty() then
        onlineSessionType = onlineSessionID.lanPartyMode
      elseif Network.isLANGame() then
        onlineSessionType = onlineSessionID.lan
      end
    end
  end
  if onlineSession and onlineSessionType and onlineSessionType == onlineSessionID.public then
    phaseManager.setTimeToJoinScore(phaseManager.timeToJoinScore.enterSession)
  end
  print("<< GAMESTATUS - onlineSessionType = " .. tostring(onlineSessionType) .. " splitscreenSession = " .. tostring(splitscreenSession) .. " >> ")
  if configSelector.launchConfig.skipNetworkEnterSession then
    print("<< GAMESTATUS - SKIPPING NETWORK ENTERSESSION >>")
  else
    print("<< GAMESTATUS - ENTERING NETWORK SESSION >>")
    addUserUpdateFunction("networkTime", updateNetworkTime(), 1)
    scriptSystems.runInitiators(onlineHost)
    if newSession then
      scriptSystems.registerUpdates()
      Menu.ShowMain = 0
    end
  end
  launch(newSession)
end
_G.EnterSession = enterSession
function launch(newSession)
  print("LAUNCH")
  if configSelector.launchConfig.launchEvent then
    print("<< GAMESTATUS - GAME LAUNCHING ( OVERRIDE LAUNCH EVENT: " .. tostring(configSelector.launchConfig.launchEvent) .. " ) >>")
    launchEvents[configSelector.launchConfig.launchEvent]()
  elseif gameStatus.onlineSession then
    print("<< GAMESTATUS - GAME LAUNCHING ( ONLINE ) >>")
    launchEvents.Online(newSession)
  else
    print("<< GAMESTATUS - GAME LAUNCHING ( OFFLINE ) >>")
    launchEvents.Offline()
  end
  if not platform then
    platform = framework.getPlatform()
    if platform == platformID.PS3 then
      print("<< GAMESTATUS - PLATFORM == PS3 >>")
    elseif platform == platformID.XBOX360 then
      print("<< GAMESTATUS - PLATFORM == XBOX 360 >>")
    elseif platform == platformID.PC then
      print("<< GAMESTATUS - PLATFORM == PC >>")
    else
      platform = false
      print("<< GAMESTATUS - PLATFORM == UNKNOWN >>")
    end
  end
end
