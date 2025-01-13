module("localPlayer.minimapSupport", package.seeall)
maxNormalHeight = 350
minZoomedHeight = 1500
maxZoomedHeight = 3200
zoomed = false
googleMapActive = false
vecSecondPoI = false
parent = localPlayer
local matrixPoI = vec.matrix()
local workingVector = vec.vector()
local minimapBlockWagglePrompt = false
local blockZoomOut = false
coreSettings = {
  unexpandedViewportFOV = math.rad(110),
  expandedViewportFOV = math.rad(73),
  cameraHeight = 400,
  cameraDistanceBehind = 0,
  unexpandedCameraPitch = math.rad(90),
  expandedCameraPitch = math.rad(80),
  spriteWidth = 0.32,
  spriteHeight = 0.21,
  playerMarkerSize = 30,
  playerMarkerColour = {
    red = 1,
    green = 1,
    blue = 1,
    alpha = 1
  },
  spriteYPosition = 0.004,
  carLength = 5,
  carWidth = 2,
  roadColour = {
    red = 0.35,
    green = 0.4,
    blue = 0.35,
    alpha = 1
  },
  roadDensityColoursEnabled = true,
  densityColourRoadMultiplier = 0.9,
  vehicles = false,
  vehicleColour = {
    red = 0,
    green = 0,
    blue = 0,
    alpha = 1
  },
  highlightedVehicles = false,
  highlightedVehicleColour = {
    red = 1,
    green = 0.8,
    blue = 0,
    alpha = 1
  },
  highlightedVehicleModelUID = 1,
  highlightedVehicleScaleFactor = 7,
  highlightedAnimDuration = 5,
  highlightedAnimStepLength = 1,
  markerFadeDistance = 250,
  markerFadeAlphaValue = 0.5,
  rotation = true
}
coreSettings.viewportAspectRatio = coreSettings.spriteWidth / coreSettings.spriteHeight
function initialise()
  for localID = 0, localPlayerManager.maxNumOfPlayers - 1 do
    minimap.SetViewportFOV(coreSettings.unexpandedViewportFOV, localID)
    minimap.SetCameraHeight(coreSettings.cameraHeight, localID)
    minimap.SetCameraDistanceBehind(coreSettings.cameraDistanceBehind, localID)
    minimap.SetCameraPitch(coreSettings.unexpandedcameraPitch, localID)
    minimap.SetSpriteWidth(coreSettings.spriteWidth, localID)
    minimap.SetSpriteHeight(coreSettings.spriteHeight, localID)
    minimap.SetPlayerMarkerSize(coreSettings.playerMarkerSize, localID)
    minimap.SetPlayerMarkerColour(coreSettings.playerMarkerColour, localID)
    minimap.SetSpriteYPosition(coreSettings.spriteYPosition, localID)
    minimap.SetCarLength(coreSettings.carLength, localID)
    minimap.SetCarWidth(coreSettings.carWidth, localID)
    minimap.SetVehicles(coreSettings.vehicles, localID)
    minimap.SetVehicleColour(coreSettings.vehicleColour, localID)
    minimap.SetHighlightedVehicles(coreSettings.highlightedVehicles, localID)
    minimap.SetHighlightedVehicleColour(coreSettings.highlightedVehicleColour, localID)
    minimap.SetHighlightedVehicleModelUID(coreSettings.highlightedVehicleModelUID, localID)
    minimap.SetHighlightedVehicleScaleFactor(coreSettings.highlightedVehicleScaleFactor, localID)
    minimap.SetHighlightedAnimDuration(coreSettings.highlightedAnimDuration, localID)
    minimap.SetHighlightedAnimStepLength(coreSettings.highlightedAnimStepLength, localID)
    minimap.SetMarkerFadeDistance(coreSettings.markerFadeDistance, localID)
    minimap.SetMarkerFadeAlphaValue(coreSettings.markerFadeAlphaValue, localID)
    minimap.SetRotationState(coreSettings.rotation, localID)
    minimap.SetCameraDistanceBehindExpanded(coreSettings.cameraDistanceBehind, localID)
    minimap.SetCameraPitchExpanded(coreSettings.expandedCameraPitch, localID)
    minimap.SetCameraDistanceBehindUnexpanded(coreSettings.cameraDistanceBehind, localID)
    minimap.SetCameraPitchUnexpanded(coreSettings.unexpandedCameraPitch, localID)
    minimap.SetViewportAspectRatio(minimap.GetSpriteWidth(localID) / minimap.GetSpriteHeight(localID), localID)
  end
  if not gameStatus.onlineSession then
    setHighlightedVehicleModelType("exclamationMark")
  end
