cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.GetawayActivity4 = {
  FileVersion = "2",
  name = "GetawayActivity4",
  title = "ID:244233",
  MissionID = "21326",
  description = "ID:245575",
  cardInstances = {
    Actors = {
      ["Player"] = {
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
          damageMultiplier = 0.3,
          attackStationaryVehicle = false,
          desiredSpeed = 55,
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
      },
      ["Opponent 2"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
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
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static to rolling"
          },
          vehicleId = 265,
          avoidUTurns = true,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAlleys = 0,
          ignoreOtherAis = false,
          shaderParam = 0,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions 2"
          },
          ramInFrontDistance = 50,
          enableSiren = true,
          enableSimulationArea = false,
          spawnSpeed = 40,
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = 0,
          desiredSpeed = 170,
          raceManagerRoute = false,
          stayInLockedArea = true,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          collisionResilience = "Very tough",
          avoidedByCivilianTraffic = true,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Opponent"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
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
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static to rolling"
          },
          vehicleId = 265,
          avoidUTurns = true,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAlleys = 0,
          ignoreOtherAis = false,
          shaderParam = 0,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions 2"
          },
          ramInFrontDistance = 50,
          enableSiren = true,
          enableSimulationArea = false,
          spawnSpeed = 90,
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = 0,
          desiredSpeed = 120,
          raceManagerRoute = false,
          stayInLockedArea = true,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          collisionResilience = "Very tough",
          avoidedByCivilianTraffic = true,
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
    MissionSettings = {
      ["New MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Enable traffic at mission end"] = true,
          ["disablePlayerIgnoring"] = false,
          ["Spawn type"] = "Always active",
          ["Delete task object on reject preview"] = false,
          ["Start location"] = "GetawayActivity4 start",
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
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
      ["New Positions 2"] = {
        [1] = {
          ["1"] = "Opponent",
          ["alternateLocation"] = "GetawayActivity4 Opponent spawn",
          ["2"] = "Opponent 2"
        },
        ["name"] = "Positions"
      },
      ["Player spawn"] = {
        [1] = {
          ["Spawn location"] = "GetawayActivity4 Player spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
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
              cardName = "Opponent 2",
              cardType = "Actor"
            },
            [3] = {
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
          ["Time limit"] = 300,
          ["Start countdown"] = false,
          ["End hotspot position"] = "GetawayActivity4 end",
          ["Lose cops before destination"] = true,
          ["Checkpoint type"] = "Hotspot"
        },
        ["name"] = "Felony getaway activity"
      }
    }
  }
}
