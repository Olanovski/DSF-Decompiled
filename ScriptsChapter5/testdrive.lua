cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.TestDrive = {
  FileVersion = "2",
  name = "TestDrive",
  title = "ID:184715",
  MissionID = "12496",
  description = "ID:184716",
  cardInstances = {
    Actors = {
      Tanner = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          matchTrafficSpeed = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Tanner team"
          },
          drivingSkill = "Average",
          characters = {
            instance = 1,
            type = "Characters",
            name = "Tanner Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          noOccupants = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Warmup route"
          },
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0.5,
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 62,
          shaderParam = 0,
          attackStationaryVehicle = false,
          previewMovie = "preview",
          isMultiplayerActor = false,
          stayInLockedArea = false,
          reactionTime = "Average",
          enableSiren = false,
          avoidAttacks = false,
          enableSimulationArea = false,
          collisionResilience = "Average",
          damageMultiplier = 0.5
        },
        ["name"] = "Actor"
      },
      Ordell = {
        [1] = {
          noOccupants = false,
          lockedToPlayer = false,
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          reactionTime = "Average",
          maintainLane = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = true,
          routeName = "Test drive opponent 1",
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Set position"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "Ordell team"
          },
          vehicleId = 163,
          enableSimulationArea = false,
          avoidUTurns = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          shaderParam = 0,
          damageMultiplier = 0.5,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Ordell Character"
          },
          forceHighLodCharacters = false,
          drivingSkill = "Average",
          wanderType = "random",
          selfRightIfOverturned = true,
          stayInLockedArea = false,
          whenSpawned = "Never",
          enableSiren = false,
          avoidAttacks = false,
          matchTrafficSpeed = false,
          attackStationaryVehicle = false,
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Tanner Character"] = {
        [1] = {
          ["Passenger id"] = "-1916574018",
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      },
      ["Ordell Character"] = {
        [1] = {
          ["Passenger id"] = "1535564652",
          ["Driver id"] = "454042078"
        },
        ["name"] = "Character"
      }
    },
    SpawnTypes = {
      ["New Positions"] = {
        [1] = {
          ["1"] = "Tanner"
        },
        ["name"] = "Positions"
      },
      ["New Set position"] = {
        [1] = {
          ["Spawn location"] = "Test drive",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    Teams = {
      ["Ordell team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Tanner team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionCompletes = {
      Complete = {
        [1] = {
          ["Failure reason (wrecked)"] = "ID:182731",
          ["Success reason"] = "ID:184720",
          ["Pass condition"] = "ID:184716",
          ["Failure reason"] = "ID:184719"
        },
        ["name"] = "Test drive"
      }
    },
    WarmupTypes = {
      ["New Warmup route"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          warmupRouteName = "Test drive warmup 1",
          forceZapToVehicle = false,
          forceMissionAccept = false,
          matchTrafficSpeed = true,
          lookToVehicle = false
        },
        ["name"] = "Warmup route"
      }
    },
    MissionSettings = {
      ["New MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Load traffic on start"] = "Chapter 5 - Test Drive",
          ["disablePlayerIgnoring"] = false,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Test drive player 1",
          ["Audio logic file"] = "Test Drive APIP",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    MissionInfos = {
      ["New Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:245547",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective",
              cardName = "Ordell",
              cardType = "Actor"
            },
            [2] = {
              value = "Objective",
              cardName = "Tanner",
              cardType = "Actor"
            }
          },
          ["2 Text"] = "ID:184718"
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Test drive"] = {
        [1] = {
          ["Tanner team"] = {
            instance = 1,
            type = "Teams",
            name = "Tanner team"
          },
          ["Ordell team"] = {
            instance = 1,
            type = "Teams",
            name = "Ordell team"
          },
          ["Time limit"] = 85
        },
        ["name"] = "Test drive"
      }
    }
  }
}
