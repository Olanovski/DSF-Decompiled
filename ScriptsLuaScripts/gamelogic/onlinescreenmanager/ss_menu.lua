module("SSMenu", package.seeall)
local repeating = false
local PLAYING = 0
local STOPPED = 1
local FADEOUT = 0
local FADEIN = 1
local FADEOFF = 2
currentState = STOPPED
desiredState = STOPPED
fadeState = FADEOFF
local inputDesired = false
local launchRequest = false
function onFadeUp(state)
  print("onFadeUp state " .. tostring(state))
  NetworkLog.Write("onFadeUp state " .. tostring(state))
  currentState = state
  fadeState = FADEOFF
  if state == STOPPED then
    for localID, plr in next, localPlayerManager.players, nil do
      SetZapInput(inputDesired, localID)
    end
    currentState = STOPPED
    if launchRequest then
      PartyBusManager.Launch()
      launchRequest = false
    end
  end
end
function fadeUpToNewState()
  print("fadeUpToNewState desiredState " .. tostring(desiredState))
  NetworkLog.Write("fadeUpToNewState desiredState " .. tostring(desiredState))
  fadeState = FADEIN
  if desiredState == PLAYING then
    if localPlayerManager.players[1] then
      coopSystem.deleteLocalPlayer(1)
    end
    zap.setDefaultZapSettingsForPlayer(0, false)
    engineCutscene.triggerCutscene("MenusTest", function()
      print("startCB")
      NetworkLog.Write("startCB")
      onFadeUp(PLAYING)
      PartyBusManager.DeactivateLoadingScreen()
    end, function()
      if desiredState == PLAYING then
        playSplitScreenCutscene(true)
      end
    end, true)
  elseif desiredState == STOPPED then
    function finaliseStopping()
      spoolsystem.RemoveSpoolCentre(1)
      coopSystem.createNewLocalPlayer()
      zap.setDefaultZapSettingsForPlayer(0, true)
      SetZapInput(false, 1)
      for localID, plr in next, localPlayerManager.players, nil do
        plr.inCutsceneOrIcam = nil
        plr.inCutscene = false
      end
      vehicleManager.reapplyAllHighLODOccupants()
      local delayStartTime = g_NetworkTime
      addUserUpdateFunction("ssHackDelay", function()
        if g_NetworkTime - delayStartTime > 1 then
          print("ssHackDelay")
          NetworkLog.Write("ssHackDelay")
          localPlayerManager.players[0]:exitCutsceneMode()
          onFadeUp(STOPPED)
          removeUserUpdateFunction("ssHackDelay")
        end
      end, 1)
    end
    function disposeCutscene()
      print("disposeCutscene")
      NetworkLog.Write("disposeCutscene")
      Cutscene.Dispose()
      finaliseStopping()
    end
    if Cutscene.IsPlaying() then
      print("Cutscene.IsPlaying")
      NetworkLog.Write("Cutscene.IsPlaying")
      Cutscene.SetCompleteCallback(disposeCutscene)
      Cutscene.Stop()
    else
      print("!Cutscene.IsPlaying")
      NetworkLog.Write("!Cutscene.IsPlaying")
      finaliseStopping()
    end
  end
end
function fadeToNewState(state)
  print("fadeToNewState state " .. tostring(state))
  NetworkLog.Write("fadeToNewState state " .. tostring(state))
  desiredState = state
  fadeState = FADEOUT
  for localID, plr in next, localPlayerManager.players, nil do
    zapcontroller.setRenderTarget(false, localID)
  end
  spooling.fadeOut(nil, 0, fadeUpToNewState, nil, nil, false, 1)
end
function playSplitScreenCutscene(rep)
  print("playSplitScreenCutscene currentState " .. tostring(currentState))
  NetworkLog.Write("playSplitScreenCutscene currentState " .. tostring(currentState))
  if currentState == PLAYING and not rep then
    return
  end
  fadeToNewState(PLAYING)
  OneShotSound.Play("Mus_SplitScreenMenu_Play")
