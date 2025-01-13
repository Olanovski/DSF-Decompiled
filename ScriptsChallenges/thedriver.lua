cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.TheDriver = {
  FileVersion = "2",
  name = "TheDriver",
  title = "ID:231198",
  MissionID = "39749",
  description = "ID:245469",
  cardInstances = {
    Actors = {
      Evader = {
        [1] = {
          lockedToPlayer = false,
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
            name = "Getaway Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Getaway Character"
          },
          forceHighLodCharacters = true,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On mission start",
          driveInOncoming = 0.4,
          driveOnPavements = 0.3,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Very tough",
          raceManagerRoute = false,
          shaderParam = 1,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Getaway Spawn"
          },
          vehicleId = 237,
          rubberbandingToPlayerStrength = "Medium",
          enableSiren = false,
          spawnSpeed = 0,
          enableSimulationArea = false,
          damageMultiplier = 0.8,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -40,
          ignoreCivilianTraffic = false,
          stayInLockedArea = true,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          avoidedByCivilianTraffic = true,
          ignoreOtherAis = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      localPlayer = {
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
      Chaser = {
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
            name = "Chaser Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          matchTrafficSpeedMultiplier = 1,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Chaser Character"
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
            name = "TheDriver Static"
          },
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Player Spawn"
          },
          vehicleId = 156,
          shaderParam = 0,
          enableSiren = false,
          spawnSpeed = 0,
          enableSimulationArea = false,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          ignoreOtherAis = false,
          stayInLockedArea = false,
          blockTow = false,
          previewMovie = " ",
          avoidAttacks = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Getaway Character"] = {
        [1] = {
          ["Passenger id"] = "1724981652",
          ["Driver id"] = "-234707716"
        },
        ["name"] = "Character"
      },
      ["Chaser Character"] = {
        [1] = {
          ["Passenger id"] = "-239779572",
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      ["TheDriver MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = true,
          ["Spawn type"] = "Always active",
          ["Enable traffic at mission end"] = true,
          ["disablePlayerIgnoring"] = false,
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = true,
          ["Start location"] = "TheDriverStart",
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["Getaway Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Chaser Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Player Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    SpawnTypes = {
      ["Getaway Spawn"] = {
        [1] = {
          ["Spawn location"] = "TheDriverGetawaySpawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Player Spawn"] = {
        [1] = {
          ["Spawn location"] = "TheDriverPlayerSpawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["New As localPlayer"] = {
        [1] = {},
        ["name"] = "As localPlayer"
      }
    },
    WarmupTypes = {
      ["TheDriver Static"] = {
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
      ["New FelonySettings 5"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    MissionInfos = {
      ["TheDriver Title"] = {
        [1] = {
          ["1 Text"] = "ID:231353",
          ["Success reason"] = "ID:245207",
          ["missionMarkers"] = {
            [1] = {
              value = "None",
              cardName = "localPlayer",
              cardType = "Actor"
            },
            [2] = {
              value = "Objective",
              cardName = "Chaser",
              cardType = "Actor"
            },
            [3] = {
              value = "Opponent",
              cardName = "Evader",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Felony chase challenge"] = {
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
            name = "Getaway Team"
          },
          ["Start prompt"] = "ID:231353",
          ["Initial route"] = "TheDriverRoute",
          ["Final looped route"] = "TheDriverLoop"
        },
        ["name"] = "Felony chase challenge"
      }
    }
  }
}
