cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Gone in 59 seconds"] = {
  FileVersion = "2",
  name = "Gone in 59 seconds",
  title = "ID:184818",
  MissionID = "4819",
  description = "ID:184819",
  cardInstances = {
    Actors = {
      ["Police"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 40,
          team = {
            instance = 1,
            type = "Teams",
            name = "Police team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Police Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          previewMovie = " ",
          enableSiren = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Warmup route"
          },
          shaderParam = 0,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 280,
          enableSimulationArea = false,
          isMultiplayerActor = false,
          spawnSpeed = 40,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          ignoreCivilianTraffic = false,
          reactionTime = "Average",
          noOccupants = false,
          stayInLockedArea = false,
          blockTow = false,
          routeName = "GoneWarmupRoute",
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          ignoreOtherAis = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Truck 2"] = {
        [1] = {
          trailerPanelSet = 1,
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = true,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          desiredSpeed = 30,
          team = {
            instance = 1,
            type = "Teams",
            name = "Truck team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Truck Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = true,
          whenSpawned = "On mission start",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          trailerShaderParam = 1,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          vehicleTrailerId = 289,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Set position - Truck 2"
          },
          vehicleId = 286,
          shaderParam = 6,
          enableSiren = false,
          spawnSpeed = 10,
          enableSimulationArea = true,
          damageMultiplier = 0.2,
          attackStationaryVehicle = false,
          ignoreCivilianTraffic = false,
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          ignoreOtherAis = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Hot Car 3"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Hot Car team2"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Hot Car 3 Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On mission start",
          vehicleTrailerId = -1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "car3 pos"
          },
          vehicleId = 132,
          shaderParam = 4,
          panelSet = 2,
          enableSiren = false,
          enableSimulationArea = false,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          raceManagerRoute = false,
          routeName = "HotCarRoute3",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Truck 3"] = {
        [1] = {
          trailerPanelSet = 1,
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = true,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          desiredSpeed = 30,
          team = {
            instance = 1,
            type = "Teams",
            name = "Truck team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Truck Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = true,
          whenSpawned = "On mission start",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          trailerShaderParam = 1,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          vehicleTrailerId = 289,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Set position - Truck 3"
          },
          vehicleId = 286,
          shaderParam = 6,
          enableSiren = false,
          spawnSpeed = 10,
          enableSimulationArea = true,
          damageMultiplier = 0.2,
          attackStationaryVehicle = false,
          ignoreCivilianTraffic = false,
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          ignoreOtherAis = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Goon 2"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Goon team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Goon Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On mission start",
          tailingDistance = 10,
          vehicleTrailerId = -1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleId = 176,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          enableSiren = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Goon2"
          },
          ramInFrontDistance = 40,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Strong",
          rubberbandingActor = "Hot Car 3",
          shaderParam = 2,
          attackStationaryVehicle = true,
          distanceBehindPlayer = 10,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          groupAggression = "High",
          avoidAttacks = false,
          avoidAlleys = 1,
          desiredSpeed = 90,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Truck 4"] = {
        [1] = {
          trailerPanelSet = 1,
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = true,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          desiredSpeed = 30,
          team = {
            instance = 1,
            type = "Teams",
            name = "Truck team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Truck Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = true,
          whenSpawned = "On mission start",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          trailerShaderParam = 1,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          vehicleTrailerId = 289,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Set position - Truck 4"
          },
          vehicleId = 286,
          shaderParam = 6,
          enableSiren = false,
          spawnSpeed = 10,
          enableSimulationArea = true,
          damageMultiplier = 0.2,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          avoidAlleys = 0,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Goon 3"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Goon team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Goon Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On mission start",
          tailingDistance = 10,
          vehicleTrailerId = -1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleId = 176,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          enableSiren = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Goon3"
          },
          ramInFrontDistance = 40,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Strong",
          rubberbandingActor = "Hot Car 3",
          shaderParam = 1,
          attackStationaryVehicle = true,
          distanceBehindPlayer = 10,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          groupAggression = "High",
          avoidAttacks = false,
          avoidAlleys = 1,
          desiredSpeed = 90,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Goon 4"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Goon team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Goon Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On mission start",
          tailingDistance = 10,
          vehicleTrailerId = -1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleId = 176,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          enableSiren = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Goon4"
          },
          ramInFrontDistance = 40,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Strong",
          rubberbandingActor = "Hot Car 3",
          shaderParam = 3,
          attackStationaryVehicle = true,
          distanceBehindPlayer = 15,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          groupAggression = "High",
          avoidAttacks = false,
          avoidAlleys = 1,
          desiredSpeed = 90,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Hot Car 4"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Hot Car team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Hot Car 4 Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On mission start",
          vehicleTrailerId = -1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Hot Car Set position 4"
          },
          vehicleId = 241,
          shaderParam = 4,
          enableSiren = false,
          enableSimulationArea = false,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          raceManagerRoute = false,
          routeName = "HotCarRoute4",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Hot Car 2"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Hot Car team"
          },
          applyDamage = 0.75,
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Hot Car 2 Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On mission start",
          vehicleTrailerId = -1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Hot Car Set position 2"
          },
          vehicleId = 213,
          shaderParam = 3,
          enableSiren = false,
          enableSimulationArea = false,
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          raceManagerRoute = false,
          routeName = "HotCarRoute2",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Goon 1"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Goon team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Goon Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On mission start",
          tailingDistance = 5,
          vehicleTrailerId = -1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleId = 176,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          enableSiren = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Goon1"
          },
          ramInFrontDistance = 40,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Strong",
          rubberbandingActor = "Hot Car 3",
          shaderParam = 1,
          attackStationaryVehicle = true,
          distanceBehindPlayer = 5,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          groupAggression = "High",
          avoidAttacks = false,
          avoidAlleys = 1,
          desiredSpeed = 90,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Hot Car 1"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Hot Car team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Hot Car 1 Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On mission start",
          vehicleTrailerId = -1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Hot Car Set position 1"
          },
          vehicleId = 217,
          shaderParam = 0,
          enableSiren = false,
          enableSimulationArea = false,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          raceManagerRoute = false,
          routeName = "HotCarRoute1",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Tow truck"] = {
        [1] = {
          noOccupants = false,
          lockedToPlayer = true,
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          stayInLockedArea = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
          aiIgnorePlayers = false,
          raceManagerRoute = false,
          desiredSpeed = 0,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Tow spawn"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "Tow team"
          },
          vehicleId = 287,
          drivingSkill = "Average",
          avoidUTurns = false,
          enableSiren = false,
          enableSimulationArea = false,
          shaderParam = 9,
          attackStationaryVehicle = false,
          forceHighLodCharacters = false,
          reactionTime = "Average",
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On mission start",
          collisionResilience = "Average",
          avoidAttacks = false,
          ignoreCivilianTraffic = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Truck Character"
          },
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      ["Truck 1"] = {
        [1] = {
          trailerPanelSet = 1,
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = true,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Truck team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          matchTrafficSpeedMultiplier = 0,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Truck Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = true,
          whenSpawned = "On mission start",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = true,
          trailerShaderParam = 1,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          ignoreOtherAis = false,
          vehicleTrailerId = 289,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Set position - Truck 1"
          },
          vehicleId = 286,
          shaderParam = 6,
          enableSiren = false,
          spawnSpeed = 0,
          enableSimulationArea = true,
          damageMultiplier = 0.2,
          attackStationaryVehicle = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          desiredSpeed = 0,
          aiIgnorePlayerInCivsUntilHit = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Goon Character"] = {
        [1] = {
          ["Passenger id"] = "1369800786",
          ["Driver id"] = "1200791648"
        },
        ["name"] = "Character"
      },
      ["Police Character"] = {
        [1] = {
          ["Passenger id"] = "-1843533868",
          ["Driver id"] = "215156097"
        },
        ["name"] = "Character"
      },
      ["Hot Car 2 Character"] = {
        [1] = {
          ["Passenger id"] = "-777103668",
          ["Driver id"] = "-494987193"
        },
        ["name"] = "Character"
      },
      ["Hot Car 4 Character"] = {
        [1] = {
          ["Driver id"] = "-891125475"
        },
        ["name"] = "Character"
      },
      ["Truck Character"] = {
        [1] = {
          ["Passenger id"] = "-1",
          ["Driver id"] = "890180051"
        },
        ["name"] = "Character"
      },
      ["Hot Car 1 Character"] = {
        [1] = {
          ["Passenger id"] = "-1",
          ["Driver id"] = "-674195012"
        },
        ["name"] = "Character"
      },
      ["Hot Car 3 Character"] = {
        [1] = {
          ["Passenger id"] = "289009431",
          ["Driver id"] = "-2095856815"
        },
        ["name"] = "Character"
      }
    },
    SpawnTypes = {
      ["Set position - Truck 3"] = {
        [1] = {
          ["Spawn location"] = "Gone in 59 seconds truck 3",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Set position - Truck 1"] = {
        [1] = {
          ["Spawn location"] = "Gone in 59 seconds truck 1",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Hot Car Set position 2"] = {
        [1] = {
          ["Spawn location"] = "Gone in 59 seconds hot car 2",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Hot Car Set position 3"] = {
        [1] = {
          ["Spawn location"] = "Gone in 59 seconds hot car 3",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Goon2"] = {
        [1] = {
          ["Spawn location"] = "Gone in 59 seconds goon 2 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Hot Car Set position 4"] = {
        [1] = {
          ["Spawn location"] = "Gone in 59 seconds hot car 4",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Ahead of hot car"] = {
        [1] = {
          withVehicleDirection = false,
          actor = "Hot Car 3",
          distance = 90,
          aheadOfVehicle = true
        },
        ["name"] = "Relative to Vehicle"
      },
      ["Goon4"] = {
        [1] = {
          ["Spawn location"] = "Gone in 59 seconds goon 4 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Tow spawn"] = {
        [1] = {
          ["Spawn location"] = "Gone in 59 seconds tow",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["car3 pos"] = {
        [1] = {
          ["Spawn location"] = "Gone in 59 seconds hot car 3",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Goon3"] = {
        [1] = {
          ["Spawn location"] = "Gone in 59 seconds goon 3 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Goon1"] = {
        [1] = {
          ["Spawn location"] = "Gone in 59 seconds goon 1 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["behind hot car"] = {
        [1] = {
          withVehicleDirection = true,
          actor = "Hot Car 3",
          distance = 40,
          aheadOfVehicle = false
        },
        ["name"] = "Relative to Vehicle"
      },
      ["Hot Car Set position 1"] = {
        [1] = {
          ["Spawn location"] = "Gone in 59 seconds hot car 1",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["New Positions"] = {
        [1] = {
          ["1"] = "Police"
        },
        ["name"] = "Positions"
      },
      ["Set position - Truck 4"] = {
        [1] = {
          ["Spawn location"] = "Gone in 59 seconds truck 4",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Set position - Truck 2"] = {
        [1] = {
          ["Spawn location"] = "Gone in 59 seconds truck 2",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    MissionSettings = {
      MissionSettings = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Spawn type"] = "Always active",
          ["Load traffic on start"] = "Chapter 6 - Its for charity",
          ["disablePlayerIgnoring"] = false,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "GoneIn59SecondsStart",
          ["Audio logic file"] = "Gone in 59 seconds APIP",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["Hot Car team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Police team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Tow team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Truck team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Goon team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Hot Car team2"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Truck team 2"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionCompletes = {
      ["New Gone in 59 seconds"] = {
        [1] = {
          ["Perfect condition"] = "ID:184833",
          ["Success reason"] = "ID:233826",
          ["Failure reason"] = "ID:184828",
          ["Success reason (perfect)"] = "ID:184833",
          ["Pass condition"] = "ID:184832",
          ["Failure reason (wrecked)"] = "ID:184015"
        },
        ["name"] = "Gone in 59 seconds"
      }
    },
    WarmupTypes = {
      ["New Warmup route"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          warmupRouteName = "GoneWarmupRoute",
          forceZapToVehicle = false,
          forceMissionAccept = false,
          lookToVehicle = false
        },
        ["name"] = "Warmup route"
      }
    },
    FelonySettings = {
      ["Felony Settings"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    MissionInfos = {
      ["New Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:184831",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective",
              cardName = "Hot Car 4",
              cardType = "Actor"
            },
            [2] = {
              value = "None",
              cardName = "Goon 3",
              cardType = "Actor"
            },
            [3] = {
              value = "Objective",
              cardName = "Hot Car 2",
              cardType = "Actor"
            },
            [4] = {
              value = "Objective (No light trails/health)",
              cardName = "Truck 1",
              cardType = "Actor"
            },
            [5] = {
              value = "None",
              cardName = "Goon 1",
              cardType = "Actor"
            },
            [6] = {
              value = "None",
              cardName = "Tow truck",
              cardType = "Actor"
            },
            [7] = {
              value = "Yellow Marker, Destination Vehicle",
              cardName = "Truck 3",
              cardType = "Actor"
            },
            [8] = {
              value = "Objective (No light trails/health)",
              cardName = "Truck 4",
              cardType = "Actor"
            },
            [9] = {
              value = "Objective",
              cardName = "Hot Car 1",
              cardType = "Actor"
            },
            [10] = {
              value = "None",
              cardName = "Goon 4",
              cardType = "Actor"
            },
            [11] = {
              value = "Objective",
              cardName = "Hot Car 3",
              cardType = "Actor"
            },
            [12] = {
              value = "None",
              cardName = "Police",
              cardType = "Actor"
            },
            [13] = {
              value = "None",
              cardName = "Goon 2",
              cardType = "Actor"
            },
            [14] = {
              value = "Objective (No light trails/health)",
              cardName = "Truck 2",
              cardType = "Actor"
            }
          },
          ["7 Text"] = "ID:186737",
          ["6 Text"] = "ID:186737",
          ["5 Text"] = "ID:186737",
          ["4 Text"] = "ID:186737",
          ["3 Text"] = "ID:186737",
          ["2 Text"] = "ID:186737"
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["Gone in 59 seconds"] = {
        [1] = {
          ["Hot Car team"] = {
            instance = 1,
            type = "Teams",
            name = "Hot Car team"
          },
          ["Police team"] = {
            instance = 1,
            type = "Teams",
            name = "Police team"
          },
          ["Truck team"] = {
            instance = 1,
            type = "Teams",
            name = "Truck team"
          },
          ["Tow team"] = {
            instance = 1,
            type = "Teams",
            name = "Tow team"
          },
          ["Hot Car team2"] = {
            instance = 1,
            type = "Teams",
            name = "Hot Car team2"
          },
          ["Goon team"] = {
            instance = 1,
            type = "Teams",
            name = "Goon team"
          },
          ["Time limit"] = 270
        },
        ["name"] = "Gone in 59 seconds"
      }
    }
  }
}
