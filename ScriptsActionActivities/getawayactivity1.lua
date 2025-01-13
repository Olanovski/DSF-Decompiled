cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.GetawayActivity1 = {
  FileVersion = "2",
  name = "GetawayActivity1",
  title = "ID:244230",
  MissionID = "19790",
  description = "ID:245575",
  cardInstances = {
    Actors = {
      Opponent = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          reactionTime = "Average",
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Chase Team"
          },
          drivingSkill = "Professional",
          accidentProbability = 0.1,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Opponent Character"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          driveInOncoming = 0.2,
          driveOnPavements = 0.2,
          noOccupants = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static to rolling"
          },
          vehicleTrailerId = -1,
          avoidUTurns = true,
          avoidedByCivilianTraffic = true,
          avoidAlleys = 0.3,
          raceManagerRoute = false,
          vehicleId = 271,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Opponent spawn"
          },
          ramInFrontDistance = 50,
          shaderParam = 0,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 40,
          rubberbandingActor = "Player",
          enableSiren = true,
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          enableSimulationArea = false,
          stayInLockedArea = true,
          distanceBehindPlayer = 5,
          isMultiplayerActor = false,
          avoidAttacks = false,
          matchTrafficSpeed = false,
          collisionResilience = "Very tough",
          desiredSpeed = 120
        },
        ["name"] = "Actor"
      },
      Player = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
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
          vehicleTrailerId = -1,
          driveInOncoming = 0.3,
          driveOnPavements = 0.2,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static to rolling"
          },
          shaderParam = 0,
          avoidUTurns = true,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Player spawn"
          },
          vehicleId = 62,
          enableSimulationArea = false,
          isMultiplayerActor = false,
          spawnSpeed = 30,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          desiredSpeed = 50,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
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
          ["Driver id"] = "-1907524522"
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
      ["New FelonySettings"] = {
        [1] = {disablePoliceInTrafficDuringMission = false},
        ["name"] = "FelonySettings"
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
      }
    },
    SpawnTypes = {
      ["Opponent spawn"] = {
        [1] = {
          ["Spawn location"] = "GetawayActivity1 Opponent spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Player spawn"] = {
        [1] = {
          ["Spawn location"] = "GetawayActivity1 Player spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
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
    MissionSettings = {
      ["New MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Enable traffic at mission end"] = true,
          ["disablePlayerIgnoring"] = false,
          ["Spawn type"] = "Always active",
          ["Delete task object on reject preview"] = false,
          ["Start location"] = "GetawayActivity1 start",
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    MissionInfos = {
      ["New Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:245575",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective",
              cardName = "Player",
              cardType = "Actor"
            },
            [2] = {
              value = "Opponent",
              cardName = "Opponent",
              cardType = "Actor"
            }
          },
          ["2 Text"] = "ID:236468"
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["Felony getaway activity"] = {
        [1] = {
          ["Lose cops"] = false,
          ["Evade team"] = {
            instance = 1,
            type = "Teams",
            name = "Evade Team"
          },
          ["Chase team"] = {
            instance = 1,
            type = "Teams",
            name = "Chase Team"
          },
          ["Enable constant felony"] = false,
          ["Time limit"] = 180,
          ["Start countdown"] = false,
          ["End hotspot position"] = "GetawayActivity1 end",
          ["Lose cops before destination"] = true,
          ["Checkpoint type"] = "Hotspot"
        },
        ["name"] = "Felony getaway activity"
      }
    }
  }
}
