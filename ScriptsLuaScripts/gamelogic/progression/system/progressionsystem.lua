module("progressionSystem", package.seeall)
currentProgression = ProfileSettings.GetProgression()
currentChapter = false
local loadNextPot = false
function setLoadNextPot(state)
  print("setLoadNextPot = " .. tostring(state))
  callStack()
  loadNextPot = state
end
function getLoadNextPot()
  print("getLoadNextPot = " .. tostring(loadNextPot))
  callStack()
  return loadNextPot
end
function unlockAchievement(ID)
  Achievements.UnlockAchievement(ID)
end
function _G.getCurrentChapter()
  if challengeProgressionTable[currentProgression] and challengeProgressionTable[currentProgression].settings then
    return challengeProgressionTable[currentProgression].settings.chapter
  end
end
function getCurrentChapterInlcudingArtificial()
  local playerTaskObject = localPlayer:getTaskObject()
  if playerTaskObject then
    local mission, potID, subType, type = progressionSystem.findMissionInProgression(playerTaskObject.coreData.instance.challenge.name)
    if type == "mission" then
      return getCurrentChapter()
    elseif mission.settings and mission.settings.chapter then
      return mission.settings.chapter
    else
      return progressionSystem.getCurrentChapter()
    end
  else
    return progressionSystem.getCurrentChapter()
  end
end
function findChallengeInProgression(challengeID)
  for challengeType, typePot in next, challengeLookupTable, nil do
    for potID, challenges in next, typePot, nil do
      for i, challenge in next, challenges, nil do
        if challenge.ID == challengeID then
          return challenge, nil, challengeType, "challenge"
        end
      end
    end
  end
end
function findActivityInProgression(challengeID)
  for activityType, groups in next, activitiesLookupTable, nil do
    for subType, activities in next, groups, nil do
      for i, activity in next, activities, nil do
        if activity.ID == challengeID then
          return activity, subType, activityType, "activity"
        end
      end
    end
  end
  return findChallengeInProgression(challengeID)
end
function findMissionInProgression(challengeID)
  if challengeID then
    for potID, missionPots in next, challengeProgressionTable, nil do
      for missionType, pot in next, missionPots, nil do
        if missionType ~= "settings" then
          for i, mission in ipairs(pot) do
            if mission.ID == challengeID then
              local type
              if missionType == "tutorials" then
                type = "progressionTutorial"
              else
                type = "mission"
              end
              return mission, potID, missionType, type
            end
          end
        end
      end
    end
    return findActivityInProgression(challengeID)
  end
