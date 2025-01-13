module("activeChallenges", package.seeall)
local activitiesCreated = false
triggerRadii = {
  Dare = 30,
  Challenge = 30,
  Activity = 30,
  Token = 3.5,
  Garage = 30
}
activityTypes = {
  "Dare",
  "Challenge",
  "Activity"
}
proximityRadii = {
  Dare = {Near = 25},
  Challenge = {Near = 25},
  Activity = {Near = 25},
  Token = {Near = 100},
  Garage = {Near = 20, Middle = 10}
}
activitiesHotspots = {}
local preallocatedTypeTable = {}
function registerActivity(activity, type)
  if type ~= "Token" then
    local found = false
    for __, currentActivity in next, activitiesHotspots, nil do
      if activity == currentActivity then
        found = true
        break
      end
    end
    if not found then
      activity.activityIndex = #activitiesHotspots + 1
      preallocatedTypeTable.type = activity.iconType
      activitiesHotspots[activity.activityIndex] = activity
      local mission = localPlayer.getTaskObject()
      activity.iconIndex = feedbackSystem.newTarget(activity, "In world icon", preallocatedTypeTable)
      InteractiveIconsManager.addIcon(type, activity.activityIndex, activity.position, triggerRadii[type])
    end
  elseif not activity.activityIndex then
    activity.activityIndex = activity.uid
    InteractiveIconsManager.addIcon(type, activity.activityIndex, activity.position, triggerRadii[type])
  end
end
function deleteActivityIcons()
  for __, activity in next, activitiesHotspots, nil do
    removeActivity(activity)
  end
  for chapter, tokenList in next, collectableLookupTable, nil do
    for uid, token in next, tokenList, nil do
      collectables.showIcon(token, false)
    end
  end
  activitiesCreated = false
end
function enableActivities()
  for __, activity in next, activitiesHotspots, nil do
    if activity.markers and activity ~= dareSystem.activeDare then
      for markerType, marker in next, activity.markers, nil do
        if markerType ~= "icon" then
          marker.visible = true
        end
      end
    end
  end
  for __, activityType in ipairs(activityTypes) do
    InteractiveIconsManager.enableIconType(activityType, true)
  end
end
function disableActivities()
  feedbackSystem.previewScreen.clearActivityBeingPrompted()
  for __, activity in next, activitiesHotspots, nil do
    if activity.hotspotTerrainMarkerUID then
      TerrainMarker.Delete(activity.hotspotTerrainMarkerUID)
      activity.hotspotTerrainMarkerUID = nil
    end
    if activity.markers then
      for markerType, marker in next, activity.markers, nil do
        if markerType == "minimap" or markerType == "shift" then
          marker.visible = false
        else
          Marker:delete(marker)
          activity.markers[markerType] = nil
        end
      end
    end
  end
  for __, activityType in ipairs(activityTypes) do
    InteractiveIconsManager.enableIconType(activityType, false)
  end
  activitiesCreated = false
end
function enableCollectables()
  if not challengeProgressionTable[progressionSystem.currentProgression].settings or not challengeProgressionTable[progressionSystem.currentProgression].settings.blockCollectables then
    InteractiveIconsManager.enableIconType("Token", true)
    if abilities.collectableDetection.getLevel() == math.huge then
      for uid, token in next, collectablesByUID, nil do
        if not token.minimapIndex and ProfileSettings.GetCollectableUnlocked(uid) and not ProfileSettings.GetCollectableOwned(uid) then
          collectables.showAbilityIcon(collectablesByUID[uid], true)
        end
      end
    end
  end
end
function disableCollectables()
  for uid, token in next, collectablesByUID, nil do
    if token.iconIndex then
      feedbackSystem.clearTarget(token.iconIndex)
      token.iconIndex = nil
    end
    if token.minimapIndex then
      feedbackSystem.clearTarget(token.minimapIndex)
      token.minimapIndex = nil
    end
  end
  InteractiveIconsManager.enableIconType("Token", false)
