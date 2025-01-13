cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.Uplaych3 = {
  FileVersion = "2",
  name = "Uplaych3",
  title = "ID:214686",
  MissionID = "26949",
  description = "ID:236746",
  cardInstances = {
    Actors = {
      ["Evader"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 60,
          team = {
            instance = 1,
            type = "Teams",
            name = "Evade Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Evader Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
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
          shaderParam = 5,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = true,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Positions spawn"
          },
          vehicleId = 144,
          enableSimulationArea = false,
          isMultiplayerActor = false,
          spawnSpeed = 0,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          ignoreCivilianTraffic = false,
          reactionTime = "Average",
          noOccupants = false,
          stayInLockedArea = true,
          blockTow = false,
          routeName = "Uplaych3Route",
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          ignoreOtherAis = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Chaser 3"] = {
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
            name = "Chase team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Chaser Character"
          },
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
            name = "Behind Positions"
          },
          vehicleId = 271,
          spawnSpeed = 40,
          attackStationaryVehicle = false,
          enableSiren = true,
          enableSimulationArea = false,
          stayInLockedArea = false,
          blockTow = false,
          avoidAttacks = false,
          desiredSpeed = 60,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["Chaser 1"] = {
        [1] = {
          noOccupants = false,
          lockedToPlayer = true,
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          reactionTime = "Average",
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Behind Positions"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "Chase team"
          },
          maintainLane = false,
          enableSimulationArea = false,
          vehicleId = 271,
          spawnSpeed = 40,
          matchTrafficSpeed = false,
          aiIgnorePlayers = false,
          desiredSpeed = 60,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Chaser Character"
          },
          forceHighLodCharacters = false,
          drivingSkill = "Average",
          wanderType = "random",
          selfRightIfOverturned = false,
          stayInLockedArea = false,
          whenSpawned = "On mission start",
          avoidUTurns = false,
          avoidAttacks = false,
          enableSiren = true,
          attackStationaryVehicle = false,
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      ["Chaser 4"] = {
        [1] = {
          noOccupants = false,
          lockedToPlayer = true,
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          reactionTime = "Average",
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Behind Positions"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "Chase team"
          },
          maintainLane = false,
          enableSimulationArea = false,
          vehicleId = 271,
          spawnSpeed = 40,
          matchTrafficSpeed = false,
          aiIgnorePlayers = false,
          desiredSpeed = 60,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Chaser Character"
          },
          forceHighLodCharacters = false,
          drivingSkill = "Average",
          wanderType = "random",
          selfRightIfOverturned = false,
          stayInLockedArea = false,
          whenSpawned = "On mission start",
          avoidUTurns = false,
          avoidAttacks = false,
          enableSiren = true,
          attackStationaryVehicle = false,
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      ["Chaser 2"] = {
        [1] = {
          noOccupants = false,
          lockedToPlayer = true,
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          reactionTime = "Average",
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Behind Positions"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "Chase team"
          },
          maintainLane = false,
          enableSimulationArea = false,
          vehicleId = 271,
          spawnSpeed = 40,
          matchTrafficSpeed = false,
          aiIgnorePlayers = false,
          desiredSpeed = 60,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Chaser Character"
          },
          forceHighLodCharacters = false,
          drivingSkill = "Average",
          wanderType = "random",
          selfRightIfOverturned = false,
          stayInLockedArea = false,
          whenSpawned = "On mission start",
          avoidUTurns = false,
          avoidAttacks = false,
          enableSiren = true,
          attackStationaryVehicle = false,
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Evader Character"] = {
        [1] = {
          ["Behind passenger id"] = "267737180",
          ["Driver id"] = "-673381849",
          ["Behind driver id"] = "-1"
        },
        ["name"] = "Character"
      },
      ["Chaser Character"] = {
        [1] = {
          ["Driver id"] = "105509604"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      MissionSettings = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Enable traffic at mission end"] = true,
          ["disablePlayerIgnoring"] = false,
          ["Spawn type"] = "Always active",
          ["Delete task object on reject preview"] = true,
          ["Start location"] = "Uplaych3Start",
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["Chase team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Evade Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    SpawnTypes = {
      ["Positions spawn"] = {
        [1] = {
          ["1"] = "Evader"
        },
        ["name"] = "Positions"
      },
      ["Behind Positions"] = {
        [1] = {
          ["alternateLocation"] = "Uplaych3 Cop 1 Start",
          ["3"] = "Chaser 3",
          ["2"] = "Chaser 2",
          ["4"] = "Chaser 4",
          ["1"] = "Chaser 1"
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
        [1] = {reenablePatrollingVehiclesAfterFelonyEnd = false, disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    MissionInfos = {
      ["Title and Info"] = {
        [1] = {
          ["1 Text"] = "ID:186175",
          ["showRouteArrows"] = "All",
          ["missionMarkers"] = {
            [1] = {
              value = "None",
              cardName = "Chaser 3",
              cardType = "Actor"
            },
            [2] = {
              value = "None",
              cardName = "Chaser 4",
              cardType = "Actor"
            },
            [3] = {
              value = "None",
              cardName = "Chaser 1",
              cardType = "Actor"
            },
            [4] = {
              value = "None",
              cardName = "Chaser 2",
              cardType = "Actor"
            },
            [5] = {
              value = "Objective",
              cardName = "Evader",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["Generic chase challenge"] = {
        [1] = {
          ["Chase team"] = {
            instance = 1,
            type = "Teams",
            name = "Chase team"
          },
          ["Evade team"] = {
            instance = 1,
            type = "Teams",
            name = "Evade Team"
          },
          ["Start prompt"] = "ID:245917",
          ["Felony"] = true,
          ["Checkpoint type"] = "Hotspot"
        },
        ["name"] = "Generic chase challenge"
      }
    }
  }
}
