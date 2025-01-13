cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Mass Chase"] = {
  FileVersion = "2",
  name = "Mass Chase",
  title = "ID:184799",
  MissionID = "2821",
  description = "ID:184800",
  cardInstances = {
    Actors = {
      ["Cop 4 Actor"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 15,
          team = {
            instance = 1,
            type = "Teams",
            name = "Cop Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop2"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0.1,
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
            name = "Cop 4 position"
          },
          vehicleId = 265,
          enableSiren = false,
          spawnSpeed = 0,
          enableSimulationArea = false,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          ignoreOtherAis = false,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Cop 7 Actor"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 60,
          team = {
            instance = 1,
            type = "Teams",
            name = "Cop Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop3"
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
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Cop 7 position"
          },
          vehicleId = 265,
          enableSiren = false,
          spawnSpeed = 60,
          enableSimulationArea = false,
          attackStationaryVehicle = false,
          avoidedByCivilianTraffic = false,
          stayInLockedArea = false,
          blockTow = false,
          ignoreOtherAis = false,
          avoidAttacks = false,
          ignoreCivilianTraffic = false,
          reactionTime = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Cop 1 Actor"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 85,
          team = {
            instance = 1,
            type = "Teams",
            name = "Cop Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop1"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
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
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Mass chase 1: Start spawn"
          },
          vehicleId = 265,
          enableSiren = true,
          spawnSpeed = 60,
          enableSimulationArea = false,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          ignoreCivilianTraffic = false,
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          raceManagerRoute = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Cop 8 Actor"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 15,
          team = {
            instance = 1,
            type = "Teams",
            name = "Cop Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop4"
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
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Cop 8 position"
          },
          vehicleId = 265,
          enableSiren = false,
          spawnSpeed = 0,
          enableSimulationArea = false,
          attackStationaryVehicle = false,
          avoidedByCivilianTraffic = false,
          stayInLockedArea = false,
          blockTow = false,
          ignoreOtherAis = false,
          avoidAttacks = false,
          ignoreCivilianTraffic = false,
          reactionTime = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Cop 10 Actor"] = {
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
            name = "Truck Cop Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop2"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 0,
          driveOnPavements = 0.4,
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
            name = "Cop 10 relative to truck"
          },
          ramInFrontDistance = 150,
          vehicleId = 265,
          enableSiren = true,
          enableSimulationArea = false,
          spawnSpeed = 70,
          attackStationaryVehicle = false,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          groupAggression = "High",
          avoidAttacks = false,
          avoidAlleys = 0.1,
          desiredSpeed = 70,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Cop 11 Actor"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 60,
          team = {
            instance = 1,
            type = "Teams",
            name = "Cop Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop1"
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
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Cop 11 position"
          },
          vehicleId = 265,
          enableSiren = false,
          spawnSpeed = 60,
          enableSimulationArea = false,
          attackStationaryVehicle = false,
          avoidedByCivilianTraffic = false,
          stayInLockedArea = false,
          blockTow = false,
          ignoreOtherAis = false,
          avoidAttacks = false,
          ignoreCivilianTraffic = false,
          reactionTime = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Truck"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = true,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          desiredSpeed = 40,
          team = {
            instance = 1,
            type = "Teams",
            name = "Truck Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = true,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = true,
          collisionResilience = "Unstoppable",
          raceManagerRoute = true,
          vehicleTrailerId = -1,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Truck position"
          },
          vehicleId = 286,
          shaderParam = 4,
          enableSiren = false,
          spawnSpeed = 120,
          enableSimulationArea = true,
          damageMultiplier = 0.2,
          attackStationaryVehicle = false,
          routeName = "Mass chase 1 truck",
          reactionTime = "Average",
          stayInLockedArea = false,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          ignoreOtherAis = false,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Player"] = {
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
            name = "Player Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Player Character"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          distanceFromFrontOfGroup = 0,
          driveInOncoming = 0.1,
          vehicleTrailerId = -1,
          previewMovie = "Hello",
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Warmup route"
          },
          avoidUTurns = true,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          shaderParam = 0,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Mass chase 1: Start spawn"
          },
          vehicleId = 226,
          enableSiren = false,
          enableSimulationArea = true,
          restrictedVehicleType = 0,
          damageMultiplier = 0.2,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          ignoreCivilianTraffic = false,
          noOccupants = false,
          stayInLockedArea = true,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          raceManagerRoute = false,
          aiIgnorePlayerInCivsUntilHit = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Cop 5 Actor"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 15,
          team = {
            instance = 1,
            type = "Teams",
            name = "Cop Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop3"
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
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Cop 5 position"
          },
          vehicleId = 265,
          enableSiren = false,
          spawnSpeed = 0,
          enableSimulationArea = false,
          attackStationaryVehicle = false,
          avoidedByCivilianTraffic = false,
          stayInLockedArea = false,
          blockTow = false,
          ignoreOtherAis = false,
          avoidAttacks = false,
          ignoreCivilianTraffic = false,
          reactionTime = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Cop 9 Actor"] = {
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
            name = "Truck Cop Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop4"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 0,
          driveOnPavements = 0.5,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          vehicleTrailerId = -1,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Cop 9 relative to truck"
          },
          ramInFrontDistance = 150,
          vehicleId = 265,
          enableSiren = true,
          enableSimulationArea = false,
          spawnSpeed = 70,
          attackStationaryVehicle = false,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          groupAggression = "High",
          avoidAttacks = false,
          avoidAlleys = 0.1,
          desiredSpeed = 70,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Cop 3 Actor"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 15,
          team = {
            instance = 1,
            type = "Teams",
            name = "Cop Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop1"
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
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Cop 3 position"
          },
          vehicleId = 265,
          enableSiren = false,
          spawnSpeed = 0,
          enableSimulationArea = false,
          attackStationaryVehicle = false,
          avoidedByCivilianTraffic = false,
          stayInLockedArea = false,
          blockTow = false,
          ignoreOtherAis = false,
          avoidAttacks = false,
          ignoreCivilianTraffic = false,
          reactionTime = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Cop 2 Actor"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 85,
          team = {
            instance = 1,
            type = "Teams",
            name = "Cop Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop2"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
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
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Mass chase 1: Start spawn"
          },
          vehicleId = 265,
          enableSiren = true,
          spawnSpeed = 60,
          enableSimulationArea = false,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          ignoreCivilianTraffic = false,
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          raceManagerRoute = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Cop1"] = {
        [1] = {
          ["Driver id"] = "781923877"
        },
        ["name"] = "Character"
      },
      ["Cop3"] = {
        [1] = {
          ["Driver id"] = "900396692"
        },
        ["name"] = "Character"
      },
      ["Cop4"] = {
        [1] = {
          ["Driver id"] = "-1784376771"
        },
        ["name"] = "Character"
      },
      ["Cop2"] = {
        [1] = {
          ["Driver id"] = "1580977604"
        },
        ["name"] = "Character"
      },
      ["Player Character"] = {
        [1] = {
          ["Passenger id"] = "-1370363296",
          ["Driver id"] = "1367889294"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      MissionSettings = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Disable traffic"] = false,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Mass chase 1 player",
          ["Audio logic file"] = "Mass Chase APIP",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["disablePlayerIgnoring"] = false,
          ["Enable race status prompts"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    SpawnTypes = {
      ["Cop 4 position"] = {
        [1] = {
          ["Spawn location"] = "Mass chase 1: Cop 4 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Mass chase 1: Start spawn"] = {
        [1] = {
          ["1"] = "Player",
          ["3"] = "Cop 2 Actor",
          ["2"] = "Cop 1 Actor"
        },
        ["name"] = "Positions"
      },
      ["Cop 8 position"] = {
        [1] = {
          ["Spawn location"] = "Mass chase 1: Cop 8 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Cop 5 position"] = {
        [1] = {
          ["Spawn location"] = "Mass chase 1: Cop 5 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Cop 9 relative to truck"] = {
        [1] = {
          actor = "Truck",
          whichLane = "randomLane",
          withVehicleDirection = true,
          distance = 10,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = false
        },
        ["name"] = "Relative to Vehicle"
      },
      ["Truck position"] = {
        [1] = {
          ["Spawn location"] = "Mass chase 1 buddy",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Cop 3 position"] = {
        [1] = {
          ["Spawn location"] = "Mass chase 1: Cop 3 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Cop 10 relative to truck"] = {
        [1] = {
          actor = "Truck",
          whichLane = "randomLane",
          withVehicleDirection = true,
          distance = 10,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = false
        },
        ["name"] = "Relative to Vehicle"
      },
      ["Cop 11 position"] = {
        [1] = {
          ["Spawn location"] = "Mass chase 1: Cop 11 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Cop 7 position"] = {
        [1] = {
          ["Spawn location"] = "Mass chase 1: Cop 7 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Cop 6 position"] = {
        [1] = {
          ["Spawn location"] = "Mass chase 1: Cop 6 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    Teams = {
      ["Cop Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Truck Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Truck Cop Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Player Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionCompletes = {
      ["New Mass chase complete"] = {
        [1] = {
          ["Perfect condition"] = "ID:184802",
          ["Success reason"] = "ID:184803",
          ["Failure reason"] = "ID:231166",
          ["Success reason (perfect)"] = "ID:184804",
          ["Pass condition"] = "ID:184801",
          ["Failure reason (wrecked)"] = "ID:184950"
        },
        ["name"] = "Mass chase"
      }
    },
    WarmupTypes = {
      ["New Warmup route"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          warmupRouteName = "Mass chase 1 warmup",
          matchTrafficSpeed = false,
          actorToChase = "Player",
          forceZapToVehicle = false,
          forceMissionAccept = false,
          driveInOncoming = 0.5,
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
      ["Mission Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:245541",
          ["missionMarkers"] = {
            [1] = {
              value = "None",
              cardName = "Cop 9 Actor",
              cardType = "Actor"
            },
            [2] = {
              value = "None",
              cardName = "Cop 3 Actor",
              cardType = "Actor"
            },
            [3] = {
              value = "None",
              cardName = "Cop 4 Actor",
              cardType = "Actor"
            },
            [4] = {
              value = "None",
              cardName = "Cop 5 Actor",
              cardType = "Actor"
            },
            [5] = {
              value = "None",
              cardName = "Cop 8 Actor",
              cardType = "Actor"
            },
            [6] = {
              value = "None",
              cardName = "Cop 2 Actor",
              cardType = "Actor"
            },
            [7] = {
              value = "Objective",
              cardName = "Player",
              cardType = "Actor"
            },
            [8] = {
              value = "Yellow Marker, Destination Vehicle",
              cardName = "Truck",
              cardType = "Actor"
            },
            [9] = {
              value = "None",
              cardName = "Cop 11 Actor",
              cardType = "Actor"
            },
            [10] = {
              value = "None",
              cardName = "Cop 10 Actor",
              cardType = "Actor"
            },
            [11] = {
              value = "None",
              cardName = "Cop 7 Actor",
              cardType = "Actor"
            },
            [12] = {
              value = "None",
              cardName = "Cop 1 Actor",
              cardType = "Actor"
            }
          },
          ["5 Text"] = "ID:184790",
          ["4 Text"] = "ID:245542",
          ["3 Text"] = "ID:245508",
          ["2 Text"] = "ID:236468"
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Mass chase"] = {
        [1] = {
          ["Buddy team"] = {
            instance = 1,
            type = "Teams",
            name = "Truck Team"
          },
          ["Spawner 2 team"] = {
            instance = 1,
            type = "Teams",
            name = "Truck Cop Team"
          },
          ["Player team"] = {
            instance = 1,
            type = "Teams",
            name = "Player Team"
          },
          ["Spawner team"] = {
            instance = 1,
            type = "Teams",
            name = "Cop Team"
          }
        },
        ["name"] = "Mass chase"
      }
    }
  }
}