end
function initialiseActivities()
  if not activitiesCreated then
    for __, groups in next, activitiesLookupTable, nil do
      for subType, challenges in next, groups, nil do
        for i, challenge in next, challenges, nil do
          if previewCameras.Activities[challenge.ID] then
            challenge.previewCamera = previewCameras.Activities[challenge.ID]
          end
          if challenge.position and ProfileSettings.GetChallengeOwned(cards.ReverseMissionNetworkLookup[challenge.ID]) then
            registerActivity(challenge, "Activity")
          end
        end
      end
    end
    for __, groups in next, challengeLookupTable, nil do
      for i, challenges in next, groups, nil do
        for j, challenge in next, challenges, nil do
          if previewCameras.Challenges[challenge.ID] then
            challenge.previewCamera = previewCameras.Challenges[challenge.ID]
          end
          if challenge.position and ProfileSettings.GetChallengeOwned(cards.ReverseMissionNetworkLookup[challenge.ID]) then
            if challenge.settings.chapterAvailable then
              if type(progressionSystem.currentChapter) == "number" and (progressionSystem.currentChapter >= challenge.settings.chapterAvailable or ProfileSettings.GetStoryModeComplete() and progressionSystem.currentChapter >= 1) then
                registerActivity(challenge, "Challenge")
              end
            else
              registerActivity(challenge, "Challenge")
            end
          end
        end
      end
    end
    for uid, dare in next, daresByUID, nil do
      if previewCameras.Dares[uid] then
        dare.previewCamera = previewCameras.Dares[uid]
      end
      if dare.position and ProfileSettings.GetDareUnlocked(uid) and not ProfileSettings.GetDareCompleted(uid) then
        registerActivity(dare, "Dare")
      end
    end
    for uid, token in next, collectablesByUID, nil do
      if token.position and ProfileSettings.GetCollectableUnlocked(uid) and not ProfileSettings.GetCollectableOwned(uid) then
        registerActivity(token, "Token")
      end
    end
    InteractiveIconsManager.enable(true)
    for iconType, ranges in next, proximityRadii, nil do
      InteractiveIconsManager.setIconProximity(iconType, ranges)
    end
    activitiesCreated = true
  end
end
function updateProximityRadii(type, Near, Middle, Far)
  if proximityRadii[type] then
    if Near then
      proximityRadii[type].Near = Near
    end
    if Middle then
      proximityRadii[type].Middle = Middle
    end
    if Far then
      proximityRadii[type].Far = Far
    end
    InteractiveIconsManager.setIconProximity(type, proximityRadii[type])
  end
end
function enableSpecifiedActivity(activity)
  if activity.markers then
    for type, marker in next, activity.markers, nil do
      marker.visible = true
    end
    if activity.hotspotTerrainMarkerUID then
      TerrainMarker.Update(activity.hotspotTerrainMarkerUID, activity.position, vec.vector(0.05, 0.08, 0.15, 0.7), 7.5)
    end
  end
end
function disableSpecifiedActivity(activity)
  if activity.markers then
    for type, marker in next, activity.markers, nil do
      marker.visible = false
    end
    if activity.hotspotTerrainMarkerUID then
      TerrainMarker.Delete(activity.hotspotTerrainMarkerUID)
    end
  end
end
function removeActivity(activity, token)
  feedbackSystem.clearTarget(activity.iconIndex)
  if activity.activityIndex then
    InteractiveIconsManager.removeIcon(activity.activityIndex, activity.position)
  end
  if not token then
    activitiesHotspots[activity.activityIndex] = nil
  elseif activity.minimapIndex then
    feedbackSystem.clearTarget(activity.minimapIndex)
  end
  activity.markers = nil
  activity.iconIndex = nil
  activity.activityIndex = nil
end
function showPromptOnShiftIn()
  if feedbackSystem.previewScreen.activityBeingPrompted then
    feedbackSystem.previewScreen.displayActivityPrompt(feedbackSystem.previewScreen.activityBeingPrompted)
  end
