module("activeChallenges", package.seeall)
local minCleanupDistance = 600
local stepRate = 120
local playerPositionBasedSpawnInterval = 2
local previousPlayerPositionBasedSpawnCheck
local cleanupInterval = 1 * stepRate
local cleanupTimer = 0
local availableUnspawnedPlayerPositionBasedMissions = {}
local availableUnspawnedAlwaysActiveMissions = {}
local spawnedPlayerPositionBasedMissions = {}
local spawnedAlwaysActiveMissions = {}
local lastPlayerPosition = vec.vector(0, 0, 0, 1)
local workingVector = vec.vector()
local missionsRemoved, playerTaskObject
preventActiveChallenges = false
function getNumberOfSpawnedMissions()
  return #spawnedPlayerPositionBasedMissions + #spawnedAlwaysActiveMissions
end
function playerPositionBasedMissionsOnWarmup()
  if #spawnedPlayerPositionBasedMissions > 0 then
    return true
  end
end
function initiate()
  zapcontroller.SetDistanceToTriggerAudioPreview(localPlayer.localID, 250)
  addUserUpdateFunction("activeChallengesUpdate", update, updates.stepRate / stepRate)
end
function disable(blockMissionDeletion)
  if not blockMissionDeletion and not gameStatus.onlineSession then
    local playerTaskObject = false
    local previewVehicle = vehicleManager.previewVehicleManager.previewVehicle
    if previewVehicle then
      playerTaskObject = previewVehicle:getTaskObject()
    elseif localPlayer.getTaskObject() then
      playerTaskObject = localPlayer.getTaskObject()
    end
    for instanceID, instance in next, challengeSystem.instances, nil do
      deleteMissionWarmupMarker(instance, true)
      if not playerTaskObject or instance ~= playerTaskObject.coreData.instance then
        instance:delete()
      end
    end
  end
  removeUserUpdateFunction("activeChallengesUpdate")
end
function purge()
  disable()
  deleteActivityIcons()
end
function enable(state, blockMissionDeletion)
  if state then
    initiate()
  else
    disable(blockMissionDeletion)
  end
end
function emptySpawnLists()
  for k, v in next, availableUnspawnedPlayerPositionBasedMissions, nil do
    availableUnspawnedPlayerPositionBasedMissions[k] = nil
  end
  for k, v in next, availableUnspawnedAlwaysActiveMissions, nil do
    availableUnspawnedAlwaysActiveMissions[k] = nil
  end
end
function deleteAllInstances()
  disableActivities()
  disableCollectables()
  emptySpawnLists()
  for instanceID, instance in next, challengeSystem.instances, nil do
    instance:delete()
  end
end
function addMissionToSpawnList(availableChallenge, overrideDoNotSpawn)
  if not availableChallenge.complete and (not availableChallenge.doNotSpawn or availableChallenge.doNotSpawn and overrideDoNotSpawn) and cardSystem.formattedMissionData[availableChallenge.ID] then
    local challenge = cardSystem.formattedMissionData[availableChallenge.ID].challenge
    if challenge.settings.alwaysActiveChallenge then
      table.insert(availableUnspawnedAlwaysActiveMissions, challenge)
    elseif challenge.settings.playerPositionBasedChallenge then
      table.insert(availableUnspawnedPlayerPositionBasedMissions, challenge)
    end
  end
end
function updateActiveChallengePot(progressionPot, noNeedToUnspool)
  deleteAllInstances()
  if progressionPot.missions then
    for index, challenge in next, progressionPot.missions, nil do
      local overrideDoNotSpawn = challenge.ID == "Exposition 06 Law Breaker (cop)" and ProfileSettings.IsTakedownUnlocked()
      addMissionToSpawnList(challenge, overrideDoNotSpawn)
    end
  end
  if progressionPot.tannerMission then
    for index, challenge in next, progressionPot.tannerMission, nil do
      if challenge.spawn and not challenge.completed then
        addMissionToSpawnList(challenge)
      end
    end
  end
  if progressionPot.storyMission then
    for index, challenge in next, progressionPot.storyMission, nil do
      if challenge.spawn and not challenge.completed then
        addMissionToSpawnList(challenge)
      end
    end
  end
  enableActivities()
  enableCollectables()
  if not noNeedToUnspool then
    spooling.unspoolUnneceassaryMissionVehicles(progressionPot)
  end
