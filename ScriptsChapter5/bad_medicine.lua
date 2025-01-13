cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Bad medicine"] = {
  FileVersion = "2",
  name = "Bad medicine",
  title = "ID:184875",
  MissionID = "221",
  description = "ID:184876",
  cardInstances = {
    Actors = {
      ["Convoy2 (Actor)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 55,
          team = {
            instance = 1,
            type = "Teams",
            name = "Convoy (Team)"
          },
          drivingSkill = "Over-cautious",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Convoy 2 Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = true,
          whenSpawned = "Never",
          distanceFromFrontOfGroup = 50,
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = true,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Convoy2 SP (Spawn)"
          },
          vehicleId = 290,
          enableSiren = false,
          enableSimulationArea = true,
          spawnSpeed = 55,
          damageMultiplier = 1.5,
          attackStationaryVehicle = false,
          rubberbandingStrength = "Average",
          reactionTime = "Average",
          raceManagerRoute = false,
          routeName = "Bad medicine route",
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = true,
          avoidAttacks = false,
          avoidAlleys = 1,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["StoppedConvoy1 (Actor)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 5,
          team = {
            instance = 1,
            type = "Teams",
            name = "StoppedConvoy (Team)"
          },
          applyDamage = 0.5,
          drivingSkill = "Cautious",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "StoppedConvoy Characters"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = true,
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
            name = "Stopped Convoy1 SP (Spawn)"
          },
          vehicleId = 290,
          enableSiren = false,
          spawnSpeed = 0,
          enableSimulationArea = false,
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          reactionTime = "Fast",
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          avoidAlleys = 1,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Convoy1 (Actor)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 55,
          team = {
            instance = 1,
            type = "Teams",
            name = "Convoy (Team)"
          },
          drivingSkill = "Over-cautious",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Convoy 1 Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = true,
          whenSpawned = "Never",
          distanceFromFrontOfGroup = 0,
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = true,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Convoy1 SP (Spawn)"
          },
          vehicleId = 290,
          enableSiren = false,
          enableSimulationArea = true,
          spawnSpeed = 60,
          damageMultiplier = 1.5,
          attackStationaryVehicle = false,
          rubberbandingStrength = "Average",
          reactionTime = "Average",
          raceManagerRoute = true,
          routeName = "Bad medicine route",
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = true,
          avoidAttacks = false,
          avoidAlleys = 1,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["StoppedConvoy9 (Actor)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 5,
          team = {
            instance = 1,
            type = "Teams",
            name = "StoppedConvoy (Team)"
          },
          applyDamage = 0.5,
          drivingSkill = "Cautious",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "StoppedConvoy Characters"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = true,
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
            name = "Stopped Convoy9 SP (Spawn)"
          },
          vehicleId = 170,
          shaderParam = 1,
          enableSiren = false,
          spawnSpeed = 0,
          enableSimulationArea = false,
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          reactionTime = "Fast",
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          avoidAlleys = 1,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["StoppedConvoy5 (Actor)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 5,
          team = {
            instance = 1,
            type = "Teams",
            name = "StoppedConvoy (Team)"
          },
          applyDamage = 0.5,
          drivingSkill = "Cautious",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Ron"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = true,
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
            name = "Stopped Convoy5 SP (Spawn)"
          },
          vehicleId = 290,
          enableSiren = false,
          spawnSpeed = 0,
          enableSimulationArea = false,
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          reactionTime = "Fast",
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          avoidAlleys = 1,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["StoppedConvoy7 (Actor)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 5,
          team = {
            instance = 1,
            type = "Teams",
            name = "StoppedConvoy (Team)"
          },
          applyDamage = 0.5,
          drivingSkill = "Cautious",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "StoppedConvoy Characters"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = true,
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
            name = "Stopped Convoy7 SP (Spawn)"
          },
          vehicleId = 170,
          shaderParam = 4,
          enableSiren = false,
          spawnSpeed = 0,
          enableSimulationArea = false,
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          reactionTime = "Fast",
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          avoidAlleys = 1,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["StoppedConvoy8 (Actor)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 5,
          team = {
            instance = 1,
            type = "Teams",
            name = "StoppedConvoy (Team)"
          },
          applyDamage = 0.5,
          drivingSkill = "Cautious",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "StoppedConvoy Characters"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = true,
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
            name = "Stopped Convoy8 SP (Spawn)"
          },
          vehicleId = 170,
          shaderParam = 4,
          enableSiren = false,
          spawnSpeed = 0,
          enableSimulationArea = false,
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          reactionTime = "Fast",
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          avoidAlleys = 1,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["StoppedConvoy6 (Actor)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 5,
          team = {
            instance = 1,
            type = "Teams",
            name = "StoppedConvoy (Team)"
          },
          applyDamage = 0.5,
          drivingSkill = "Cautious",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "StoppedConvoy Characters"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = true,
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
            name = "Stopped Convoy6 SP (Spawn)"
          },
          vehicleId = 170,
          shaderParam = 1,
          enableSiren = false,
          spawnSpeed = 0,
          enableSimulationArea = false,
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          reactionTime = "Fast",
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          avoidAlleys = 1,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Convoy3 (Actor)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 55,
          team = {
            instance = 1,
            type = "Teams",
            name = "Convoy (Team)"
          },
          drivingSkill = "Over-cautious",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Convoy 3 Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = true,
          whenSpawned = "Never",
          distanceFromFrontOfGroup = 100,
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = true,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Convoy3 SP (Spawn)"
          },
          vehicleId = 290,
          enableSiren = false,
          enableSimulationArea = true,
          spawnSpeed = 55,
          damageMultiplier = 1.5,
          attackStationaryVehicle = false,
          rubberbandingStrength = "Average",
          reactionTime = "Average",
          raceManagerRoute = false,
          routeName = "Bad medicine route",
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = true,
          avoidAttacks = false,
          avoidAlleys = 1,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["StoppedConvoy3 (Actor)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 5,
          team = {
            instance = 1,
            type = "Teams",
            name = "StoppedConvoy (Team)"
          },
          applyDamage = 0.5,
          drivingSkill = "Cautious",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Convoy 3 Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = true,
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
            name = "Stopped Convoy3 SP (Spawn)"
          },
          vehicleId = 290,
          enableSiren = false,
          spawnSpeed = 0,
          enableSimulationArea = false,
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          reactionTime = "Fast",
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          avoidAlleys = 1,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["StoppedConvoy2 (Actor)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 5,
          team = {
            instance = 1,
            type = "Teams",
            name = "StoppedConvoy (Team)"
          },
          applyDamage = 0.5,
          drivingSkill = "Cautious",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "StoppedConvoy Characters"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = true,
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
            name = "Stopped Convoy2 SP (Spawn)"
          },
          vehicleId = 290,
          enableSiren = false,
          spawnSpeed = 0,
          enableSimulationArea = false,
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          reactionTime = "Fast",
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          avoidAlleys = 1,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Attacker1 (Actor)"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 75,
          team = {
            instance = 1,
            type = "Teams",
            name = "Attacker (Team)"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Ron"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          enableSiren = false,
          tailingDistance = 50,
          driveOnPavements = 0.1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Warmup route"
          },
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          enableSimulationArea = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 271,
          aiIgnorePlayerInCivsUntilHit = false,
          isMultiplayerActor = false,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          ignoreCivilianTraffic = false,
          raceManagerRoute = false,
          matchTrafficSpeed = false,
          previewMovie = " ",
          stayInLockedArea = false,
          blockTow = false,
          groupAggression = "Low",
          avoidAttacks = false,
          avoidAlleys = 0,
          driveInOncoming = 0.1,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["StoppedConvoy4 (Actor)"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 5,
          team = {
            instance = 1,
            type = "Teams",
            name = "StoppedConvoy (Team)"
          },
          applyDamage = 0.5,
          drivingSkill = "Cautious",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "StoppedConvoy Characters"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = true,
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
            name = "Stopped Convoy4 SP (Spawn)"
          },
          vehicleId = 290,
          enableSiren = false,
          spawnSpeed = 0,
          enableSimulationArea = false,
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          reactionTime = "Fast",
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          avoidAlleys = 1,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["StoppedConvoy Characters"] = {
        [1] = {},
        ["name"] = "Character"
      },
      ["Ron"] = {
        [1] = {
          ["Passenger id"] = "-922446650",
          ["Driver id"] = "1307138515"
        },
        ["name"] = "Character"
      },
      ["Convoy 1 Character"] = {
        [1] = {
          ["Passenger id"] = "-1156800003",
          ["Driver id"] = "-153831608"
        },
        ["name"] = "Character"
      },
      ["Convoy 3 Character"] = {
        [1] = {
          ["Passenger id"] = "1548270126",
          ["Driver id"] = "77551189"
        },
        ["name"] = "Character"
      },
      ["Convoy 2 Character"] = {
        [1] = {
          ["Passenger id"] = "765256936",
          ["Driver id"] = "-1864251838"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      ["Mission Settings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Disable traffic"] = false,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Bad medicine start",
          ["Audio logic file"] = "Bad Medicine APIP",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["disablePlayerIgnoring"] = true,
          ["Enable race status prompts"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["Attacker (Team)"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Convoy (Team)"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["StoppedConvoy (Team)"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    SpawnTypes = {
      ["Stopped Convoy1 SP (Spawn)"] = {
        [1] = {
          ["Spawn location"] = "Bad medicine stopped convoy1",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Stopped Convoy7 SP (Spawn)"] = {
        [1] = {
          ["Spawn location"] = "Bad medicine stopped convoy7",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Convoy3 SP (Spawn)"] = {
        [1] = {
          ["Spawn location"] = "Bad medicine convoy3",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Stopped Convoy3 SP (Spawn)"] = {
        [1] = {
          ["Spawn location"] = "Bad medicine stopped convoy3",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Stopped Convoy4 SP (Spawn)"] = {
        [1] = {
          ["Spawn location"] = "Bad medicine stopped convoy4",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Stopped Convoy8 SP (Spawn)"] = {
        [1] = {
          ["Spawn location"] = "Bad medicine stopped convoy8",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["New Positions"] = {
        [1] = {
          ["1"] = "Attacker1 (Actor)"
        },
        ["name"] = "Positions"
      },
      ["Stopped Convoy5 SP (Spawn)"] = {
        [1] = {
          ["Spawn location"] = "Bad medicine stopped convoy5",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Stopped Convoy2 SP (Spawn)"] = {
        [1] = {
          ["Spawn location"] = "Bad medicine stopped convoy2",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Convoy2 SP (Spawn)"] = {
        [1] = {
          ["Spawn location"] = "Bad medicine convoy2",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Stopped Convoy6 SP (Spawn)"] = {
        [1] = {
          ["Spawn location"] = "Bad medicine stopped convoy6",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Stopped Convoy9 SP (Spawn)"] = {
        [1] = {
          ["Spawn location"] = "Bad medicine stopped convoy9",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Convoy1 SP (Spawn)"] = {
        [1] = {
          ["Spawn location"] = "Bad medicine convoy1",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    WarmupTypes = {
      ["New Warmup route"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          lookToVehicleTriggerRadius = 50,
          warmupRouteName = "Bad medicine warmup route",
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
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    MissionInfos = {
      ["New Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:245545",
          ["Success reason"] = "ID:236566",
          ["missionMarkers"] = {
            [1] = {
              value = "Opponent",
              cardName = "Convoy1 (Actor)",
              cardType = "Actor"
            },
            [2] = {
              value = "Opponent",
              cardName = "Convoy2 (Actor)",
              cardType = "Actor"
            },
            [3] = {
              value = "None",
              cardName = "StoppedConvoy5 (Actor)",
              cardType = "Actor"
            },
            [4] = {
              value = "None",
              cardName = "StoppedConvoy4 (Actor)",
              cardType = "Actor"
            },
            [5] = {
              value = "Opponent",
              cardName = "Convoy3 (Actor)",
              cardType = "Actor"
            },
            [6] = {
              value = "None",
              cardName = "StoppedConvoy7 (Actor)",
              cardType = "Actor"
            },
            [7] = {
              value = "None",
              cardName = "StoppedConvoy8 (Actor)",
              cardType = "Actor"
            },
            [8] = {
              value = "None",
              cardName = "StoppedConvoy2 (Actor)",
              cardType = "Actor"
            },
            [9] = {
              value = "None",
              cardName = "StoppedConvoy9 (Actor)",
              cardType = "Actor"
            },
            [10] = {
              value = "None",
              cardName = "StoppedConvoy3 (Actor)",
              cardType = "Actor"
            },
            [11] = {
              value = "Objective",
              cardName = "Attacker1 (Actor)",
              cardType = "Actor"
            },
            [12] = {
              value = "None",
              cardName = "StoppedConvoy1 (Actor)",
              cardType = "Actor"
            },
            [13] = {
              value = "None",
              cardName = "StoppedConvoy6 (Actor)",
              cardType = "Actor"
            }
          },
          ["Failure reason"] = "ID:184882",
          ["3 Text"] = "ID:184883",
          ["Pass condition"] = "ID:184880",
          ["2 Text"] = "ID:248729"
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["Bad medicine"] = {
        [1] = {
          ["Total laps"] = 0,
          ["Guard team"] = {
            instance = 1,
            type = "Teams",
            name = "StoppedConvoy (Team)"
          },
          ["Chaser eliminates all racers"] = true,
          ["Racer damage for chaser win"] = 1,
          ["Don't highlight starting car"] = false,
          ["Race team"] = {
            instance = 1,
            type = "Teams",
            name = "Convoy (Team)"
          },
          ["Racer dont destroy chasers"] = false,
          ["Photograph mission"] = false,
          ["Score needed for each vehicle"] = false,
          ["Chase team"] = {
            instance = 1,
            type = "Teams",
            name = "Attacker (Team)"
          }
        },
        ["name"] = "Bad medicine"
      }
    }
  }
}
