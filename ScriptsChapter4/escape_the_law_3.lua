cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Escape the law 3"] = {
  FileVersion = "2",
  name = "Escape the law 3",
  title = "ID:184725",
  MissionID = "5966",
  description = "ID:184726",
  cardInstances = {
    Actors = {
      ["chase team member 1"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 100,
          team = {
            instance = 1,
            type = "Teams",
            name = "chase team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Dan"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          tailingDistance = 5,
          driveOnPavements = 0.5,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Getaway Warmup"
          },
          enableSiren = true,
          avoidUTurns = false,
          groupAggression = "High",
          collisionResilience = "Tough",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Positions start cop"
          },
          vehicleId = 271,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Strong",
          rubberbandingActor = "evade team member 1",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = 5,
          driveInOncoming = 0.2,
          ignoreCivilianTraffic = false,
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Fast",
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          aiIgnorePlayerInCivsUntilHit = false
        },
        ["name"] = "Actor"
      },
      ["Roadblocker 9 (group2)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Roadblock 2 team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Herb"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 5,
          vehicleTrailerId = -1,
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
            name = "Roadblock position 9 (group2)"
          },
          vehicleId = 271,
          rubberbandingToPlayerStrength = "Strong",
          enableSiren = true,
          rubberbandingActor = "evade team member 1",
          enableSimulationArea = false,
          attackStationaryVehicle = true,
          distanceBehindPlayer = 5,
          stayInLockedArea = false,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          desiredSpeed = 80,
          groupAggression = "Evil",
          avoidedByCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["Roadblocker 4 (group2)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Roadblock 2 team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Herb"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 5,
          vehicleTrailerId = -1,
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
            name = "Roadblock position 4 (group2)"
          },
          vehicleId = 271,
          rubberbandingToPlayerStrength = "Strong",
          enableSiren = true,
          rubberbandingActor = "evade team member 1",
          enableSimulationArea = false,
          attackStationaryVehicle = true,
          distanceBehindPlayer = 5,
          stayInLockedArea = false,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          desiredSpeed = 80,
          groupAggression = "Evil",
          avoidedByCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["Roadblocker 4 (group1)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Roadblock 2 team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Herb"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 5,
          driveOnPavements = 0.5,
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
            name = "Roadblock position 4 (group1)"
          },
          vehicleId = 271,
          rubberbandingToPlayerStrength = "Medium",
          vehicleTrailerId = -1,
          enableSiren = true,
          rubberbandingActor = "evade team member 1",
          enableSimulationArea = false,
          attackStationaryVehicle = true,
          distanceBehindPlayer = 5,
          stayInLockedArea = false,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          desiredSpeed = 7,
          matchTrafficSpeed = false,
          groupAggression = "Evil"
        },
        ["name"] = "Actor"
      },
      ["Roadblocker 5 (group2)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Roadblock 2 team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Willa"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 5,
          vehicleTrailerId = -1,
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
            name = "Roadblock position 5 (group2)"
          },
          vehicleId = 271,
          rubberbandingToPlayerStrength = "Strong",
          enableSiren = true,
          rubberbandingActor = "evade team member 1",
          enableSimulationArea = false,
          attackStationaryVehicle = true,
          distanceBehindPlayer = 5,
          stayInLockedArea = false,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          desiredSpeed = 80,
          groupAggression = "Evil",
          avoidedByCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["chase team member 2"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "chase team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Dan"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On mission start",
          tailingDistance = 5,
          driveOnPavements = 0.5,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          vehicleTrailerId = -1,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Positions start cop 2"
          },
          vehicleId = 271,
          rubberbandingToPlayerStrength = "Strong",
          enableSiren = true,
          rubberbandingActor = "evade team member 1",
          enableSimulationArea = false,
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = 5,
          stayInLockedArea = false,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          desiredSpeed = 80,
          matchTrafficSpeed = false,
          groupAggression = "High"
        },
        ["name"] = "Actor"
      },
      ["Roadblocker 2 (group2)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Roadblock 2 team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Willa"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          distanceFromFrontOfGroup = 0,
          tailingDistance = 5,
          driveOnPavements = 0.5,
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
            name = "Roadblock position 2 (group2)"
          },
          vehicleId = 280,
          rubberbandingToPlayerStrength = "Strong",
          vehicleTrailerId = -1,
          enableSiren = true,
          rubberbandingActor = "evade team member 1",
          enableSimulationArea = false,
          attackStationaryVehicle = true,
          distanceBehindPlayer = 5,
          stayInLockedArea = false,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          desiredSpeed = 80,
          matchTrafficSpeed = false,
          groupAggression = "Evil"
        },
        ["name"] = "Actor"
      },
      ["Roadblocker 4"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Roadblock team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Logan"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 5,
          vehicleTrailerId = -1,
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
            name = "Roadblock position 1 (group2)"
          },
          vehicleId = 280,
          rubberbandingToPlayerStrength = "Strong",
          enableSiren = true,
          rubberbandingActor = "evade team member 1",
          enableSimulationArea = false,
          attackStationaryVehicle = true,
          distanceBehindPlayer = 5,
          stayInLockedArea = false,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          desiredSpeed = 80,
          groupAggression = "Evil",
          avoidedByCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["chase team member 4"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "chase team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Willa"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 5,
          driveOnPavements = 0.5,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          vehicleTrailerId = -1,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Set position ambush1 cop1"
          },
          vehicleId = 271,
          rubberbandingToPlayerStrength = "Strong",
          enableSiren = true,
          rubberbandingActor = "evade team member 1",
          enableSimulationArea = false,
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = 5,
          stayInLockedArea = false,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          desiredSpeed = 80,
          matchTrafficSpeed = false,
          groupAggression = "High"
        },
        ["name"] = "Actor"
      },
      ["Roadblocker 2 (group1)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Roadblock 2 team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Dan"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          distanceFromFrontOfGroup = 0,
          tailingDistance = 5,
          driveOnPavements = 0.5,
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
            name = "Roadblock position 2 (group1)"
          },
          vehicleId = 271,
          rubberbandingToPlayerStrength = "Medium",
          vehicleTrailerId = -1,
          enableSiren = true,
          rubberbandingActor = "evade team member 1",
          enableSimulationArea = false,
          attackStationaryVehicle = true,
          distanceBehindPlayer = 5,
          stayInLockedArea = false,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          desiredSpeed = 80,
          matchTrafficSpeed = false,
          groupAggression = "Evil"
        },
        ["name"] = "Actor"
      },
      ["Roadblocker 1 (group2)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Roadblock 2 team"
          },
          drivingSkill = "Reckless",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Willa"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 5,
          vehicleTrailerId = -1,
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
            name = "Roadblock position 1 (group2)"
          },
          vehicleId = 271,
          rubberbandingToPlayerStrength = "Strong",
          enableSiren = true,
          rubberbandingActor = "evade team member 1",
          enableSimulationArea = false,
          attackStationaryVehicle = true,
          distanceBehindPlayer = 5,
          stayInLockedArea = false,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          desiredSpeed = 80,
          groupAggression = "Evil",
          avoidedByCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["chase team member 4 (softsave 1)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 85,
          team = {
            instance = 1,
            type = "Teams",
            name = "chase team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Logan"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 5,
          driveOnPavements = 0.5,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Softsave Positions 1"
          },
          vehicleId = 271,
          enableSiren = true,
          rubberbandingToPlayerStrength = "Strong",
          enableSimulationArea = false,
          spawnSpeed = 40,
          rubberbandingActor = "evade team member 1",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = 5,
          driveInOncoming = 0.2,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          ignoreCivilianTraffic = false,
          avoidAttacks = false,
          groupAggression = "High",
          avoidedByCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["Roadblocker 6 (group2)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Roadblock 2 team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Herb"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 5,
          vehicleTrailerId = -1,
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
            name = "Roadblock position 6 (group2)"
          },
          vehicleId = 271,
          rubberbandingToPlayerStrength = "Strong",
          enableSiren = true,
          rubberbandingActor = "evade team member 1",
          enableSimulationArea = false,
          attackStationaryVehicle = true,
          distanceBehindPlayer = 5,
          stayInLockedArea = false,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          desiredSpeed = 80,
          groupAggression = "Evil",
          avoidedByCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["chase team member 5 (softsave 2)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 85,
          team = {
            instance = 1,
            type = "Teams",
            name = "chase team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Willa"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 5,
          driveOnPavements = 0.5,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Softsave Positions 2"
          },
          vehicleId = 271,
          enableSiren = true,
          rubberbandingToPlayerStrength = "Strong",
          enableSimulationArea = false,
          spawnSpeed = 45,
          rubberbandingActor = "evade team member 1",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = 5,
          driveInOncoming = 0.2,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          ignoreCivilianTraffic = false,
          avoidAttacks = false,
          groupAggression = "High",
          avoidedByCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["chase team member 1 (softsave 2)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 85,
          team = {
            instance = 1,
            type = "Teams",
            name = "chase team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Dan"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 5,
          driveOnPavements = 0.5,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Softsave Positions 2"
          },
          vehicleId = 271,
          enableSiren = true,
          rubberbandingToPlayerStrength = "Strong",
          enableSimulationArea = false,
          spawnSpeed = 35,
          rubberbandingActor = "evade team member 1",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = 5,
          driveInOncoming = 0.2,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          ignoreCivilianTraffic = false,
          avoidAttacks = false,
          groupAggression = "High",
          avoidedByCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["chase team member 4 (softsave 2)"] = {
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
            name = "chase team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Logan"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 5,
          driveOnPavements = 0.5,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          enableSiren = true,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Softsave Positions 2"
          },
          vehicleId = 271,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 40,
          rubberbandingActor = "evade team member 1",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = 5,
          driveInOncoming = 0.2,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          groupAggression = "High",
          avoidAttacks = false,
          desiredSpeed = 85,
          avoidedByCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Roadblocker 1 (group1)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Roadblock 2 team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Dan"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 5,
          driveOnPavements = 0.5,
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
            name = "Roadblock position 1 (group1)"
          },
          vehicleId = 271,
          rubberbandingToPlayerStrength = "Medium",
          vehicleTrailerId = -1,
          enableSiren = true,
          rubberbandingActor = "evade team member 1",
          enableSimulationArea = false,
          attackStationaryVehicle = true,
          distanceBehindPlayer = 5,
          stayInLockedArea = false,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          desiredSpeed = 80,
          matchTrafficSpeed = false,
          groupAggression = "Evil"
        },
        ["name"] = "Actor"
      },
      ["Roadblocker 3 (group2)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Roadblock 2 team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Herb"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 5,
          vehicleTrailerId = -1,
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
            name = "Roadblock position 3 (group2)"
          },
          vehicleId = 271,
          rubberbandingToPlayerStrength = "Strong",
          enableSiren = true,
          rubberbandingActor = "evade team member 1",
          enableSimulationArea = false,
          attackStationaryVehicle = true,
          distanceBehindPlayer = 5,
          stayInLockedArea = false,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          desiredSpeed = 80,
          groupAggression = "Evil",
          avoidedByCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["chase team member 6 (softsave 2)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 85,
          team = {
            instance = 1,
            type = "Teams",
            name = "chase team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Herb"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 5,
          driveOnPavements = 0.5,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Softsave Positions 2"
          },
          vehicleId = 271,
          enableSiren = true,
          rubberbandingToPlayerStrength = "Strong",
          enableSimulationArea = false,
          spawnSpeed = 45,
          rubberbandingActor = "evade team member 1",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = 5,
          driveInOncoming = 0.2,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          ignoreCivilianTraffic = false,
          avoidAttacks = false,
          groupAggression = "High",
          avoidedByCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["Dropoff vehicle"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Dropoff Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Dropoff Character"
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
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Dropoff spawn"
          },
          vehicleId = 138,
          shaderParam = 8,
          attackStationaryVehicle = false,
          stayInLockedArea = false,
          blockTow = false,
          enableSiren = false,
          avoidAttacks = false,
          reactionTime = "Average",
          enableSimulationArea = false,
          aiIgnorePlayerInCivsUntilHit = false
        },
        ["name"] = "Actor"
      },
      ["Roadblocker 7 (group2)"] = {
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
            name = "Roadblock team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Herb"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 5,
          vehicleTrailerId = -1,
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
            name = "Roadblock position 7 (group2)"
          },
          vehicleId = 271,
          rubberbandingToPlayerStrength = "Strong",
          enableSiren = true,
          enableSimulationArea = false,
          rubberbandingActor = "evade team member 1",
          attackStationaryVehicle = true,
          distanceBehindPlayer = 5,
          groupAggression = "Evil",
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          ignoreOtherAis = false,
          desiredSpeed = 80,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["chase team member 5"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 80,
          team = {
            instance = 1,
            type = "Teams",
            name = "chase team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Herb"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 5,
          driveOnPavements = 0.5,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Set position ambush1 cop2"
          },
          vehicleId = 271,
          enableSiren = true,
          rubberbandingToPlayerStrength = "Strong",
          enableSimulationArea = false,
          spawnSpeed = 0,
          rubberbandingActor = "evade team member 1",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = 5,
          avoidedByCivilianTraffic = false,
          stayInLockedArea = false,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          ignoreCivilianTraffic = false,
          groupAggression = "High"
        },
        ["name"] = "Actor"
      },
      ["chase team member 3 (softsave 1)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 85,
          team = {
            instance = 1,
            type = "Teams",
            name = "chase team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Logan"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 5,
          driveOnPavements = 0.5,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Softsave Positions 1"
          },
          vehicleId = 271,
          enableSiren = true,
          rubberbandingToPlayerStrength = "Strong",
          enableSimulationArea = false,
          spawnSpeed = 35,
          rubberbandingActor = "evade team member 1",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = 5,
          driveInOncoming = 0.2,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          ignoreCivilianTraffic = false,
          avoidAttacks = false,
          groupAggression = "High",
          avoidedByCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["Roadblocker 10 (group2)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Roadblock 2 team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Herb"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 5,
          vehicleTrailerId = -1,
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
            name = "Roadblock position 10 (group2)"
          },
          vehicleId = 280,
          rubberbandingToPlayerStrength = "Strong",
          enableSiren = true,
          rubberbandingActor = "evade team member 1",
          enableSimulationArea = false,
          attackStationaryVehicle = true,
          distanceBehindPlayer = 5,
          stayInLockedArea = false,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          desiredSpeed = 80,
          groupAggression = "Evil",
          avoidedByCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["chase team member 1 (softsave 1)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 85,
          team = {
            instance = 1,
            type = "Teams",
            name = "chase team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Dan"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 5,
          driveOnPavements = 0.5,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Softsave Positions 1"
          },
          vehicleId = 271,
          enableSiren = true,
          rubberbandingToPlayerStrength = "Strong",
          enableSimulationArea = false,
          spawnSpeed = 35,
          rubberbandingActor = "evade team member 1",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = 5,
          driveInOncoming = 0.2,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          ignoreCivilianTraffic = false,
          avoidAttacks = false,
          groupAggression = "High",
          avoidedByCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["chase team member 2 (softsave 2)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 85,
          team = {
            instance = 1,
            type = "Teams",
            name = "chase team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Herb"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 5,
          driveOnPavements = 0.5,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Softsave Positions 2"
          },
          vehicleId = 271,
          enableSiren = true,
          rubberbandingToPlayerStrength = "Strong",
          enableSimulationArea = false,
          spawnSpeed = 35,
          rubberbandingActor = "evade team member 1",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = 5,
          driveInOncoming = 0.2,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          ignoreCivilianTraffic = false,
          avoidAttacks = false,
          groupAggression = "High",
          avoidedByCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["chase team member 3 (softsave 2)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 85,
          team = {
            instance = 1,
            type = "Teams",
            name = "chase team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Logan"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 5,
          driveOnPavements = 0.5,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Softsave Positions 2"
          },
          vehicleId = 271,
          enableSiren = true,
          rubberbandingToPlayerStrength = "Strong",
          enableSimulationArea = false,
          spawnSpeed = 35,
          rubberbandingActor = "evade team member 1",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = 5,
          driveInOncoming = 0.2,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          ignoreCivilianTraffic = false,
          avoidAttacks = false,
          groupAggression = "High",
          avoidedByCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["chase team member 2 (softsave 1)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 85,
          team = {
            instance = 1,
            type = "Teams",
            name = "chase team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Herb"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 5,
          driveOnPavements = 0.5,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Softsave Positions 1"
          },
          vehicleId = 271,
          enableSiren = true,
          rubberbandingToPlayerStrength = "Strong",
          enableSimulationArea = false,
          spawnSpeed = 35,
          rubberbandingActor = "evade team member 1",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = 5,
          driveInOncoming = 0.2,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          ignoreCivilianTraffic = false,
          avoidAttacks = false,
          groupAggression = "High",
          avoidedByCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["evade team member 1"] = {
        [1] = {
          lockedToPlayer = false,
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
            name = "evade team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "New Character"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          tailingDistance = 0,
          driveOnPavements = 0.5,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Getaway Warmup"
          },
          shaderParam = 3,
          avoidUTurns = true,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Evader position"
          },
          vehicleId = 203,
          enableSimulationArea = false,
          spawnSpeed = 30,
          isMultiplayerActor = false,
          damageMultiplier = 0.7,
          attackStationaryVehicle = false,
          desiredSpeed = 60,
          matchTrafficSpeed = false,
          routeName = "Escape the law 3",
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          previewMovie = "csx_1",
          avoidAttacks = false,
          driveInOncoming = 0,
          avoidedByCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["chase team member 6 (softsave 1)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 85,
          team = {
            instance = 1,
            type = "Teams",
            name = "chase team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Herb"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 5,
          driveOnPavements = 0.5,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Softsave Positions 1"
          },
          vehicleId = 271,
          enableSiren = true,
          rubberbandingToPlayerStrength = "Strong",
          enableSimulationArea = false,
          spawnSpeed = 45,
          rubberbandingActor = "evade team member 1",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = 5,
          driveInOncoming = 0.2,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          ignoreCivilianTraffic = false,
          avoidAttacks = false,
          groupAggression = "High",
          avoidedByCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["Roadblocker 8 (group2)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Roadblock 2 team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Dan"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 5,
          vehicleTrailerId = -1,
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
            name = "Roadblock position 8 (group2)"
          },
          vehicleId = 280,
          rubberbandingToPlayerStrength = "Strong",
          enableSiren = true,
          rubberbandingActor = "evade team member 1",
          enableSimulationArea = false,
          attackStationaryVehicle = true,
          distanceBehindPlayer = 5,
          stayInLockedArea = false,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          desiredSpeed = 80,
          groupAggression = "Evil",
          avoidedByCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["chase team member 5 (softsave 1)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 85,
          team = {
            instance = 1,
            type = "Teams",
            name = "chase team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Willa"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 5,
          driveOnPavements = 0.5,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Softsave Positions 1"
          },
          vehicleId = 271,
          enableSiren = true,
          rubberbandingToPlayerStrength = "Strong",
          enableSimulationArea = false,
          spawnSpeed = 45,
          rubberbandingActor = "evade team member 1",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = 5,
          driveInOncoming = 0.2,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          ignoreCivilianTraffic = false,
          avoidAttacks = false,
          groupAggression = "High",
          avoidedByCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["Roadblocker 3 (group1)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Roadblock team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Herb"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 5,
          driveOnPavements = 0.5,
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
            name = "Roadblock position 3 (group1)"
          },
          vehicleId = 271,
          rubberbandingToPlayerStrength = "Medium",
          vehicleTrailerId = -1,
          enableSiren = true,
          rubberbandingActor = "evade team member 1",
          enableSimulationArea = false,
          attackStationaryVehicle = true,
          distanceBehindPlayer = 5,
          stayInLockedArea = false,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          desiredSpeed = 80,
          matchTrafficSpeed = false,
          groupAggression = "Evil"
        },
        ["name"] = "Actor"
      },
      ["chase team member 3"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "chase team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Dan"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On mission start",
          tailingDistance = 5,
          driveOnPavements = 0.5,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          vehicleTrailerId = -1,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Positions start cop 2"
          },
          vehicleId = 271,
          rubberbandingToPlayerStrength = "Strong",
          enableSiren = true,
          rubberbandingActor = "evade team member 1",
          enableSimulationArea = false,
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = 5,
          stayInLockedArea = false,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          desiredSpeed = 120,
          matchTrafficSpeed = false,
          groupAggression = "High"
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["New Character"] = {
        [1] = {
          ["Passenger id"] = "-1662061033",
          ["Driver id"] = "423141928"
        },
        ["name"] = "Character"
      },
      ["Cop Dan"] = {
        [1] = {
          ["Passenger id"] = "2106453917",
          ["Driver id"] = "-1843533868"
        },
        ["name"] = "Character"
      },
      ["Dropoff Character"] = {
        [1] = {
          ["Driver id"] = "-114664299"
        },
        ["name"] = "Character"
      },
      ["Cop Logan"] = {
        [1] = {
          ["Passenger id"] = "-872299577",
          ["Driver id"] = "1307138515"
        },
        ["name"] = "Character"
      },
      ["Cop Willa"] = {
        [1] = {
          ["Passenger id"] = "600862826",
          ["Driver id"] = "-879852041"
        },
        ["name"] = "Character"
      },
      ["Cop Herb"] = {
        [1] = {
          ["Passenger id"] = "-393069347",
          ["Driver id"] = "215156097"
        },
        ["name"] = "Character"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {
          onlyVehicleAbleToStartFelonies = "evade team member 1",
          disablePoliceInTrafficDuringMission = true,
          reenablePatrollingVehiclesAfterFelonyEnd = false
        },
        ["name"] = "FelonySettings"
      }
    },
    SpawnTypes = {
      ["Set position ambush1 cop1"] = {
        [1] = {
          ["Spawn location"] = "Escape the law 3 ambusher 1 cop1",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Roadblock position 7 (group2)"] = {
        [1] = {
          ["Spawn location"] = "Escape the law 3 roadblocker 7 (group2)",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Roadblock position 4 (group2)"] = {
        [1] = {
          ["Spawn location"] = "Escape the law 3 roadblocker 4 (group2)",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Roadblock position 1 (group1)"] = {
        [1] = {
          ["Spawn location"] = "Escape the law 3 roadblocker 1 (group1)",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Positions start cop 2"] = {
        [1] = {
          ["1"] = "chase team member 2",
          ["alternateLocation"] = "Escape the law 3 start cop2",
          ["2"] = "chase team member 3"
        },
        ["name"] = "Positions"
      },
      ["Roadblock position 1 (group2)"] = {
        [1] = {
          ["Spawn location"] = "Escape the law 3 roadblocker 1 (group2)",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Roadblock position 6 (group2)"] = {
        [1] = {
          ["Spawn location"] = "Escape the law 3 roadblocker 6 (group2)",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Softsave Positions 1"] = {
        [1] = {
          ["alternateLocation"] = "Escape the law 3 softsave cops 1",
          ["3"] = "chase team member 3 (softsave 1)",
          ["2"] = "chase team member 2 (softsave 1)",
          ["5"] = "chase team member 5 (softsave 1)",
          ["4"] = "chase team member 4 (softsave 1)",
          ["1"] = "chase team member 1 (softsave 1)",
          ["6"] = "chase team member 6 (softsave 1)"
        },
        ["name"] = "Positions"
      },
      ["Roadblock position 5 (group2)"] = {
        [1] = {
          ["Spawn location"] = "Escape the law 3 roadblocker 5 (group2)",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Roadblock position 9 (group2)"] = {
        [1] = {
          ["Spawn location"] = "Escape the law 3 roadblocker 9 (group2)",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Positions start cop"] = {
        [1] = {
          ["alternateLocation"] = "Escape the law 3 start cop",
          ["1"] = "chase team member 1"
        },
        ["name"] = "Positions"
      },
      ["Set position ambush1 cop2"] = {
        [1] = {
          ["Spawn location"] = "Escape the law 3 ambusher 1 cop2",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Dropoff spawn"] = {
        [1] = {
          ["Spawn location"] = "Escape the law 3 dropoff",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Roadblock position 3 (group2)"] = {
        [1] = {
          ["Spawn location"] = "Escape the law 3 roadblocker 3 (group2)",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Roadblock position 2 (group1)"] = {
        [1] = {
          ["Spawn location"] = "Escape the law 3 roadblocker 2 (group1)",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Softsave Positions 2"] = {
        [1] = {
          ["alternateLocation"] = "Escape the law 3 softsave cops 2",
          ["3"] = "chase team member 3 (softsave 2)",
          ["2"] = "chase team member 2 (softsave 2)",
          ["5"] = "chase team member 5 (softsave 2)",
          ["4"] = "chase team member 4 (softsave 2)",
          ["1"] = "chase team member 1 (softsave 2)",
          ["6"] = "chase team member 6 (softsave 2)"
        },
        ["name"] = "Positions"
      },
      ["Roadblock position 3 (group1)"] = {
        [1] = {
          ["Spawn location"] = "Escape the law 3 roadblocker 3 (group1)",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Roadblock position 10 (group2)"] = {
        [1] = {
          ["Spawn location"] = "Escape the law 3 roadblocker 10 (group2)",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Roadblock position 2 (group2)"] = {
        [1] = {
          ["Spawn location"] = "Escape the law 3 roadblocker 2 (group2)",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Evader position"] = {
        [1] = {
          ["alternateLocation"] = "Escape the law 3 spawn",
          ["1"] = "evade team member 1"
        },
        ["name"] = "Positions"
      },
      ["Roadblock position 4 (group1)"] = {
        [1] = {
          ["Spawn location"] = "Escape the law 3 roadblocker 4 (group1)",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Roadblock position 8 (group2)"] = {
        [1] = {
          ["Spawn location"] = "Escape the law 3 roadblocker 8 (group2)",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    Teams = {
      ["chase team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Roadblock team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["evade team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Dropoff Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Roadblock 2 team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionCompletes = {
      ["complete Escape the law 3"] = {
        [1] = {
          ["Perfect condition"] = "ID:184732",
          ["Success reason"] = "ID:184733",
          ["Success reason (perfect)"] = "ID:184734",
          ["Pass condition"] = "ID:184731",
          ["Failure reason (wrecked)"] = "ID:182731",
          ["Failure reason"] = "ID:184730",
          ["Arrested"] = "ID:184730",
          ["Out of time"] = "ID:184729"
        },
        ["name"] = "Escape the law 3"
      }
    },
    WarmupTypes = {
      ["Getaway Warmup"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          lookToVehicleTriggerRadius = 50,
          matchTrafficSpeed = false,
          warmupRouteName = "Escape the law 3 warmup",
          forceZapToVehicle = false,
          actorToChase = "evade team member 1",
          forceMissionAccept = false,
          lookToVehicle = false
        },
        ["name"] = "Warmup route"
      }
    },
    MissionSettings = {
      ["New MissionSetting"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Disable traffic"] = false,
          ["Hud logic file"] = "Escape the law 3 HUD",
          ["Mission props"] = "EscapeTheLaw3",
          ["Enable traffic at mission end"] = true,
          ["disablePlayerIgnoring"] = false,
          ["Audio logic file"] = "Escape the law 3 APIP",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["Start location"] = "Escape the law 3 start",
          ["Enable race status prompts"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    MissionInfos = {
      ["New Title and description 3"] = {
        [1] = {
          ["1 Text"] = "ID:248735",
          ["Success reason"] = "ID:245620",
          ["missionMarkers"] = {
            [1] = {
              value = "None",
              cardName = "Roadblocker 7 (group2)",
              cardType = "Actor"
            },
            [2] = {
              value = "None",
              cardName = "chase team member 6 (softsave 1)",
              cardType = "Actor"
            },
            [3] = {
              value = "Objective",
              cardName = "evade team member 1",
              cardType = "Actor"
            },
            [4] = {
              value = "None",
              cardName = "Roadblocker 4",
              cardType = "Actor"
            },
            [5] = {
              value = "None",
              cardName = "Roadblocker 2 (group2)",
              cardType = "Actor"
            },
            [6] = {
              value = "None",
              cardName = "Roadblocker 2 (group1)",
              cardType = "Actor"
            },
            [7] = {
              value = "None",
              cardName = "chase team member 2",
              cardType = "Actor"
            },
            [8] = {
              value = "None",
              cardName = "chase team member 5",
              cardType = "Actor"
            },
            [9] = {
              value = "None",
              cardName = "Dropoff vehicle",
              cardType = "Actor"
            },
            [10] = {
              value = "None",
              cardName = "Roadblocker 1 (group2)",
              cardType = "Actor"
            },
            [11] = {
              value = "None",
              cardName = "Roadblocker 3 (group2)",
              cardType = "Actor"
            },
            [12] = {
              value = "None",
              cardName = "Roadblocker 4 (group2)",
              cardType = "Actor"
            },
            [13] = {
              value = "None",
              cardName = "Roadblocker 1 (group1)",
              cardType = "Actor"
            },
            [14] = {
              value = "None",
              cardName = "Roadblocker 4 (group1)",
              cardType = "Actor"
            },
            [15] = {
              value = "None",
              cardName = "chase team member 3 (softsave 1)",
              cardType = "Actor"
            },
            [16] = {
              value = "None",
              cardName = "chase team member 3 (softsave 2)",
              cardType = "Actor"
            },
            [17] = {
              value = "None",
              cardName = "chase team member 4 (softsave 2)",
              cardType = "Actor"
            },
            [18] = {
              value = "None",
              cardName = "chase team member 1",
              cardType = "Actor"
            },
            [19] = {
              value = "None",
              cardName = "Roadblocker 10 (group2)",
              cardType = "Actor"
            },
            [20] = {
              value = "None",
              cardName = "chase team member 1 (softsave 1)",
              cardType = "Actor"
            },
            [21] = {
              value = "None",
              cardName = "chase team member 5 (softsave 1)",
              cardType = "Actor"
            },
            [22] = {
              value = "None",
              cardName = "chase team member 5 (softsave 2)",
              cardType = "Actor"
            },
            [23] = {
              value = "None",
              cardName = "Roadblocker 3 (group1)",
              cardType = "Actor"
            },
            [24] = {
              value = "None",
              cardName = "chase team member 3",
              cardType = "Actor"
            },
            [25] = {
              value = "None",
              cardName = "Roadblocker 5 (group2)",
              cardType = "Actor"
            },
            [26] = {
              value = "None",
              cardName = "chase team member 4 (softsave 1)",
              cardType = "Actor"
            },
            [27] = {
              value = "None",
              cardName = "chase team member 4",
              cardType = "Actor"
            },
            [28] = {
              value = "None",
              cardName = "Roadblocker 6 (group2)",
              cardType = "Actor"
            },
            [29] = {
              value = "None",
              cardName = "chase team member 2 (softsave 1)",
              cardType = "Actor"
            },
            [30] = {
              value = "None",
              cardName = "chase team member 1 (softsave 2)",
              cardType = "Actor"
            },
            [31] = {
              value = "None",
              cardName = "chase team member 6 (softsave 2)",
              cardType = "Actor"
            },
            [32] = {
              value = "None",
              cardName = "Roadblocker 9 (group2)",
              cardType = "Actor"
            },
            [33] = {
              value = "None",
              cardName = "Roadblocker 8 (group2)",
              cardType = "Actor"
            },
            [34] = {
              value = "None",
              cardName = "chase team member 2 (softsave 2)",
              cardType = "Actor"
            }
          },
          ["3 Text"] = "ID:245528",
          ["2 Text"] = "ID:184738"
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      [" Escape the law 3"] = {
        [1] = {
          ["Chase team"] = {
            instance = 1,
            type = "Teams",
            name = "chase team"
          },
          ["Roadblock team"] = {
            instance = 1,
            type = "Teams",
            name = "Roadblock team"
          },
          ["Evade team"] = {
            instance = 1,
            type = "Teams",
            name = "evade team"
          },
          ["Roadblock 2 team"] = {
            instance = 1,
            type = "Teams",
            name = "Roadblock 2 team"
          },
          ["Dropoff team"] = {
            instance = 1,
            type = "Teams",
            name = "Dropoff Team"
          }
        },
        ["name"] = "Escape the law 3"
      }
    }
  }
}
