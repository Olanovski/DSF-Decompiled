taskSystem.registerTask("Survival Level Tracker", {
  {
    name = "level",
    startingValue = 1,
    parseType = "integer32"
  }
}, function(task)
  local lastLevel = 1
  local nextVehicleID = 0
  local lastDestination = false
  local nextStartLocation = false
  local nextStartHeading = false
  local workingVector = vec.vector()
  local spawnedPlayerVehicle = false
  local numCheckpoints = 0
  local playerTO = false
  local maxLevel = #task.instance.challenge.spawnPositions[task.instance.networkVars.routeIndex].levelData
  local function goalCallback(success, condition, completedLap, goalData)
    lastLevel = task.networkVars.level
    task.networkVars.level = task.networkVars.level + 1
    if task.networkVars.level <= maxLevel then
      numCheckpoints = #task.instance.challenge.spawnPositions[task.instance.networkVars.routeIndex].levelData[lastLevel].route
      lastDestination = task.instance.challenge.spawnPositions[task.instance.networkVars.routeIndex].levelData[lastLevel].route[numCheckpoints].position
      nextStartLocation = task.instance.challenge.spawnPositions[task.instance.networkVars.routeIndex].levelData[task.networkVars.level].startLocation
      nextStartHeading = task.instance.challenge.spawnPositions[task.instance.networkVars.routeIndex].levelData[task.networkVars.level].startHeading
      nextVehicleID = task.instance.challenge.spawnPositions[task.instance.networkVars.routeIndex].levelData[task.networkVars.level].playerVehicles.vehicleID
      newVehicle = false
      for localID, player in next, localPlayerManager.players, nil do
        playerTO = player.getTaskObject()
        if playerTO and playerTO.namedTasks.checkpoints then
          playerTO.namedTasks.checkpoints.networkVars.checkpoints = 0
        end
        if player.inZap or not GameVehicleResource.withinRadius(player.currentVehicle.position, lastDestination, task.instance.challenge.settings.respawnDistanceFromGate) then
          assert(not spawnedPlayerVehicle, "Already spawned a vehicle")
          spawnedPlayerVehicle = true
          newVehicle = vehicleManager.spawnVehicle({
            position = nextStartLocation,
            modelID = nextVehicleID,
            heading = nextStartHeading,
            shader = {
              [0] = 0
            }
          })
          newVehicle:set_damageMultiplier(survivalAI.playerDamageMultiplier[task.networkVars.level])
          newVehicle.networkVars.onlineRequiredVehicle = true
          if not player.inZap then
            player:SetZapLevel(1)
          else
            assert(localPlayerManager.players[math.abs(localID - 1)].currentVehicle, "On level up a player is not in a vehicle")
            zapcontroller.setZapActionTrackVehicle(true, localPlayerManager.players[math.abs(localID - 1)].currentVehicle.gameVehicle, localID, true)
          end
          player:zapToAgent(newVehicle)
          localPlayerManager.players[localID].zapToNewVehicle = true
          scoreSystem.maxAbility(localID)
        else
          zap.zapSwap.carSwapTriggered(player, nextVehicleID)
          NetworkLog.Write(">[LUA] Survival: Swap Model (Tracker)(Player) = " .. tostring(player.currentVehicle.gameVehicle) .. "  id = " .. tostring(localID))
          player.currentVehicle:set_damageMultiplier(survivalAI.playerDamageMultiplier[task.networkVars.level])
          player.currentVehicle.gameVehicle.damage = 0
        end
      end
      spawnedPlayerVehicle = false
      local chasers = task.instance.challenge.spawnPositions[task.instance.networkVars.routeIndex].levelData[task.networkVars.level].chasers
      local chaserTO = false
      local chaserTarget = false
      local behaviour = false
      for i = 1, 8 do
        chaserTO = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[i]]
        if chaserTO and chaserTO.coreData.agent then
          if math.mod(i, 2) == 0 then
            chaserTarget = localPlayerManager.players[0].currentVehicle
          else
            chaserTarget = localPlayerManager.players[1].currentVehicle
          end
          if chaserTarget then
            if cardSystem.logic.survivalSwapStatus[i] then
              cardSystem.logic.survivalSwapQueue[i] = {
                vehicle = chaserTO.coreData.agent.gameVehicle,
                callback = function(vehicle, level)
                  NetworkLog.Write(">[LUA] Survival: Swap Complete Callback: vehicle = " .. tostring(vehicle) .. " level = " .. tostring(level))
                  local vehicleTO = vehicle:getTaskObject()
                  if vehicleTO then
                    vehicle:set_damageMultiplier(survivalAI.chaserDamageMultiplier[level])
                    local behaviour = {
                      traits = survivalAI.AITraits[level]
                    }
                    behaviour.opponentGameVehicle = vehicleTO.namedTasks.chase.dynamicTargets[1].gameVehicle
                    vehicle:highSpeedDrive(behaviour)
                  end
                end
              }
              NetworkLog.Write(">[LUA] Survival: Queue Model (Tracker)(Cop) = " .. tostring(chaserTO.coreData.agent.gameVehicle) .. "  objID = " .. tostring(i))
            else
              cardSystem.logic.survivalSwapStatus[i] = true
              NetworkLog.Write(">[LUA] Survival: Swap Model (Tracker)(Cop) = " .. tostring(chaserTO.coreData.agent.gameVehicle) .. "  objID = " .. tostring(i))
              GameVehicleResource.swapWithModel(chaserTO.coreData.agent.gameVehicle, chasers[i])
              chaserTO.coreData.agent:set_damageMultiplier(survivalAI.chaserDamageMultiplier[task.networkVars.level])
              behaviour = {
                traits = survivalAI.AITraits[task.networkVars.level]
              }
              behaviour.opponentGameVehicle = chaserTO.namedTasks.chase.dynamicTargets[1].gameVehicle
              chaserTO.coreData.agent:highSpeedDrive(behaviour)
              cardSystem.logic.survivalSwapStatus[i] = {
                vehicle = chaserTO.coreData.agent.gameVehicle,
                callback = false
              }
            end
          else
            chaserTO:delete()
          end
        end
      end
    end
  end
  return goalCallback
end)
