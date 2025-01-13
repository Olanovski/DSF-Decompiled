cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Protect the base"] = {
  FileVersion = "2",
  name = "Protect the base",
  title = "ID:184711",
  MissionID = "6864",
  description = "ID:184697",
  cardInstances = {
    Actors = {
      ["Siege car 1000m West"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = true,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Attack team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = true,
          characters = {
            instance = 1,
            type = "Characters",
            name = "8Attacker"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleId = 188,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = true,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          shaderParam = 3,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Siege 1000m West position"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 50,
          damageMultiplier = 13,
          attackStationaryVehicle = true,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = true,
          groupAggression = "Evil",
          avoidAttacks = false,
          avoidAlleys = 1,
          desiredSpeed = 50,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Siege car 1000m East bis"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = true,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Attack team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = true,
          characters = {
            instance = 1,
            type = "Characters",
            name = "11Attacker"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleId = 188,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = true,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          shaderParam = 3,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Siege 1000m East position bis relative to vehicle"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 50,
          damageMultiplier = 20,
          attackStationaryVehicle = true,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = true,
          groupAggression = "Evil",
          avoidAttacks = false,
          avoidAlleys = 1,
          desiredSpeed = 50,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Siege car 1000m East"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = true,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          desiredSpeed = 50,
          team = {
            instance = 1,
            type = "Teams",
            name = "Attack team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = true,
          accidentProbability = 0,
          characters = {
            instance = 1,
            type = "Characters",
            name = "3Attacker"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          vehicleId = 188,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 3,
          avoidUTurns = false,
          groupAggression = "Evil",
          avoidAlleys = 1,
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Siege 1000m East position"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 50,
          damageMultiplier = 13,
          attackStationaryVehicle = true,
          aiIgnorePlayerInCivsUntilHit = true,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = true,
          ignoreCivilianTraffic = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Very tough",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Siege car 1000m North Large"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = true,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Attack team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = true,
          characters = {
            instance = 1,
            type = "Characters",
            name = "2Attacker"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleId = 180,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = true,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          shaderParam = 0,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Siege 1000m North position"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 50,
          maximumDamagePerCollision = 0.6,
          damageMultiplier = 20,
          attackStationaryVehicle = true,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = true,
          groupAggression = "Evil",
          avoidAttacks = false,
          avoidAlleys = 1,
          desiredSpeed = 50,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Siege car 700m West"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = true,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Attack team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = true,
          characters = {
            instance = 1,
            type = "Characters",
            name = "9Attacker"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleId = 188,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = true,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          shaderParam = 3,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Siege 700m West position"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 60,
          damageMultiplier = 13,
          attackStationaryVehicle = true,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = true,
          groupAggression = "Evil",
          avoidAttacks = false,
          avoidAlleys = 1,
          desiredSpeed = 60,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["MoneyTruck"] = {
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
            name = "Protect team"
          },
          drivingSkill = "Cautious",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "New Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          driveInOncoming = 0.1,
          driveOnPavements = 0.1,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = true,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "MoneyTruckWarmup"
          },
          shaderParam = 0,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions 2"
          },
          vehicleId = 301,
          enableSimulationArea = true,
          isMultiplayerActor = false,
          spawnSpeed = 0,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          desiredSpeed = 40,
          matchTrafficSpeed = true,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = true,
          previewMovie = " ",
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["BombCar"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 0,
          team = {
            instance = 1,
            type = "Teams",
            name = "Bomb car team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "BombCarCharacter"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On mission start",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          vehicleTrailerId = -1,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "BombCarSpawn"
          },
          vehicleId = 266,
          shaderParam = 2,
          enableSiren = false,
          spawnSpeed = 0,
          enableSimulationArea = false,
          damageMultiplier = 0,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = true,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          avoidAlleys = 0,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Siege car 1000m West bis"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = true,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Attack team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = true,
          characters = {
            instance = 1,
            type = "Characters",
            name = "6Attacker"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleId = 188,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = true,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          shaderParam = 3,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Siege 1000m West position bis relative to vehicle"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 50,
          damageMultiplier = 20,
          attackStationaryVehicle = true,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = true,
          groupAggression = "Evil",
          avoidAttacks = false,
          avoidAlleys = 1,
          desiredSpeed = 50,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Siege car 1000m North bis"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = true,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Attack team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = true,
          characters = {
            instance = 1,
            type = "Characters",
            name = "2Attacker"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleId = 188,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = true,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Siege 1000m North position bis relative to vehicle"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 50,
          damageMultiplier = 20,
          attackStationaryVehicle = true,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = true,
          groupAggression = "Evil",
          avoidAttacks = false,
          avoidAlleys = 1,
          desiredSpeed = 50,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Siege car 1000m South"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = true,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Attack team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = true,
          characters = {
            instance = 1,
            type = "Characters",
            name = "5Attacker"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleId = 188,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = true,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          shaderParam = 3,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Siege 1000m South position"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 50,
          damageMultiplier = 13,
          attackStationaryVehicle = true,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = true,
          groupAggression = "Evil",
          avoidAttacks = false,
          avoidAlleys = 1,
          desiredSpeed = 50,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Siege car 1000m East Large"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = true,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Attack team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = true,
          characters = {
            instance = 1,
            type = "Characters",
            name = "11Attacker"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleId = 180,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = true,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          shaderParam = 0,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Siege 1000m East position"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 50,
          maximumDamagePerCollision = 0.6,
          damageMultiplier = 20,
          attackStationaryVehicle = true,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = true,
          groupAggression = "Evil",
          avoidAttacks = false,
          avoidAlleys = 1,
          desiredSpeed = 50,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Final Boss"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Attack team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = true,
          characters = {
            instance = 1,
            type = "Characters",
            name = "5Attacker"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleId = 180,
          avoidUTurns = true,
          aiIgnorePlayerInCivsUntilHit = true,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          shaderParam = 0,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Final Boss position"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = true,
          spawnSpeed = 30,
          maximumDamagePerCollision = 0.6,
          damageMultiplier = 13,
          attackStationaryVehicle = true,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = true,
          groupAggression = "Evil",
          avoidAttacks = false,
          avoidAlleys = 1,
          desiredSpeed = 30,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Siege car 700m South"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = true,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Attack team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = true,
          characters = {
            instance = 1,
            type = "Characters",
            name = "7Attacker"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleId = 188,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = true,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          shaderParam = 3,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Siege 700m South position"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 60,
          damageMultiplier = 13,
          attackStationaryVehicle = true,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = true,
          groupAggression = "Evil",
          avoidAttacks = false,
          avoidAlleys = 1,
          desiredSpeed = 60,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Siege car 1000m West Large"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = true,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Attack team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = true,
          characters = {
            instance = 1,
            type = "Characters",
            name = "6Attacker"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleId = 180,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = true,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          shaderParam = 0,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Siege 1000m West position"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 50,
          maximumDamagePerCollision = 0.6,
          damageMultiplier = 20,
          attackStationaryVehicle = true,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = true,
          groupAggression = "Evil",
          avoidAttacks = false,
          avoidAlleys = 1,
          desiredSpeed = 50,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Siege car 700m North"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = true,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Attack team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = true,
          characters = {
            instance = 1,
            type = "Characters",
            name = "1Attacker"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleId = 188,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = true,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          shaderParam = 3,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Siege 700m North position"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 60,
          damageMultiplier = 13,
          attackStationaryVehicle = true,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = true,
          groupAggression = "Evil",
          avoidAttacks = false,
          avoidAlleys = 1,
          desiredSpeed = 60,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Siege car 1000m South bis"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = true,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Attack team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = true,
          characters = {
            instance = 1,
            type = "Characters",
            name = "10Attacker"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleId = 188,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = true,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          shaderParam = 3,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Siege 1000m South position bis relative to vehicle"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 50,
          maximumDamagePerCollision = 0.6,
          damageMultiplier = 20,
          attackStationaryVehicle = true,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = true,
          groupAggression = "Evil",
          avoidAttacks = false,
          avoidAlleys = 1,
          desiredSpeed = 50,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Siege car 1000m South Large"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = true,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Attack team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = true,
          characters = {
            instance = 1,
            type = "Characters",
            name = "10Attacker"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleId = 180,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = true,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          shaderParam = 0,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Siege 1000m South position"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 50,
          maximumDamagePerCollision = 0.6,
          damageMultiplier = 20,
          attackStationaryVehicle = true,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = true,
          groupAggression = "Evil",
          avoidAttacks = false,
          avoidAlleys = 1,
          desiredSpeed = 50,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Siege car 700m East"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = true,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Attack team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = true,
          characters = {
            instance = 1,
            type = "Characters",
            name = "12Attacker"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleId = 188,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = true,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          shaderParam = 3,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Siege 700m East position"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 60,
          damageMultiplier = 13,
          attackStationaryVehicle = true,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = true,
          groupAggression = "Evil",
          avoidAttacks = false,
          avoidAlleys = 1,
          desiredSpeed = 60,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Siege car 1000m North"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = true,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Attack team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = true,
          characters = {
            instance = 1,
            type = "Characters",
            name = "4Attacker"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleId = 188,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = true,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          shaderParam = 3,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Siege 1000m North position"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 50,
          damageMultiplier = 13,
          attackStationaryVehicle = true,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = true,
          groupAggression = "Evil",
          avoidAttacks = false,
          avoidAlleys = 1,
          desiredSpeed = 50,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["12Attacker"] = {
        [1] = {
          ["Driver id"] = "1597691979"
        },
        ["name"] = "Character"
      },
      ["10Attacker"] = {
        [1] = {
          ["Driver id"] = "-1496449035"
        },
        ["name"] = "Character"
      },
      ["11Attacker"] = {
        [1] = {
          ["Driver id"] = "-674195012"
        },
        ["name"] = "Character"
      },
      ["Fire character"] = {
        [1] = {
          ["Passenger id"] = "-1656694476",
          ["Driver id"] = "-1809471421"
        },
        ["name"] = "Character"
      },
      ["Other characters"] = {
        [1] = {
          ["Passenger id"] = "-1",
          ["Driver id"] = "267737180"
        },
        ["name"] = "Character"
      },
      ["2Attacker"] = {
        [1] = {
          ["Driver id"] = "-1907691761"
        },
        ["name"] = "Character"
      },
      ["3Attacker"] = {
        [1] = {
          ["Driver id"] = "-1496449035"
        },
        ["name"] = "Character"
      },
      ["2Cop characters"] = {
        [1] = {
          ["Passenger id"] = "-197606133",
          ["Driver id"] = "1397250177"
        },
        ["name"] = "Character"
      },
      ["1Attacker"] = {
        [1] = {
          ["Driver id"] = "570150525"
        },
        ["name"] = "Character"
      },
      ["6Attacker"] = {
        [1] = {
          ["Driver id"] = "-153831608"
        },
        ["name"] = "Character"
      },
      ["7Attacker"] = {
        [1] = {
          ["Driver id"] = "1989331258"
        },
        ["name"] = "Character"
      },
      ["BombCarCharacter"] = {
        [1] = {},
        ["name"] = "Character"
      },
      ["5Attacker"] = {
        [1] = {
          ["Driver id"] = "-902779500"
        },
        ["name"] = "Character"
      },
      ["8Attacker"] = {
        [1] = {
          ["Driver id"] = "1918505690"
        },
        ["name"] = "Character"
      },
      ["9Attacker"] = {
        [1] = {
          ["Driver id"] = "-26767158"
        },
        ["name"] = "Character"
      },
      ["New Character"] = {
        [1] = {
          ["Passenger id"] = "1506433331",
          ["Driver id"] = "681333099"
        },
        ["name"] = "Character"
      },
      ["Cop characters"] = {
        [1] = {
          ["Passenger id"] = "1626880721",
          ["Driver id"] = "-1748422665"
        },
        ["name"] = "Character"
      },
      ["4Attacker"] = {
        [1] = {
          ["Driver id"] = "1454955712"
        },
        ["name"] = "Character"
      }
    },
    SpawnTypes = {
      ["Siege 1000m West position bis relative to vehicle"] = {
        [1] = {
          actor = "Siege car 1000m West",
          whichLane = "randomLane",
          withVehicleDirection = true,
          distance = 5,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = false
        },
        ["name"] = "Relative to Vehicle"
      },
      ["Siege 700m South position"] = {
        [1] = {
          ["Spawn location"] = "Siege 700m South spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Siege 1000m West position"] = {
        [1] = {
          ["Spawn location"] = "Siege 1000m West spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Final Boss position"] = {
        [1] = {
          ["Spawn location"] = "Final Boss spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Siege 1000m North position"] = {
        [1] = {
          ["Spawn location"] = "Siege 1000m North spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Siege 700m East position"] = {
        [1] = {
          ["Spawn location"] = "Siege 700m East spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Siege 1000m South position bis relative to vehicle"] = {
        [1] = {
          actor = "Siege car 1000m South",
          whichLane = "randomLane",
          withVehicleDirection = true,
          distance = 5,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = false
        },
        ["name"] = "Relative to Vehicle"
      },
      ["New Positions 2"] = {
        [1] = {
          ["1"] = "MoneyTruck"
        },
        ["name"] = "Positions"
      },
      ["Siege 1000m East position bis relative to vehicle"] = {
        [1] = {
          actor = "Siege car 1000m East",
          whichLane = "randomLane",
          withVehicleDirection = true,
          distance = 5,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = false
        },
        ["name"] = "Relative to Vehicle"
      },
      ["Siege 1000m South position"] = {
        [1] = {
          ["Spawn location"] = "Siege 1000m South spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Siege 700m West position"] = {
        [1] = {
          ["Spawn location"] = "Siege 700m West spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["BombCarSpawn"] = {
        [1] = {
          ["Spawn location"] = "Bomb car",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Siege 1000m North position bis relative to vehicle"] = {
        [1] = {
          actor = "Siege car 1000m North",
          whichLane = "randomLane",
          withVehicleDirection = true,
          distance = 5,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = false
        },
        ["name"] = "Relative to Vehicle"
      },
      ["Siege 700m North position"] = {
        [1] = {
          ["Spawn location"] = "Siege 700m North spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Siege 1000m East position"] = {
        [1] = {
          ["Spawn location"] = "Siege 1000m East spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    Teams = {
      ["Bomb car team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Protect team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Attack team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Emergency team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionSettings = {
      ["New MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Load traffic on start"] = "Chapter 6 Best Defence",
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Disable traffic"] = false,
          ["Hud logic file"] = "Protect the base HUD",
          ["Cutscene at mission end"] = "mis_ch4_bestdefence_02",
          ["Enable traffic at mission end"] = true,
          ["disablePlayerIgnoring"] = true,
          ["Audio logic file"] = "Protect the base APIP",
          ["freezeFrameOnMissionEndCutscene"] = true,
          ["Delete task object on reject preview"] = false,
          ["Start location"] = "Protect the base",
          ["Enable race status prompts"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    WarmupTypes = {
      MoneyTruckWarmup = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          warmupRouteName = "ProtectTheBaseWarmupRoute",
          forceZapToVehicle = false,
          forceMissionAccept = false,
          matchTrafficSpeed = true,
          lookToVehicle = false
        },
        ["name"] = "Warmup route"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {reenablePatrollingVehiclesAfterFelonyEnd = false, disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    MissionInfos = {
      ["New Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:245548",
          ["Success reason"] = "ID:184781",
          ["Failure reason"] = "ID:184701",
          ["missionMarkers"] = {
            [1] = {
              value = "Opponent",
              cardName = "Siege car 1000m North Large",
              cardType = "Actor"
            },
            [2] = {
              value = "Opponent",
              cardName = "Siege car 1000m East Large",
              cardType = "Actor"
            },
            [3] = {
              value = "None",
              cardName = "BombCar",
              cardType = "Actor"
            },
            [4] = {
              value = "Opponent",
              cardName = "Siege car 700m East",
              cardType = "Actor"
            },
            [5] = {
              value = "Opponent",
              cardName = "Siege car 1000m East",
              cardType = "Actor"
            },
            [6] = {
              value = "Opponent",
              cardName = "Siege car 1000m North",
              cardType = "Actor"
            },
            [7] = {
              value = "Opponent",
              cardName = "Siege car 1000m South bis",
              cardType = "Actor"
            },
            [8] = {
              value = "Opponent",
              cardName = "Siege car 1000m South Large",
              cardType = "Actor"
            },
            [9] = {
              value = "Opponent",
              cardName = "Final Boss",
              cardType = "Actor"
            },
            [10] = {
              value = "Opponent",
              cardName = "Siege car 700m West",
              cardType = "Actor"
            },
            [11] = {
              value = "Opponent",
              cardName = "Siege car 1000m West Large",
              cardType = "Actor"
            },
            [12] = {
              value = "Opponent",
              cardName = "Siege car 1000m West",
              cardType = "Actor"
            },
            [13] = {
              value = "Opponent",
              cardName = "Siege car 1000m South",
              cardType = "Actor"
            },
            [14] = {
              value = "Objective",
              cardName = "MoneyTruck",
              cardType = "Actor"
            },
            [15] = {
              value = "Opponent",
              cardName = "Siege car 1000m North bis",
              cardType = "Actor"
            },
            [16] = {
              value = "Opponent",
              cardName = "Siege car 1000m West bis",
              cardType = "Actor"
            },
            [17] = {
              value = "Opponent",
              cardName = "Siege car 1000m East bis",
              cardType = "Actor"
            },
            [18] = {
              value = "Opponent",
              cardName = "Siege car 700m South",
              cardType = "Actor"
            },
            [19] = {
              value = "Opponent",
              cardName = "Siege car 700m North",
              cardType = "Actor"
            }
          },
          ["Pass condition"] = "ID:184704",
          ["2 Text"] = "ID:184699"
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["Protect The Base Type"] = {
        [1] = {
          ["Bomb car team"] = {
            instance = 1,
            type = "Teams",
            name = "Bomb car team"
          },
          ["Protect team"] = {
            instance = 1,
            type = "Teams",
            name = "Protect team"
          },
          ["Attack team"] = {
            instance = 1,
            type = "Teams",
            name = "Attack team"
          },
          ["Emergency team"] = {
            instance = 1,
            type = "Teams",
            name = "Emergency team"
          }
        },
        ["name"] = "Protect the base"
      }
    }
  }
}
