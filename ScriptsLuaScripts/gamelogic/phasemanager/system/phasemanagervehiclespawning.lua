module("phaseManager", package.seeall)
vehicleRemovalFinished = false
function removeGrid()
  vehicleRemovalFinished = true
  for SNVID, vehicle in next, vehicleManager.vehiclesBySNVID, nil do
    if vehicle.networkVars.onlineRequiredVehicle then
      vehicleManager.callForDeletion(SNVID)
      vehicleRemovalFinished = false
    end
  end
end
function stepGridRemoval()
  vehicleRemovalFinished = true
  for SNVID, vehicle in next, vehicleManager.vehiclesBySNVID, nil do
    if vehicle.isLocal and vehicle.networkVars.onlineRequiredVehicle and vehicle:canBeDeleted() then
      vehicle:delete()
      vehicleRemovalFinished = false
    end
  end
end
local turnTrackTable = {}
function findNextTurnTaker()
  assert(networkVars.modeID, "PHASE MANAGER CORE, no mode to setup turn taking for")
  local instance = challengeSystem.instances[networkVars.modeID]
  for playerID, player in next, playerManager.players, nil do
    if instance.turnTracking[playerID + 1] == 0 then
      table.insert(turnTrackTable, playerID)
    end
  end
  if #turnTrackTable == 0 then
    networkVars.nextTurnTaker = 255
  else
    networkVars.nextTurnTaker = turnTrackTable[framework.random(1, #turnTrackTable)]
  end
  turnTrackTable = {}
end
local assignGrid = function(style, gridSortStyle)
  if style == 1 then
    local playersInOrder = onlineScreenManager.getScreenCurrentPlayerTable(gridSortStyle)
    local validPlayers = 0
    for i, player in ipairs(playersInOrder) do
      if player then
        validPlayers = validPlayers + 1
      else
        break
      end
    end
    assert(validPlayers == playerManager.numberOfPlayers, "Warning - Sort Grid will fail as number of players in the player screen table does not match player manager table")
    local vehicleNum = 9
    for i, player in ipairs(playersInOrder) do
      if player then
        local vehicle = vehicleManager.vehiclesBySNVID[vehicleGrid[vehicleNum]]
        vehicle.networkVars.onlineOwnerID = player.id
        vehicleGrid[player.id + 1] = vehicle.SNVID
        vehicleNum = vehicleNum + 1
      else
        break
      end
    end
  elseif style == 2 then
    local teamOneInOrder = {}
    local teamTwoInOrder = {}
    local playersInOrder = onlineScreenManager.getScreenCurrentPlayerTable(gridSortStyle)
    local validPlayers = 0
    for i, player in ipairs(playersInOrder) do
      if player then
        validPlayers = validPlayers + 1
      else
        break
      end
    end
    assert(validPlayers == playerManager.numberOfPlayers, "Warning - Sort Grid will fail as number of players in the player screen table does not match player manager table")
    for i, player in ipairs(playersInOrder) do
      if player then
        if PlayerGamePlay.getPlayerTeam(player.id) == 1 then
          table.insert(teamOneInOrder, player)
        elseif PlayerGamePlay.getPlayerTeam(player.id) == 2 then
          table.insert(teamTwoInOrder, player)
        else
          assert(false, "PHASE MANAGER, Player has no team")
        end
      else
        break
      end
    end
    if #teamOneInOrder > 4 or #teamTwoInOrder > 4 then
      for playerID, player in next, playerManager.players, nil do
        NetworkLog.Write(">[LUA] PHASE MANAGER - playerID = " .. tostring(playerID) .. ", team = " .. tostring(PlayerGamePlay.getPlayerTeam(playerID)))
      end
      assert(false, "MORE THAN 4 PLAYERS IN A TEAM IS NOT SUPPORTED!")
    end
    local vehicleNum = 9
    for index, player in ipairs(teamOneInOrder) do
      local vehicle = vehicleManager.vehiclesBySNVID[vehicleGrid[vehicleNum]]
      vehicle.networkVars.onlineOwnerID = player.id
      vehicleGrid[player.id + 1] = vehicle.SNVID
      vehicleNum = vehicleNum + 2
    end
    local vehicleNum = 10
    for index, player in ipairs(teamTwoInOrder) do
      local vehicle = vehicleManager.vehiclesBySNVID[vehicleGrid[vehicleNum]]
      vehicle.networkVars.onlineOwnerID = player.id
      vehicleGrid[player.id + 1] = vehicle.SNVID
      vehicleNum = vehicleNum + 2
    end
  elseif style == 4 then
    findNextTurnTaker()
    local playersInOrder = onlineScreenManager.getScreenCurrentPlayerTable(gridSortStyle)
    local validPlayers = 0
    for i, player in ipairs(playersInOrder) do
      if player then
        validPlayers = validPlayers + 1
      else
        break
      end
    end
    assert(validPlayers == playerManager.numberOfPlayers, "Warning - Sort Grid will fail as number of players in the player screen table does not match player manager table")
    local vehicleNum = 10
    for i, player in ipairs(playersInOrder) do
      if player then
        local vehicle
        if player.id == networkVars.nextTurnTaker then
          local vehicle = vehicleManager.vehiclesBySNVID[vehicleGrid[9]]
          vehicle.networkVars.onlineOwnerID = player.id
          vehicleGrid[player.id + 1] = vehicle.SNVID
        else
          local vehicle = vehicleManager.vehiclesBySNVID[vehicleGrid[vehicleNum]]
          vehicle.networkVars.onlineOwnerID = player.id
          vehicleGrid[player.id + 1] = vehicle.SNVID
          vehicleNum = vehicleNum + 1
        end
      else
        break
      end
    end
    if networkVars.nextTurnTaker == 255 then
      local vehicle = vehicleManager.vehiclesBySNVID[vehicleGrid[9]]
      vehicle.networkVars.onlineOwnerID = 254
    end
  elseif style == 5 then
    local vehicle = vehicleManager.vehiclesBySNVID[vehicleGrid[9]]
    vehicle.networkVars.onlineOwnerID = localPlayerManager.players[0].playerID
    vehicleGrid[localPlayerManager.players[0].playerID + 1] = vehicle.SNVID
    vehicle = vehicleManager.vehiclesBySNVID[vehicleGrid[10]]
    vehicle.networkVars.onlineOwnerID = localPlayerManager.players[1].playerID
    vehicleGrid[localPlayerManager.players[1].playerID + 1] = vehicle.SNVID
  elseif faceOffNext() and style == 3 then
    local playersInOrder = onlineScreenManager.getScreenCurrentPlayerTable(gridSortStyle)
    local vehicle, vehicleNum
    for i, player in ipairs(playersInOrder) do
      if player then
        if i == 1 then
          vehicleNum = 9
        elseif i == 2 then
          vehicleNum = 13
        elseif i == 3 then
          vehicleNum = 10
        elseif i == 4 then
          vehicleNum = 14
        elseif i == 5 then
          vehicleNum = 11
        elseif i == 6 then
          vehicleNum = 15
        elseif i == 7 then
          vehicleNum = 12
        elseif i == 8 then
          vehicleNum = 16
        end
        vehicle = vehicleManager.vehiclesBySNVID[vehicleGrid[vehicleNum]]
        assert(vehicle.networkVars.onlineOwnerID == 255, "QUAD GRID VEHICLE ASSIGNMENT HAS GONE WRONG!")
        vehicle.networkVars.onlineOwnerID = player.id
        vehicleGrid[player.id + 1] = vehicle.SNVID
      else
        break
      end
    end
  elseif style == 3 then
    local teamOneInOrder = {}
    local teamTwoInOrder = {}
    local playersInOrder = onlineScreenManager.getScreenCurrentPlayerTable(gridSortStyle)
    local validPlayers = 0
    for i, player in ipairs(playersInOrder) do
      if player then
        validPlayers = validPlayers + 1
      else
        break
      end
    end
    assert(validPlayers == playerManager.numberOfPlayers, "Warning - Sort Grid will fail as number of players in the player screen table does not match player manager table")
    if networkVars.modeID and challengeSystem.instances[networkVars.modeID] and challengeSystem.instances[networkVars.modeID].challenge.settings.swapGrid then
      for i, player in ipairs(playersInOrder) do
        if player then
          if PlayerGamePlay.getPlayerTeam(player.id) == challengeSystem.instances[networkVars.modeID].networkVars.roundOn then
            table.insert(teamOneInOrder, player)
          else
            table.insert(teamTwoInOrder, player)
          end
        else
          break
        end
      end
    else
      for i, player in ipairs(playersInOrder) do
        if player then
          if PlayerGamePlay.getPlayerTeam(player.id) == 1 then
            table.insert(teamOneInOrder, player)
          elseif PlayerGamePlay.getPlayerTeam(player.id) == 2 then
            table.insert(teamTwoInOrder, player)
          else
            assert(false, "PHASE MANAGER, Player has no team")
          end
        else
          break
        end
      end
    end
    if #teamOneInOrder > 4 or #teamTwoInOrder > 4 then
      for playerID, player in next, playerManager.players, nil do
        NetworkLog.Write(">[LUA] PHASE MANAGER - playerID = " .. tostring(playerID) .. ", team = " .. tostring(PlayerGamePlay.getPlayerTeam(playerID)))
      end
      assert(false, "MORE THAN 4 PLAYERS IN A TEAM IS NOT SUPPORTED!")
    end
    local vehicleNum = 9
    for index, player in ipairs(teamOneInOrder) do
      local vehicle = vehicleManager.vehiclesBySNVID[vehicleGrid[vehicleNum]]
      vehicle.networkVars.onlineOwnerID = player.id
      vehicleGrid[player.id + 1] = vehicle.SNVID
      vehicleNum = vehicleNum + 1
    end
    vehicleNum = 13
    for index, player in ipairs(teamTwoInOrder) do
      local vehicle = vehicleManager.vehiclesBySNVID[vehicleGrid[vehicleNum]]
      vehicle.networkVars.onlineOwnerID = player.id
      vehicleGrid[player.id + 1] = vehicle.SNVID
      vehicleNum = vehicleNum + 1
    end
  elseif style == 6 then
    local playersInOrder = onlineScreenManager.getScreenCurrentPlayerTable(gridSortStyle)
    local vehicle, vehicleNum
    for i, player in ipairs(playersInOrder) do
      if player then
        if i == 1 then
          vehicleNum = 9
        elseif i == 2 then
          vehicleNum = 11
        elseif i == 3 then
          vehicleNum = 13
        elseif i == 4 then
          vehicleNum = 15
        elseif i == 5 then
          vehicleNum = 10
        elseif i == 6 then
          vehicleNum = 12
        elseif i == 7 then
          vehicleNum = 14
        elseif i == 8 then
          vehicleNum = 16
        end
        vehicle = vehicleManager.vehiclesBySNVID[vehicleGrid[vehicleNum]]
        assert(vehicle.networkVars.onlineOwnerID == 255, "QUAD GRID VEHICLE ASSIGNMENT HAS GONE WRONG!")
        vehicle.networkVars.onlineOwnerID = player.id
        vehicleGrid[player.id + 1] = vehicle.SNVID
      else
        break
      end
    end
  end
  if not devTestAll8Vehicles then
    for SNVID, vehicle in next, vehicleManager.vehiclesBySNVID, nil do
      if vehicle.networkVars.onlineOwnerID ~= nil and vehicle.networkVars.onlineOwnerID == 255 then
        for i = 9, 16 do
          if vehicleGrid[i] == SNVID then
            vehicleGrid[i] = 0
            break
          end
        end
        vehicle:delete()
      elseif vehicle.networkVars.onlineOwnerID ~= nil and vehicle.networkVars.onlineOwnerID ~= localPlayer.playerID then
        zapcontroller.AddLockedVehicle({
          gameVehicle = vehicle.gameVehicle
        })
      end
    end
  end
  if challengeSystem.instances[networkVars.modeID] and challengeSystem.instances[networkVars.modeID].assignTaskObjects then
    challengeSystem.instances[networkVars.modeID].assignTaskObjects(challengeSystem.instances[networkVars.modeID])
  end
  networkParsing.writeBuffer(SNO, SNOID, 3, vehicleGridBuffer, vehicleGrid)
end
local eightVehicles = {
  [1] = {modelID = false, shaderParams = false},
  [2] = {modelID = false, shaderParams = false},
  [3] = {modelID = false, shaderParams = false},
  [4] = {modelID = false, shaderParams = false},
  [5] = {modelID = false, shaderParams = false},
  [6] = {modelID = false, shaderParams = false},
  [7] = {modelID = false, shaderParams = false},
  [8] = {modelID = false, shaderParams = false}
}
function spawnGrid(style, gridStagger, gridWidth, vehicleTypes, positions, headings, gridSortStyle)
  assert(isLocal and (style == 1 or style == 2) or style == 3 or style == 4 or style == 5 or style == 6, "PHASE MANAGER CORE, invalid grid style or not local")
  vehicleGrid = {
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 0,
    [5] = 0,
    [6] = 0,
    [7] = 0,
    [8] = 0,
    [9] = 0,
    [10] = 0,
    [11] = 0,
    [12] = 0,
    [13] = 0,
    [14] = 0,
    [15] = 0,
    [16] = 0
  }
  if style == 5 then
    local vehicles = {
      [1] = {
        modelID = vehicleTypes.vehicleTypeA.vehicleID,
        shaderParams = vehicleTypes.vehicleTypeA.shader
      },
      [2] = {
        modelID = vehicleTypes.vehicleTypeB.vehicleID,
        shaderParams = vehicleTypes.vehicleTypeB.shader
      }
    }
    local spawnData = {
      type = "Grid",
      position = positions.positionA,
      gridSpacing = gridWidth,
      vehicles = vehicles,
      heading = headings.headingA,
      gridMaxVehicles = 2,
      staggeredGridSpacing = gridStagger
    }
    local gridOne = Spawn.Spawn(spawnData)
    for index, gameVehicle in ipairs(gridOne) do
      local vehicle = vehicleManager.takeOwnership({
        gameVehicle = gridOne[index]
      })
      vehicle.networkVars.onlineRequiredVehicle = true
      vehicle.networkVars.onlineOwnerID = 255
      vehicleGrid[index + 8] = vehicle.SNVID
    end
  elseif style == 1 or style == 2 then
    local randomOffset = framework.random(0, 7)
    for i = 1, 8 do
      eightVehicles[i].modelID = vehicleTypes.vehicleTypeA.vehicleID
      eightVehicles[i].shaderParams = {
        [0] = vehicleTypes.vehicleTypeA.shader[0]
      }
      if eightVehicles[i].shaderParams[0] == -1 then
        eightVehicles[i].shaderParams[0] = i - 1 + randomOffset
      end
    end
    local spawnData = {
      type = "Grid",
      position = positions.positionA,
      gridSpacing = gridWidth,
      vehicles = eightVehicles,
      heading = headings.headingA,
      gridMaxVehicles = 8,
      staggeredGridSpacing = gridStagger
    }
    local gridOne = Spawn.Spawn(spawnData)
    for index, gameVehicle in ipairs(gridOne) do
      local vehicle = vehicleManager.takeOwnership({
        gameVehicle = gridOne[index]
      })
      vehicle.networkVars.onlineRequiredVehicle = true
      vehicle.networkVars.onlineOwnerID = 255
      vehicleGrid[index + 8] = vehicle.SNVID
    end
  elseif style == 3 or style == 4 then
    local posANumber = 4
    local posBNumber = 4
    local posBIncrement = 12
    if style == 4 then
      posANumber = 1
      posBNumber = 7
      posBIncrement = 9
    end
    local vehicles = {}
    local randomOffset = framework.random(0, 7)
    for i = 1, posANumber do
      local nextType = vehicleTypes.vehicleTypeA.vehicleID
      local shader = {
        [0] = vehicleTypes.vehicleTypeA.shader[0]
      }
      if shader[0] == -1 then
        shader[0] = #vehicles + randomOffset
      end
      table.insert(vehicles, {modelID = nextType, shaderParams = shader})
    end
    local spawnData = {
      type = "Grid",
      position = positions.positionA,
      gridSpacing = gridWidth,
      vehicles = vehicles,
      heading = headings.headingA,
      gridMaxVehicles = 4,
      staggeredGridSpacing = gridStagger
    }
    local gridOne = Spawn.Spawn(spawnData)
    for index, gameVehicle in ipairs(gridOne) do
      local vehicle = vehicleManager.takeOwnership({
        gameVehicle = gridOne[index]
      })
      vehicle.networkVars.onlineRequiredVehicle = true
      vehicle.networkVars.onlineOwnerID = 255
      vehicleGrid[index + 8] = vehicle.SNVID
    end
    vehicles = {}
    for i = 1, posBNumber do
      local nextType = vehicleTypes.vehicleTypeB.vehicleID
      local shader = {
        [0] = vehicleTypes.vehicleTypeB.shader[0]
      }
      if shader[0] == -1 then
        shader[0] = #vehicles + randomOffset
      end
      table.insert(vehicles, {modelID = nextType, shaderParams = shader})
    end
    spawnData = {
      type = "Grid",
      position = positions.positionB,
      gridSpacing = gridWidth,
      vehicles = vehicles,
      heading = headings.headingB,
      gridMaxVehicles = 4,
      staggeredGridSpacing = gridStagger
    }
    local gridTwo = Spawn.Spawn(spawnData)
    for index, gameVehicle in ipairs(gridTwo) do
      local vehicle = vehicleManager.takeOwnership({
        gameVehicle = gridTwo[index]
      })
      vehicle.networkVars.onlineRequiredVehicle = true
      vehicle.networkVars.onlineOwnerID = 255
      vehicleGrid[index + posBIncrement] = vehicle.SNVID
    end
  elseif style == 6 then
    local vehicles = {}
    local randomOffset = framework.random(0, 7)
    for i = 1, 2 do
      local nextType = vehicleTypes.vehicleTypeA.vehicleID
      local shader = {
        [0] = vehicleTypes.vehicleTypeA.shader[0]
      }
      if shader[0] == -1 then
        shader[0] = #vehicles + randomOffset
      end
      table.insert(vehicles, {modelID = nextType, shaderParams = shader})
    end
    local spawnData = {
      type = "Grid",
      position = positions.positionA,
      gridSpacing = gridWidth,
      vehicles = vehicles,
      heading = headings.headingA,
      gridMaxVehicles = 2,
      staggeredGridSpacing = gridStagger
    }
    local gridOne = Spawn.Spawn(spawnData)
    for index, gameVehicle in ipairs(gridOne) do
      local vehicle = vehicleManager.takeOwnership({
        gameVehicle = gridOne[index]
      })
      vehicle.networkVars.onlineRequiredVehicle = true
      vehicle.networkVars.onlineOwnerID = 255
      vehicleGrid[index + 8] = vehicle.SNVID
    end
    vehicles = {}
    for i = 1, 2 do
      local nextType = vehicleTypes.vehicleTypeB.vehicleID
      local shader = {
        [0] = vehicleTypes.vehicleTypeB.shader[0]
      }
      if shader[0] == -1 then
        shader[0] = #vehicles + randomOffset
      end
      table.insert(vehicles, {modelID = nextType, shaderParams = shader})
    end
    spawnData = {
      type = "Grid",
      position = positions.positionB,
      gridSpacing = gridWidth,
      vehicles = vehicles,
      heading = headings.headingB,
      gridMaxVehicles = 2,
      staggeredGridSpacing = gridStagger
    }
    local gridTwo = Spawn.Spawn(spawnData)
    for index, gameVehicle in ipairs(gridTwo) do
      local vehicle = vehicleManager.takeOwnership({
        gameVehicle = gridTwo[index]
      })
      vehicle.networkVars.onlineRequiredVehicle = true
      vehicle.networkVars.onlineOwnerID = 255
      vehicleGrid[index + 10] = vehicle.SNVID
    end
    vehicles = {}
    for i = 1, 2 do
      local nextType = vehicleTypes.vehicleTypeC.vehicleID
      local shader = {
        [0] = vehicleTypes.vehicleTypeC.shader[0]
      }
      if shader[0] == -1 then
        shader[0] = #vehicles + randomOffset
      end
      table.insert(vehicles, {modelID = nextType, shaderParams = shader})
    end
    spawnData = {
      type = "Grid",
      position = positions.positionC,
      gridSpacing = gridWidth,
      vehicles = vehicles,
      heading = headings.headingC,
      gridMaxVehicles = 2,
      staggeredGridSpacing = gridStagger
    }
    local gridThree = Spawn.Spawn(spawnData)
    for index, gameVehicle in ipairs(gridThree) do
      local vehicle = vehicleManager.takeOwnership({
        gameVehicle = gridThree[index]
      })
      vehicle.networkVars.onlineRequiredVehicle = true
      vehicle.networkVars.onlineOwnerID = 255
      vehicleGrid[index + 12] = vehicle.SNVID
    end
    vehicles = {}
    for i = 1, 2 do
      local nextType = vehicleTypes.vehicleTypeD.vehicleID
      local shader = {
        [0] = vehicleTypes.vehicleTypeD.shader[0]
      }
      if shader[0] == -1 then
        shader[0] = #vehicles + randomOffset
      end
      table.insert(vehicles, {modelID = nextType, shaderParams = shader})
    end
    spawnData = {
      type = "Grid",
      position = positions.positionD,
      gridSpacing = gridWidth,
      vehicles = vehicles,
      heading = headings.headingD,
      gridMaxVehicles = 2,
      staggeredGridSpacing = gridStagger
    }
    local gridFour = Spawn.Spawn(spawnData)
    for index, gameVehicle in ipairs(gridFour) do
      local vehicle = vehicleManager.takeOwnership({
        gameVehicle = gridFour[index]
      })
      vehicle.networkVars.onlineRequiredVehicle = true
      vehicle.networkVars.onlineOwnerID = 255
      vehicleGrid[index + 14] = vehicle.SNVID
    end
  end
  assignGrid(style, gridSortStyle)
end
function vehicleRequest(fromPlayer)
  if spawnDone and vehicleGrid[fromPlayer.playerID + 1] ~= 0 or not vehicleRemovalFinished then
    return
  end
  if faceOffSystem.currentFaceOff and not faceOffSystem.currentFaceOff.faceOffEnding then
    local position = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].positionA
    local heading = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].headingA
    local vehicleTypeA = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].vehicleSet[networkVars.missionVehicleIndex]
    local style = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.gridStyle
    local gridSize = 8
    local gridWidth = 10
    if faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].gridWidth then
      gridWidth = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].gridWidth
    end
    if style == 3 then
      gridSize = 4
      if PlayerGamePlay.getPlayerTeam(fromPlayer.playerID) == 1 then
        position = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].positionA
        heading = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].headingA
      else
        position = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].positionB
        heading = faceOffSystem.faceOffPool[networkVars.modeIndex].settings.areas[networkVars.modeAreaIndex].headingB
      end
    end
    local vehicle = {
      {
        modelID = vehicleTypeA.vehicleID,
        shaderParams = vehicleTypeA.shader
      }
    }
    local spawnData = {
      type = "Grid",
      position = position,
      gridSpacing = gridWidth,
      vehicles = vehicle,
      heading = heading,
      gridMaxVehicles = gridSize,
      staggeredGridSpacing = gridStagger
    }
    local grid = Spawn.Spawn(spawnData)
    vehicle = vehicleManager.takeOwnership({
      gameVehicle = grid[1]
    })
    vehicle.networkVars.onlineRequiredVehicle = true
    vehicle.networkVars.onlineOwnerID = fromPlayer.playerID
    if vehicle.networkVars.onlineOwnerID ~= localPlayer.playerID then
      zapcontroller.AddLockedVehicle({
        gameVehicle = vehicle.gameVehicle
      })
    end
  elseif challengeSystem.instances[networkVars.modeID] and not challengeSystem.instances[networkVars.modeID].instanceEnding then
    local missionData = cardSystem.createMission(cards.MissionNetworkLookup[networkVars.modeIndex])
    local style = missionData.settings.gridStyle
    local vehicleTypeA
    if missionData.spawnPositions[networkVars.modeAreaIndex].frequenceAndVehicles then
      vehicleTypeA = missionData.spawnPositions[networkVars.modeAreaIndex].frequenceAndVehicles[networkVars.vehicleFreqIndex].vehicleSet[networkVars.missionVehicleIndex]
    else
      vehicleTypeA = missionData.spawnPositions[networkVars.modeAreaIndex].vehicleSet[networkVars.missionVehicleIndex]
    end
    assert(style ~= 5, "Cant use split screen style 5 as players should never join mid game")
    local vehicle = {
      {
        modelID = vehicleTypeA.vehicleID,
        shaderParams = vehicleTypeA.shader
      }
    }
    local position, heading
    local numVehicles = 8
    local gridWidth = 10
    if missionData.spawnPositions[networkVars.modeAreaIndex].gridWidth then
      gridWidth = missionData.spawnPositions[networkVars.modeAreaIndex].gridWidth
    end
    if style == 1 or style == 2 then
      position = missionData.spawnPositions[networkVars.modeAreaIndex].positionA
      heading = missionData.spawnPositions[networkVars.modeAreaIndex].headingA
    elseif style == 4 then
      position = missionData.spawnPositions[networkVars.modeAreaIndex].positionB
      heading = missionData.spawnPositions[networkVars.modeAreaIndex].headingB
    elseif style == 3 then
      assert(PlayerGamePlay.getPlayerTeam(fromPlayer.playerID) ~= 0, "PHASE MANAGER CORE, new player doesnt have a team")
      numVehicles = 4
      if networkVars.modeID and challengeSystem.instances[networkVars.modeID] and challengeSystem.instances[networkVars.modeID].challenge.settings.numRounds and 0 < challengeSystem.instances[networkVars.modeID].challenge.settings.numRounds then
        if PlayerGamePlay.getPlayerTeam(fromPlayer.playerID) == challengeSystem.instances[networkVars.modeID].networkVars.roundOn then
          position = missionData.spawnPositions[networkVars.modeAreaIndex].positionA
          heading = missionData.spawnPositions[networkVars.modeAreaIndex].headingA
        else
          position = missionData.spawnPositions[networkVars.modeAreaIndex].positionB
          heading = missionData.spawnPositions[networkVars.modeAreaIndex].headingB
        end
      elseif PlayerGamePlay.getPlayerTeam(fromPlayer.playerID) == 1 then
        position = missionData.spawnPositions[networkVars.modeAreaIndex].positionA
        heading = missionData.spawnPositions[networkVars.modeAreaIndex].headingA
      else
        position = missionData.spawnPositions[networkVars.modeAreaIndex].positionB
        heading = missionData.spawnPositions[networkVars.modeAreaIndex].headingB
      end
    elseif style == 6 then
      numVehicles = 2
      if fromPlayer.playerID == 1 or fromPlayer.playerID == 5 then
        position = missionData.spawnPositions[networkVars.modeAreaIndex].positionA
        heading = missionData.spawnPositions[networkVars.modeAreaIndex].headingA
      elseif fromPlayer.playerID == 2 or fromPlayer.playerID == 6 then
        position = missionData.spawnPositions[networkVars.modeAreaIndex].positionB
        heading = missionData.spawnPositions[networkVars.modeAreaIndex].headingB
      elseif fromPlayer.playerID == 3 or fromPlayer.playerID == 7 then
        position = missionData.spawnPositions[networkVars.modeAreaIndex].positionC
        heading = missionData.spawnPositions[networkVars.modeAreaIndex].headingC
      else
        position = missionData.spawnPositions[networkVars.modeAreaIndex].positionD
        heading = missionData.spawnPositions[networkVars.modeAreaIndex].headingD
      end
    end
    local spawnData = {
      type = "Grid",
      position = position,
      gridSpacing = gridWidth,
      vehicles = vehicle,
      heading = heading,
      gridMaxVehicles = numVehicles,
      staggeredGridSpacing = gridStagger
    }
    local grid = Spawn.Spawn(spawnData)
    vehicle = vehicleManager.takeOwnership({
      gameVehicle = grid[1]
    })
    vehicle.networkVars.onlineRequiredVehicle = true
    vehicle.networkVars.onlineOwnerID = fromPlayer.playerID
    if vehicle.networkVars.onlineOwnerID ~= localPlayer.playerID then
      zapcontroller.AddLockedVehicle({
        gameVehicle = vehicle.gameVehicle
      })
    end
    if challengeSystem.instances[networkVars.modeID].assignTaskObjects then
      if fromPlayer then
        NetworkLog.Write(">[LUA] - VEHICLE REQUEST - PlayerID: " .. tostring(fromPlayer.playerID) .. "  ModeID: " .. tostring(challengeSystem.instances[networkVars.modeID].challenge.name))
      end
      challengeSystem.instances[networkVars.modeID].assignTaskObjects(challengeSystem.instances[networkVars.modeID], fromPlayer, vehicle)
    end
  end
end
