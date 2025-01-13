cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.Uplaych2 = {
  FileVersion = "2",
  name = "Uplaych2",
  title = "ID:214684",
  MissionID = "26437",
  description = "ID:236745",
  cardInstances = {
    Actors = {
      ["Opponent 3"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Average",
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Opponent team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          matchTrafficSpeedMultiplier = 1,
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
          vehicleTrailerId = -1,
          driveInOncoming = 0.6,
          driveOnPavements = 0.3,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Static"
          },
          shaderParam = 1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Opponent 3 spawn position"
          },
          vehicleId = 129,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Medium",
          spawnSpeed = 0,
          rubberbandingActor = "Player",
          damageMultiplier = 0.7,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = -75,
          matchTrafficSpeed = false,
          routeName = "Uplaych2Route",
          stayInLockedArea = false,
          blockTow = false,
          raceManagerRoute = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = true,
          desiredSpeed = 110,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Player"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = true,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 90,
          team = {
            instance = 1,
            type = "Teams",
            name = "Player team"
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
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          previewMovie = "preview vehicle",
          enableSiren = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Static"
          },
          shaderParam = 0,
          avoidUTurns = false,
          avoidedByCivilianTraffic = true,
          collisionResilience = "Average",
          raceManagerRoute = true,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Player spawn position"
          },
          vehicleId = 129,
          enableSimulationArea = false,
          isMultiplayerActor = false,
          spawnSpeed = 0,
          damageMultiplier = 0.6,
          attackStationaryVehicle = false,
          ignoreCivilianTraffic = false,
          reactionTime = "Average",
          noOccupants = false,
          stayInLockedArea = false,
          blockTow = false,
          routeName = "Uplaych2Route",
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          ignoreOtherAis = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Opponent 2"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Average",
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Opponent team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          matchTrafficSpeedMultiplier = 1,
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
          vehicleTrailerId = -1,
          driveInOncoming = 0.6,
          driveOnPavements = 0.3,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Static"
          },
          shaderParam = 1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Opponent 2 spawn position"
          },
          vehicleId = 129,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Medium",
          spawnSpeed = 0,
          rubberbandingActor = "Player",
          damageMultiplier = 0.7,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = -85,
          matchTrafficSpeed = false,
          routeName = "Uplaych2Route",
          stayInLockedArea = false,
          blockTow = false,
          raceManagerRoute = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = true,
          desiredSpeed = 110,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Opponent 1"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Average",
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Opponent team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          matchTrafficSpeedMultiplier = 1,
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
          vehicleTrailerId = -1,
          driveInOncoming = 0.6,
          driveOnPavements = 0.3,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Static"
          },
          shaderParam = 0,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Opponent 1 spawn position"
          },
          vehicleId = 129,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Medium",
          spawnSpeed = 0,
          rubberbandingActor = "Player",
          damageMultiplier = 0.7,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = -80,
          matchTrafficSpeed = false,
          routeName = "Uplaych2Route",
          stayInLockedArea = false,
          blockTow = false,
          raceManagerRoute = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = true,
          desiredSpeed = 110,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Opponent Character"] = {
        [1] = {
          ["Driver id"] = "830448357"
        },
        ["name"] = "Character"
      },
      ["Player Character"] = {
        [1] = {
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      }
    },
    FelonySettings = {
      FelonySettings = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    Teams = {
      ["Opponent team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Player team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    SpawnTypes = {
      ["Opponent 2 spawn position"] = {
        [1] = {
          ["Spawn location"] = "Uplaych2 spawn 3",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Player spawn position"] = {
        [1] = {
          ["Spawn location"] = "Uplaych2 spawn 1",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Opponent 3 spawn position"] = {
        [1] = {
          ["Spawn location"] = "Uplaych2 spawn 4",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Opponent 1 spawn position"] = {
        [1] = {
          ["Spawn location"] = "Uplaych2 spawn 2",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    WarmupTypes = {
      Static = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          forceZapToVehicle = false,
          forceMissionAccept = false,
          lookToVehicle = false
        },
        ["name"] = "Static"
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
          ["Start location"] = "Uplaych2Start",
          ["Clear area around vehicles"] = 40,
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = true,
          ["disablePlayerIgnoring"] = false,
          ["Enable race status prompts"] = true
        },
        ["name"] = "MissionSettings"
      }
    },
    MissionInfos = {
      Title = {
        [1] = {
          ["1 Text"] = "ID:245603",
          ["showRouteArrows"] = "All",
          ["missionMarkers"] = {
            [1] = {
              value = "Opponent",
              cardName = "Opponent 1",
              cardType = "Actor"
            },
            [2] = {
              value = "Opponent",
              cardName = "Opponent 3",
              cardType = "Actor"
            },
            [3] = {
              value = "Opponent",
              cardName = "Opponent 2",
              cardType = "Actor"
            },
            [4] = {
              value = "Objective",
              cardName = "Player",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["Uplaych2 settings"] = {
        [1] = {
          ["Slow motion on goal complete"] = true,
          ["Total laps"] = 0,
          ["Destroy opposing teams"] = true,
          ["Endless race"] = false,
          ["Overtake target (+ score)"] = false,
          ["Race team 2"] = {
            instance = 1,
            type = "Teams",
            name = "Opponent team"
          },
          ["Score drift distance"] = false,
          ["Race team 1"] = {
            instance = 1,
            type = "Teams",
            name = "Player team"
          },
          ["Score jump distance"] = false,
          ["Damage amount for fail"] = 1,
          ["Start prompt"] = "ID:245603",
          ["scoringType"] = "Time",
          ["Hide checkpoints"] = false,
          ["Checkpoint type"] = "Checkpoint Gate"
        },
        ["name"] = "Generic challenge race"
      }
    }
  }
}
