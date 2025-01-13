cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Heat From Above"] = {
  FileVersion = "2",
  name = "Heat From Above",
  title = "ID:184463",
  MissionID = "15056",
  description = "ID:184464",
  cardInstances = {
    Actors = {
      ["Chasing Goon Front Smash 3"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 150,
          team = {
            instance = 1,
            type = "Teams",
            name = "Exploder Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Chasing Goon 1 and 5 "
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0.8,
          driveOnPavements = 0.6,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAlleys = 0,
          raceManagerRoute = false,
          vehicleTrailerId = -1,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Relative to Vehicle Ahead Facing 200"
          },
          vehicleId = 266,
          shaderParam = 2,
          enableSiren = false,
          spawnSpeed = 120,
          enableSimulationArea = false,
          damageMultiplier = 0.5,
          attackStationaryVehicle = true,
          avoidedByCivilianTraffic = false,
          reactionTime = "Fastest",
          stayInLockedArea = false,
          blockTow = false,
          collisionResilience = "Average",
          avoidAttacks = false,
          ignoreCivilianTraffic = false,
          groupAggression = "Relentless"
        },
        ["name"] = "Actor"
      },
      ["Chasing Goon Front Smash 1"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 150,
          team = {
            instance = 1,
            type = "Teams",
            name = "Exploder Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Chasing Goon 1 and 5 "
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 1,
          driveOnPavements = 1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAlleys = 0,
          raceManagerRoute = false,
          vehicleId = 266,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Relative to Vehicle Ahead Facing 200"
          },
          ramInFrontDistance = 200,
          shaderParam = 2,
          enableSiren = false,
          spawnSpeed = 120,
          enableSimulationArea = false,
          damageMultiplier = 0.5,
          attackStationaryVehicle = true,
          avoidedByCivilianTraffic = false,
          reactionTime = "Fastest",
          stayInLockedArea = false,
          blockTow = false,
          collisionResilience = "Average",
          avoidAttacks = false,
          ignoreCivilianTraffic = false,
          groupAggression = "Relentless"
        },
        ["name"] = "Actor"
      },
      ["Chaser 1"] = {
        [1] = {
          noOccupants = false,
          lockedToPlayer = false,
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          driveInOncoming = 0,
          avoidUTurns = false,
          vehicleId = 271,
          groupAggression = "High",
          enableSiren = true,
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Chase Spawner"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "Chase team"
          },
          matchTrafficSpeed = false,
          drivingSkill = "Professional",
          avoidedByCivilianTraffic = true,
          spawnSpeed = 70,
          aiIgnorePlayers = false,
          desiredSpeed = 45,
          reactionTime = "Fastest",
          attackStationaryVehicle = false,
          forceHighLodCharacters = false,
          enableSimulationArea = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          collisionResilience = "Unstoppable",
          avoidAttacks = false,
          stayInLockedArea = false,
          tailingDistance = 0,
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      ["Accident emergency 2 cop"] = {
        [1] = {
          noOccupants = false,
          lockedToPlayer = false,
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Accident emergency 2 spawn cop"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "Stationary team"
          },
          drivingSkill = "Average",
          reactionTime = "Average",
          spawnSpeed = 0,
          vehicleId = 271,
          enableSiren = true,
          attackStationaryVehicle = false,
          forceHighLodCharacters = false,
          avoidUTurns = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          enableSimulationArea = false,
          avoidAttacks = false,
          aiIgnorePlayers = false,
          stayInLockedArea = false,
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      ["Racer"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 45,
          team = {
            instance = 1,
            type = "Teams",
            name = "Race team"
          },
          drivingSkill = "Reckless",
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0.2,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = true,
          avoidedByCivilianTraffic = true,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Chase Spawner"
          },
          vehicleId = 242,
          spawnSpeed = 70,
          vehicleTrailerId = -1,
          enableSiren = false,
          shaderParam = 7,
          attackStationaryVehicle = false,
          enableSimulationArea = true,
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          ignoreCivilianTraffic = false,
          routeName = "Heat from above racer",
          aiIgnorePlayerInCivsUntilHit = false
        },
        ["name"] = "Actor"
      },
      ["Truck"] = {
        [1] = {
          trailerPanelSet = 1,
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = true,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 30,
          team = {
            instance = 1,
            type = "Teams",
            name = "Truck Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = true,
          isMultiplayerActor = false,
          avoidUTurns = true,
          trailerShaderParam = 1,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Weak",
          raceManagerRoute = false,
          vehicleTrailerId = 289,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Truck Spawn"
          },
          vehicleId = 286,
          shaderParam = 6,
          enableSiren = false,
          spawnSpeed = 0,
          enableSimulationArea = true,
          damageMultiplier = 0.45,
          attackStationaryVehicle = false,
          routeName = "Heat From Above Truck Route",
          reactionTime = "Average",
          stayInLockedArea = false,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          ignoreOtherAis = false,
          ignoreCivilianTraffic = true,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Firetruck"] = {
        [1] = {
          noOccupants = false,
          lockedToPlayer = false,
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          maintainLane = false,
          reactionTime = "Fastest",
          vehicleId = 185,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 1,
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "Race team"
          },
          avoidUTurns = false,
          drivingSkill = "Professional",
          aiIgnorePlayers = false,
          spawnSpeed = 70,
          routeName = "Heat from above firetruck",
          matchTrafficSpeed = false,
          shaderParam = 0,
          attackStationaryVehicle = false,
          forceHighLodCharacters = false,
          enableSimulationArea = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          stayInLockedArea = false,
          whenSpawned = "Never",
          collisionResilience = "Unstoppable",
          avoidAttacks = false,
          enableSiren = true,
          driveInOncoming = 0.1,
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      ["Chasing Goon Start 1"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Exploder Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Chasing Goon 1 and 5 "
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 1,
          driveOnPavements = 1,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleId = 266,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          shaderParam = 2,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Relative to Vehicle Ahead Facing 300"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 120,
          damageMultiplier = 1.5,
          attackStationaryVehicle = true,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          groupAggression = "Relentless",
          avoidAttacks = false,
          avoidAlleys = 0,
          desiredSpeed = 150,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Ambulance 1"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Race team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = true,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Ambulance spawner"
          },
          vehicleId = 271,
          vehicleTrailerId = -1,
          spawnSpeed = 60,
          enableSiren = true,
          enableSimulationArea = false,
          attackStationaryVehicle = false,
          stayInLockedArea = false,
          blockTow = false,
          routeName = "Heat from above ambulance",
          avoidAttacks = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
          desiredSpeed = 63
        },
        ["name"] = "Actor"
      },
      ["Chasing Goon Front Smash 2"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 150,
          team = {
            instance = 1,
            type = "Teams",
            name = "Exploder Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Chasing Goon 1 and 5 "
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 0,
          driveOnPavements = 1,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleId = 266,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAlleys = 0,
          raceManagerRoute = false,
          shaderParam = 2,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Relative to Vehicle Ahead Facing 200"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 120,
          damageMultiplier = 0.5,
          attackStationaryVehicle = true,
          driveInOncoming = 1,
          collisionResilience = "Tough",
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          ignoreCivilianTraffic = false,
          avoidAttacks = false,
          groupAggression = "Relentless",
          avoidedByCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["Tanner Actor 2"] = {
        [1] = {
          noOccupants = false,
          lockedToPlayer = true,
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          reactionTime = "Average",
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          aiIgnorePlayers = false,
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Tanner 2 position"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "Stationary team"
          },
          vehicleId = 62,
          enableSimulationArea = false,
          shaderParam = 0,
          matchTrafficSpeed = false,
          enableSiren = false,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          forceHighLodCharacters = false,
          collisionResilience = "Average",
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          drivingSkill = "Average",
          avoidAttacks = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "New Character"
          },
          stayInLockedArea = false,
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      ["Tanner Actor"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Tanner Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "New Character"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Tanner Warmup"
          },
          avoidUTurns = true,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Tanner Actor Spawn"
          },
          vehicleId = 62,
          shaderParam = 0,
          enableSiren = false,
          enableSimulationArea = true,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          previewMovie = "asdf",
          stayInLockedArea = false,
          blockTow = false,
          isMultiplayerActor = false,
          avoidAttacks = false,
          matchTrafficSpeed = false,
          desiredSpeed = 40,
          avoidedByCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["Ambulance 3"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Race team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 1,
          driveOnPavements = 1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Ambulance spawner"
          },
          vehicleId = 185,
          vehicleTrailerId = -1,
          spawnSpeed = 68,
          enableSiren = true,
          enableSimulationArea = false,
          attackStationaryVehicle = false,
          stayInLockedArea = false,
          blockTow = false,
          routeName = "Heat from above ambulance",
          avoidAttacks = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
          desiredSpeed = 68
        },
        ["name"] = "Actor"
      },
      ["Chaser 7"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          reactionTime = "Fastest",
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Chase team"
          },
          enableSimulationArea = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 3,
          driveOnPavements = 0,
          noOccupants = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = true,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Relative to Racer"
          },
          vehicleId = 271,
          spawnSpeed = 70,
          attackStationaryVehicle = false,
          vehicleTrailerId = -1,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          groupAggression = "High",
          enableSiren = true,
          avoidAttacks = false,
          desiredSpeed = 60,
          drivingSkill = "Professional",
          driveInOncoming = 0
        },
        ["name"] = "Actor"
      },
      ["Streetracer 8"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 8,
          team = {
            instance = 1,
            type = "Teams",
            name = "Race team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          accidentProbability = 0,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 1,
          driveOnPavements = 1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Streetracer Spawner"
          },
          vehicleId = 242,
          vehicleTrailerId = -1,
          enableSiren = false,
          spawnSpeed = 60,
          enableSimulationArea = false,
          shaderParam = 3,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          avoidedByCivilianTraffic = false,
          stayInLockedArea = false,
          blockTow = false,
          routeName = "Heat from above streetrace",
          avoidAttacks = false,
          avoidAlleys = 0,
          ignoreCivilianTraffic = true
        },
        ["name"] = "Actor"
      },
      ["Streetracer 7"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 75,
          team = {
            instance = 1,
            type = "Teams",
            name = "Race team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 1,
          driveOnPavements = 1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Streetracer Spawner"
          },
          vehicleId = 242,
          vehicleTrailerId = -1,
          enableSiren = false,
          spawnSpeed = 60,
          enableSimulationArea = false,
          shaderParam = 4,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          routeName = "Heat from above streetrace",
          stayInLockedArea = false,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          avoidAlleys = 0,
          ignoreCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["Streetracer 2"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Race team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          distanceFromFrontOfGroup = 0,
          driveInOncoming = 1,
          driveOnPavements = 1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Streetracer Spawner"
          },
          vehicleId = 242,
          vehicleTrailerId = -1,
          spawnSpeed = 60,
          enableSiren = false,
          enableSimulationArea = false,
          shaderParam = 4,
          attackStationaryVehicle = false,
          stayInLockedArea = false,
          blockTow = false,
          routeName = "Heat from above streetrace",
          avoidAttacks = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
          desiredSpeed = 78
        },
        ["name"] = "Actor"
      },
      ["Chaser 5"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          reactionTime = "Fastest",
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Chase team"
          },
          enableSimulationArea = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 3,
          driveOnPavements = 0,
          noOccupants = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = true,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Chase Spawner"
          },
          vehicleId = 271,
          spawnSpeed = 70,
          attackStationaryVehicle = false,
          vehicleTrailerId = -1,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          groupAggression = "High",
          enableSiren = true,
          avoidAttacks = false,
          desiredSpeed = 60,
          drivingSkill = "Professional",
          driveInOncoming = 0
        },
        ["name"] = "Actor"
      },
      ["Chasing Goon Horde 1b"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Goon Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Chasing Goon 1 and 5 "
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0.8,
          driveOnPavements = 0.6,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          shaderParam = 0,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Relative to Vehicle Behind Following 150"
          },
          vehicleId = 239,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 120,
          damageMultiplier = 1.5,
          attackStationaryVehicle = true,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          groupAggression = "Relentless",
          avoidAttacks = false,
          avoidAlleys = 0,
          desiredSpeed = 170,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Accident 1 RK Spyder"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Stationary team"
          },
          applyDamage = 0.9,
          drivingSkill = "Average",
          disablePanelDetach = false,
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
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Accident 1 RK Spyder position"
          },
          vehicleId = 266,
          shaderParam = 5,
          attackStationaryVehicle = false,
          stayInLockedArea = false,
          blockTow = false,
          enableSiren = false,
          avoidAttacks = false,
          enableSimulationArea = true,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false
        },
        ["name"] = "Actor"
      },
      ["Accident emergency 3 cop"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Stationary team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
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
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Accident emergency 3 spawn"
          },
          vehicleId = 271,
          spawnSpeed = 0,
          attackStationaryVehicle = false,
          stayInLockedArea = false,
          blockTow = false,
          enableSiren = true,
          avoidAttacks = false,
          enableSimulationArea = false,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false
        },
        ["name"] = "Actor"
      },
      ["Firetruck 3"] = {
        [1] = {
          noOccupants = false,
          lockedToPlayer = false,
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          matchTrafficSpeed = false,
          vehicleId = 185,
          avoidedByCivilianTraffic = true,
          enableSiren = true,
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "Race team"
          },
          avoidUTurns = false,
          drivingSkill = "Professional",
          collisionResilience = "Unstoppable",
          spawnSpeed = 70,
          routeName = "Heat from above firetruck",
          reactionTime = "Fastest",
          shaderParam = 0,
          attackStationaryVehicle = false,
          forceHighLodCharacters = false,
          enableSimulationArea = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          stayInLockedArea = false,
          whenSpawned = "Never",
          aiIgnorePlayers = false,
          avoidAttacks = false,
          maintainLane = false,
          driveInOncoming = 0,
          driveOnPavements = 0
        },
        ["name"] = "Actor"
      },
      ["Chasing Goon Horde 1a"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Goon Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Chasing Goon 1 and 5 "
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 1,
          driveOnPavements = 1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          shaderParam = 0,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Relative to Vehicle Behind Following 160"
          },
          vehicleId = 239,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 120,
          damageMultiplier = 1.5,
          attackStationaryVehicle = true,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          groupAggression = "High",
          avoidAttacks = false,
          avoidAlleys = 0,
          desiredSpeed = 170,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Streetracer 5"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 85,
          team = {
            instance = 1,
            type = "Teams",
            name = "Race team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 1,
          driveOnPavements = 1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Streetracer Spawner"
          },
          vehicleId = 242,
          vehicleTrailerId = -1,
          enableSiren = false,
          spawnSpeed = 60,
          enableSimulationArea = false,
          shaderParam = 6,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          routeName = "Heat from above streetrace",
          stayInLockedArea = false,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          avoidAlleys = 0,
          ignoreCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["Chaser 4"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          reactionTime = "Fastest",
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Chase team"
          },
          enableSimulationArea = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 6,
          driveOnPavements = 0,
          noOccupants = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = true,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Chase Spawner"
          },
          vehicleId = 271,
          spawnSpeed = 70,
          attackStationaryVehicle = false,
          vehicleTrailerId = -1,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          groupAggression = "High",
          enableSiren = true,
          avoidAttacks = false,
          desiredSpeed = 60,
          drivingSkill = "Professional",
          driveInOncoming = 0
        },
        ["name"] = "Actor"
      },
      ["Firetruck 2"] = {
        [1] = {
          noOccupants = false,
          lockedToPlayer = false,
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          matchTrafficSpeed = false,
          vehicleId = 185,
          avoidedByCivilianTraffic = false,
          enableSiren = true,
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "Race team"
          },
          avoidUTurns = false,
          drivingSkill = "Professional",
          collisionResilience = "Unstoppable",
          spawnSpeed = 70,
          routeName = "Heat from above firetruck",
          reactionTime = "Fastest",
          shaderParam = 0,
          attackStationaryVehicle = false,
          forceHighLodCharacters = false,
          enableSimulationArea = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          stayInLockedArea = false,
          whenSpawned = "Never",
          aiIgnorePlayers = false,
          avoidAttacks = false,
          maintainLane = false,
          driveInOncoming = 0,
          driveOnPavements = 0
        },
        ["name"] = "Actor"
      },
      ["Chaser 6"] = {
        [1] = {
          noOccupants = false,
          lockedToPlayer = false,
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          stayInLockedArea = false,
          reactionTime = "Fastest",
          avoidedByCivilianTraffic = true,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Relative to Racer"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "Chase team"
          },
          vehicleId = 271,
          enableSimulationArea = false,
          avoidUTurns = false,
          spawnSpeed = 70,
          matchTrafficSpeed = false,
          groupAggression = "High",
          aiIgnorePlayers = false,
          attackStationaryVehicle = false,
          forceHighLodCharacters = false,
          desiredSpeed = 60,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          enableSiren = true,
          avoidAttacks = false,
          drivingSkill = "Professional",
          tailingDistance = 3,
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      ["Accident 2 Cadillac"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Stationary team"
          },
          applyDamage = 0.9,
          drivingSkill = "Average",
          disablePanelDetach = false,
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
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Accident 2  Cadillac position"
          },
          vehicleId = 266,
          shaderParam = 8,
          attackStationaryVehicle = false,
          stayInLockedArea = false,
          blockTow = false,
          enableSiren = false,
          avoidAttacks = false,
          enableSimulationArea = true,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false
        },
        ["name"] = "Actor"
      },
      ["Chasing Goon Horde 2b"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Goon Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Chasing Goon 1 and 5 "
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0.8,
          driveOnPavements = 0.6,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          shaderParam = 0,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Relative to Vehicle Behind Following 150"
          },
          vehicleId = 239,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 120,
          damageMultiplier = 1.5,
          attackStationaryVehicle = true,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          groupAggression = "Relentless",
          avoidAttacks = false,
          avoidAlleys = 0,
          desiredSpeed = 180,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Streetracer 3"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 71,
          team = {
            instance = 1,
            type = "Teams",
            name = "Race team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          accidentProbability = 0.2,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 1,
          driveOnPavements = 1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Streetracer Spawner"
          },
          vehicleId = 242,
          vehicleTrailerId = -1,
          enableSiren = false,
          spawnSpeed = 60,
          enableSimulationArea = false,
          shaderParam = 0,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          avoidedByCivilianTraffic = false,
          stayInLockedArea = false,
          blockTow = false,
          routeName = "Heat from above streetrace",
          avoidAttacks = false,
          avoidAlleys = 0,
          ignoreCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["Chaser 3"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          reactionTime = "Fastest",
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Chase team"
          },
          enableSimulationArea = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 5,
          driveOnPavements = 0,
          noOccupants = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = true,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Chase Spawner"
          },
          vehicleId = 271,
          spawnSpeed = 70,
          attackStationaryVehicle = false,
          vehicleTrailerId = -1,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          groupAggression = "High",
          enableSiren = true,
          avoidAttacks = false,
          desiredSpeed = 60,
          drivingSkill = "Professional",
          driveInOncoming = 0
        },
        ["name"] = "Actor"
      },
      ["Chasing Goon Horde 2a"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Goon Team"
          },
          drivingSkill = "Reckless",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Chasing Goon 1 and 5 "
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0.8,
          driveOnPavements = 0.6,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          shaderParam = 0,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Relative to Vehicle Behind Following 160"
          },
          vehicleId = 239,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 120,
          damageMultiplier = 1.5,
          attackStationaryVehicle = true,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          groupAggression = "Relentless",
          avoidAttacks = false,
          avoidAlleys = 0,
          desiredSpeed = 180,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Chasing Goon Start 2"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Goon Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Chasing Goon 1 and 5 "
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0.8,
          driveOnPavements = 0.6,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          shaderParam = 0,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Relative to Vehicle Behind Following 150"
          },
          vehicleId = 239,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 100,
          damageMultiplier = 1.5,
          attackStationaryVehicle = true,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          groupAggression = "Relentless",
          avoidAttacks = false,
          avoidAlleys = 0,
          desiredSpeed = 180,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Real enemy"] = {
        [1] = {
          noOccupants = false,
          lockedToPlayer = false,
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          maintainLane = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Real enemy spawn"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "Enemy Team"
          },
          vehicleId = 239,
          enableSimulationArea = false,
          matchTrafficSpeed = false,
          spawnSpeed = 0,
          aiIgnorePlayers = false,
          desiredSpeed = 40,
          damageMultiplier = 0.75,
          attackStationaryVehicle = false,
          forceHighLodCharacters = false,
          shaderParam = 4,
          wanderType = "random",
          selfRightIfOverturned = true,
          stayInLockedArea = false,
          whenSpawned = "Never",
          drivingSkill = "Professional",
          avoidAttacks = false,
          enableSiren = false,
          reactionTime = "Average",
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      ["Endcop2"] = {
        [1] = {
          noOccupants = false,
          lockedToPlayer = true,
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "EndCop2 position"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "Stationary team"
          },
          drivingSkill = "Average",
          reactionTime = "Average",
          spawnSpeed = 0,
          vehicleId = 271,
          enableSiren = true,
          attackStationaryVehicle = false,
          forceHighLodCharacters = false,
          avoidUTurns = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          enableSimulationArea = false,
          avoidAttacks = false,
          aiIgnorePlayers = false,
          stayInLockedArea = false,
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      ["Streetracer 1"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 80,
          team = {
            instance = 1,
            type = "Teams",
            name = "Race team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 1,
          driveOnPavements = 1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = true,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Streetracer Spawner"
          },
          vehicleId = 242,
          vehicleTrailerId = -1,
          enableSiren = false,
          spawnSpeed = 60,
          enableSimulationArea = false,
          shaderParam = 0,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          routeName = "Heat from above streetrace",
          stayInLockedArea = false,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          avoidAlleys = 0,
          ignoreCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["Chasing Goon SUV 1"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Goon Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Chasing Goon 4 and 8"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0.8,
          driveOnPavements = 0.8,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          shaderParam = 0,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Relative to Vehicle Behind Following 160"
          },
          vehicleId = 239,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 100,
          damageMultiplier = 1.5,
          attackStationaryVehicle = true,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          groupAggression = "High",
          avoidAttacks = false,
          avoidAlleys = 0,
          desiredSpeed = 150,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Chasing Goon SUV 2"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Goon Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Chasing Goon 4 and 8"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0.8,
          driveOnPavements = 0.8,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          shaderParam = 0,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Relative to Vehicle Behind Following 150"
          },
          vehicleId = 239,
          enableSiren = true,
          enableSimulationArea = false,
          spawnSpeed = 100,
          damageMultiplier = 1.5,
          attackStationaryVehicle = true,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          groupAggression = "Relentless",
          avoidAttacks = false,
          avoidAlleys = 0,
          desiredSpeed = 180,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Endcop1"] = {
        [1] = {
          noOccupants = false,
          lockedToPlayer = true,
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "EndCop1 position"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "Stationary team"
          },
          drivingSkill = "Average",
          reactionTime = "Average",
          spawnSpeed = 0,
          vehicleId = 271,
          enableSiren = true,
          attackStationaryVehicle = false,
          forceHighLodCharacters = false,
          avoidUTurns = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          enableSimulationArea = false,
          avoidAttacks = false,
          aiIgnorePlayers = false,
          stayInLockedArea = false,
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      ["Ambulance 2"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Race team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 1,
          driveOnPavements = 1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Ambulance spawner"
          },
          vehicleId = 276,
          vehicleTrailerId = -1,
          spawnSpeed = 60,
          enableSiren = true,
          enableSimulationArea = false,
          shaderParam = 0,
          attackStationaryVehicle = false,
          stayInLockedArea = false,
          blockTow = false,
          routeName = "Heat from above ambulance",
          avoidAttacks = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = true,
          desiredSpeed = 68
        },
        ["name"] = "Actor"
      },
      ["Accident 3 Tanker"] = {
        [1] = {
          noOccupants = false,
          lockedToPlayer = false,
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Accident 3 tanker position"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "Stationary team"
          },
          applyDamage = 0.9,
          enableSimulationArea = false,
          reactionTime = "Average",
          vehicleId = 286,
          avoidUTurns = false,
          attackStationaryVehicle = false,
          forceHighLodCharacters = false,
          enableSiren = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          aiIgnorePlayers = false,
          avoidAttacks = false,
          drivingSkill = "Average",
          stayInLockedArea = false,
          vehicleTrailerId = 131
        },
        ["name"] = "Actor"
      },
      ["Streetracer 4"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 80,
          team = {
            instance = 1,
            type = "Teams",
            name = "Race team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 1,
          driveOnPavements = 1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Streetracer Spawner"
          },
          vehicleId = 242,
          vehicleTrailerId = -1,
          enableSiren = false,
          spawnSpeed = 60,
          enableSimulationArea = false,
          shaderParam = 7,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          routeName = "Heat from above streetrace",
          stayInLockedArea = false,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          avoidAlleys = 0,
          ignoreCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["Streetracer 6"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 80,
          team = {
            instance = 1,
            type = "Teams",
            name = "Race team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 1,
          driveOnPavements = 1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Streetracer Spawner"
          },
          vehicleId = 242,
          vehicleTrailerId = -1,
          enableSiren = false,
          spawnSpeed = 60,
          enableSimulationArea = false,
          shaderParam = 5,
          attackStationaryVehicle = false,
          reactionTime = "Fastest",
          routeName = "Heat from above streetrace",
          stayInLockedArea = false,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          avoidAlleys = 0,
          ignoreCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["Chaser 2"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          matchTrafficSpeed = false,
          aiIgnorePlayers = false,
          desiredSpeed = 70,
          team = {
            instance = 1,
            type = "Teams",
            name = "Chase team"
          },
          drivingSkill = "Professional",
          accidentProbability = 0.1,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 2,
          driveOnPavements = 0,
          noOccupants = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          groupAggression = "High",
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Chase Spawner"
          },
          vehicleId = 271,
          spawnSpeed = 70,
          attackStationaryVehicle = false,
          vehicleTrailerId = -1,
          enableSiren = true,
          stayInLockedArea = false,
          enableSimulationArea = false,
          avoidedByCivilianTraffic = true,
          avoidAttacks = false,
          ignoreCivilianTraffic = false,
          reactionTime = "Fastest",
          driveInOncoming = 0
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["New Character"] = {
        [1] = {
          ["Passenger id"] = "-1916574018",
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      },
      ["Chasing Goon 3 and 7"] = {
        [1] = {
          ["Passenger id"] = "1548270126",
          ["Driver id"] = "-2120230844"
        },
        ["name"] = "Character"
      },
      ["Chasing Goon 4 and 8"] = {
        [1] = {
          ["Passenger id"] = "-2095856815",
          ["Driver id"] = "1597691979"
        },
        ["name"] = "Character"
      },
      ["Chasing Goon 2 and 6"] = {
        [1] = {
          ["Passenger id"] = "-1784376771",
          ["Driver id"] = "830448357"
        },
        ["name"] = "Character"
      },
      ["Chasing Goon 1 and 5 "] = {
        [1] = {
          ["Passenger id"] = "1200791648",
          ["Driver id"] = "76265956"
        },
        ["name"] = "Character"
      }
    },
    SpawnTypes = {
      ["Accident 1 RK Spyder position"] = {
        [1] = {
          ["Spawn location"] = "Heat from above accident 1 RK Spyder",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Tanner 2 position"] = {
        [1] = {
          ["Spawn location"] = "Heat from above Tanner 2",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Truck Spawn"] = {
        [1] = {
          ["Spawn location"] = "Truck",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Accident 2  Cadillac position"] = {
        [1] = {
          ["Spawn location"] = "Heat from above accident 2 Cadillac",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Accident 3 tanker position"] = {
        [1] = {
          ["Spawn location"] = "Heat from above accident 3 Tanker",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["EndCop1 position"] = {
        [1] = {
          ["Spawn location"] = "Heat from above Endcop1",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Relative to Vehicle Ahead Facing 200"] = {
        [1] = {
          actor = "Truck",
          whichLane = "randomLane",
          withVehicleDirection = false,
          distance = 220,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = true
        },
        ["name"] = "Relative to Vehicle"
      },
      ["Tanner Actor Spawn"] = {
        [1] = {
          ["1"] = "Tanner Actor"
        },
        ["name"] = "Positions"
      },
      ["Relative to Vehicle Behind Following 150"] = {
        [1] = {
          actor = "Truck",
          whichLane = "randomLane",
          withVehicleDirection = true,
          distance = 150,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = false
        },
        ["name"] = "Relative to Vehicle"
      },
      ["Accident emergency 3 spawn"] = {
        [1] = {
          ["Spawn location"] = "Heat from above accident emergency 3 cop",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Firetruck position"] = {
        [1] = {
          ["Spawn location"] = "Heat from above firetruck",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Relative to Vehicle Behind Following 160"] = {
        [1] = {
          actor = "Truck",
          whichLane = "randomLane",
          withVehicleDirection = true,
          distance = 170,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = false
        },
        ["name"] = "Relative to Vehicle"
      },
      ["Tanner Static"] = {
        [1] = {
          ["Spawn location"] = "Heat from above Tanner",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["New Positions"] = {
        [1] = {
          ["1"] = "Firetruck",
          ["alternateLocation"] = "Heat from above firetruck",
          ["3"] = "Firetruck 3",
          ["2"] = "Firetruck 2"
        },
        ["name"] = "Positions"
      },
      ["Streetracer Spawner"] = {
        [1] = {
          ["1"] = "Streetracer 1",
          ["3"] = "Streetracer 3",
          ["2"] = "Streetracer 2",
          ["5"] = "Streetracer 5",
          ["4"] = "Streetracer 4",
          ["7"] = "Streetracer 7",
          ["6"] = "Streetracer 6",
          ["8"] = "Streetracer 8",
          ["alternateLocation"] = "Heat from above streetracer 1"
        },
        ["name"] = "Positions"
      },
      ["Ambulance spawner"] = {
        [1] = {
          ["1"] = "Ambulance 1",
          ["alternateLocation"] = "Heat from above ambulance 1",
          ["3"] = "Ambulance 3",
          ["2"] = "Ambulance 2"
        },
        ["name"] = "Positions"
      },
      ["Real enemy spawn"] = {
        [1] = {
          ["Spawn location"] = "Real enemy",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Relative to Vehicle Ahead Facing 300"] = {
        [1] = {
          actor = "Truck",
          whichLane = "randomLane",
          withVehicleDirection = false,
          distance = 300,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = true
        },
        ["name"] = "Relative to Vehicle"
      },
      ["Accident emergency 2 spawn cop"] = {
        [1] = {
          ["Spawn location"] = "Heat from above accident emergency 2 cop",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Tanner spawn"] = {
        [1] = {
          ["1"] = "Tanner Actor"
        },
        ["name"] = "Positions"
      },
      ["EndCop2 position"] = {
        [1] = {
          ["Spawn location"] = "Heat from above Endcop2",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Relative to Vehicle Behind Following 200"] = {
        [1] = {
          actor = "Truck",
          whichLane = "randomLane",
          withVehicleDirection = true,
          distance = 180,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = false
        },
        ["name"] = "Relative to Vehicle"
      },
      ["Relative to Racer"] = {
        [1] = {
          actor = "Truck",
          whichLane = "randomLane",
          withVehicleDirection = true,
          distance = 5,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = false
        },
        ["name"] = "Relative to Vehicle"
      },
      ["Chase Spawner"] = {
        [1] = {
          ["alternateLocation"] = "Heat from above chase 1",
          ["3"] = "Chaser 2",
          ["2"] = "Chaser 1",
          ["5"] = "Chaser 4",
          ["4"] = "Chaser 3",
          ["1"] = "Racer",
          ["6"] = "Chaser 5"
        },
        ["name"] = "Positions"
      }
    },
    Teams = {
      ["Chase team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Race team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Enemy Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Stationary team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Tanner Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Goon Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Exploder Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Truck Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionSettings = {
      ["New MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Spawn type"] = "Always active",
          ["Load traffic on start"] = "SM2 Heat From Above ",
          ["disablePlayerIgnoring"] = false,
          ["Cutscene after mission end screen"] = "mis_ch2_eyesoncity_01",
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Heat from above",
          ["Audio logic file"] = "Heat from above",
          ["Delete task object on reject preview"] = false,
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    WarmupTypes = {
      ["Tanner Warmup"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          warmupRouteName = "Heat from above warmup",
          forceZapToVehicle = false,
          forceMissionAccept = false,
          matchTrafficSpeed = false,
          lookToVehicle = false
        },
        ["name"] = "Warmup route"
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
          ["1 Text"] = "ID:245534",
          ["Success reason"] = "ID:245618",
          ["missionMarkers"] = {
            [1] = {
              value = "Opponent",
              cardName = "Chasing Goon Horde 2a",
              cardType = "Actor"
            },
            [2] = {
              value = "Opponent",
              cardName = "Chasing Goon Start 2",
              cardType = "Actor"
            },
            [3] = {
              value = "None",
              cardName = "Accident emergency 3 cop",
              cardType = "Actor"
            },
            [4] = {
              value = "None",
              cardName = "Chaser 3",
              cardType = "Actor"
            },
            [5] = {
              value = "None",
              cardName = "Streetracer 8",
              cardType = "Actor"
            },
            [6] = {
              value = "None",
              cardName = "Chaser 2",
              cardType = "Actor"
            },
            [7] = {
              value = "Opponent",
              cardName = "Chasing Goon Front Smash 1",
              cardType = "Actor"
            },
            [8] = {
              value = "None",
              cardName = "Racer",
              cardType = "Actor"
            },
            [9] = {
              value = "None",
              cardName = "Accident emergency 2 cop",
              cardType = "Actor"
            },
            [10] = {
              value = "Opponent",
              cardName = "Chasing Goon SUV 1",
              cardType = "Actor"
            },
            [11] = {
              value = "Opponent",
              cardName = "Chasing Goon Horde 2b",
              cardType = "Actor"
            },
            [12] = {
              value = "None",
              cardName = "Streetracer 7",
              cardType = "Actor"
            },
            [13] = {
              value = "None",
              cardName = "Chaser 5",
              cardType = "Actor"
            },
            [14] = {
              value = "None",
              cardName = "Chaser 4",
              cardType = "Actor"
            },
            [15] = {
              value = "None",
              cardName = "Streetracer 6",
              cardType = "Actor"
            },
            [16] = {
              value = "Opponent",
              cardName = "Chasing Goon SUV 2",
              cardType = "Actor"
            },
            [17] = {
              value = "Opponent",
              cardName = "Chasing Goon Horde 1a",
              cardType = "Actor"
            },
            [18] = {
              value = "None",
              cardName = "Endcop2",
              cardType = "Actor"
            },
            [19] = {
              value = "None",
              cardName = "Accident 2 Cadillac",
              cardType = "Actor"
            },
            [20] = {
              value = "None",
              cardName = "Tanner Actor 2",
              cardType = "Actor"
            },
            [21] = {
              value = "None",
              cardName = "Accident 3 Tanker",
              cardType = "Actor"
            },
            [22] = {
              value = "None",
              cardName = "Endcop1",
              cardType = "Actor"
            },
            [23] = {
              value = "None",
              cardName = "Streetracer 5",
              cardType = "Actor"
            },
            [24] = {
              value = "None",
              cardName = "Chaser 1",
              cardType = "Actor"
            },
            [25] = {
              value = "None",
              cardName = "Accident 1 RK Spyder",
              cardType = "Actor"
            },
            [26] = {
              value = "None",
              cardName = "Tanner Actor",
              cardType = "Actor"
            },
            [27] = {
              value = "None",
              cardName = "Streetracer 4",
              cardType = "Actor"
            },
            [28] = {
              value = "None",
              cardName = "Streetracer 3",
              cardType = "Actor"
            },
            [29] = {
              value = "Yellow Marker, Destination Vehicle",
              cardName = "Truck",
              cardType = "Actor"
            },
            [30] = {
              value = "None",
              cardName = "Streetracer 2",
              cardType = "Actor"
            },
            [31] = {
              value = "None",
              cardName = "Firetruck 2",
              cardType = "Actor"
            },
            [32] = {
              value = "None",
              cardName = "Firetruck 3",
              cardType = "Actor"
            },
            [33] = {
              value = "None",
              cardName = "Ambulance 2",
              cardType = "Actor"
            },
            [34] = {
              value = "Opponent",
              cardName = "Chasing Goon Start 1",
              cardType = "Actor"
            },
            [35] = {
              value = "None",
              cardName = "Firetruck",
              cardType = "Actor"
            },
            [36] = {
              value = "Opponent",
              cardName = "Chasing Goon Horde 1b",
              cardType = "Actor"
            },
            [37] = {
              value = "Opponent",
              cardName = "Chasing Goon Front Smash 3",
              cardType = "Actor"
            },
            [38] = {
              value = "Opponent",
              cardName = "Chasing Goon Front Smash 2",
              cardType = "Actor"
            },
            [39] = {
              value = "None",
              cardName = "Ambulance 3",
              cardType = "Actor"
            },
            [40] = {
              value = "None",
              cardName = "Streetracer 1",
              cardType = "Actor"
            },
            [41] = {
              value = "None",
              cardName = "Chaser 6",
              cardType = "Actor"
            },
            [42] = {
              value = "None",
              cardName = "Ambulance 1",
              cardType = "Actor"
            },
            [43] = {
              value = "Objective",
              cardName = "Real enemy",
              cardType = "Actor"
            },
            [44] = {
              value = "None",
              cardName = "Chaser 7",
              cardType = "Actor"
            }
          },
          ["3 Text"] = "ID:245535",
          ["2 Text"] = "ID:184823"
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Heat from above"] = {
        [1] = {
          ["Chase team"] = {
            instance = 1,
            type = "Teams",
            name = "Chase team"
          },
          ["Race team"] = {
            instance = 1,
            type = "Teams",
            name = "Race team"
          },
          ["Truck team"] = {
            instance = 1,
            type = "Teams",
            name = "Truck Team"
          },
          ["Enemy team"] = {
            instance = 1,
            type = "Teams",
            name = "Enemy Team"
          },
          ["Tanner team"] = {
            instance = 1,
            type = "Teams",
            name = "Tanner Team"
          },
          ["Goon team"] = {
            instance = 1,
            type = "Teams",
            name = "Goon Team"
          },
          ["Stationary team"] = {
            instance = 1,
            type = "Teams",
            name = "Stationary team"
          },
          ["Exploder team"] = {
            instance = 1,
            type = "Teams",
            name = "Exploder Team"
          }
        },
        ["name"] = "Heat from above"
      }
    }
  }
}
