cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Team colours tutorial"] = {
  FileVersion = "2",
  name = "Team colours tutorial",
  title = "ID:231120",
  MissionID = "920",
  description = "ID:245455",
  cardInstances = {
    Actors = {
      ["Opponent 2"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 130,
          team = {
            instance = 1,
            type = "Teams",
            name = "Opponent team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Opponent character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          enableSiren = false,
          driveInOncoming = 0.2,
          driveOnPavements = 0.5,
          noOccupants = false,
          shaderParam = 5,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Static"
          },
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          ignoreOtherAis = false,
          enableSimulationArea = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Positions"
          },
          vehicleId = 278,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Medium",
          spawnSpeed = 0,
          rubberbandingActor = "Player",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -40,
          ignoreCivilianTraffic = false,
          raceManagerRoute = false,
          routeName = "TeamColoursTutorialRoute",
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
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
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
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
            name = "Player character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          driveInOncoming = 0.2,
          driveOnPavements = 0.4,
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
            name = "Positions"
          },
          vehicleId = 278,
          enableSimulationArea = false,
          isMultiplayerActor = false,
          spawnSpeed = 0,
          damageMultiplier = 0.8,
          attackStationaryVehicle = false,
          desiredSpeed = 100,
          raceManagerRoute = true,
          routeName = "TeamColoursTutorialRoute",
          stayInLockedArea = true,
          blockTow = false,
          previewMovie = "preview vehicle",
          avoidAttacks = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Opponent 1"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 130,
          team = {
            instance = 1,
            type = "Teams",
            name = "Opponent team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Opponent character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          enableSiren = false,
          driveInOncoming = 0.2,
          driveOnPavements = 0.5,
          noOccupants = false,
          shaderParam = 2,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Static"
          },
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          ignoreOtherAis = false,
          enableSimulationArea = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Positions"
          },
          vehicleId = 278,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Medium",
          spawnSpeed = 0,
          rubberbandingActor = "Player",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -45,
          ignoreCivilianTraffic = false,
          raceManagerRoute = false,
          routeName = "TeamColoursTutorialRoute",
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Opponent 3"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 130,
          team = {
            instance = 1,
            type = "Teams",
            name = "Opponent team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Opponent character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          enableSiren = false,
          driveInOncoming = 0.2,
          driveOnPavements = 0.4,
          noOccupants = false,
          shaderParam = 4,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Static"
          },
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          ignoreOtherAis = false,
          enableSimulationArea = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Positions"
          },
          vehicleId = 278,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Medium",
          spawnSpeed = 0,
          rubberbandingActor = "Player",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -40,
          ignoreCivilianTraffic = false,
          raceManagerRoute = false,
          routeName = "TeamColoursTutorialRoute",
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Player character"] = {
        [1] = {
          ["Passenger id"] = "-1",
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      },
      ["Opponent character"] = {
        [1] = {
          ["Passenger id"] = "-1",
          ["Driver id"] = "1580977604"
        },
        ["name"] = "Character"
      }
    },
    SpawnTypes = {
      Positions = {
        [1] = {
          ["1"] = "Opponent 1",
          ["4"] = "Player",
          ["3"] = "Opponent 3",
          ["2"] = "Opponent 2"
        },
        ["name"] = "Positions"
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
    MissionSettings = {
      Settings = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Disable traffic"] = false,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "TeamColoursTutorialStart",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["disablePlayerIgnoring"] = false,
          ["Enable race status prompts"] = true
        },
        ["name"] = "MissionSettings"
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
    FelonySettings = {
      FelonySettings = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    MissionInfos = {
      ["Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:245602",
          ["showRouteArrows"] = "All",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective",
              cardName = "Player",
              cardType = "Actor"
            },
            [2] = {
              value = "Opponent",
              cardName = "Opponent 1",
              cardType = "Actor"
            },
            [3] = {
              value = "Opponent",
              cardName = "Opponent 3",
              cardType = "Actor"
            },
            [4] = {
              value = "Opponent",
              cardName = "Opponent 2",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["Generic challenge race type"] = {
        [1] = {
          ["Slow motion on goal complete"] = false,
          ["Total laps"] = 1,
          ["Destroy opposing teams"] = false,
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
          ["Start prompt"] = "ID:245602",
          ["scoringType"] = "Time",
          ["Hide checkpoints"] = false,
          ["Checkpoint type"] = "Checkpoint Gate"
        },
        ["name"] = "Generic challenge race"
      }
    }
  }
}
