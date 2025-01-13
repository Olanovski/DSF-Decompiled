cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.TestActivity = {
  FileVersion = "2",
  name = "TestActivity",
  title = "TestActivity",
  MissionID = "14670",
  description = "<Description>",
  cardInstances = {
    Actors = {
      Opponent = {
        [1] = {
          noOccupants = false,
          maintainLane = false,
          wrongWayIndicator = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static"
          },
          vehicleId = 182,
          reactionTime = "Average",
          shaderParam = 2,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = true,
          ignoreCivilianTraffic = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "New Team 2"
          },
          isMultiplayerActor = false,
          enableSimulationArea = false,
          avoidUTurns = false,
          aiIgnorePlayers = false,
          routeName = "TestActivityRoute",
          drivingSkill = "Professional",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          forceHighLodCharacters = false,
          matchTrafficSpeed = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          stayInLockedArea = false,
          whenSpawned = "On warmup",
          enableSiren = false,
          avoidAttacks = false,
          desiredSpeed = 80,
          characters = {
            instance = 1,
            type = "Characters",
            name = "New Character"
          },
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      Player = {
        [1] = {
          wrongWayIndicator = false,
          matchTrafficSpeed = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "New Team"
          },
          drivingSkill = "Professional",
          characters = {
            instance = 1,
            type = "Characters",
            name = "New Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          noOccupants = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = true,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 182,
          shaderParam = 0,
          attackStationaryVehicle = false,
          previewMovie = "preview vehicle",
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static"
          },
          reactionTime = "Average",
          stayInLockedArea = false,
          enableSiren = false,
          desiredSpeed = 80,
          avoidAttacks = false,
          enableSimulationArea = false,
          routeName = "TestActivityRoute",
          damageMultiplier = 1
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["New Character"] = {
        [1] = {
          ["Driver id"] = "317540154"
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
          ["Start location"] = "Test activity start",
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["New Team 2"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["New Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {disablePoliceInTrafficDuringMission = false},
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
      }
    },
    SpawnTypes = {
      ["New Positions"] = {
        [1] = {
          ["1"] = "Opponent",
          ["2"] = "Player"
        },
        ["name"] = "Positions"
      }
    },
    MissionInfos = {
      ["New Title and description"] = {
        [1] = {
          showRouteArrows = "All",
          missionMarkers = {
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
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Generic race activity"] = {
        [1] = {
          ["Destroy opposing teams"] = false,
          ["Endless race"] = false,
          ["Race team 2"] = {
            instance = 1,
            type = "Teams",
            name = "New Team 2"
          },
          ["Race team 1"] = {
            instance = 1,
            type = "Teams",
            name = "New Team"
          },
          ["Hide checkpoints"] = false,
          ["Damage amount for fail"] = 1,
          ["Start prompt"] = "ID:184680",
          ["Disable Shift"] = true,
          ["Checkpoint type"] = "Checkpoint Gate"
        },
        ["name"] = "Generic race activity"
      }
    }
  }
}
