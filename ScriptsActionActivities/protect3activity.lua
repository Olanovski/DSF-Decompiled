cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.Protect3Activity = {
  FileVersion = "2",
  name = "Protect3Activity",
  title = "ID:244229",
  MissionID = "1453",
  description = "ID:231119",
  cardInstances = {
    Actors = {
      ["Attacker 700m North"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          desiredSpeed = 60,
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
            name = "Attacker Vehicle Driver"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          driveInOncoming = 0.8,
          driveOnPavements = 0.8,
          noOccupants = false,
          vehicleId = 176,
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
            name = "700m North position"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 60,
          damageMultiplier = 12,
          attackStationaryVehicle = true,
          aiIgnorePlayerInCivsUntilHit = true,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = true,
          blockTow = false,
          ignoreCivilianTraffic = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Attacker 1000m East"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
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
            name = "Attacker Vehicle Driver"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          driveInOncoming = 0.8,
          driveOnPavements = 0.8,
          noOccupants = false,
          vehicleId = 176,
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
            name = "1000m East position"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 50,
          damageMultiplier = 12,
          attackStationaryVehicle = true,
          aiIgnorePlayerInCivsUntilHit = true,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = true,
          blockTow = false,
          ignoreCivilianTraffic = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Attacker 1000m South Large"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
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
            name = "Attacker Vehicle Driver"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          driveInOncoming = 0.8,
          driveOnPavements = 0.8,
          noOccupants = false,
          vehicleId = 251,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 6,
          avoidUTurns = false,
          groupAggression = "Evil",
          avoidAlleys = 1,
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "1000m South position"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = false,
          maximumDamagePerCollision = 0.5,
          spawnSpeed = 50,
          damageMultiplier = 12,
          attackStationaryVehicle = true,
          aiIgnorePlayerInCivsUntilHit = true,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = true,
          blockTow = false,
          ignoreCivilianTraffic = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Attacker 1000m West"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
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
            name = "Attacker Vehicle Driver"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          driveInOncoming = 0.8,
          driveOnPavements = 0.8,
          noOccupants = false,
          vehicleId = 176,
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
            name = "1000m West position"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 50,
          damageMultiplier = 12,
          attackStationaryVehicle = true,
          aiIgnorePlayerInCivsUntilHit = true,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = true,
          blockTow = false,
          ignoreCivilianTraffic = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Attacker 1000m East Large"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
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
            name = "Attacker Vehicle Driver"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          driveInOncoming = 0.8,
          driveOnPavements = 0.8,
          noOccupants = false,
          vehicleId = 251,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 6,
          avoidUTurns = false,
          groupAggression = "Evil",
          avoidAlleys = 1,
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "1000m East position"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = false,
          maximumDamagePerCollision = 0.5,
          spawnSpeed = 50,
          damageMultiplier = 12,
          attackStationaryVehicle = true,
          aiIgnorePlayerInCivsUntilHit = true,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = true,
          blockTow = false,
          ignoreCivilianTraffic = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Attacker 700m West"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          desiredSpeed = 60,
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
            name = "Attacker Vehicle Driver"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          driveInOncoming = 0.8,
          driveOnPavements = 0.8,
          noOccupants = false,
          vehicleId = 176,
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
            name = "700m West position"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 60,
          damageMultiplier = 12,
          attackStationaryVehicle = true,
          aiIgnorePlayerInCivsUntilHit = true,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = true,
          blockTow = false,
          ignoreCivilianTraffic = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Attacker 1000m North"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
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
            name = "Attacker Vehicle Driver"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          driveInOncoming = 0.8,
          driveOnPavements = 0.8,
          noOccupants = false,
          vehicleId = 176,
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
            name = "1000m North position"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 50,
          damageMultiplier = 12,
          attackStationaryVehicle = true,
          aiIgnorePlayerInCivsUntilHit = true,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = true,
          blockTow = false,
          ignoreCivilianTraffic = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Attacker 700m East"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          desiredSpeed = 60,
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
            name = "Attacker Vehicle Driver"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          driveInOncoming = 0.8,
          driveOnPavements = 0.8,
          noOccupants = false,
          vehicleId = 176,
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
            name = "700m East position"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 60,
          damageMultiplier = 12,
          attackStationaryVehicle = true,
          aiIgnorePlayerInCivsUntilHit = true,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = true,
          blockTow = false,
          ignoreCivilianTraffic = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Attacker 1000m South"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
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
            name = "Attacker Vehicle Driver"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          driveInOncoming = 0.8,
          driveOnPavements = 0.8,
          noOccupants = false,
          vehicleId = 176,
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
            name = "1000m South position"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 50,
          damageMultiplier = 12,
          attackStationaryVehicle = true,
          aiIgnorePlayerInCivsUntilHit = true,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = true,
          blockTow = false,
          ignoreCivilianTraffic = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Attacker 1000m West Large"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
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
            name = "Attacker Vehicle Driver"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          driveInOncoming = 0.8,
          driveOnPavements = 0.8,
          noOccupants = false,
          vehicleId = 251,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 6,
          avoidUTurns = false,
          groupAggression = "Evil",
          avoidAlleys = 1,
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "1000m West position"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = false,
          maximumDamagePerCollision = 0.5,
          spawnSpeed = 50,
          damageMultiplier = 12,
          attackStationaryVehicle = true,
          aiIgnorePlayerInCivsUntilHit = true,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = true,
          blockTow = false,
          ignoreCivilianTraffic = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Attacker 700m South"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          desiredSpeed = 60,
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
            name = "Attacker Vehicle Driver"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          driveInOncoming = 0.8,
          driveOnPavements = 0.8,
          noOccupants = false,
          vehicleId = 176,
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
            name = "700m South position"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 60,
          damageMultiplier = 12,
          attackStationaryVehicle = true,
          aiIgnorePlayerInCivsUntilHit = true,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = true,
          blockTow = false,
          ignoreCivilianTraffic = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Attacker 1000m North Large"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
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
            name = "Attacker Vehicle Driver"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          driveInOncoming = 0.1,
          driveOnPavements = 0.1,
          noOccupants = false,
          vehicleId = 251,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 6,
          avoidUTurns = false,
          groupAggression = "Evil",
          avoidAlleys = 1,
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "1000m North position"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = false,
          maximumDamagePerCollision = 0.5,
          spawnSpeed = 50,
          damageMultiplier = 12,
          attackStationaryVehicle = true,
          aiIgnorePlayerInCivsUntilHit = true,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = true,
          blockTow = false,
          ignoreCivilianTraffic = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Attacked Vehicle"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Protect team"
          },
          drivingSkill = "Average",
          characters = {
            instance = 1,
            type = "Characters",
            name = "Attacked Vehicle Driver"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          driveInOncoming = 0.1,
          driveOnPavements = 0.1,
          noOccupants = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Attacked vehicle set position"
          },
          vehicleId = 301,
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          vehicleTrailerId = -1,
          shaderParam = 0,
          enableSiren = false,
          stayInLockedArea = false,
          previewMovie = " ",
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static"
          },
          avoidAttacks = false,
          enableSimulationArea = false,
          matchTrafficSpeed = false,
          aiIgnorePlayerInCivsUntilHit = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Attacker Vehicle Driver"] = {
        [1] = {
          ["Driver id"] = "1169626408"
        },
        ["name"] = "Character"
      },
      ["Attacked Vehicle Driver"] = {
        [1] = {
          ["Driver id"] = "-1490034552"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      Protect3Activity = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Protect3Activity",
          ["disablePlayerIgnoring"] = false,
          ["Spawn type"] = "Always active",
          ["Delete task object on reject preview"] = false,
          ["Hud logic file"] = "Protect 3 HUD",
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["Attack team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Protect team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    SpawnTypes = {
      ["700m North position"] = {
        [1] = {
          ["Spawn location"] = "700m North position spawn 3",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["700m East position"] = {
        [1] = {
          ["Spawn location"] = "700m East position spawn 3",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["700m South position"] = {
        [1] = {
          ["Spawn location"] = "700m South position spawn 3",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Relative to 1000m East"] = {
        [1] = {
          actor = "Attacker 1000m East",
          whichLane = "randomLane",
          withVehicleDirection = true,
          distance = 5,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = false
        },
        ["name"] = "Relative to Vehicle"
      },
      ["Relative to 1000m North"] = {
        [1] = {
          actor = "Attacker 1000m North",
          whichLane = "randomLane",
          withVehicleDirection = true,
          distance = 5,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = false
        },
        ["name"] = "Relative to Vehicle"
      },
      ["700m West position"] = {
        [1] = {
          ["Spawn location"] = "700m West position spawn 3",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["1000m East position"] = {
        [1] = {
          ["Spawn location"] = "1000m East position spawn 3",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["1000m North position"] = {
        [1] = {
          ["Spawn location"] = "1000m North position spawn 3",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Relative to 1000m West"] = {
        [1] = {
          actor = "Attacker 1000m West",
          whichLane = "randomLane",
          withVehicleDirection = true,
          distance = 5,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = false
        },
        ["name"] = "Relative to Vehicle"
      },
      ["1000m West position"] = {
        [1] = {
          ["Spawn location"] = "1000m West position spawn 3",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["1000m South position"] = {
        [1] = {
          ["Spawn location"] = "1000m South position spawn 3",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Attacked vehicle set position"] = {
        [1] = {
          ["Spawn location"] = "Attacked Vehicle Protect 3",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Relative to 1000m South"] = {
        [1] = {
          actor = "Attacker 1000m South",
          whichLane = "randomLane",
          withVehicleDirection = true,
          distance = 5,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = false
        },
        ["name"] = "Relative to Vehicle"
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
          ["1 Text"] = "ID:231119",
          ["missionMarkers"] = {
            [1] = {
              value = "Opponent",
              cardName = "Attacker 1000m South Large",
              cardType = "Actor"
            },
            [2] = {
              value = "Opponent",
              cardName = "Attacker 700m South",
              cardType = "Actor"
            },
            [3] = {
              value = "Opponent",
              cardName = "Attacker 1000m West Large",
              cardType = "Actor"
            },
            [4] = {
              value = "Opponent",
              cardName = "Attacker 1000m East Large",
              cardType = "Actor"
            },
            [5] = {
              value = "Opponent",
              cardName = "Attacker 1000m North",
              cardType = "Actor"
            },
            [6] = {
              value = "Objective",
              cardName = "Attacked Vehicle",
              cardType = "Actor"
            },
            [7] = {
              value = "Opponent",
              cardName = "Attacker 1000m South",
              cardType = "Actor"
            },
            [8] = {
              value = "Opponent",
              cardName = "Attacker 700m North",
              cardType = "Actor"
            },
            [9] = {
              value = "Opponent",
              cardName = "Attacker 1000m North Large",
              cardType = "Actor"
            },
            [10] = {
              value = "Opponent",
              cardName = "Attacker 1000m East",
              cardType = "Actor"
            },
            [11] = {
              value = "Opponent",
              cardName = "Attacker 700m East",
              cardType = "Actor"
            },
            [12] = {
              value = "Opponent",
              cardName = "Attacker 700m West",
              cardType = "Actor"
            },
            [13] = {
              value = "Opponent",
              cardName = "Attacker 1000m West",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["Generic protect activity"] = {
        [1] = {
          ["S3 Spawn Delay"] = 1,
          ["Protect team"] = {
            instance = 1,
            type = "Teams",
            name = "Protect team"
          },
          ["S1 Pickups"] = true,
          ["Time limit"] = 180,
          ["S2 Spawn Delay"] = 2,
          ["S1 Spawn Delay"] = 1,
          ["Truck damage"] = 0.2,
          ["S3 Pickups"] = false,
          ["S3 Max Attackers"] = 5,
          ["S3 Doubles"] = false,
          ["S2 Pickups"] = false,
          ["S2 Max Attackers"] = 3,
          ["S2 Doubles"] = false,
          ["S1 Doubles"] = false,
          ["Attack team"] = {
            instance = 1,
            type = "Teams",
            name = "Attack team"
          },
          ["S1 Max Attackers"] = 4
        },
        ["name"] = "Generic protect activity"
      }
    }
  }
}
