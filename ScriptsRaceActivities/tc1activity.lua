cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.TC1Activity = {
  FileVersion = "2",
  name = "TC1Activity",
  title = "ID:244245",
  MissionID = "15182",
  description = "ID:245572",
  cardInstances = {
    Actors = {
      ["Teammate"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = true,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 110,
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
          avoidedByCivilianTraffic = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          shaderParam = 3,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Positions spawn"
          },
          vehicleId = 151,
          enableSiren = false,
          rubberbandingToPlayerStrength = "Weak",
          enableSimulationArea = false,
          spawnSpeed = 30,
          damageMultiplier = 0.4,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = 80,
          ignoreCivilianTraffic = false,
          routeName = "TC1Activity route",
          stayInLockedArea = true,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          raceManagerRoute = false,
          aiIgnorePlayerInCivsUntilHit = false,
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
            name = "Positions spawn"
          },
          vehicleId = 151,
          rubberbandingToPlayerStrength = "Medium",
          isMultiplayerActor = false,
          spawnSpeed = 10,
          damageMultiplier = 0.4,
          attackStationaryVehicle = false,
          distanceBehindPlayer = 20,
          desiredSpeed = 120,
          raceManagerRoute = true,
          routeName = "TC1Activity route",
          stayInLockedArea = true,
          blockTow = false,
          previewMovie = "preview vehicle",
          avoidAttacks = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
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
          desiredSpeed = 140,
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
          avoidedByCivilianTraffic = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          shaderParam = 6,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Positions spawn"
          },
          vehicleId = 190,
          enableSiren = false,
          rubberbandingToPlayerStrength = "Strong",
          enableSimulationArea = false,
          spawnSpeed = 40,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = -35,
          ignoreCivilianTraffic = false,
          routeName = "TC1Activity route",
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
          desiredSpeed = 135,
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
          avoidedByCivilianTraffic = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          shaderParam = 7,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Positions spawn"
          },
          vehicleId = 190,
          enableSiren = false,
          rubberbandingToPlayerStrength = "Strong",
          enableSimulationArea = false,
          spawnSpeed = 40,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = -30,
          ignoreCivilianTraffic = false,
          routeName = "TC1Activity route",
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
    MissionSettings = {
      ["New MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Enable traffic at mission end"] = true,
          ["disablePlayerIgnoring"] = false,
          ["Spawn type"] = "Always active",
          ["Delete task object on reject preview"] = false,
          ["Start location"] = "TC1Activity start",
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
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
      ["Positions spawn"] = {
        [1] = {
          ["1"] = "Opponent 1",
          ["4"] = "Player",
          ["3"] = "Teammate",
          ["2"] = "Opponent 2"
        },
        ["name"] = "Positions"
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
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
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
          ["Willpower reduction rate"] = 0,
          ["Willpower reward"] = 0,
          ["Destroy opposing teams"] = true,
          ["Eject if in lead"] = false,
          ["Willpower reduction time"] = 0,
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