end
addInitObject(initialise)
function showGoogleMap(self)
  if configSelector.launchConfig.City == "Install\\san_francisco.dngc" and not (localPlayerManager.numberOfPlayers > 1) then
    if minimap.GetOn(self.parent.localID) then
      self:hide()
    end
    if gameStatus.onlineSession then
      if self.googleMapActive then
        Menu.ShowGoogleMap = 0
      end
      self.googleMapActive = false
    elseif localPlayer.isHUDActive() then
      if not self.googleMapActive then
        Menu.ShowGoogleMap = 1
      end
      self.googleMapActive = true
    end
  end
end
function hideGoogleMap(self)
  if not gameStatus.onlineSession then
    if self.googleMapActive then
      Menu.ShowGoogleMap = 0
    end
    self.googleMapActive = false
  end
  if not minimap.GetOn(self.parent.localID) and not localPlayer.inCutscene and localPlayer.isHUDActive() then
    self:show()
  end
end
local ssMinimapState = {
  [0] = {expanded = 0, shown = false},
  [1] = {expanded = 0, shown = false}
}
function resetMinimapState()
  ssMinimapState[0].expanded = 0
  ssMinimapState[0].shown = false
  ssMinimapState[1].expanded = 0
  ssMinimapState[1].shown = false
end
function showSS(localPlayerID)
  if not ssMinimapState[localPlayerID].shown then
    if localPlayerID == 0 then
      feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_minimap_expand", 0)
      feedbackSystem.menusMaster.splitscreenSetVariable("iMinimap_splitscreen_p1_show", 1)
    else
      feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_minimap_expand", 0)
      feedbackSystem.menusMaster.splitscreenSetVariable("iMinimap_SS_Display", 1)
    end
    minimap.SetOn(true, localPlayerID)
    ssMinimapState[localPlayerID].shown = true
  end
end
function hideSS(localPlayerID)
  if ssMinimapState[localPlayerID].shown then
    if localPlayerID == 0 then
      feedbackSystem.menusMaster.splitscreenSetVariable("iMinimap_splitscreen_p1_show", 0)
    else
      feedbackSystem.menusMaster.splitscreenSetVariable("iMinimap_SS_Display", 0)
    end
    minimap.SetOn(false, localPlayerID)
    ssMinimapState[localPlayerID].shown = false
  end
end
function expandSS(localPlayerID, expand)
  if ssMinimapState[localPlayerID].expanded ~= expand then
    if localPlayerID == 0 then
      feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p1_minimap_expand", expand)
    else
      feedbackSystem.menusMaster.splitscreenSetVariable("iSS_p2_minimap_expand", expand)
    end
    ssMinimapState[localPlayerID].expanded = expand
  end
end
function show(self)
  if configSelector.launchConfig.City == "Install\\san_francisco.dngc" and not gameStatus.splitscreenSession and (localPlayer.isHUDActive() or not self.googleMapActive) and not localPlayer.inCutscene and not vehicleManager.previewVehicleManager.previewVehicle and localPlayer.isHUDActive() then
    minimap.SetOn(true, self.parent.localID)
    feedbackSystem.menusMaster.currentHUDSetVariable("iMinimap_Display", 1)
  end
end
function hide(self)
  self:setPointofInterest(false)
  if userUpdateFunctions.blockZoomOutForPrompt then
    removeUserUpdateFunction("blockZoomOutForPrompt")
  end
  blockZoomOut = false
  localPlayer.minimapSupport:zoomIn()
  if not gameStatus.splitscreenSession then
    feedbackSystem.menusMaster.currentHUDSetVariable("iMinimap_Display", 0)
    minimap.SetOn(false, self.parent.localID)
  end
end
function zoomIn(self)
  if self.zoomed then
    self.zoomed = false
    minimap.SetCameraDistanceBehindUnexpanded(coreSettings.cameraDistanceBehind, self.parent.localID)
    minimap.SetCameraPitchUnexpanded(coreSettings.unexpandedCameraPitch, self.parent.localID)
    minimap.SetViewportFOV(coreSettings.unexpandedViewportFOV, self.parent.localID)
    if not gameStatus.splitscreenSession then
      if Network.isOnlineGame() then
        Menu.FireEvent("Online_HUD", "EVENT_Expand_Map_Stop", Online)
      else
        Menu.FireEvent("Master", "EVENT_Expand_Map_Stop")
      end
    else
      expandSS(self.parent.localID, 0)
    end
    OneShotSound.PlayGUI("HUD_MiniMap_Close_OneShot")
    self:update()
    if gameStatus.onlineSession then
      feedbackSystem.menusMaster.locationPrompt(true)
    end
    if self.parent.inZap then
      zap.zoomInOutButtonPrompts(self.parent, true)
    end
    if minimapBlockWagglePrompt then
      self.parent:setBlockWagglePrompt(false)
    end
    minimapBlockWagglePrompt = false
    if feedbackSystem.menusMaster.primaryPromptActive or feedbackSystem.menusMaster.secondaryPromptActive then
      blockZoomOut = true
      addUserUpdateFunction("blockZoomOutForPrompt", function()
        blockZoomOut = false
        removeUserUpdateFunction("blockZoomOutForPrompt")
      end, 0.7 * updates.stepRate, true)
    end
  end