end
function hidePromptOnShiftOut()
  feedbackSystem.previewScreen.hideActivityPrompt(true)
end
function triggerActivity()
  if feedbackSystem.previewScreen.activityBeingPrompted then
    if feedbackSystem.previewScreen.activityBeingPrompted and localPlayer.inZap then
      feedbackSystem.previewScreen.hidePreviewScreen()
    end
    if feedbackSystem.previewScreen.activityBeingPrompted.hotspotType == "dare" then
      if not dareSystem.activeDare or feedbackSystem.previewScreen.activityBeingPrompted ~= dareSystem.activeDare then
        if localPlayer.currentVehicle and not localPlayer.inZap then
          if localPlayer.currentVehicle.damage < 1 then
            feedbackSystem.previewScreen.showPreview("darePreview", feedbackSystem.previewScreen.activityBeingPrompted)
          end
        else
          feedbackSystem.previewScreen.showPreview("darePreview", feedbackSystem.previewScreen.activityBeingPrompted)
        end
      end
    else
      feedbackSystem.previewScreen.showPreview("activityPreview", feedbackSystem.previewScreen.activityBeingPrompted.ID)
    end
  end
  feedbackSystem.previewScreen.hideActivityPrompt(true)
end
local challengeString = "challenge"
local dareString = "dare"
local activityString = "activity"
local function inRangeCheck(inRange, index, type)
  if not progressionSystem.applyingChapterSettings then
    if inRange then
      if activitiesHotspots[index] and (type ~= dareString or dareSystem.activeDare and dareSystem.activeDare ~= activitiesHotspots[index] or not dareSystem.activeDare) then
        if feedbackSystem.previewScreen.missionDescription then
          feedbackSystem.previewScreen.hideZapPreview("mission")
        end
        feedbackSystem.previewScreen.activityBeingPrompted = activitiesHotspots[index]
        feedbackSystem.previewScreen.activityBeingPrompted.hotspotType = type
        if not dareSystem.promptingDareRetry then
          if localPlayer.inZap then
            if type == dareString then
              feedbackSystem.previewScreen.showPreview("shiftHotspotPreview", activitiesHotspots[index])
            else
              feedbackSystem.previewScreen.showPreview("shiftHotspotPreview", activitiesHotspots[index].ID)
            end
          else
            feedbackSystem.previewScreen.displayActivityPrompt(activitiesHotspots[index])
          end
        end
      end
    elseif feedbackSystem.previewScreen.activityBeingPrompted and feedbackSystem.previewScreen.activityBeingPrompted.ID == activitiesHotspots[index].ID then
      feedbackSystem.previewScreen.clearActivityBeingPrompted()
      if localPlayer.inZap then
        feedbackSystem.previewScreen.hideZapPreview()
      else
        feedbackSystem.previewScreen.hideActivityPrompt()
      end
    end
  end
end
function _G.DareDrawDistanceCallback(activityIndex, inRange)
  local dare = activitiesHotspots[activityIndex]
  if dare and dare ~= dareSystem.activeDare then
    targetStyleInWorldVisible(dare, inRange)
  end
end
function _G.DareActivationDistanceCallback(activityIndex, inRange)
end
function _G.DareProximityDistanceCallback(index, distance, inRange)
  inRangeCheck(inRange, index, dareString)
end
function _G.ActivityDrawDistanceCallback(activityIndex, inRange)
  targetStyleInWorldVisible(activitiesHotspots[activityIndex], inRange)
end
function _G.ActivityActivationDistanceCallback(activityIndex, inRange)
end
function _G.ActivityProximityDistanceCallback(index, distance, inRange)
  inRangeCheck(inRange, index, activityString)
end
function _G.ChallengeDrawDistanceCallback(activityIndex, inRange)
  targetStyleInWorldVisible(activitiesHotspots[activityIndex], inRange)