end
function updateSettingsUnlock(unlockPot)
  local settings = challengeProgressionTable[unlockPot].settings
  if settings then
    localPlayer:blockAbility("zap", settings.blockZap)
    enableAbilities(localPlayer.localID, not settings.blockAbilities)
    setMaxZapLevel(settings.maxZapLevel or #zap.settings.levelData)
    enableWillpower(not settings.blockWillpower)
    activeChallenges.enable(not settings.blockActiveChallenges, true)
    garage.enable(not settings.blockGarage)
    if settings.blockActivities then
      activeChallenges.deleteActivityIcons()
    else
      activeChallenges.initialiseActivities()
    end
    if settings.blockCollectables then
      activeChallenges.disableCollectables()
    end
    if not localPlayer.inZap then
      localPlayer.controllerInterface:resetCallbacks()
    end
  end
end
local missionsCompleted = 0
function setSavedMissions()
  local missionList = {}
  for i, mission in ipairs(cards.MissionNetworkLookup) do
    if ProfileSettings.GetMissionCompleted(i) then
      missionList[mission] = {}
      missionList[mission].completed = true
    end
  end
  for i, pot in ipairs(challengeProgressionTable) do
    for challengeType, challenges in next, pot, nil do
      if challengeType ~= "settings" then
        for j, challenge in ipairs(challenges) do
          if missionList[challenge.ID] and missionList[challenge.ID].completed then
            challenge.complete = true
          end
        end
      end
    end
  end
end
function updateUnlockProgression()
  print("updateUnlockProgression()")
  callStack()
  updateSettingsUnlock(currentProgression)
  initiateMissionsMenu()
  chapterSelect()
end
local cleanupCurrentChapter = function()
  if challengeProgressionTable[currentProgression - 1] then
    for index, challenge in next, challengeProgressionTable[currentProgression - 1].missions, nil do
      if cards.Missions and cards.Missions[challenge.ID] and cards.Missions[challenge.ID].MissionID then
        Sound.RemovePreview(cards.Missions[challenge.ID].MissionID)
      end
    end
  end
end
local isChapterAcrossMultiplePots = function(chapter)
  local count = 0
  for i = 1, #challengeProgressionTable do
    local pot = challengeProgressionTable[i]
    for challengeType, challenges in next, pot, nil do
      if challengeProgressionTable[i].settings and challengeProgressionTable[i].settings.chapter and challengeProgressionTable[i].settings.chapter == chapter then
        count = count + 1
        if count > 1 then
          return true
        end
      end
    end
  end
end
function tutorialCheck(type)
  if ProfileSettings.GetStoryModeComplete() then
    return false
  end
  local currentPot = challengeProgressionTable[currentProgression]
  if getLoadNextPot() and challengeProgressionTable[currentProgression - 1] then
    currentPot = challengeProgressionTable[currentProgression - 1]
  end
  for challengeType, challenges in next, currentPot, nil do
    if challengeType == "tutorials" then
      for i, challenge in ipairs(challenges) do
        if type == challenge.type and not challenge.complete then
          return challenge.ability, challenge.level, challenge.hospitalCutscene
        end
      end
    end
  end
end
applyingChapterSettings = false
inArtificialChapter = false
function applyChapterSettings(pot, missionID, forced, skipCutScene, noSpoolingOrInitialCutscene, initialLoad, fromInWorld, fromChallenge)
  chapterLoading.handleChapterLoading(pot, missionID, forced, skipCutScene, noSpoolingOrInitialCutscene, initialLoad, nil, fromInWorld, fromChallenge)
end
function applyChallengeSettings(challenge, instantFade, fromInWorld)
  challengeLoading.handleChallengeLoad(challenge, instantFade, fromInWorld)
end
function initialiseProgressionPot(initialLoad, skipCutScene, noSpoolingOrInitialCutscene)
  print("Initialising challenge pot = " .. tostring(currentProgression))
  applyChapterSettings(currentProgression, nil, nil, skipCutScene, noSpoolingOrInitialCutscene, initialLoad)
end
function skipToProgressionPot(pot, initialLoad, skipCutScene)
  if currentProgression ~= pot then
    currentProgression = pot
  end
  initialiseProgressionPot(initialLoad, skipCutScene)
end
function isMissionInCurrentChapter(challengeID)
  local currentPot = challengeProgressionTable[currentProgression]
  if getLoadNextPot() and challengeProgressionTable[currentProgression - 1] then
    currentPot = challengeProgressionTable[currentProgression - 1]
  end
  for challengeType, challenges in next, currentPot, nil do
    if challengeType ~= "settings" then
      for i, challenge in ipairs(challenges) do
        if challenge.ID == challengeID then
          return challenge
        end
      end
    end
  end
end
local getNumberOfCompletedMissions = function(currentPot)
  local numberOfCompletedChallenges = 0
  if currentPot.missions then
    for index, challenge in next, currentPot.missions, nil do
      if challenge.complete then
        numberOfCompletedChallenges = numberOfCompletedChallenges + 1
      end
    end
  end
  return numberOfCompletedChallenges
end
function nextChapterCheck(currentPot)
  local numberOfCompletedChallenges = getNumberOfCompletedMissions(currentPot)
  local function everythingCompleted()
    for challengeType, challenges in next, currentPot, nil do
      if challengeType ~= "settings" then
        for i, challenge in ipairs(challenges) do
          if not challenge.complete then
            return false
          end
        end
      end
    end
    return true
  end
  if (not currentPot.storyMission and currentPot.missions and numberOfCompletedChallenges == #currentPot.missions or currentPot.storyMission and currentPot.storyMission[1].complete or everythingCompleted()) and currentProgression < #challengeProgressionTable then
    return true
  end
end
local chapterProgressCheck = function()
  local currentPot = challengeProgressionTable[currentProgression]
  if nextChapterCheck(currentPot) then
    if currentPot.settings.achievementUnlock then
      for key, achievementData in pairs(AchievementTable.AchievementID) do
        if achievementData.achievementID == currentPot.settings.chapter + 1 then
          unlockAchievement(achievementData.achievementID)
        end
      end
    end
    currentProgression = currentProgression + 1
    if currentProgression == 9 and ProfileSettings.GetStoryModeComplete() then
      currentProgression = currentProgression + 1
    end
    setLoadNextPot(true)
    ProfileSettings.SetProgression(currentProgression)
    currentPot = challengeProgressionTable[currentProgression]
    if currentPot.settings.chapter ~= 0 then
      local completedChapter = currentPot.settings.chapter - 1
      ProfileSettings.SetChapter(completedChapter)
    end
  else
    setLoadNextPot(false)
  end
end
function showNextRecap(currentPot, mission, subType)
  local chapter = currentPot.settings.chapter
  if chapter > 0 and chapter < 8 and currentPot.missions and currentPot.tannerMission and currentPot.tannerMission[1].complete and getNumberOfCompletedMissions(currentPot) == #currentPot.missions and (not mission or mission and not mission.unlocksAbility and not mission.type) and (not missionType or subType ~= "storyMission") then
    return true
  end
end
function getChallengeWillpowerReward(challengeName, completeActivityReward)
  local mission, potID, subType, type = findMissionInProgression(challengeName)
  local rewardType = false
  local rewardKey = false
  local willpowerReward = false
  if willpowerRewards[subType] then
    rewardType = subType
  end
  if type == "mission" and potID > 8 and not mission.complete then
    rewardType = subType
    if challengeProgressionTable[potID] and challengeProgressionTable[potID].settings.chapter then
      rewardKey = challengeProgressionTable[potID].settings.chapter
    end
  elseif mission.settings and mission.settings.chapter then
    if type == "activity" then
      rewardType = "activities"
      rewardKey = mission.settings.chapter
      if completeActivityReward and (potID == "Checkpoints" or potID == "Smash") then
        return false
      end
    elseif type == "challenge" then
      rewardType = "challenges"
      rewardKey = challengeName
    end
  end
  if rewardType and rewardKey then
    willpowerReward = willpowerRewards[rewardType][rewardKey]
  end
  if willpowerReward == 0 then
    return false
  else
    return willpowerReward
  end
end
local countCompletedActivities = function()
  local count = 0
  for type, groups in next, activitiesLookupTable, nil do
    for subType, challenges in next, groups, nil do
      for i, challenge in next, challenges, nil do
        if ProfileSettings.GetChallengeCompleted(cards.ReverseMissionNetworkLookup[challenge.ID]) then
          count = count + 1
        end
      end
    end
  end
  return count
end
function saveOnMissionComplete(instance)
  local challengeName = instance.challenge.name
  local networkID = cards.ReverseMissionNetworkLookup[challengeName]
  local mission, potID, subType, type = findMissionInProgression(challengeName)
  GameplayTracking.OnObjectiveStop(missionInfo[cards.ReverseMissionNetworkLookup[challengeName]].challengeTitle, type, "COMPLETE", "COMPLETE")
  if instance.missionType == "challenge" or instance.missionType == "activity" then
    scoreSystem.willpowerReward(getChallengeWillpowerReward(challengeName, true) or instance.accumulatedWillpower, mission.iconType, true)
    if networkID then
      ProfileSettings.SetChallengeCompleted(networkID, subType ~= "unlockable")
      if instance.missionType == "activity" then
        vehicleManager.updateVehicleUnlocks(nil, countCompletedActivities())
        vehicleManager.updateVehicleUnlocks(nil, challengeName)
      end
      targetStyleInWorldSetComplete(mission)
      GameplayTracking.OnMissionComplete()
      saveGame("When completing challenge " .. challengeName)
    end
  else
    local completedChallenge = isMissionInCurrentChapter(challengeName)
    if completedChallenge and not missionLaunchedFromFrontEnd then
      if not ProfileSettings.GetMissionCompleted(networkID) and challengeName ~= "Exposition 04 return to dealer" and challengeName ~= "Exposition 02 I wish we could help" then
        scoreSystem.willpowerReward(getChallengeWillpowerReward(challengeName), mission.iconType, true)
      end
      if challengeName == "Final fight" and not ProfileSettings.GetToolTipShown(toolTipLookupTable["Reached Finale"]) then
        ProfileSettings.SetToolTipShown(toolTipLookupTable["Reached Finale"])
      end
      mission.complete = true
      chapterProgressCheck()
      activityUnlockCheck(completedChallenge)
    end
    if networkID then
      ProfileSettings.SetMissionCompleted(networkID, mission.statsMission)
      GameplayTracking.OnMissionComplete()
    else
      for potIndex, progressionPot in next, challengeProgressionTable, nil do
        for challengeType, challenges in next, progressionPot, nil do
          if challengeType ~= "settings" then
            for index, challenge in next, challenges, nil do
              if challenge.ID == challengeName then
                challenge.complete = true
              end
            end
          end
        end
      end
    end
    saveGame("When completing mission " .. challengeName)
  end
end
function showStoryMissionUnlockPanel(storyMissionName)
  local mission, potID, missionType, type = findMissionInProgression(storyMissionName)
  local networkID = cards.ReverseMissionNetworkLookup[storyMissionName]
  local narration = ""
  if missionType == "storyMission" then
    narration = "SMUnlock"
  else
    narration = "TJUnlock"
  end
  if challengeProgressionTable[currentProgression].missions then
    feedbackSystem.menusMaster.queueUnlockPanel("city", type, missionType, networkID, nil, nil, missionInfo[networkID].challengeTitle, "ID:245785")
  end
end
function challengeComplete(instance, matrixOrVehicleList)
  if not instance.challenge then
    printTable(instance, 2)
    callStack()
  end
  local challengeName = instance.challenge.name
  local missionType = instance.missionType
  local disableZapOnCompletion = instance.challenge.settings.disableZapOnCompletion
  local afterEndScreenCutscene = instance.challenge.afterEndScreenCutscene
  local afterEndScreenLocation = instance.challenge.afterEndScreenLocation
  local fromInWorld = instance.fromInWorld
  clearSoftSave()
  instance:delete()
  if not localPlayer.challenge.retryingMission then
    if not missionLaunchedFromFrontEnd then
      missionEndLoading.handleMissionEndLoading(challengeName, true, disableZapOnCompletion, afterEndScreenCutscene, afterEndScreenLocation, fromInWorld)
    else
      if missionType == "challenge" then
        local mission, potID, subType, type = findMissionInProgression(challengeName)
        ProfileSettings.SetChallengeCompleted(cards.ReverseMissionNetworkLookup[challengeName], subType ~= "unlockable")
      else
        ProfileSettings.SetMissionCompleted(cards.ReverseMissionNetworkLookup[challengeName], mission.statsMission)
      end
      PauseMenu.quit()
    end
  end
end
function challengeFailed(instance, matrixOrVehicleList)
  local challengeName = instance.challenge.name
  local isChallenge = instance.missionType == "challenge"
  local fromInWorld = instance.fromInWorld
  instance:delete()
  if not localPlayer.challenge.retryingMission then
    if not missionLaunchedFromFrontEnd then
      missionEndLoading.handleMissionEndLoading(challengeName, false, false, nil, nil, fromInWorld)
    else
      PauseMenu.quit()
    end
  end
end
function challengeAbandoned(instance)
  local challengeName = instance.challenge.name
  local fromInWorld = instance.fromInWorld
  local mission, potID, subType, type = findMissionInProgression(challengeName)
  GameplayTracking.OnObjectiveStop(missionInfo[cards.ReverseMissionNetworkLookup[challengeName]].challengeTitle, type, "ABANDON", "ABANDON")
  GameplayTracking.OnMissionAbandon()
  clearSoftSave()
  instance:delete()
  if not missionLaunchedFromFrontEnd then
    missionEndLoading.handleMissionEndLoading(challengeName, false, false, nil, nil, fromInWorld)
  else
    PauseMenu.quit()
  end
end
function _G.launchMission(missionNetworkID)
  local missionID = cards.MissionNetworkLookup[missionNetworkID]
  assert(missionID, "launchMission called with invalid mission ID")
  local mission, potID, subType, type = findMissionInProgression(missionID)
  if type == "challenge" or type == "activity" then
    applyChallengeSettings(mission, true)
  else
    assert(potID, "launchMission called for " .. missionID .. ", mission not found in progression")
    applyChapterSettings(potID, missionID, true)
  end
end
function isEverythingUnlocked()
  for uid, dare in next, dareSystem.daresByUID, nil do
    if not ProfileSettings.GetDareCompleted(uid) then
      return false
    end
  end
  for potID, pot in ipairs(challengeProgressionTable) do
    if pot.settings.chapter < 10 then
      for challengeType, challengeGroup in next, pot, nil do
        if challengeType ~= "settings" then
          for __, challenge in ipairs(challengeGroup) do
            if not ProfileSettings.GetMissionCompleted(cards.ReverseMissionNetworkLookup[challenge.ID]) then
              return false
            end
          end
        end
      end
    end
  end
  for unlockType, challengeList in next, challengeLookupTable, nil do
    if unlockType ~= "unlockable" then
      for __, challengeGroup in next, challengeList, nil do
        for __, challenge in ipairs(challengeGroup) do
          if not ProfileSettings.GetChallengeUnlocked(cards.ReverseMissionNetworkLookup[challenge.ID]) then
            return false
          end
        end
      end
    end
  end
  for activityGroup, activityTypes in next, activitiesLookupTable, nil do
    for activityType, activityList in next, activityTypes, nil do
      for __, activity in ipairs(activityList) do
        if not ProfileSettings.GetChallengeUnlocked(cards.ReverseMissionNetworkLookup[activity.ID]) then
          return false
        end
      end
    end
  end
  for uid, vehicle in next, Vehicles, nil do
    if not ProfileSettings.GetVehicleUnlocked(uid) then
      return false
    end
  end
  return true
end
function forceStartMission(missionID, fromRetry, fromInWorld)
  print("forceStartMission( " .. tostring(missionID) .. ", " .. tostring(fromRetry) .. " )")
  callStack()
  assert(cardSystem.formattedMissionData[missionID], "mission " .. missionID .. " not loaded")
  local mission, potID, subType, type = findMissionInProgression(missionID)
  if not localPlayer.inZap and type ~= "progressionTutorial" and zap.currentUnlockedZapLevel > 0 then
    localPlayer:SetZapLevel(zap.currentUnlockedZapLevel, nil, false, {forcedOut = true})
  end
  if not fromRetry then
    clearSoftSave()
  end
  local softSaveData = getSoftSaveData()
  if softSaveData or fromRetry then
    local instance = false
    for instanceID, instance in next, challengeSystem.instances, nil do
      instance:delete()
    end
    instance = challengeSystem.createInstance(cardSystem.formattedMissionData[missionID])
    if type == "challenge" then
      instance.fromInWorld = fromInWorld or false
    end
  else
    local challengePreviewActor = false
    for i, actor in ipairs(cardSystem.formattedMissionData[missionID].challenge.actorPool) do
      if actor.previewMovie then
        challengePreviewActor = actor.ID
        break
      end
    end
    assert(challengePreviewActor, "mission " .. missionID .. " cannot be launched - start actor not found")
    local challengeVehicle
    local challengeInstance = false
    for instanceID, instance in next, challengeSystem.instances, nil do
      if instance.challenge.name == missionID then
        if instance.syncedPhase < 3 then
          challengeInstance = instance
        else
          instance:delete()
        end
      else
        instance:delete()
      end
    end
    challengeInstance = challengeInstance or challengeSystem.createInstance(cardSystem.formattedMissionData[missionID])
    if challengeInstance.taskObjectsByActorID[challengePreviewActor] then
      challengeVehicle = challengeInstance.taskObjectsByActorID[challengePreviewActor].coreData.agent
    end
    if not configSelector.launchConfig.enableProgression and missionProgression then
      updateSettingsUnlock(missionProgression)
    end
    if missionID ~= "Exposition 07 Speed dare" and missionID ~= "Exposition 02 I wish we could help" then
      if challengeVehicle then
        if mission.forceStart then
          zapcontroller.RemoveChallengeVehicle({
            gameVehicle = challengeVehicle.gameVehicle
          })
        end
        localPlayer:SetZapLevel(0, challengeVehicle, true, {disableZapFlash = true, playerInstigated = true})
      elseif type == "progressionTutorial" then
        challengeInstance:newActorFromAgent("Tutorial actor", localPlayer)
        localPlayer.missionSupport:setHooksFromVehicle(localPlayer)
      end
    end
    feedbackSystem.menusMaster.masterSetTextVariable("mission_title", challengeInstance.challenge.title)
    feedbackSystem.menusMaster.masterSetTextVariable("mission_description", challengeInstance.challenge.description)
    if type == "challenge" then
      challengeInstance.fromInWorld = fromInWorld or false
    end
    if not mission.forceStart and not fromInWorld then
      spooling.fadeIn()
    end
  end
end
function chapterSelect()
  local chapterSelect = {}
  local potNumber = {}
  local chapters = {}
  for k, v in next, challengeProgressionTable, nil do
    local chapter = v.settings.chapter
    if chapter and (not chapters[chapter] or k < potNumber[chapter]) then
      chapters[v.settings.chapter] = {
        name = "Chapter " .. chapter,
        action = function()
          quitMission()
          skipToProgressionPot(k)
          PauseMenu.resume()
        end
      }
      potNumber[chapter] = k
    end
  end
  for i, infoTable in ipairs(chapters) do
    table.insert(chapterSelect, infoTable)
  end
  table.insert(chapterSelect, {
    name = "Back",
    action = changePauseMenu("OptionsMenu")
  })
  addPauseMenu("chapterSelect", chapterSelect)
end
local spawnStoryMission = function(challenge)
  if not challenge.spawn then
    challenge.spawn = true
  end
end
local unlockStoryMission = function(challenge)
  if not challenge.unlocked then
    challenge.unlocked = true
    challenge.spawn = true
    return challenge.ID
  end
end
function missionsRemainingBeforeUnlock(type)
  local currentPot = challengeProgressionTable[currentProgression]
  local missionsComplete = getNumberOfCompletedMissions(currentPot)
  local unlockMissionAfter
  local missionsRemaining = 0
  if type == "tannerMission" then
    unlockMissionAfter = 2
  elseif type == "storyMission" then
    unlockMissionAfter = #currentPot.missions
  end
  if unlockMissionAfter and missionsComplete < unlockMissionAfter then
    missionsRemaining = unlockMissionAfter - missionsComplete
    return missionsRemaining
  end
end
function storyMissionUnlockCheck(initialLoad)
  local missionName = false
  local currentPot = challengeProgressionTable[currentProgression]
  if currentPot.missions then
    if currentPot.tannerMission then
      local tannerMissionComplete = false
      for i, challenge in ipairs(currentPot.tannerMission) do
        if not challenge.complete and not challenge.spawn then
          spawnStoryMission(challenge)
        end
        if not challenge.complete and not challenge.unlocked and not missionsRemainingBeforeUnlock("tannerMission") then
          missionName = unlockStoryMission(challenge)
          break
        elseif challenge.complete then
          tannerMissionComplete = true
        end
      end
      if currentPot.storyMission then
        for i, challenge in ipairs(currentPot.storyMission) do
          if not challenge.complete and not challenge.spawn and tannerMissionComplete then
            spawnStoryMission(challenge)
          end
          if not challenge.complete and not challenge.unlocked and tannerMissionComplete and not missionsRemainingBeforeUnlock("storyMission") then
            missionName = unlockStoryMission(challenge)
            break
          end
        end
      end
    elseif currentPot.storyMission then
      for i, challenge in ipairs(currentPot.storyMission) do
        if not challenge.complete and not challenge.spawn then
          spawnStoryMission(challenge)
        end
        if not challenge.complete and not challenge.unlocked and not missionsRemainingBeforeUnlock("storyMission") then
          missionName = unlockStoryMission(challenge)
          break
        end
      end
    end
  elseif currentPot.storyMission and not currentPot.storyMission[1].complete then
    missionName = unlockStoryMission(currentPot.storyMission[1])
  end
  if missionName and not initialLoad then
    showStoryMissionUnlockPanel(missionName)
  end
  return missionName
end
function activityUnlockCheck(challenge)
  if challenge.complete and challenge.unlocks then
    for __, activityUnlock in ipairs(challenge.unlocks) do
      if activitiesLookupTable[activityUnlock.type] and activitiesLookupTable[activityUnlock.type][activityUnlock.subType] and activitiesLookupTable[activityUnlock.type][activityUnlock.subType][activityUnlock.ID] then
        local challengeName = activitiesLookupTable[activityUnlock.type][activityUnlock.subType][activityUnlock.ID].ID
        local ID = cards.ReverseMissionNetworkLookup[challengeName]
        if not ProfileSettings.GetChallengeOwned(ID) then
          ProfileSettings.SetChallengeUnlocked(ID, true)
          shop.purchaseChallenge(ID)
        end
      elseif activitiesLookupTable[activityUnlock.type] then
        if activitiesLookupTable[activityUnlock.type][activityUnlock.subType] then
          if not activitiesLookupTable[activityUnlock.type][activityUnlock.subType][activityUnlock.ID] then
            print("######################## WARNING: The mission " .. challenge.ID .. " is requesting an activity ID which does not exist: " .. activityUnlock.ID)
          end
        else
          print("######################## WARNING: The mission " .. challenge.ID .. " is requesting an activity subType which does not exist: " .. activityUnlock.subType)
        end
      else
        print("######################## WARNING: The mission " .. challenge.ID .. " is requesting an activity type which does not exist: " .. activityUnlock.type)
      end
    end
  end
end
function challengeUnlockCheck(garage)
  local unlocks = false
  if challengeLookupTable.shop[garage] then
    for __, challenge in next, challengeLookupTable.shop[garage], nil do
      local networkID = cards.ReverseMissionNetworkLookup[challenge.ID]
      if not ProfileSettings.GetChallengeUnlocked(networkID) then
        ProfileSettings.SetChallengeUnlocked(networkID)
        if challengePrices[challenge.ID].Price == 0 then
          shop.purchaseChallenge(networkID)
        else
          unlocks = unlocks or {}
          table.insert(unlocks, networkID)
        end
      end
    end
  end
  if unlocks then
    local unlockTitle = "NEW CHALLENGES"
    if #unlocks == 1 then
      unlockTitle = missionInfo[unlocks[1]].challengeTitle
    end
    feedbackSystem.menusMaster.queueUnlockPanel("gadget", "challenge", "challenge", unlocks, nil, nil, unlockTitle, "ID:245770")
  end
end
function abilityHasTutorial(name, level)
  level = level or 0
  for challengeType, challenges in next, challengeProgressionTable[currentProgression], nil do
    if challengeType == "tutorials" then
      for index, challenge in next, challenges, nil do
        if challenge.ability == name and (not challenge.level or challenge.level == level) then
          return challenge
        end
      end
    end
  end
  for i, pot in next, challengeProgressionTable, nil do
    for challengeType, challenges in next, pot, nil do
      if challengeType == "tutorials" then
        for index, challenge in next, challenges, nil do
          if challenge.ability == name and (not challenge.level or challenge.level == level) then
            return challenge
          end
        end
      end
    end
  end
end
function startTutorial(name, level)
  local challenge = abilityHasTutorial(name, level)
  if cardSystem.formattedMissionData[challenge.ID] then
    forceStartMission(challenge.ID)
  else
    local mission, potID, subType, type = findMissionInProgression(challenge.ID)
    applyChapterSettings(potID, challenge.ID, true)
  end
end
_G.startTutorial = progressionSystem.startTutorial
function endTutorial()
  scoreSystem.tutorialMode(localPlayer.localID, false)
end
local trafficEventsState
function getTrafficEvents()
  return trafficEventsState
end
function setTrafficEvents(enable)
  if enable and trafficEvents and trafficEvents.enabled then
    if trafficEvents.events then
      for eventType, data in next, trafficEvents.events, nil do
        TrafficEventsManager.AddDynamicEventSpawner(eventType, data.frequency)
        TrafficEventsManager.SetSystemTimeSleepingBetweenEvents(data.minTimeBetween, eventType)
      end
    end
    TrafficEventsManager.SetDynamicEventsGlobalProbability(0.05)
    TrafficEventsManager.SetEnable(true)
    trafficEventsState = true
  else
    TrafficEventsManager.SetEnable(false)
    trafficEventsState = false
  end
end
function saveGame(circumstance)
  print("////////////////////////// SAVE GAME called at: " .. tostring(g_NetworkTime) .. ". " .. circumstance)
  ProfileSettings.TriggerAutoSave()
end
local finaleMissions = {
  ["Alone"] = true,
  ["Final fight"] = true,
  ["Avoid The Cars"] = true,
  ["Anything you can do"] = true,
  ["Epilogue"] = true,
  ["Epilogue pt 2"] = true
}
local function createAction(challengeID)
  local missionNetworkID = 0
  for ID, missionID in next, cards.MissionNetworkLookup, nil do
    if missionID == challengeID then
      missionNetworkID = ID
    end
  end
  return function()
    if finaleMissions[challengeID] then
      local mission, potID = findMissionInProgression(challengeID)
      currentProgression = potID
      local currentPot = challengeProgressionTable[currentProgression]
      if currentPot.missions then
        for index, challenge in next, currentPot.missions, nil do
          challenge.complete = true
        end
      end
      for i = currentProgression + 1, #challengeProgressionTable do
        if challengeProgressionTable[i].storyMission then
          for j = 1, #challengeProgressionTable[i].storyMission do
            print("Resetting complete field " .. tostring(challengeProgressionTable[i].storyMission[j].ID))
            challengeProgressionTable[i].storyMission[j].complete = false
          end
        end
      end
    end
    launchMission(missionNetworkID)
    PauseMenu.resume()
  end
end
local function unlockChallenges(challenges, chapterMissions, pot)
  local chapterMissions = chapterMissions
  for k, challenge in ipairs(challenges) do
    local infoTable = {
      name = missionInfo[cards.ReverseMissionNetworkLookup[challenge.ID]].challengeTitle,
      action = createAction(challenge.ID)
    }
    table.insert(chapterMissions, infoTable)
  end
  return chapterMissions
end
function initiateMissionsMenu()
  local availableChapters
  for k, v in next, challengeProgressionTable[currentProgression].settings, nil do
    if k == "chapter" then
      availableChapters = v
    end
  end
  local function createChaptersMissionMenu()
    local chapterMissions = {}
    for progression, pot in ipairs(challengeProgressionTable) do
      if pot.settings.chapter then
        chapter = pot.settings.chapter
        chapterProgression = progression
        if chapter <= availableChapters then
          chapterMissions[chapter] = chapterMissions[chapter] or {}
          if pot.missions then
            chapterMissions[chapter] = unlockChallenges(challengeProgressionTable[chapterProgression].missions, chapterMissions[chapter], progression)
          end
          if pot.tannerMission then
            chapterMissions[chapter] = unlockChallenges(challengeProgressionTable[chapterProgression].tannerMission, chapterMissions[chapter], progression)
          end
          if pot.storyMission then
            chapterMissions[chapter] = unlockChallenges(challengeProgressionTable[chapterProgression].storyMission, chapterMissions[chapter], progression)
          end
        end
      end
    end
    for i, chapter in next, chapterMissions, nil do
      table.insert(chapter, {
        name = "Back",
        action = changePauseMenu("MissionsMenu")
      })
      addPauseMenu("chapterMissions" .. i, chapterMissions[i])
    end
  end
  local function createChapterMenu()
    local missionsMenu = {}
    local chapters = {}
    for k, v in ipairs(challengeProgressionTable) do
      local chapter = v.settings.chapter
      if chapter and chapter <= availableChapters then
        local name
        if chapter > 0 then
          name = "Chapter " .. chapter
        else
          name = "Chapter " .. chapter .. " FOR DEV ONLY"
        end
        chapters[v.settings.chapter] = {
          name = name,
          action = changePauseMenu("chapterMissions" .. chapter)
        }
      end
    end
    if chapters[0] then
      table.insert(missionsMenu, chapters[0])
    end
    for i, infoTable in ipairs(chapters) do
      table.insert(missionsMenu, infoTable)
    end
    table.insert(missionsMenu, {
      name = "Back",
      action = changePauseMenu("Pause")
    })
    addPauseMenu("MissionsMenu", missionsMenu)
  end
  local function createMenu(type)
    local menuContents = {}
    local typeMenuContents = {}
    local lookupTable, menu
    if type == "activities" then
      lookupTable = activitiesLookupTable
      menu = "ActivitiesMenu"
    elseif type == "challenges" then
      lookupTable = challengeLookupTable
      menu = "ChallengesMenu"
    end
    for challengeType, typePot in next, lookupTable, nil do
      table.insert(menuContents, {
        name = challengeType,
        action = changePauseMenu(challengeType)
      })
      for potID, challenges in next, typePot, nil do
        for i, challenge in next, challenges, nil do
          typeMenuContents[challengeType] = typeMenuContents[challengeType] or {}
          table.insert(typeMenuContents[challengeType], {
            name = missionInfo[cards.ReverseMissionNetworkLookup[challenge.ID]].challengeTitle,
            action = createAction(challenge.ID)
          })
        end
      end
    end
    for challengeType, tables in next, typeMenuContents, nil do
      table.insert(tables, {
        name = "Back",
        action = changePauseMenu(menu)
      })
      addPauseMenu(challengeType, tables)
    end
    table.insert(menuContents, {
      name = "Back",
      action = changePauseMenu("Pause")
    })
    addPauseMenu(menu, menuContents)
  end
  local function createActiviesAndChallengeMenu()
    createMenu("activities")
    createMenu("challenges")
  end
  createChapterMenu()
  createChaptersMissionMenu()
  createActiviesAndChallengeMenu()
end