end
local function getClosestChallengeVehicleDistance(instance)
  local closestChallengeVehicleDistance = math.huge
  for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
    local distance = workingVector:sub(lastPlayerPosition, taskObject.coreData.agent.position):length()
    if closestChallengeVehicleDistance > distance then
      closestChallengeVehicleDistance = distance
    end
  end
  return closestChallengeVehicleDistance
end
function spawnRandomActiveChallenge()
  if localPlayer.currentVehicle.gameVehicle.matrix then
    local challenge = availableUnspawnedPlayerPositionBasedMissions[math.random(#availableUnspawnedPlayerPositionBasedMissions)]
    local instance = challengeSystem.createInstance(cardSystem.formattedMissionData[challenge.name], spawnMatrix)
    createMissionWarmupMarker(instance)
    return instance
  end
  return false
end
function addActiveChallenge(instance)
  local indexToRemove, validChallengeTable, spawnedMissionsTable
  if instance.challenge.settings.alwaysActiveChallenge then
    validChallengeTable = availableUnspawnedAlwaysActiveMissions
    spawnedMissionsTable = spawnedAlwaysActiveMissions
  elseif instance.challenge.settings.playerPositionBasedChallenge then
    validChallengeTable = availableUnspawnedPlayerPositionBasedMissions
    spawnedMissionsTable = spawnedPlayerPositionBasedMissions
  end
  if validChallengeTable then
    for index, challenge in next, validChallengeTable, nil do
      if instance.challenge.name == challenge.name then
        table.insert(spawnedMissionsTable, instance.challenge)
        indexToRemove = index
      end
    end
    if indexToRemove then
      table.remove(validChallengeTable, indexToRemove)
    end
  end
end
function removeActiveChallenge(instance)
  local indexToRemove, spawnedMissionsTable
  if instance.challenge.settings.alwaysActiveChallenge then
    spawnedMissionsTable = spawnedAlwaysActiveMissions
  elseif instance.challenge.settings.playerPositionBasedChallenge then
    spawnedMissionsTable = spawnedPlayerPositionBasedMissions
  end
  if spawnedMissionsTable then
    for index, challenge in next, spawnedMissionsTable, nil do
      if instance.challenge.name == challenge.name then
        indexToRemove = index
      end
    end
    if indexToRemove then
      table.remove(spawnedMissionsTable, indexToRemove)
      addMissionToSpawnList(progressionSystem.findMissionInProgression(instance.challenge.name))
    end
  end
end
function triggerMissionAudioPreview(gameVehicle)
  local played = false
  local missionInstance
  for instanceID, instance in next, challengeSystem.instances, nil do
    if instance.startActor and instance.taskObjectsByActorID[instance.startActor] and instance.taskObjectsByActorID[instance.startActor].coreData.agent.gameVehicle == gameVehicle then
      missionInstance = instance
      break
    end
  end
  if missionInstance then
    local missionID = missionInstance.challenge.name
    if challengeProgressionTable[progressionSystem.currentProgression].missions then
      for __, mission in next, challengeProgressionTable[progressionSystem.currentProgression].missions, nil do
        if mission.ID == missionID then
          if mission.previewAudio then
            played = eventFeedback(localPlayer.currentVehicle, mission.previewAudio, nil, "missionCritical")
          end
          break
        end
      end
    end
  end
  return played
end
function update()
  if not gameStatus.simulationPaused and not preventActiveChallenges and not localPlayer.challenge.retryingMission and not progressionSystem.inArtificialChapter and not feedbackSystem.unlockPanelSupport.rewardPanelActive and not progressionSystem.applyingChapterSettings then
    playerTaskObject = localPlayer.missionSupport:getMainTaskObject()
    if playerTaskObject or vehicleManager.previewVehicleManager.previewVehicle then
      local playerInstance
      if playerTaskObject then
        playerInstance = playerTaskObject.instance
      elseif vehicleManager.previewVehicleManager.previewVehicle then
        playerInstance = vehicleManager.previewVehicleManager.previewVehicle:getTaskObject().coreData.instance
      end
      if playerInstance and not missionsRemoved then
        for instanceID, instance in next, challengeSystem.instances, nil do
          if instance ~= playerInstance then
            instance:delete()
          end
        end
        missionsRemoved = true
      end
    elseif localPlayer.primaryFelony.getawayGameVehicle then
      if not missionsRemoved then
        for instanceID, instance in next, challengeSystem.instances, nil do
          instance:delete(nil, true)
        end
        missionsRemoved = true
      end
    else
      if missionsRemoved then
        previousPlayerPositionBasedSpawnCheck = g_NetworkTime
        missionsRemoved = false
      end
      if localPlayer.currentVehicle and not localPlayer.inZap then
        if not previousPlayerPositionBasedSpawnCheck then
          previousPlayerPositionBasedSpawnCheck = g_NetworkTime
        end
        lastPlayerPosition = localPlayer.position
        if #availableUnspawnedPlayerPositionBasedMissions > 0 then
          if g_NetworkTime >= previousPlayerPositionBasedSpawnCheck + playerPositionBasedSpawnInterval then
            local roadIndex = localPlayer.currentVehicle:get_closestRoadIndex()
            if not Atlas.IsRoadAnAlleyway(roadIndex) and not isEventActive() then
              spawnRandomActiveChallenge()
            end
            previousPlayerPositionBasedSpawnCheck = g_NetworkTime
          end
        elseif #spawnedPlayerPositionBasedMissions > 0 then
          cleanupTimer = cleanupTimer + 1
          if cleanupTimer >= cleanupInterval then
            for instanceID, instance in next, challengeSystem.instances, nil do
              local closestChallengeVehicleDistance
              if instance.challenge.settings.playerPositionBasedChallenge then
                closestChallengeVehicleDistance = getClosestChallengeVehicleDistance(instance)
              end
              if closestChallengeVehicleDistance and closestChallengeVehicleDistance > minCleanupDistance then
                instance:delete()
                previousPlayerPositionBasedSpawnCheck = g_NetworkTime
              end
            end
            cleanupTimer = 0
          end
        end
      end
      if #availableUnspawnedAlwaysActiveMissions > 0 then
        local missionsToSpawn = {}
        local indexesToDelete = {}
        for index, challenge in next, availableUnspawnedAlwaysActiveMissions, nil do
          local location = challenge.settings.position
          if not zap.vehicleInLockedArea(location) then
            local createMission = true
            for k, v in next, challengeSystem.instances, nil do
              if challenge.name == v.challenge.name then
                print("-------------- MISSION (" .. challenge.name .. ") ALREADY EXISTS IN WORLD SO REMOVING FROM TABLE OF UNSPAWNED MISSIONS")
                indexesToDelete[#indexesToDelete + 1] = index
                createMission = false
              end
            end
            if createMission then
              missionsToSpawn[#missionsToSpawn + 1] = challenge
            end
          end
        end
        for i = 1, #indexesToDelete do
          table.remove(availableUnspawnedAlwaysActiveMissions, indexesToDelete[i])
        end
        for i = 1, #missionsToSpawn do
          local challenge = missionsToSpawn[i]
          local instance = challengeSystem.createInstance(cardSystem.formattedMissionData[challenge.name])
          createMissionWarmupMarker(instance)
        end
      end
    end
    updateFeedback()
  end
end
