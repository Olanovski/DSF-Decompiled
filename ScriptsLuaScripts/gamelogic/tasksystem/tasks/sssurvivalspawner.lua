local workingVector = vec.vector()
taskSystem.registerTask("Survival Spawner", nil, function(task)
  local sortScore = function(vehicleDataA, vehicleDataB)
    if vehicleDataA.chaserType == vehicleDataB.chaserType then
      return vehicleDataA.score < vehicleDataB.score
    else
      return vehicleDataA.chaserType > vehicleDataB.chaserType
    end
  end
  local function goalCallback(success, condition, completedLap, objID)
    local player = false
    local objTaskObject = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[objID]]
    if math.mod(objID, 2) == 0 then
      player = localPlayerManager.players[0].currentVehicle and localPlayerManager.players[0] or localPlayerManager.players[1]
    else
      player = localPlayerManager.players[1].currentVehicle and localPlayerManager.players[1] or localPlayerManager.players[0]
    end
    if player.currentVehicle and 1 > player.currentVehicle.damage then
      local potentialVehicles = {}
      local vehicleList = {}
      local grabDistance = 80
      local vehicleDistance = 0
      local vehiclePositionDot = 0
      local vehicleHeadingDot = 0
      local distanceScore = 0
      local chaserBehaviourType = 0
      local vehicleScore = 0
      local playerHeading = player.currentVehicle.matrix[2]
      local playerExtrapolatedPosition = player.currentVehicle.position
      playerExtrapolatedPosition.x = playerExtrapolatedPosition.x + playerHeading.x * player.currentVehicle.gameVehicle.speed
      playerExtrapolatedPosition.y = playerExtrapolatedPosition.y + playerHeading.y * player.currentVehicle.gameVehicle.speed
      playerExtrapolatedPosition.z = playerExtrapolatedPosition.z + playerHeading.z * player.currentVehicle.gameVehicle.speed
      repeat
        vehicleList = TrafficSystem.vehicleList(playerExtrapolatedPosition, grabDistance)
        vehicleDistance = 0
        vehiclePositionDot = 0
        vehicleHeadingDot = 0
        distanceScore = 0
        local targetVehicle = vehicleList[1]
        for i, vehicle in next, vehicleList, nil do
          vehicleHeadingDot = playerHeading:dot(vehicle.matrix[2])
          if vehicleHeadingDot < 0 then
            if vehicleHeadingDot < -0.8 then
              chaserBehaviourType = 1
              vehicleDistance = workingVector:sub(vehicle.position, player.currentVehicle.position):length()
              vehiclePositionDot = workingVector:sub(vehicle.position, player.currentVehicle.position):normalise():dot(playerHeading)
              if vehiclePositionDot > 0.8 then
                distanceScore = math.abs(vehicleDistance - 2 * player.currentVehicle.gameVehicle.speed) * 0.025
                vehicleScore = distanceScore - vehiclePositionDot / 2 + vehicleHeadingDot
                table.insert(potentialVehicles, {
                  index = i,
                  score = vehicleScore,
                  chaserType = chaserBehaviourType
                })
              end
            end
          else
            vehicleDistance = workingVector:sub(vehicle.position, player.currentVehicle.position):length()
            if vehicleDistance < task.instance.challenge.settings.maxChaserDistance * 0.9 then
              vehiclePositionDot = workingVector:sub(vehicle.position, player.currentVehicle.position):normalise():dot(playerHeading)
              if vehiclePositionDot < -0.8 and vehicleHeadingDot > 0.7 then
                chaserBehaviourType = 0
                distanceScore = vehicleDistance * 0.025
                vehicleScore = distanceScore + vehiclePositionDot - vehicleHeadingDot
                table.insert(potentialVehicles, {
                  index = i,
                  score = vehicleScore,
                  chaserType = chaserBehaviourType
                })
              elseif vehicleDistance < 30 and vehicleHeadingDot > 0.9 then
                chaserBehaviourType = 3
                distanceScore = math.abs(vehicleDistance - 15) * 0.025
                vehicleScore = distanceScore + vehiclePositionDot - vehicleHeadingDot
                table.insert(potentialVehicles, {
                  index = i,
                  score = vehicleScore,
                  chaserType = chaserBehaviourType
                })
              elseif vehiclePositionDot > 0.5 and vehicleDistance > 20 then
                chaserBehaviourType = 8
                distanceScore = math.abs(vehicleDistance - player.currentVehicle.gameVehicle.speed) * 0.025
                vehicleScore = distanceScore - math.abs(vehiclePositionDot / 2) - vehicleHeadingDot
                table.insert(potentialVehicles, {
                  index = i,
                  score = vehicleScore,
                  chaserType = chaserBehaviourType
                })
              end
            end
          end
        end
        grabDistance = grabDistance + 50
        if grabDistance > task.instance.challenge.settings.maxChaserDistance then
          break
        end
      until #potentialVehicles > 0
      if #potentialVehicles > 0 then
        table.sort(potentialVehicles, sortScore)
        local randomType = framework.random(0, 8)
        local found = false
        for i, chaser in next, potentialVehicles, nil do
          if randomType >= chaser.chaserType then
            found = chaser
            break
          end
        end
        found = found or potentialVehicles[1]
        SNV.CreateSNVFromGV(vehicleList[found.index])
        local scriptVehicle = vehicleManager.takeOwnership({
          gameVehicle = vehicleList[found.index]
        })
        if objTaskObject then
          objTaskObject:delete()
        end
        task.instance:newActorFromAgent(OBJ_TEAM_ONE_STRING_TABLE[objID], scriptVehicle)
        local packageTO = task.instance.taskObjectsByActorID[OBJ_TEAM_TWO_STRING_TABLE[1]]
        local chasers = task.instance.challenge.spawnPositions[task.instance.networkVars.routeIndex].levelData[packageTO.namedTasks.level.networkVars.level].chasers
        NetworkLog.Write(">[LUA] Survival: Swap Model (Spawner) = " .. tostring(scriptVehicle.gameVehicle) .. "  objID = " .. tostring(objID))
        GameVehicleResource.swapWithModel(scriptVehicle.gameVehicle, chasers[objID])
        cardSystem.logic.survivalSwapStatus[objID] = {
          vehicle = scriptVehicle.gameVehicle,
          callback = false
        }
        scriptVehicle:set_damageMultiplier(survivalAI.chaserDamageMultiplier[packageTO.namedTasks.level.networkVars.level])
        scriptVehicle:disableMinimapMarker(true)
        selfRightVehicleList.addTableOfVehicles({
          scriptVehicle.gameVehicle
        })
        scriptVehicle.gameVehicle.performance = 1.25
        ZapAIPresence.StartTransition(nil, scriptVehicle.gameVehicle, objID - 1)
        local taskObject = task.instance.taskObjectsByActorID[OBJ_TEAM_ONE_STRING_TABLE[objID]]
        taskObject.swapComplete = false
        taskObject.engageBehaviour = 1
        taskObject.namedTasks.chase.AIUpdate()
        if found.chaserType == 1 then
          taskObject.engageBehaviour = 0
        end
        if found.chaserType >= 4 then
          taskObject.engageBehaviour = framework.random(2, 5)
        end
      elseif objTaskObject then
        objTaskObject:delete()
      end
      potentialVehicles, vehicleList = nil, nil
    elseif objTaskObject then
      objTaskObject:delete()
    end
  end
  return goalCallback
end)
