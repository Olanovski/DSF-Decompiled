cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Exposition pre crash chase"] = {
  FileVersion = "2",
  name = "Exposition pre crash chase",
  title = "ID:182822",
  MissionID = "4855",
  description = "ID:221952",
  cardInstances = {
    Actors = {
      ["Wrecked Cop"] = {
        [1] = {
          stayInLockedArea = false,
          vehicleId = 271,
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          matchTrafficSpeed = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Wrecked cop spawn position"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "Static Team"
          },
          enableSiren = true,
          drivingSkill = "Professional",
          groupAggression = "DejaVu",
          aiIgnorePlayers = false,
          enableSimulationArea = true,
          reactionTime = "Fastest",
          matchTrafficSpeedMultiplier = 1,
          attackStationaryVehicle = true,
          forceHighLodCharacters = false,
          damageMultiplier = 0,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On mission start",
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop characters"
          },
          avoidAttacks = false,
          avoidAlleys = 0,
          tailingDistance = 0,
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      ["Approaching cop 2"] = {
        [1] = {
          wrongWayIndicator = false,
          matchTrafficSpeed = false,
          aiIgnorePlayers = true,
          desiredSpeed = 30,
          team = {
            instance = 1,
            type = "Teams",
            name = "Crash Team"
          },
          drivingSkill = "Professional",
          matchTrafficSpeedMultiplier = 1,
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 0,
          driveOnPavements = 0.1,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = true,
          avoidAlleys = 0,
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Approaching cop spawn position"
          },
          ramInFrontDistance = 100,
          spawnSpeed = 30,
          vehicleTrailerId = -1,
          vehicleId = 271,
          damageMultiplier = 0,
          attackStationaryVehicle = true,
          enableSiren = true,
          enableSimulationArea = false,
          stayInLockedArea = false,
          ignoreCivilianTraffic = false,
          collisionResilience = "Unstoppable",
          avoidAttacks = false,
          reactionTime = "Fastest",
          groupAggression = "DejaVu",
          driveInOncoming = 1
        },
        ["name"] = "Actor"
      },
      ["Cop"] = {
        [1] = {
          wrongWayIndicator = false,
          matchTrafficSpeed = false,
          aiIgnorePlayers = true,
          desiredSpeed = 110,
          team = {
            instance = 1,
            type = "Teams",
            name = "Crash Team"
          },
          drivingSkill = "Professional",
          matchTrafficSpeedMultiplier = 1,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop characters"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 0,
          vehicleTrailerId = -1,
          isMultiplayerActor = false,
          avoidUTurns = false,
          groupAggression = "DejaVu",
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "cop spawn position"
          },
          vehicleId = 271,
          spawnSpeed = 60,
          damageMultiplier = 0,
          attackStationaryVehicle = true,
          reactionTime = "Fastest",
          stayInLockedArea = false,
          enableSiren = true,
          enableSimulationArea = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = true,
          ignoreCivilianTraffic = false,
          avoidAlleys = 0
        },
        ["name"] = "Actor"
      },
      ["Fire Truck"] = {
        [1] = {
          maintainLane = false,
          vehicleId = 185,
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          matchTrafficSpeed = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = true,
          aiIgnorePlayers = false,
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Fire Truck spawn position"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "Crash Team"
          },
          enableSiren = true,
          drivingSkill = "Professional",
          avoidAlleys = 0,
          spawnSpeed = 60,
          desiredSpeed = 100,
          enableSimulationArea = false,
          matchTrafficSpeedMultiplier = 1,
          attackStationaryVehicle = false,
          forceHighLodCharacters = false,
          reactionTime = "Average",
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          stayInLockedArea = false,
          whenSpawned = "Never",
          damageMultiplier = 0,
          avoidAttacks = false,
          collisionResilience = "Unstoppable",
          tailingDistance = 0,
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      ["Civ 2"] = {
        [1] = {
          wrongWayIndicator = false,
          reactionTime = "Fastest",
          damageCauseScale = 1,
          ignoreCivilianTraffic = true,
          team = {
            instance = 1,
            type = "Teams",
            name = "Bus Team"
          },
          drivingSkill = "Professional",
          matchTrafficSpeedMultiplier = 1,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Jericho Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Civ 2 spawn position"
          },
          ramInFrontDistance = 300,
          spawnSpeed = 40,
          vehicleId = 128,
          damageMultiplier = 0,
          attackStationaryVehicle = true,
          enableSiren = false,
          enableSimulationArea = true,
          stayInLockedArea = false,
          avoidAlleys = 0,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          groupAggression = "DejaVu",
          aiIgnorePlayers = false,
          desiredSpeed = 30
        },
        ["name"] = "Actor"
      },
      ["Lost cop 2"] = {
        [1] = {
          wrongWayIndicator = false,
          matchTrafficSpeed = false,
          aiIgnorePlayers = true,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Crash Team"
          },
          drivingSkill = "Professional",
          matchTrafficSpeedMultiplier = 1,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop characters"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 0,
          driveOnPavements = 0.2,
          isMultiplayerActor = false,
          avoidUTurns = false,
          groupAggression = "DejaVu",
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Lost cop spawn position"
          },
          vehicleId = 271,
          spawnSpeed = 60,
          vehicleTrailerId = -1,
          damageMultiplier = 0,
          attackStationaryVehicle = true,
          enableSiren = true,
          enableSimulationArea = false,
          stayInLockedArea = false,
          desiredSpeed = 50,
          avoidedByCivilianTraffic = true,
          avoidAttacks = false,
          reactionTime = "Fastest",
          avoidAlleys = 0,
          driveInOncoming = 0.5
        },
        ["name"] = "Actor"
      },
      ["Ambulance 2"] = {
        [1] = {
          maintainLane = false,
          vehicleId = 276,
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          matchTrafficSpeed = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = true,
          aiIgnorePlayers = false,
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Ambulance 2 spawn position"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "Static Team"
          },
          enableSiren = true,
          drivingSkill = "Professional",
          avoidAlleys = 0,
          spawnSpeed = 60,
          desiredSpeed = 90,
          enableSimulationArea = false,
          matchTrafficSpeedMultiplier = 1,
          attackStationaryVehicle = false,
          forceHighLodCharacters = false,
          reactionTime = "Average",
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          stayInLockedArea = false,
          whenSpawned = "Never",
          damageMultiplier = 0,
          avoidAttacks = false,
          collisionResilience = "Unstoppable",
          tailingDistance = 0,
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      ["Wrecked Cop 3"] = {
        [1] = {
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          stayInLockedArea = false,
          avoidUTurns = false,
          vehicleId = 271,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Wrecked cop 3 spawn position"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "Static Team"
          },
          matchTrafficSpeed = false,
          enableSimulationArea = false,
          aiIgnorePlayers = false,
          enableSiren = true,
          drivingSkill = "Professional",
          reactionTime = "Average",
          matchTrafficSpeedMultiplier = 1,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop characters"
          },
          forceHighLodCharacters = false,
          damageMultiplier = 0,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          attackStationaryVehicle = false,
          avoidAttacks = false,
          avoidAlleys = 0,
          tailingDistance = 0,
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      ["Civ cop crash"] = {
        [1] = {
          wrongWayIndicator = false,
          matchTrafficSpeed = true,
          damageCauseScale = 1,
          ignoreCivilianTraffic = true,
          team = {
            instance = 1,
            type = "Teams",
            name = "Bus Team"
          },
          drivingSkill = "Professional",
          matchTrafficSpeedMultiplier = 1,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop characters"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0.25,
          driveOnPavements = 0,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Cop hit spawn position"
          },
          vehicleId = 179,
          spawnSpeed = 50,
          damageMultiplier = 0,
          attackStationaryVehicle = false,
          vehicleTrailerId = -1,
          shaderParam = 2,
          enableSiren = false,
          stayInLockedArea = false,
          enableSimulationArea = true,
          collisionResilience = "Unstoppable",
          avoidAttacks = false,
          reactionTime = "Average",
          aiIgnorePlayers = false,
          desiredSpeed = 40
        },
        ["name"] = "Actor"
      },
      ["Approaching cop"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          matchTrafficSpeed = false,
          aiIgnorePlayers = true,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Crash Team"
          },
          drivingSkill = "Professional",
          matchTrafficSpeedMultiplier = 1,
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 0,
          vehicleTrailerId = -1,
          noOccupants = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          groupAggression = "DejaVu",
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Approaching cop spawn position"
          },
          ramInFrontDistance = 100,
          spawnSpeed = 60,
          vehicleId = 271,
          damageMultiplier = 0,
          attackStationaryVehicle = true,
          enableSiren = true,
          enableSimulationArea = false,
          stayInLockedArea = false,
          reactionTime = "Fastest",
          avoidedByCivilianTraffic = true,
          avoidAttacks = false,
          desiredSpeed = 110,
          avoidAlleys = 0,
          driveInOncoming = 1
        },
        ["name"] = "Actor"
      },
      ["Tanner"] = {
        [1] = {
          wrongWayIndicator = false,
          reactionTime = "Average",
          aiIgnorePlayers = false,
          routeName = "Pre Crash Jericho Chase Route",
          team = {
            instance = 1,
            type = "Teams",
            name = "Tanner team"
          },
          drivingSkill = "Professional",
          characters = {
            instance = 1,
            type = "Characters",
            name = "Tanner Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          driveInOncoming = 0.5,
          driveOnPavements = 0.5,
          previewMovie = "no preview",
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Cutscene 2"
          },
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Tanner spawn position"
          },
          vehicleId = 62,
          vehicleTrailerId = -1,
          damageMultiplier = 0,
          attackStationaryVehicle = false,
          shaderParam = 0,
          enableSiren = false,
          isMultiplayerActor = false,
          stayInLockedArea = false,
          enableSimulationArea = true,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          avoidAlleys = 0,
          ignoreCivilianTraffic = true,
          desiredSpeed = 60
        },
        ["name"] = "Actor"
      },
      ["Garbage"] = {
        [1] = {
          wrongWayIndicator = false,
          matchTrafficSpeed = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = true,
          team = {
            instance = 1,
            type = "Teams",
            name = "Bus Team"
          },
          drivingSkill = "Professional",
          matchTrafficSpeedMultiplier = 1,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Jericho Character"
          },
          forceHighLodCharacters = false,
          wanderType = "preferLeft",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0.25,
          driveOnPavements = 0,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Garbage spawn position"
          },
          vehicleId = 284,
          spawnSpeed = 50,
          damageMultiplier = 0,
          attackStationaryVehicle = false,
          vehicleTrailerId = -1,
          shaderParam = 2,
          stayInLockedArea = false,
          enableSiren = false,
          enableSimulationArea = true,
          avoidAttacks = false,
          reactionTime = "Average",
          desiredSpeed = 40,
          collisionResilience = "Unstoppable"
        },
        ["name"] = "Actor"
      },
      ["Fire Truck 2"] = {
        [1] = {
          maintainLane = false,
          vehicleId = 185,
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          matchTrafficSpeed = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = true,
          aiIgnorePlayers = false,
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Fire Truck 2 spawn position"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "Crash Team"
          },
          enableSiren = true,
          drivingSkill = "Professional",
          avoidAlleys = 0,
          spawnSpeed = 60,
          desiredSpeed = 100,
          enableSimulationArea = false,
          matchTrafficSpeedMultiplier = 1,
          attackStationaryVehicle = false,
          forceHighLodCharacters = false,
          reactionTime = "Average",
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          stayInLockedArea = false,
          whenSpawned = "Never",
          damageMultiplier = 0,
          avoidAttacks = false,
          collisionResilience = "Unstoppable",
          tailingDistance = 0,
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      ["Alley cop"] = {
        [1] = {
          wrongWayIndicator = false,
          matchTrafficSpeed = false,
          aiIgnorePlayers = true,
          ignoreCivilianTraffic = true,
          team = {
            instance = 1,
            type = "Teams",
            name = "Crash Team"
          },
          drivingSkill = "Professional",
          matchTrafficSpeedMultiplier = 1,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop characters"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 0,
          driveOnPavements = 1,
          isMultiplayerActor = false,
          avoidUTurns = false,
          groupAggression = "DejaVu",
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Alley cop spawn position"
          },
          vehicleId = 271,
          spawnSpeed = 60,
          vehicleTrailerId = -1,
          damageMultiplier = 0,
          attackStationaryVehicle = true,
          enableSiren = true,
          enableSimulationArea = false,
          stayInLockedArea = false,
          desiredSpeed = 60,
          avoidedByCivilianTraffic = true,
          avoidAttacks = false,
          reactionTime = "Fastest",
          avoidAlleys = 0,
          driveInOncoming = 0.5
        },
        ["name"] = "Actor"
      },
      ["Ambulance"] = {
        [1] = {
          maintainLane = false,
          vehicleId = 276,
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          matchTrafficSpeed = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = true,
          aiIgnorePlayers = false,
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Ambulance spawn position"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "Static Team"
          },
          enableSiren = true,
          drivingSkill = "Professional",
          avoidAlleys = 0,
          spawnSpeed = 60,
          desiredSpeed = 90,
          enableSimulationArea = false,
          matchTrafficSpeedMultiplier = 1,
          attackStationaryVehicle = false,
          forceHighLodCharacters = false,
          reactionTime = "Average",
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          stayInLockedArea = false,
          whenSpawned = "Never",
          damageMultiplier = 0,
          avoidAttacks = false,
          collisionResilience = "Unstoppable",
          tailingDistance = 0,
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      ["Jericho"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 135,
          team = {
            instance = 1,
            type = "Teams",
            name = "Jericho Team"
          },
          drivingSkill = "Over-cautious",
          characters = {
            instance = 1,
            type = "Characters",
            name = "Jericho Character"
          },
          forceHighLodCharacters = true,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On mission start",
          driveInOncoming = 0.5,
          driveOnPavements = 0,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          enableSiren = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          raceManagerRoute = true,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Jericho Set position"
          },
          vehicleId = 277,
          enableSimulationArea = true,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 30,
          rubberbandingActor = "Tanner",
          damageCauseScale = 5000,
          damageMultiplier = 0,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -10,
          reactionTime = "Average",
          collisionResilience = "Unstoppable",
          stayInLockedArea = false,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          ignoreCivilianTraffic = true,
          routeName = "Pre Crash Jericho Chase Route"
        },
        ["name"] = "Actor"
      },
      ["Lost cop 1"] = {
        [1] = {
          wrongWayIndicator = false,
          matchTrafficSpeed = false,
          aiIgnorePlayers = true,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Static Team"
          },
          drivingSkill = "Professional",
          matchTrafficSpeedMultiplier = 1,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop characters"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 0,
          driveOnPavements = 0.2,
          isMultiplayerActor = false,
          avoidUTurns = false,
          groupAggression = "DejaVu",
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Lost cop spawn position"
          },
          vehicleId = 271,
          spawnSpeed = 60,
          vehicleTrailerId = -1,
          damageMultiplier = 0,
          attackStationaryVehicle = true,
          enableSiren = true,
          enableSimulationArea = false,
          stayInLockedArea = false,
          desiredSpeed = 60,
          avoidedByCivilianTraffic = true,
          avoidAttacks = false,
          reactionTime = "Fastest",
          avoidAlleys = 0,
          driveInOncoming = 0.5
        },
        ["name"] = "Actor"
      },
      ["Civ 1"] = {
        [1] = {
          wrongWayIndicator = false,
          reactionTime = "Fastest",
          damageCauseScale = 1,
          ignoreCivilianTraffic = true,
          team = {
            instance = 1,
            type = "Teams",
            name = "Crash Team"
          },
          drivingSkill = "Professional",
          matchTrafficSpeedMultiplier = 1,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Jericho Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Civ 1 spawn position"
          },
          ramInFrontDistance = 300,
          spawnSpeed = 40,
          vehicleId = 272,
          damageMultiplier = 0,
          attackStationaryVehicle = true,
          enableSiren = false,
          enableSimulationArea = true,
          stayInLockedArea = false,
          avoidAlleys = 0,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          groupAggression = "DejaVu",
          aiIgnorePlayers = false,
          desiredSpeed = 110
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Tanner Character"] = {
        [1] = {
          ["Passenger id"] = "-1916574018",
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      },
      ["Jericho Character"] = {
        [1] = {
          ["Driver id"] = "-376150524"
        },
        ["name"] = "Character"
      },
      ["Cop characters"] = {
        [1] = {
          ["Driver id"] = "-1907524522"
        },
        ["name"] = "Character"
      }
    },
    SpawnTypes = {
      ["Wrecked cop 3 spawn position"] = {
        [1] = {
          ["Spawn location"] = "Exposition part 1 cop wrecked 3",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Ambulance 2 spawn position"] = {
        [1] = {
          ["Spawn location"] = "Exposition part 1 ambulance 2",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Lost cop spawn position"] = {
        [1] = {
          ["Spawn location"] = "Exposition part 1 lost cop 1",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Garbage spawn position"] = {
        [1] = {
          ["Spawn location"] = "Exposition part 1 garbage",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Alley cop spawn position"] = {
        [1] = {
          ["Spawn location"] = "Exposition part 1 alley cop",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Wrecked cop spawn position"] = {
        [1] = {
          ["Spawn location"] = "Exposition part 1 cop wrecked",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Approaching cop 2 spawn position"] = {
        [1] = {
          ["Spawn location"] = "Exposition part 1 cop 2 approaching",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Ambulance spawn position"] = {
        [1] = {
          ["Spawn location"] = "Exposition part 1 ambulance",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Cop hit spawn position"] = {
        [1] = {
          ["Spawn location"] = "Exposition part 1 cop hit",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Civ 1 spawn position"] = {
        [1] = {
          ["Spawn location"] = "Exposition part 1 civ crash 1",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Approaching cop spawn position"] = {
        [1] = {
          ["Spawn location"] = "Exposition part 1 cop approaching",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Tanner spawn position"] = {
        [1] = {
          ["Spawn location"] = "Exposition pre crash chase tanner",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Civ 2 spawn position"] = {
        [1] = {
          ["Spawn location"] = "Exposition part 1 civ crash 2",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Fire Truck 2 spawn position"] = {
        [1] = {
          ["Spawn location"] = "Exposition part 1 fire truck 2",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Lost cop 2 spawn position"] = {
        [1] = {
          ["Spawn location"] = "Exposition part 1 lost cop 2",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Fire Truck spawn position"] = {
        [1] = {
          ["Spawn location"] = "Exposition part 1 fire truck",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["cop spawn position"] = {
        [1] = {
          ["Spawn location"] = "Exposition part 1 cop",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Jericho Set position"] = {
        [1] = {
          ["Spawn location"] = "Exposition pre crash chase jericho",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    Teams = {
      ["Tanner team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Bus Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Jericho Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Static Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Crash Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    FelonySettings = {
      ["New FelonySettings 2"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    WarmupTypes = {
      ["New Static 2"] = {
        [1] = {forceZapToVehicle = false, lookToVehicle = false},
        ["name"] = "Static"
      },
      ["New Cutscene 2"] = {
        [1] = {forceMissionAccept = true},
        ["name"] = "Cutscene"
      }
    },
    MissionSettings = {
      ["New MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Disable traffic"] = false,
          ["Clear area around vehicles"] = 20,
          ["Mission props"] = "ExpositionPreCrashChase",
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Exposition pre crash chase jericho mission start",
          ["Audio logic file"] = "Exposition pre crash jericho chase",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = true,
          ["disablePlayerIgnoring"] = false,
          ["Enable race status prompts"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    MissionInfos = {
      [" Title and description"] = {
        [1] = {
          missionMarkers = {
            [1] = {
              value = "None",
              cardName = "Lost cop 2",
              cardType = "Actor"
            },
            [2] = {
              value = "None",
              cardName = "Ambulance 2",
              cardType = "Actor"
            },
            [3] = {
              value = "None",
              cardName = "Civ 1",
              cardType = "Actor"
            },
            [4] = {
              value = "None",
              cardName = "Lost cop 1",
              cardType = "Actor"
            },
            [5] = {
              value = "None",
              cardName = "Civ 2",
              cardType = "Actor"
            },
            [6] = {
              value = "None",
              cardName = "Alley cop",
              cardType = "Actor"
            },
            [7] = {
              value = "None",
              cardName = "Civ cop crash",
              cardType = "Actor"
            },
            [8] = {
              value = "None",
              cardName = "Tanner",
              cardType = "Actor"
            },
            [9] = {
              value = "None",
              cardName = "Cop",
              cardType = "Actor"
            },
            [10] = {
              value = "None",
              cardName = "Approaching cop 2",
              cardType = "Actor"
            },
            [11] = {
              value = "None",
              cardName = "Garbage",
              cardType = "Actor"
            },
            [12] = {
              value = "None",
              cardName = "Approaching cop",
              cardType = "Actor"
            },
            [13] = {
              value = "None",
              cardName = "Wrecked Cop 3",
              cardType = "Actor"
            },
            [14] = {
              value = "None",
              cardName = "Fire Truck",
              cardType = "Actor"
            },
            [15] = {
              value = "Red Marker, No Health Bar",
              cardName = "Jericho",
              cardType = "Actor"
            },
            [16] = {
              value = "None",
              cardName = "Wrecked Cop",
              cardType = "Actor"
            },
            [17] = {
              value = "None",
              cardName = "Fire Truck 2",
              cardType = "Actor"
            },
            [18] = {
              value = "None",
              cardName = "Ambulance",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Exposition pre crash chase"] = {
        [1] = {
          ["Jericho team"] = {
            instance = 1,
            type = "Teams",
            name = "Jericho Team"
          },
          ["Crash Team"] = {
            instance = 1,
            type = "Teams",
            name = "Crash Team"
          },
          ["Bus Team"] = {
            instance = 1,
            type = "Teams",
            name = "Bus Team"
          },
          ["Static Team"] = {
            instance = 1,
            type = "Teams",
            name = "Static Team"
          },
          ["Tanner team"] = {
            instance = 1,
            type = "Teams",
            name = "Tanner team"
          }
        },
        ["name"] = "Exposition pre crash chase"
      }
    }
  }
}
