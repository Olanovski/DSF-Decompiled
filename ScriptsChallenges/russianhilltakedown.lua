cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.RussianHillTakedown = {
  FileVersion = "2",
  name = "RussianHillTakedown",
  title = "ID:214714",
  MissionID = "36677",
  description = "ID:245465",
  cardInstances = {
    Actors = {
      Evader = {
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
            name = "Evader Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          matchTrafficSpeedMultiplier = 1,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Opponents Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          driveInOncoming = 0.4,
          driveOnPavements = 0.3,
          noOccupants = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Static"
          },
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          raceManagerRoute = false,
          shaderParam = 0,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Evader Set position"
          },
          vehicleId = 303,
          enableSiren = false,
          rubberbandingToPlayerStrength = "Medium",
          enableSimulationArea = false,
          spawnSpeed = 0,
          rubberbandingActor = "Chaser",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = -35,
          matchTrafficSpeed = false,
          stayInLockedArea = true,
          blockTow = false,
          routeName = "RussianHillTakedownRoute",
          avoidAttacks = false,
          avoidedByCivilianTraffic = true,
          desiredSpeed = 80
        },
        ["name"] = "Actor"
      },
      Player = {
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
            name = "Player Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On mission start",
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
            name = "As localPlayer"
          },
          vehicleId = -1,
          attackStationaryVehicle = false,
          stayInLockedArea = false,
          blockTow = false,
          enableSiren = false,
          avoidAttacks = false,
          enableSimulationArea = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      Chaser = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          routeName = "RussianHillTakedownRoute",
          team = {
            instance = 1,
            type = "Teams",
            name = "Chaser Team"
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
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Static"
          },
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          shaderParam = 7,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Player Position spawn"
          },
          vehicleId = 191,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 0,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          ignoreCivilianTraffic = false,
          noOccupants = false,
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          raceManagerRoute = true,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Opponents Character"] = {
        [1] = {
          ["Passenger id"] = "753978192",
          ["Driver id"] = "-1651365882"
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
    MissionSettings = {
      MissionSettings = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = true,
          ["Spawn type"] = "Always active",
          ["Enable traffic at mission end"] = true,
          ["disablePlayerIgnoring"] = false,
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = true,
          ["Start location"] = "RussianHillTakedownStart",
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["Chaser Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Player Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Evader Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    SpawnTypes = {
      ["As localPlayer"] = {
        [1] = {},
        ["name"] = "As localPlayer"
      },
      ["Evader Set position"] = {
        [1] = {
          ["Spawn location"] = "RussianHillTakedownGetawaySpawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Player Position spawn"] = {
        [1] = {
          ["1"] = "Chaser"
        },
        ["name"] = "Positions"
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
      ["Title and Info"] = {
        [1] = {
          ["1 Text"] = "ID:231353",
          ["Success reason"] = "ID:245207",
          ["missionMarkers"] = {
            [1] = {
              value = "Opponent",
              cardName = "Evader",
              cardType = "Actor"
            },
            [2] = {
              value = "Objective",
              cardName = "Chaser",
              cardType = "Actor"
            },
            [3] = {
              value = "None",
              cardName = "Player",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["Felony chase challenge"] = {
        [1] = {
          ["Chase team"] = {
            instance = 1,
            type = "Teams",
            name = "Chaser Team"
          },
          ["Player"] = {
            instance = 1,
            type = "Teams",
            name = "Player Team"
          },
          ["Evade team"] = {
            instance = 1,
            type = "Teams",
            name = "Evader Team"
          },
          ["Start prompt"] = "ID:231353",
          ["Initial route"] = "RussianHillTakedownRoute",
          ["Final looped route"] = "RussianHillTakedownRoute"
        },
        ["name"] = "Felony chase challenge"
      }
    }
  }
}
