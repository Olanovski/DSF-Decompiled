cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.RelayRace = {
  FileVersion = "2",
  name = "RelayRace",
  title = "ID:184678",
  MissionID = "7888",
  description = "ID:245457",
  cardInstances = {
    Actors = {
      ["Team 2 Racer 2"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 110,
          team = {
            instance = 1,
            type = "Teams",
            name = "Team 2 - Opponent"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Team 2 Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          distanceFromFrontOfGroup = 0,
          driveInOncoming = 0.2,
          driveOnPavements = 0.5,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Team 2 spawn"
          },
          vehicleId = 285,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Medium",
          spawnSpeed = 20,
          rubberbandingActor = "Team 1 Racer 2",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -60,
          reactionTime = "Average",
          raceManagerRoute = false,
          routeName = "RelayRaceRoute",
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          avoidAlleys = 0,
          ignoreCivilianTraffic = true,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Team 3 Racer 1"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Team 3 - Opponent"
          },
          drivingSkill = "Reckless",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Team 3 Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          enableSiren = false,
          driveInOncoming = 1,
          driveOnPavements = 1,
          noOccupants = false,
          shaderParam = 0,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static"
          },
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          enableSimulationArea = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Team 3 start"
          },
          vehicleId = 126,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Medium",
          spawnSpeed = 0,
          rubberbandingActor = "Team 1 Racer 1",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -40,
          desiredSpeed = 120,
          raceManagerRoute = false,
          routeName = "RelayRaceRoute",
          stayInLockedArea = false,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Team 2 Racer 3"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 140,
          team = {
            instance = 1,
            type = "Teams",
            name = "Team 2 - Opponent"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Team 2 Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          distanceFromFrontOfGroup = 0,
          driveInOncoming = 0.2,
          driveOnPavements = 0.5,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 0,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Team 2 spawn"
          },
          vehicleId = 243,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Medium",
          spawnSpeed = 20,
          rubberbandingActor = "Team 1 Racer 3",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -60,
          reactionTime = "Average",
          raceManagerRoute = false,
          routeName = "RelayRaceRoute",
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
      ["Team 3 Racer 2"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 115,
          team = {
            instance = 1,
            type = "Teams",
            name = "Team 3 - Opponent"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Team 3 Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          driveInOncoming = 0.2,
          driveOnPavements = 0.5,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 3,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Team 3 spawn"
          },
          vehicleId = 285,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Medium",
          spawnSpeed = 20,
          rubberbandingActor = "Team 1 Racer 2",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -50,
          reactionTime = "Average",
          raceManagerRoute = false,
          routeName = "RelayRaceRoute",
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          avoidAlleys = 0,
          ignoreCivilianTraffic = true,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Team 2 Racer 1"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Team 2 - Opponent"
          },
          drivingSkill = "Reckless",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Team 2 Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          enableSiren = false,
          distanceFromFrontOfGroup = 0,
          driveInOncoming = 1,
          driveOnPavements = 1,
          noOccupants = false,
          shaderParam = 0,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static"
          },
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          enableSimulationArea = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Team 2 start"
          },
          vehicleId = 126,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Medium",
          spawnSpeed = 0,
          rubberbandingActor = "Team 1 Racer 1",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -50,
          desiredSpeed = 120,
          raceManagerRoute = false,
          routeName = "RelayRaceRoute",
          stayInLockedArea = false,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Team 1 Racer 2"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 60,
          team = {
            instance = 1,
            type = "Teams",
            name = "Team 1 - Player"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Player Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0.2,
          driveOnPavements = 0.5,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          shaderParam = 2,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Team 1 spawn"
          },
          vehicleId = 285,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 20,
          damageMultiplier = 0.9,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          raceManagerRoute = false,
          routeName = "RelayRaceRoute",
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
      ["Team 4 Racer 2"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 110,
          team = {
            instance = 1,
            type = "Teams",
            name = "Team 4 - Opponent"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Team 4 Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          driveInOncoming = 0.2,
          driveOnPavements = 0.5,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 7,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Team 4 spawn"
          },
          vehicleId = 285,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Medium",
          spawnSpeed = 20,
          rubberbandingActor = "Team 1 Racer 2",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -60,
          reactionTime = "Average",
          raceManagerRoute = false,
          routeName = "RelayRaceRoute",
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          avoidAlleys = 0,
          ignoreCivilianTraffic = true,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Team 4 Racer 1"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Team 4 - Opponent"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Team 4 Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          enableSiren = false,
          driveInOncoming = 1,
          driveOnPavements = 1,
          noOccupants = false,
          shaderParam = 0,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static"
          },
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          enableSimulationArea = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Team 4 start"
          },
          vehicleId = 126,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Medium",
          spawnSpeed = 20,
          rubberbandingActor = "Team 1 Racer 1",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -40,
          desiredSpeed = 120,
          raceManagerRoute = false,
          routeName = "RelayRaceRoute",
          stayInLockedArea = false,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Team 4 Racer 3"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 140,
          team = {
            instance = 1,
            type = "Teams",
            name = "Team 4 - Opponent"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Team 4 Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          driveInOncoming = 0.2,
          driveOnPavements = 0.5,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 5,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Team 4 spawn"
          },
          vehicleId = 243,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Medium",
          spawnSpeed = 20,
          rubberbandingActor = "Team 1 Racer 3",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -60,
          reactionTime = "Average",
          raceManagerRoute = false,
          routeName = "RelayRaceRoute",
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
      ["Team 3 Racer 3"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 140,
          team = {
            instance = 1,
            type = "Teams",
            name = "Team 3 - Opponent"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Team 3 Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          driveInOncoming = 0.2,
          driveOnPavements = 0.5,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 4,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Team 3 spawn"
          },
          vehicleId = 243,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Medium",
          spawnSpeed = 20,
          rubberbandingActor = "Team 1 Racer 3",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -55,
          reactionTime = "Average",
          raceManagerRoute = false,
          routeName = "RelayRaceRoute",
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
      ["Team 1 Racer 3"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 60,
          team = {
            instance = 1,
            type = "Teams",
            name = "Team 1 - Player"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Player Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          shaderParam = 2,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Team 1 spawn"
          },
          vehicleId = 243,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 20,
          damageMultiplier = 0.8,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          avoidAlleys = 0,
          avoidedByCivilianTraffic = false,
          stayInLockedArea = false,
          blockTow = false,
          ignoreOtherAis = false,
          avoidAttacks = false,
          ignoreCivilianTraffic = false,
          routeName = "RelayRaceRoute",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Team 1 Racer 1"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = true,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Team 1 - Player"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          matchTrafficSpeedMultiplier = 1,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Player Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          driveInOncoming = 0.2,
          driveOnPavements = 0.2,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static"
          },
          shaderParam = 0,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Team 1 start"
          },
          vehicleId = 126,
          enableSimulationArea = false,
          spawnSpeed = 0,
          isMultiplayerActor = false,
          damageMultiplier = 0.8,
          attackStationaryVehicle = false,
          desiredSpeed = 80,
          matchTrafficSpeed = false,
          routeName = "RelayRaceRoute",
          raceManagerRoute = true,
          stayInLockedArea = false,
          blockTow = false,
          previewMovie = "No Preview",
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Player Character"] = {
        [1] = {
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      },
      ["Team 4 Character"] = {
        [1] = {
          ["Driver id"] = "-1816364440"
        },
        ["name"] = "Character"
      },
      ["Team 3 Character"] = {
        [1] = {
          ["Driver id"] = "1989331258"
        },
        ["name"] = "Character"
      },
      ["Team 2 Character"] = {
        [1] = {
          ["Driver id"] = "2086556975"
        },
        ["name"] = "Character"
      }
    },
    SpawnTypes = {
      ["Team 2 start"] = {
        [1] = {
          ["Spawn location"] = "Team 2 start",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Team 3 spawn"] = {
        [1] = {
          ["Spawn location"] = "Team 3 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Team 3 start"] = {
        [1] = {
          ["Spawn location"] = "Team 3 start",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Team 1 spawn"] = {
        [1] = {
          ["Spawn location"] = "Team 1 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Team 2 spawn"] = {
        [1] = {
          ["Spawn location"] = "Team 2 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Team 4 start"] = {
        [1] = {
          ["Spawn location"] = "Team 4 start",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Team 1 start"] = {
        [1] = {
          ["Spawn location"] = "Team 1 start",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Team 4 spawn"] = {
        [1] = {
          ["Spawn location"] = "Team 4 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    Teams = {
      ["Team 2 - Opponent"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Team 4 - Opponent"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Team 1 - Player"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Team 3 - Opponent"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionSettings = {
      ["New MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Enable traffic at mission end"] = true,
          ["disablePlayerIgnoring"] = false,
          ["Spawn type"] = "Always active",
          ["Delete task object on reject preview"] = false,
          ["Start location"] = "RelayRaceStart",
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    WarmupTypes = {
      ["New Static"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          forceZapToVehicle = false,
          forceMissionAccept = false,
          lookToVehicle = false
        },
        ["name"] = "Static"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    MissionInfos = {
      ["New Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:184679",
          ["showRouteArrows"] = "All",
          ["missionMarkers"] = {
            [1] = {
              value = "Opponent",
              cardName = "Team 4 Racer 3",
              cardType = "Actor"
            },
            [2] = {
              value = "Opponent",
              cardName = "Team 3 Racer 3",
              cardType = "Actor"
            },
            [3] = {
              value = "Opponent",
              cardName = "Team 3 Racer 1",
              cardType = "Actor"
            },
            [4] = {
              value = "Opponent",
              cardName = "Team 4 Racer 1",
              cardType = "Actor"
            },
            [5] = {
              value = "Opponent",
              cardName = "Team 2 Racer 2",
              cardType = "Actor"
            },
            [6] = {
              value = "Opponent",
              cardName = "Team 2 Racer 3",
              cardType = "Actor"
            },
            [7] = {
              value = "Objective",
              cardName = "Team 1 Racer 1",
              cardType = "Actor"
            },
            [8] = {
              value = "Opponent",
              cardName = "Team 3 Racer 2",
              cardType = "Actor"
            },
            [9] = {
              value = "Objective",
              cardName = "Team 1 Racer 3",
              cardType = "Actor"
            },
            [10] = {
              value = "Opponent",
              cardName = "Team 2 Racer 1",
              cardType = "Actor"
            },
            [11] = {
              value = "Opponent",
              cardName = "Team 4 Racer 2",
              cardType = "Actor"
            },
            [12] = {
              value = "Objective",
              cardName = "Team 1 Racer 2",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Relay race"] = {
        [1] = {
          ["Slow motion on goal complete"] = false,
          ["Score jump distance"] = false,
          ["Overtake target (+ score)"] = false,
          ["Race team 2"] = {
            instance = 1,
            type = "Teams",
            name = "Team 3 - Opponent"
          },
          ["Score drift distance"] = false,
          ["Race team 1"] = {
            instance = 1,
            type = "Teams",
            name = "Team 1 - Player"
          },
          ["Hide checkpoints"] = false,
          ["Race team 3"] = {
            instance = 1,
            type = "Teams",
            name = "Team 2 - Opponent"
          },
          ["Destroy opposing teams"] = false,
          ["Race team 4"] = {
            instance = 1,
            type = "Teams",
            name = "Team 4 - Opponent"
          }
        },
        ["name"] = "Relay race"
      }
    }
  }
}