end
function _G.ChallengeActivationDistanceCallback(activityIndex, inRange)
end
function _G.ChallengeProximityDistanceCallback(index, distance, inRange)
  inRangeCheck(inRange, index, challengeString)
end
function _G.TokenDrawDistanceCallback(iconUID, inRange)
  collectables.showIcon(collectablesByUID[iconUID], inRange)
end
function _G.TokenActivationDistanceCallback(iconUID, inRange, inZap)
  if inRange and not inZap and not localPlayer.zapTransition then
    collectables.collectToken(collectablesByUID[iconUID])
  else
  end
end
function _G.TokenProximityDistanceCallback(iconUID, distance, inRange)
  if abilities.collectableDetection.getLevel() ~= math.huge then
    collectables.showAbilityIcon(collectablesByUID[iconUID], inRange)
  end
end
function _G.GarageDrawDistanceCallback(iconUID, inRange)
  garage.updateIcon(iconUID, inRange)
end
function _G.GarageActivationDistanceCallback(iconUID, inRange, inZap)
end
function _G.GarageProximityDistanceCallback(iconUID, distance, inRange)
  if not progressionSystem.applyingChapterSettings then
    if inRange then
      if distance == proximityRadii.Garage.Near then
        if not dareSystem.promptingDareRetry then
          garage.enterGarageHotspot(iconUID)
        end
        if (not feedbackSystem.previewScreen.activityBeingPrompted or feedbackSystem.previewScreen.activityBeingPrompted and feedbackSystem.previewScreen.activityBeingPrompted.ID ~= iconUID) and (not localPlayer:getTaskObject() or localPlayer:getTaskObject().coreData.instance.challenge.name == "Tutorial garage") then
          if feedbackSystem.previewScreen.missionDescription then
            feedbackSystem.previewScreen.hideZapPreview("mission")
          end
          feedbackSystem.previewScreen.activityBeingPrompted = {ID = iconUID, hotspotType = "garage"}
          if not dareSystem.promptingDareRetry then
            if localPlayer.inZap then
              local function displayPreview()
                feedbackSystem.previewScreen.showPreview("shiftHotspotPreview", iconUID)
                ProfileSettings.SetToolTipShown(toolTipLookupTable["Garage tutorial"])
              end
              if not ProfileSettings.GetToolTipShown(toolTipLookupTable["Garage tutorial"]) and (configSelector.launchConfig.Name == "Single Player" or configSelector.launchConfig.Name == "Post Debrief") then
                CutsceneFiles.tutorials.playTutorial("ID:243890", nil, displayPreview)
              else
                displayPreview()
              end
            else
              local displayPrompt = function()
                feedbackSystem.previewScreen.showGaragePrompt()
                ProfileSettings.SetToolTipShown(toolTipLookupTable["Garage tutorial"])
              end
              if not ProfileSettings.GetToolTipShown(toolTipLookupTable["Garage tutorial"]) and (configSelector.launchConfig.Name == "Single Player" or configSelector.launchConfig.Name == "Post Debrief") then
                CutsceneFiles.tutorials.playTutorial("ID:243890", nil, displayPrompt)
              else
                displayPrompt()
              end
            end
          end
        end
      elseif distance == proximityRadii.Garage.Middle and not localPlayer.inZap and ProfileSettings.GetGarageOwned(iconUID) then
        Garages.GarageRepairRangeCallback(iconUID, inRange)
      end
    elseif distance == proximityRadii.Garage.Near then
      if feedbackSystem.previewScreen.activityBeingPrompted and feedbackSystem.previewScreen.activityBeingPrompted.ID == iconUID then
        feedbackSystem.previewScreen.clearActivityBeingPrompted()
        if localPlayer.inZap then
          feedbackSystem.previewScreen.hideZapPreview()
        else
          feedbackSystem.previewScreen.hideActivityPrompt()
        end
      end
      garage.exitGarageHotspot()
    else
      Garages.GarageRepairRangeCallback(iconUID, inRange)
    end
  end
end
