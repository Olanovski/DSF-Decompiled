module("challengeSystem", package.seeall)
startups = {}
warmups = {}
countDowns = {}
challenges = {}
shutDowns = {}
instances = {}
local onlineGameSession
function initialise()
  onlineGameSession = Network.isOnlineGame() or Network.isSplitScreenMode()
end
addInitObject(initialise)
function registerStartup(startupName, defaultVars, startupFunction)
  assert(not startups[startupName], "CHALLENGESYSTEM - registerStartup: Attempt to re-register existing start: " .. tostring(startupName))
  startups[startupName] = {initiate = startupFunction, defaultVars = defaultVars}
end
function registerWarmup(warmupName, defaultVars, statusFunction)
  assert(not warmups[warmupName], "CHALLENGESYSTEM - registerWarmup: Attempt to re-register existing warmup: " .. tostring(warmupName))
  warmups[warmupName] = {createStatusCheck = statusFunction, defaultVars = defaultVars}
end
function registerCountDown(countDownName, defaultVars, taskList, statusFunction)
  assert(not countDowns[countDownName], "CHALLENGESYSTEM - registerCountDown: Attempt to re-register existing countdown: " .. tostring(countDownName))
  countDowns[countDownName] = {
    createStatusCheck = statusFunction,
    defaultVars = defaultVars,
    taskList = taskList
  }
end
function registerShutDown(shutDownName, defaultVars, statusFunction)
  assert(not shutDowns[shutDownName], "CHALLENGESYSTEM - registerShutDown: Attempt to re-register existing shutdown: " .. tostring(shutDownName))
  shutDowns[shutDownName] = {createStatusCheck = statusFunction, defaultVars = defaultVars}
end
local assignDefaultVars = function(inputTable, defaultTable)
  if inputTable.settings then
    if defaultTable.defaultVars then
      for varName, varValue in next, defaultTable.defaultVars, nil do
        if inputTable.settings[varName] == nil then
          inputTable.settings[varName] = varValue
        end
      end
    end
  else
    inputTable.settings = defaultTable.defaultVars or {}
  end
end
function registerChallenge(challengeName, createFunction)
  assert(not challenges[tostring(challengeName)], "CHALLENGESYSTEM - registerChallenge: Attempt to re-register existing challenge: " .. tostring(challengeName))
  local challenge = {
    ID = #challenges + 1,
    name = tostring(challengeName),
    create = createFunction
  }
  challenges[challenge.name] = challenge
  challenges[challenge.ID] = challenge
end
function update()
  for instanceID, instance in next, instances, nil do
    if not gameStatus.onlineSession then
      if instance.syncedPhase ~= instance.networkVars.phase then
        instance:phaseSync()
      end
      if instance.syncedPhase == instance.networkVars.phase then
        if instance.syncedPhase < CreateFaceOffStateIndex then
          if instance.syncedPhase >= WaitingForPlayersStateIndex and instance.update then
            instance:update()
          end
        else
          instance:updateResetPhase()
        end
        if instance.isLocal then
          if instance.syncedPhase == ChooseFaceOffStateIndex then
            if instance.shutDownCheck() then
              instance:endMission()
            end
          elseif instance.syncedPhase == HighLevelZapStateIndex then
            if not instance.countDownCheck or instance.countDownCheck() then
              instance:initiateChallengePhase()
            end
          elseif instance.syncedPhase == GlobalStateIndex then
            for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
              if not taskObject.coreData.actor.warmup or taskObject.coreData.actor.warmup.conditionCheck and taskObject.coreData.actor.warmup.conditionCheck() then
                instance:initiateCountdownPhase()
              end
            end
          end
        end
        if instance.isLocal ~= true and instance.syncedPhase == WaitingForPlayersStateIndex and instance.remoteInitialised == false then
          instance:initiateChallengePhaseRemote()
        end
      end
    end
    if onlineGameSession and instance.isLocal and instance.instanceID then
      updateSNOFromObject(instance)
    end
  end
end
function discardAll()
  print("DISCARDING ALL CHALLENGES TO OTHER PLAYERS")
  for instanceID, instance in next, instances, nil do
    instance:discard()
  end
end
function purge()
  for instanceID, instance in next, instances, nil do
    instance:delete(true)
  end
  instances = {}
end
function endAllInstanceWhenYouCan()
  for instanceID, instance in next, instances, nil do
    if instance.isLocal then
      instance:endInstanceWhenYouCan()
    end
  end
end
local returnValue
function stepAllInstanceDeletion()
  returnValue = true
  for instanceID, instance in next, instances, nil do
    instance:stepInstanceDeletion()
    returnValue = false
  end
  return returnValue
end
local returnValue
function markAllForDeletion()
  returnValue = true
  for instanceID, instance in next, instances, nil do
    if not instance.networkVars.flagForDeletion then
      if instance.isLocal then
        instance.networkVars.flagForDeletion = true
      end
      instance.instanceEnding = true
      returnValue = false
    end
  end
  return returnValue
end
function allObjectsDeleted()
  for instanceID, instance in next, instances, nil do
    return false
  end
  return true
end
function removeFlaggedForDeletionObjects()
  for instanceID, instance in next, instances, nil do
    if instance.isLocal and instance.networkVars.flagForDeletion then
      instance:endInstanceWhenYouCan()
    end
  end
end
