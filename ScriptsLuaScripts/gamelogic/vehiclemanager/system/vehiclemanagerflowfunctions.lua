module("vehicleManager", package.seeall)
local testOrder = {
  [1] = "discardIfConditionsNotMet",
  [2] = "heightCheck",
  [3] = "sameRoad",
  [4] = "ahead",
  [5] = "sameDirection",
  [6] = "proximity",
  [7] = "inLane"
}
function findVehiclesInTraffic(position, vectorHeading, radius, vehicleSearchParameters, maxQuantityToReturn)
  local workingVector = vec.vector()
  local selectionPosition = position
  local selectionRadius = radius or 100
  local gameVehicleList = GameVehicleResource.vehiclesInArea({center = selectionPosition, radius = selectionRadius})
  for i = 1, #gameVehicleList do
    gameVehicleList[i] = {
      gameVehicle = gameVehicleList[i]
    }
  end
  if vehicleSearchParameters.drawDebug then
    Development:addGraphics(-15194, "disc", vec.vector(1, 0, 0, 1), selectionPosition, vec.vector(1, 0, 0, 0), vec.vector(5, 0.5, 5, 0), -1)
  end
  for i, vehicleData in ripairs(gameVehicleList) do
    if vehicleData.gameVehicle.parentVehicle or not vehicleData.gameVehicle.isValid then
      table.remove(gameVehicleList, i)
    end
  end
  if vehicleSearchParameters then
    local maxQuantityToReturn = maxQuantityToReturn or 16
    local instanceHeading = false
    if vehicleSearchParameters.scoring and vehicleSearchParameters.scoring.ahead then
      instanceHeading = vectorHeading
    end
    local roadIndex = false
    if vehicleSearchParameters.scoring and vehicleSearchParameters.scoring.sameRoad then
      local road, distanceAlong = Atlas.ClosestRoadIndexAndDistanceAlong(selectionPosition)
      if distanceAlong > 0 and distanceAlong < Atlas.RoadLength(road) then
        roadIndex = road
      else
        vehicleSearchParameters.scoring.sameRoad = nil
      end
    end
    local vehicleData, currentGameVehicle, currentGameVehiclePosition
    for i = 1, #gameVehicleList do
      vehicleData = gameVehicleList[i]
      currentGameVehicle = vehicleData.gameVehicle
      local score = false
      if not vehicleData.ignoreVehicle and vehicleSearchParameters.ignoreSciptOwnedVehicles and currentGameVehicle.owner == "Script" then
        vehicleData.ignoreVehicle = true
      end
      if not vehicleData.ignoreVehicle and vehicleSearchParameters.ignoreOrphans and currentGameVehicle.owner == "Orphan" then
        vehicleData.ignoreVehicle = true
      end
      if not vehicleData.ignoreVehicle and vehicleSearchParameters.ignoreCops and currentGameVehicle.owner == "PatrolSpawnManager" then
        vehicleData.ignoreVehicle = true
      end
      if not vehicleData.ignoreVehicle and vehicleSearchParameters.ignoreThrown and currentGameVehicle.owner == "VehicleLauncher" then
        vehicleData.ignoreVehicle = true
      end
      if not vehicleData.ignoreVehicle and vehicleSearchParameters.ignoreSwappingVehicles and zapcontroller.IsSwappingVehicle(0, currentGameVehicle) then
        vehicleData.ignoreVehicle = true
      end
      if not vehicleData.ignoreVehicle and vehicleSearchParameters.modelID then
        if type(vehicleSearchParameters.modelID) == "table" then
          for key, modelID in next, vehicleSearchParameters.modelID, nil do
            vehicleData.ignoreVehicle = true
            if currentGameVehicle.model_id == modelID then
              vehicleData.ignoreVehicle = false
              break
            end
          end
        elseif currentGameVehicle.model_id ~= vehicleSearchParameters.modelID then
          vehicleData.ignoreVehicle = true
        end
      end
      if not vehicleData.ignoreVehicle and vehicleSearchParameters.avoidModelID then
        if type(vehicleSearchParameters.avoidModelID) == "table" then
          for key, modelID in next, vehicleSearchParameters.avoidModelID, nil do
            if currentGameVehicle.model_id == modelID then
              vehicleData.ignoreVehicle = true
              break
            end
          end
        elseif currentGameVehicle.model_id == vehicleSearchParameters.avoidModelID then
          vehicleData.ignoreVehicle = true
        end
      end
      if not vehicleData.ignoreVehicle and vehicleSearchParameters.idealDistance then
        local idealDistance = vehicleSearchParameters.idealDistance or 10
        local distance = workingVector:sub(currentGameVehicle.transform[3], selectionPosition):length() - idealDistance
        if distance < 0 then
          vehicleData.ignoreVehicle = true
        end
      end
      if not vehicleData.ignoreVehicle then
        currentGameVehiclePosition = currentGameVehicle.position
        if vehicleSearchParameters.drawDebug then
          Development:addGraphics(-14195 + vehicleData.gameVehicle.uid, "box", vec.vector(1, 0, 1, 1), vehicleData.gameVehicle.position, vec.vector(1, 0, 0, 0), vec.vector(1, 2, 1, 0), -1)
        end
        if vehicleSearchParameters.scoring then
          if vehicleSearchParameters.print then
            vehicleData.scoreTable = {}
          end
          score = score or 0
          for i = 1, #testOrder do
            local scoringCriteria = testOrder[i]
            local value = vehicleSearchParameters.scoring[scoringCriteria]
            if value and not vehicleData.ignoreVehicle then
              if scoringCriteria == "sameRoad" then
                local closestRoadIndex = Atlas.ClosestRoadIndexAndDistanceAlong(currentGameVehiclePosition)
                if value.condition == true and closestRoadIndex == roadIndex or value.condition == false and closestRoadIndex ~= roadIndex then
                  local increment = 1.25
                  score = score + increment
                  if vehicleSearchParameters.print then
                    vehicleData.scoreTable.sameRoad = increment
                  end
                  if vehicleSearchParameters.drawDebug then
                    Development:addGraphics(-20196 + vehicleData.gameVehicle.uid, "box", vec.vector(0, 0, 1, 1), vehicleData.gameVehicle.position, vec.vector(1, 0, 0, 0), vec.vector(2.5, 1, 2.5, 0), -1)
                  end
                elseif value.discard then
                  vehicleData.ignoreVehicle = true
                end
              elseif scoringCriteria == "ahead" then
                local angleComparison = instanceHeading:dot(workingVector:sub(currentGameVehiclePosition, selectionPosition):normalise())
                if value.condition == true and angleComparison > 0.1 or value.condition == false and angleComparison < -0.1 then
                  local increment = 1
                  score = score + increment
                  if vehicleSearchParameters.print then
                    vehicleData.scoreTable.ahead = increment
                  end
                elseif value.discard then
                  vehicleData.ignoreVehicle = true
                end
              elseif scoringCriteria == "sameDirection" then
                local angleComparison = instanceHeading:dot(currentGameVehicle.transform[2])
                if value.condition == true and angleComparison > 0.75 or value.condition == false and angleComparison < -0.75 then
                  local increment = 1.1
                  score = score + increment
                  if vehicleSearchParameters.print then
                    vehicleData.scoreTable.sameDirection = increment
                  end
                elseif value.discard then
                  vehicleData.ignoreVehicle = true
                end
              elseif scoringCriteria == "proximity" and value then
                local increment = 1 - workingVector:sub(currentGameVehicle.transform[3], selectionPosition):length() / selectionRadius
                score = score + increment
                if vehicleSearchParameters.print then
                  vehicleData.scoreTable.proximity = increment
                end
              elseif scoringCriteria == "discardIfConditionsNotMet" then
                if value.discardModelIDs and value.speed then
                  local speedInMPS = value.speed * 0.447
                  if (not value.condition or not (speedInMPS < localPlayer.currentVehicle.speed)) and (value.condition or not (speedInMPS > localPlayer.currentVehicle.speed)) then
                    for i = 1, #value.discardModelIDs do
                      if currentGameVehicle.model_id == value.discardModelIDs[i] then
                        vehicleData.ignoreVehicle = true
                      end
                    end
                  end
                end
              elseif scoringCriteria == "heightDifference" then
                local heightDifference = selectionPosition.y - currentGameVehiclePosition.y
                if (heightDifference > value.difference or heightDifference < -value.difference) and value.discard then
                  vehicleData.ignoreVehicle = true
                end
              elseif scoringCriteria == "inLane" then
                local invalidLane = 255
                local lane, totalNumberOfLanes = GameVehicleResource.getLane(currentGameVehicle)
                if lane ~= invalidLane then
                  local insideLane = totalNumberOfLanes
                  if value.lane == "outside" and lane == 0 or value.lane == "inside" and lane == insideLane or value.lane == "middle" and (lane ~= 0 or lane ~= insideLane) then
                    local increment = 1
                    score = score + increment
                    if vehicleSearchParameters.print then
                      vehicleData.scoreTable.lane = increment
                    end
                  elseif value.discard then
                    vehicleData.ignoreVehicle = true
                  end
                elseif value.discard then
                  vehicleData.ignoreVehicle = true
                end
              end
              if vehicleData.ignoreVehicle then
                vehicleData.scoreTable = nil
              else
                vehicleData.score = score
              end
            end
          end
        end
      end
    end
    for i, vehicleData in ripairs(gameVehicleList) do
      if vehicleData.ignoreVehicle then
        table.remove(gameVehicleList, i)
      end
    end
    if vehicleSearchParameters.scoring then
      table.sort(gameVehicleList, function(v1, v2)
        return v2.score < v1.score
      end)
      if vehicleSearchParameters.print then
        for i = 1, #gameVehicleList do
          print(i)
          printTable(gameVehicleList[i].scoreTable)
        end
      end
    end
    for i = 1, #gameVehicleList do
      if i > maxQuantityToReturn then
        gameVehicleList[i] = nil
      else
        gameVehicleList[i] = gameVehicleList[i].gameVehicle
      end
    end
    return gameVehicleList
  else
    return gameVehicleList
  end
end
