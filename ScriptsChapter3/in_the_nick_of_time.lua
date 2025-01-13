cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["In the nick of time"] = {
  FileVersion = "2",
  name = "In the nick of time",
  title = "ID:184840",
  MissionID = "5367",
  description = "ID:184841",
  cardInstances = {
    Actors = {
      ["Fire engine prop 1"] = {
        [1] = {
          lockedToPlayer = true,
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
            name = "Cop prop Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On mission start",
          driveInOncoming = 0.5,
          driveOnPavements = 0.5,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Set position prop fire engine 1"
          },
          vehicleId = 185,
          vehicleTrailerId = -1,
          enableSiren = true,
          enableSimulationArea = false,
          damageMultiplier = 0.1,
          attackStationaryVehicle = false,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = true,
          desiredSpeed = 80,
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          raceManagerRoute = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Bomb goon"] = {
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
            name = "Bomb goon Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          matchTrafficSpeedMultiplier = 1,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Bomb Goon"
          },
          forceHighLodCharacters = true,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          distanceFromFrontOfGroup = 0,
          tailingDistance = 0,
          driveOnPavements = 0.3,
          noOccupants = false,
          enableSimulationArea = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 0,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          enableSiren = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Bomb Goon Spawner"
          },
          vehicleId = 178,
          driveInOncoming = 0.2,
          spawnSpeed = 0,
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          groupAggression = "Low",
          routeName = "InTheNickOfTimeGetawayRoute",
          raceManagerRoute = false,
          matchTrafficSpeed = false,
          stayInLockedArea = true,
          blockTow = true,
          avoidAlleys = 1,
          avoidAttacks = false,
          desiredSpeed = 110,
          avoidedByCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Cop escort 2"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 90,
          team = {
            instance = 1,
            type = "Teams",
            name = "Cop escort Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Terry Cop"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          driveInOncoming = 0.5,
          driveOnPavements = 0.5,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Route warmup"
          },
          enableSiren = true,
          avoidUTurns = false,
          avoidedByCivilianTraffic = true,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Escort Spawner"
          },
          vehicleId = 271,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Weak",
          spawnSpeed = 50,
          rubberbandingActor = "Disposal van",
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = -60,
          ignoreCivilianTraffic = false,
          routeName = "InTheNickOfTimeMissionRoute",
          stayInLockedArea = false,
          blockTow = true,
          reactionTime = "Fastest",
          avoidAttacks = false,
          raceManagerRoute = false,
          aiIgnorePlayerInCivsUntilHit = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Cop chaser 1"] = {
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
            name = "Cop chase Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Derek Cop"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 10,
          driveOnPavements = 0.5,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          enableSiren = true,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Cop Chaser Spawner"
          },
          vehicleId = 271,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 0,
          rubberbandingActor = "Bomb goon",
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          distanceBehindPlayer = 0,
          driveInOncoming = 0.5,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = true,
          groupAggression = "Average",
          avoidAttacks = false,
          desiredSpeed = 160,
          avoidedByCivilianTraffic = true,
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
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Player Team"
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
            name = "New As localPlayer"
          },
          vehicleId = -1,
          attackStationaryVehicle = false,
          enableSiren = false,
          enableSimulationArea = false,
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          ignoreOtherAis = false,
          reactionTime = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Disposal van"] = {
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
            name = "Disposal van Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Tanner Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          driveInOncoming = 0,
          driveOnPavements = 0.5,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Route warmup"
          },
          enableSiren = true,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Escort Spawner"
          },
          vehicleId = 280,
          enableSimulationArea = false,
          isMultiplayerActor = false,
          spawnSpeed = 50,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          desiredSpeed = 70,
          raceManagerRoute = true,
          routeName = "InTheNickOfTimeMissionRoute",
          stayInLockedArea = false,
          blockTow = true,
          previewMovie = " ",
          avoidAttacks = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Cop prop 1"] = {
        [1] = {
          lockedToPlayer = true,
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
            name = "Cop prop Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On mission start",
          driveInOncoming = 0.5,
          driveOnPavements = 0.5,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Set position prop cop 2"
          },
          vehicleId = 271,
          vehicleTrailerId = -1,
          enableSiren = true,
          enableSimulationArea = false,
          damageMultiplier = 0.1,
          attackStationaryVehicle = false,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = true,
          desiredSpeed = 80,
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          raceManagerRoute = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Cop chaser 2"] = {
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
            name = "Cop chase Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Terry Cop"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          distanceFromFrontOfGroup = 0,
          tailingDistance = 5,
          driveOnPavements = 0.5,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          enableSiren = true,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Cop Chaser Spawner2"
          },
          vehicleId = 271,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 0,
          rubberbandingActor = "Bomb goon",
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          distanceBehindPlayer = 0,
          driveInOncoming = 0.5,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = true,
          groupAggression = "Average",
          avoidAttacks = false,
          desiredSpeed = 160,
          avoidedByCivilianTraffic = true,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Cop escort 1"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 90,
          team = {
            instance = 1,
            type = "Teams",
            name = "Cop escort Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Derek Cop"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          driveInOncoming = 0.5,
          driveOnPavements = 0.5,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Route warmup"
          },
          enableSiren = true,
          avoidUTurns = false,
          avoidedByCivilianTraffic = true,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Escort Spawner"
          },
          vehicleId = 271,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Weak",
          spawnSpeed = 50,
          rubberbandingActor = "Disposal van",
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = -60,
          ignoreCivilianTraffic = false,
          routeName = "InTheNickOfTimeMissionRoute",
          stayInLockedArea = false,
          blockTow = true,
          reactionTime = "Fastest",
          avoidAttacks = false,
          raceManagerRoute = false,
          aiIgnorePlayerInCivsUntilHit = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Tanner Character"] = {
        [1] = {
          ["Passenger id"] = "-42773077",
          ["Driver id"] = "-949192537"
        },
        ["name"] = "Character"
      },
      ["Bomb Goon"] = {
        [1] = {
          ["Driver id"] = "-70535787"
        },
        ["name"] = "Character"
      },
      ["Derek Cop"] = {
        [1] = {
          ["Passenger id"] = "-393069347",
          ["Driver id"] = "-922446650"
        },
        ["name"] = "Character"
      },
      ["Terry Cop"] = {
        [1] = {
          ["Passenger id"] = "-879852041",
          ["Driver id"] = "1307138515"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      ["New MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Load traffic on start"] = "Challenge traffic heavy",
          ["Hud logic file"] = "In the nick of time hud",
          ["Disable traffic"] = false,
          ["Enable traffic at mission end"] = true,
          ["disablePlayerIgnoring"] = false,
          ["Audio logic file"] = "In the nick of time APIP",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["Start location"] = "InTheNickOfTimeMissionStart",
          ["Enable race status prompts"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["Cop prop Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Cop chase Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Disposal van Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Cop escort Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Bomb goon Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Player Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    SpawnTypes = {
      ["Cop Chaser Spawner2"] = {
        [1] = {
          ["alternateLocation"] = "In the nick of time chase cop2",
          ["1"] = "Cop chaser 2"
        },
        ["name"] = "Positions"
      },
      ["New As localPlayer"] = {
        [1] = {},
        ["name"] = "As localPlayer"
      },
      ["Bomb Goon Spawner"] = {
        [1] = {
          ["alternateLocation"] = "In the nick of time bomb goon",
          ["1"] = "Bomb goon"
        },
        ["name"] = "Positions"
      },
      ["Cop Chaser Spawner"] = {
        [1] = {
          ["alternateLocation"] = "In the nick of time chase cop1",
          ["1"] = "Cop chaser 1"
        },
        ["name"] = "Positions"
      },
      ["Escort Spawner"] = {
        [1] = {
          ["1"] = "Cop escort 1",
          ["3"] = "Disposal van",
          ["2"] = "Cop escort 2"
        },
        ["name"] = "Positions"
      },
      ["Set position prop cop 2"] = {
        [1] = {
          ["Spawn location"] = "In the nick of time prop cop1",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Set position prop fire engine 1"] = {
        [1] = {
          ["Spawn location"] = "In the nick of time prop fire engine1",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    WarmupTypes = {
      ["Route warmup"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          warmupRouteName = "InTheNickOfTimeWarmupRoute",
          forceZapToVehicle = false,
          forceMissionAccept = false,
          matchTrafficSpeed = false,
          lookToVehicle = false
        },
        ["name"] = "Warmup route"
      }
    },
    FelonySettings = {
      FelonySettings = {
        [1] = {reenablePatrollingVehiclesAfterFelonyEnd = false, disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    MissionInfos = {
      ["In the nick of time mission description"] = {
        [1] = {
          ["1 Text"] = "ID:184842",
          ["Success reason"] = "ID:184845",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective",
              cardName = "Cop chaser 1",
              cardType = "Actor"
            },
            [2] = {
              value = "None",
              cardName = "Player",
              cardType = "Actor"
            },
            [3] = {
              value = "None",
              cardName = "Fire engine prop 1",
              cardType = "Actor"
            },
            [4] = {
              value = "Objective",
              cardName = "Cop chaser 2",
              cardType = "Actor"
            },
            [5] = {
              value = "Red Marker, Fake Felony Radius",
              cardName = "Bomb goon",
              cardType = "Actor"
            },
            [6] = {
              value = "Objective",
              cardName = "Disposal van",
              cardType = "Actor"
            },
            [7] = {
              value = "Blue Marker, Cop Radius",
              cardName = "Cop escort 2",
              cardType = "Actor"
            },
            [8] = {
              value = "None",
              cardName = "Cop prop 1",
              cardType = "Actor"
            },
            [9] = {
              value = "Blue Marker, Cop Radius",
              cardName = "Cop escort 1",
              cardType = "Actor"
            }
          },
          ["Failure reason"] = "ID:184844",
          ["3 Text"] = "ID:184843",
          ["Pass condition"] = "ID:184845",
          ["2 Text"] = "ID:236468"
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["In the nick of time"] = {
        [1] = {
          ["Total laps"] = 0,
          ["Disposal van team"] = {
            instance = 1,
            type = "Teams",
            name = "Disposal van Team"
          },
          ["Player team"] = {
            instance = 1,
            type = "Teams",
            name = "Player Team"
          },
          ["Cop chase team"] = {
            instance = 1,
            type = "Teams",
            name = "Cop chase Team"
          },
          ["Radius for bomb goon escape win"] = 300,
          ["Bomb goon team"] = {
            instance = 1,
            type = "Teams",
            name = "Bomb goon Team"
          },
          ["Cop team"] = {
            instance = 1,
            type = "Teams",
            name = "Cop escort Team"
          },
          ["Time limit"] = 120,
          ["Cop prop team"] = {
            instance = 1,
            type = "Teams",
            name = "Cop prop Team"
          },
          ["Damage amount for fail"] = 1
        },
        ["name"] = "In the nick of time"
      }
    }
  }
}
