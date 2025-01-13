cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.ChaseActivity3 = {
  FileVersion = "2",
  name = "ChaseActivity3",
  title = "ID:244236",
  MissionID = "18766",
  description = "ID:178462",
  cardInstances = {
    Actors = {
      Evader = {
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
            name = "Evade Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          accidentProbability = 0.1,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Opponent Character"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          driveInOncoming = 0.4,
          driveOnPavements = 0.2,
          noOccupants = false,
          enableSimulationArea = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static to rolling"
          },
          avoidUTurns = true,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          enableSiren = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Opponent spawn"
          },
          vehicleId = 293,
          rubberbandingToPlayerStrength = "Medium",
          isMultiplayerActor = false,
          spawnSpeed = 50,
          damageMultiplier = 0.7,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -25,
          desiredSpeed = 100,
          routeName = "ChaseActivityRoute3",
          raceManagerRoute = false,
          stayInLockedArea = true,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = true,
          avoidedByCivilianTraffic = true,
          avoidAlleys = 0.3,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      Player = {
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
            name = "As localPlayer"
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
            name = "Chase Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          vehicleTrailerId = -1,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Player Character"
          },
          forceHighLodCharacters = false,
          distanceBehindPlayer = 50,
          wanderType = "preferStraight",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          enableSimulationArea = false,
          shaderParam = 0,
          driveInOncoming = 0.3,
          driveOnPavements = 0.2,
          noOccupants = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static to rolling"
          },
          enableSiren = true,
          avoidUTurns = true,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Player spawn"
          },
          vehicleId = 269,
          rubberbandingToPlayerStrength = "Weak",
          spawnSpeed = 30,
          rubberbandingActor = "Evader",
          isMultiplayerActor = false,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          desiredSpeed = 80,
          matchTrafficSpeed = false,
          routeName = "ChaseActivityRoute3",
          raceManagerRoute = true,
          stayInLockedArea = true,
          blockTow = false,
          previewMovie = "preview vehicle",
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0.8,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Opponent Character"] = {
        [1] = {
          ["Driver id"] = "117973363"
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
      ["New MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Enable traffic at mission end"] = true,
          ["disablePlayerIgnoring"] = false,
          ["Spawn type"] = "Always active",
          ["Delete task object on reject preview"] = false,
          ["Start location"] = "ChaseActivity3 start",
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["Evade Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Chase Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Player Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    WarmupTypes = {
      ["New Static"] = {
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
    SpawnTypes = {
      ["As localPlayer"] = {
        [1] = {},
        ["name"] = "As localPlayer"
      },
      ["Player spawn"] = {
        [1] = {
          ["Spawn location"] = "ChaseActivity3 Player spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Opponent spawn"] = {
        [1] = {
          ["Spawn location"] = "ChaseActivity3 Opponent spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    MissionInfos = {
      ["New Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:178462",
          ["missionMarkers"] = {
            [1] = {
              value = "Red Marker, Fake Felony Radius",
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
      ["Felony chase activity "] = {
        [1] = {
          ["Chase team"] = {
            instance = 1,
            type = "Teams",
            name = "Chase Team"
          },
          ["Player"] = {
            instance = 1,
            type = "Teams",
            name = "Player Team"
          },
          ["Evade team"] = {
            instance = 1,
            type = "Teams",
            name = "Evade Team"
          },
          ["Start countdown"] = false
        },
        ["name"] = "Felony chase activity"
      }
    }
  }
}