end
function _G.MinimapZoomIn()
  localPlayer.minimapSupport:zoomIn()
end
function _G.MinimapZoomOut()
  localPlayer.minimapSupport:zoomOut()
end
function zoomOut(self)
  if not self.zoomed and not gameStatus.simulationPaused and not self.googleMapActive and not blockZoomOut then
    self.zoomed = true
    minimap.SetCameraDistanceBehindExpanded(coreSettings.cameraDistanceBehind, self.parent.localID)
    minimap.SetCameraPitchExpanded(coreSettings.expandedCameraPitch, self.parent.localID)
    minimap.SetViewportFOV(coreSettings.expandedViewportFOV, self.parent.localID)
    if not gameStatus.splitscreenSession then
      if Network.isOnlineGame() then
        Menu.FireEvent("Online_HUD", "EVENT_Expand_Map", Online)
      else
        Menu.FireEvent("Master", "EVENT_Expand_Map")
      end
    else
      expandSS(self.parent.localID, 1)
    end
    OneShotSound.PlayGUI("HUD_MiniMap_Open_OneShot")
    if not gameStatus.splitscreenSession and (Menu.GetVariable("Master", "iMinimap_flash") == 4 or Menu.GetVariable("Online", "iMinimap_flash") == 4) then
      feedbackSystem.menusMaster.currentHUDSetVariable("iMinimap_flash", 0)
    end
    if self.parent.inZap then
      zap.zoomInOutButtonPrompts(self.parent, false)
    end
    if not self.parent.blockWagglePrompt then
      self.parent:setBlockWagglePrompt(true)
      minimapBlockWagglePrompt = true
    end
    if not gameStatus.splitscreenSession then
      feedbackSystem.updatePointsFeedback()
      feedbackSystem.updateStuntFeedback()
      feedbackSystem.updateSplitTime()
      feedbackSystem.menusMaster.locationPrompt(false)
    end
  end
end
local highlightVehicleModelTypes = {
  smash = {
    model = 75,
    scale = 0.5,
    colour = {
      red = 1,
      green = 0,
      blue = 0,
      alpha = 0.7
    },
    offset = 1
  },
  exclamationMark = {
    model = 174,
    scale = 1,
    colour = {
      red = 1,
      green = 0.8,
      blue = 0,
      alpha = 1
    },
    offset = 1
  }
}
function setHighlightedVehicleModelType(type)
  if highlightVehicleModelTypes[type] then
    minimap.SetHighlightedVehicleGadgetID(highlightVehicleModelTypes[type].model)
    minimap.SetHighlightedVehicleMarkerIconScale(highlightVehicleModelTypes[type].scale)
    minimap.SetHighlightedVehicleColour(highlightVehicleModelTypes[type].colour)
    minimap.SetHighlightedVehicleMarkerIconYOffset(highlightVehicleModelTypes[type].offset)
  end
end
function setPointofInterest(self, newPoI)
  self.vecSecondPoI = newPoI or false
end
function update(self)
  if minimap.GetOn(self.parent.localID) then
    if self.zoomed and gameStatus.simulationPaused then
      self:zoomIn()
    end
    local cameraHeight
    if self.zoomed then
      if self.vecSecondPoI then
        local distanceToPoI = workingVector:sub(self.vecSecondPoI, self.parent.position):length()
        local distanceToMapEdgeY = distanceToPoI / 3 * 4
        local distanceToMapEdgeX = distanceToMapEdgeY * 1.777778
        cameraHeight = math.max(distanceToMapEdgeX / math.tan(coreSettings.expandedViewportFOV * 0.5), self.minZoomedHeight)
        cameraHeight = math.min(cameraHeight, self.maxZoomedHeight)
      else
        cameraHeight = self.maxZoomedHeight
      end
    else
      cameraHeight = self.maxNormalHeight
    end
    if self.zoomed then
      minimap.SetCameraHeightExpanded(cameraHeight, self.parent.localID)
    else
      minimap.SetCameraHeightUnexpanded(cameraHeight, self.parent.localID)
    end
  end
end
