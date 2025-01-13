cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.TC2Activity = {
  FileVersion = "2",
  name = "TC2Activity",
  title = "ID:244246",
  MissionID = "15694",
  description = "ID:245572",
  cardInstances = {
    Actors = {
      ["Teammate"] = {
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
            name = "Player Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          matchTrafficSpeedMultiplier = 1,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Friendly Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          driveInOncoming = 0.2,
          driveOnPavements = 0.2,
          noOccupants = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static to rolling"
          },
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          shaderParam = 3,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Teammate spawn position"
          },
          vehicleId = 189,
          enableSiren = false,
          rubberbandingToPlayerStrength = "Weak",
          enableSimulationArea = false,
          spawnSpeed = 30,
          damageMultiplier = 0.6,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = 60,
          matchTrafficSpeed = false,
          routeName = "TC2Activity route",
          stayInLockedArea = true,
          blockTow = false,
          raceManagerRoute = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = true,
          desiredSpeed = 140,
          unaffectedByRaceSpeedTweaks = true
        },
        ["name"] = "Actor"
      },
      ["Player"] = {
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
            name = "Player Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Friendly Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          driveInOncoming = 0.2,
          driveOnPavements = 0.2,
          noOccupants = false,
          enableSimulationArea = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static to rolling"
          },
          shaderParam = 3,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          enableSiren = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Player spawn position"
          },
          vehicleId = 189,
          rubberbandingToPlayerStrength = "Medium",
          isMultiplayerActor = false,
          spawnSpeed = 10,
          damageMultiplier = 0.6,
          attackStationaryVehicle = false,
          distanceBehindPlayer = 60,
          desiredSpeed = 140,
          raceManagerRoute = true,
          routeName = "TC2Activity route",
          stayInLockedArea = true,
          blockTow = false,
          previewMovie = "preview vehicle",
          avoidAttacks = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = true,
          unaffectedByRaceSpeedTweaks = true
        },
        ["name"] = "Actor"
      },
      ["Opponent 1"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = true,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 160,
          team = {
            instance = 1,
            type = "Teams",
            name = "Opponent Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Opponent Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          driveInOncoming = 0.2,
          driveOnPavements = 0.2,
          noOccupants = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static to rolling"
          },
          vehicleTrailerId = -1,
          avoidUTurns = false,
          avoidedByCivilianTraffic = true,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          shaderParam = 0,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Opponent 1 spawn position"
          },
          vehicleId = 182,
          enableSiren = false,
          rubberbandingToPlayerStrength = "Medium",
          enableSimulationArea = false,
          spawnSpeed = 40,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = -30,
          ignoreCivilianTraffic = false,
          routeName = "TC2Activity route",
          stayInLockedArea = true,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          raceManagerRoute = false,
          aiIgnorePlayerInCivsUntilHit = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Opponent 2"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = true,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 150,
          team = {
            instance = 1,
            type = "Teams",
            name = "Opponent Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Opponent Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          driveInOncoming = 0.2,
          driveOnPavements = 0.2,
          noOccupants = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static to rolling"
          },
          vehicleTrailerId = -1,
          avoidUTurns = false,
          avoidedByCivilianTraffic = true,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          shaderParam = 0,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Opponent 2 spawn position"
          },
          vehicleId = 182,
          enableSiren = false,
          rubberbandingToPlayerStrength = "Medium",
          enableSimulationArea = false,
          spawnSpeed = 40,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = -25,
          ignoreCivilianTraffic = false,
          routeName = "TC2Activity route",
          stayInLockedArea = true,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          raceManagerRoute = false,
          aiIgnorePlayerInCivsUntilHit = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Friendly Character"] = {
        [1] = {
          ["Driver id"] = "-2068928907"
        },
        ["name"] = "Character"
      },
      ["Opponent Character"] = {
        [1] = {
          ["Driver id"] = "-526321096"
        },
        ["name"] = "Character"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    Teams = {
      ["Opponent Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Player Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    SpawnTypes = {
      ["Opponent 2 spawn position"] = {
        [1] = {
          ["Spawn location"] = "TC2Activity spawn 4",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Player spawn position"] = {
        [1] = {
          ["Spawn location"] = "TC2Activity spawn 1",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Opponent 1 spawn position"] = {
        [1] = {
          ["Spawn location"] = "TC2Activity spawn 3",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Teammate spawn position"] = {
        [1] = {
          ["Spawn location"] = "TC2Activity spawn 2",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    WarmupTypes = {
      ["Static warmup"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          forceZapToVehicle = false,
          forceMissionAccept = false,
          lookToVehicle = false
        },
        ["name"] = "Static"
      },
      ["New Static to rolling"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          forceZapToVehicle = false,
          forceMissionAccept = false,
          lookToVehicle = false
        },
        ["name"] = "Static to rolling"
      }
    },
    MissionSettings = {
      ["New MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Disable traffic"] = false,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "TC2Activity start",
          ["Clear area around vehicles"] = 100,
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["disablePlayerIgnoring"] = false,
          ["Enable race status prompts"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    MissionInfos = {
      ["New Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:182606",
          ["showRouteArrows"] = "All",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective",
              cardName = "Player",
              cardType = "Actor"
            },
            [2] = {
              value = "Opponent",
              cardName = "Opponent 2",
              cardType = "Actor"
            },
            [3] = {
              value = "Objective",
              cardName = "Teammate",
              cardType = "Actor"
            },
            [4] = {
              value = "Opponent",
              cardName = "Opponent 1",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Team colours activity"] = {
        [1] = {
          ["Total laps"] = 0,
          ["Willpower reward"] = 0,
          ["Destroy opposing teams"] = true,
          ["Eject if in lead"] = false,
          ["Race team 2"] = {
            instance = 1,
            type = "Teams",
            name = "Opponent Team"
          },
          ["Race team 1"] = {
            instance = 1,
            type = "Teams",
            name = "Player Team"
          },
          ["Start countdown"] = false,
          ["Damage amount for fail"] = 1,
          ["Hide checkpoints"] = false,
          ["Disable Shift"] = false,
          ["Checkpoint type"] = "Checkpoint Gate"
        },
        ["name"] = "Team colours activity"
      }
    }
  }
}