end
function _G.stopSplitScreenCutscene(input)
  print("stopSplitScreenCutscene currentState " .. tostring(currentState))
  NetworkLog.Write("stopSplitScreenCutscene currentState " .. tostring(currentState))
  inputDesired = input or false
  if currentState ~= STOPPED then
    fadeToNewState(STOPPED)
    OneShotSound.Play("Mus_SplitScreenMenu_Stop")
  end
end
function _G.launchSplitScreenMenu()
  print("launchSplitScreenMenu")
  NetworkLog.Write("launchSplitScreenMenu")
  LocalisationSpooler.RequestText(10)
  Menu.ShowMain = 0
  Menu.ShowOnline = 1
  spooling.enableTraffic(true)
  Menu.ResetPage("SplitscreenMenus", "SS_01_main_menu")
end
function _G.exitSplitScreenMenu()
  print("Exiting split screen")
  NetworkLog.Write("Exiting split screen")
  Network.disableSplitScreenMode()
  coopSystem.deleteLocalPlayer(1)
  zap.setDefaultZapSettingsForPlayer(0, false)
  coopSystem.savedLocalPlayerSettings = {}
  Menu.HideZapPreview(false)
  controlHandler:setState("zap")
  OneShotSound.Play("Mus_SplitScreenMenu_Stop")
end
function SetZapInput(enableZap, localID)
  local plr = localPlayerManager.players[localID]
  if not plr.inZap or zapcontroller.getTargetZapLevel(localID) ~= 4 then
    plr:SetZapLevel(4, nil, false, {forcedOut = true})
  end
  if not enableZap then
    zapcontroller.setRenderTarget(false, localID)
    plr:showHUDElements(false)
    enableAbilities(localID, false)
    localPlayer.minimapSupport.hideSS(localID)
    feedbackSystem.multiplayerSupport.disableSSAbilityBar(localID)
  else
    zapcontroller.setRenderTarget(true, localID)
    plr:showHUDElements(true)
    feedbackSystem.multiplayerSupport.enabled = true
    abilities.nitro.setLevel(0)
    abilities.ram.setLevel(0)
    abilities.zap.setLevel(0)
    plr:blockAbility("nitro", false)
    plr:blockAbility("ram", false)
    enableAbilities(localID, true)
    localPlayer.minimapSupport.showSS(localID)
    feedbackSystem.multiplayerSupport.enableSSAbilityBar(localID)
    CoopScoringSystem.purge()
    zap.multiplayerSettings.setOnlineZapFuelLevel(3)
    scoreSystem.maxAbility(localID)
  end
  plr:blockAbility("zap", not enableZap)
  zapcontroller.EnableZapInput(enableZap, localID)
end
function _G.EnableFreeDrive(enable)
  print("EnableFreeDrive enable " .. tostring(enable) .. " fadeState " .. tostring(fadeState))
  NetworkLog.Write("EnableFreeDrive enable " .. tostring(enable) .. " fadeState " .. tostring(fadeState))
  if fadeState ~= FADEOFF then
    return false
  end
  if enable then
    stopSplitScreenCutscene(true)
  else
    if currentState == PLAYING then
      PartyBusManager.DeactivateLoadingScreen()
      return false
    end
    for localID, plr in next, localPlayerManager.players, nil do
      SetZapInput(enable, localID)
    end
    playSplitScreenCutscene()
    Presence.setPresence(13, 1)
  end
  return true
end
function _G.LaunchSplitScreenGame()
  print("LaunchSplitScreenGame  fadeState " .. tostring(fadeState))
  NetworkLog.Write("LaunchSplitScreenGame  fadeState " .. tostring(fadeState))
  if launchRequest == false then
    if fadeState ~= FADEOFF then
      return false
    else
      Menu.ChangePage("SplitscreenMenus", "SS_InASession")
      stopSplitScreenCutscene(false)
      launchRequest = true
      return true
    end
  end
end
