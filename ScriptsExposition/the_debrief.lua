cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["The debrief"] = {
  FileVersion = "2",
  name = "The debrief",
  title = "ID:231106",
  MissionID = "2375",
  description = "ID:245522",
  cardInstances = {
    Actors = {
      ["Static cop 04"] = {
        [1] = {
          isMultiplayerActor = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Static cop 04 set position"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "Static cop"
          },
          drivingSkill = "Average",
          avoidUTurns = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop car characters"
          },
          vehicleId = 269,
          enableSiren = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          enableSimulationArea = true,
          whenSpawned = "On mission start",
          aiIgnorePlayers = false,
          reactionTime = "Average",
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      ["Static cop 01"] = {
        [1] = {
          isMultiplayerActor = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Static cop set position"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "Static cop"
          },
          drivingSkill = "Average",
          avoidUTurns = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop car characters"
          },
          vehicleId = 271,
          enableSiren = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          enableSimulationArea = true,
          whenSpawned = "On mission start",
          aiIgnorePlayers = false,
          reactionTime = "Average",
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      ["Static cop 03"] = {
        [1] = {
          isMultiplayerActor = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Static cop 03 set position"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "Static cop"
          },
          drivingSkill = "Average",
          avoidUTurns = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop car characters"
          },
          vehicleId = 280,
          enableSiren = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          enableSimulationArea = true,
          whenSpawned = "On mission start",
          aiIgnorePlayers = false,
          reactionTime = "Average",
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      ["Static cop 02"] = {
        [1] = {
          isMultiplayerActor = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Static cop 02 set position"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "Static cop"
          },
          drivingSkill = "Average",
          avoidUTurns = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop car characters"
          },
          vehicleId = 271,
          enableSiren = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          enableSimulationArea = true,
          whenSpawned = "On mission start",
          aiIgnorePlayers = false,
          reactionTime = "Average",
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      ["Tanner"] = {
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
            name = "Tanner team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Characters Tanner and Jones"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          driveInOncoming = 1,
          driveOnPavements = 1,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Tanner Static warmup"
          },
          shaderParam = 0,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Set position"
          },
          vehicleId = 62,
          enableSimulationArea = false,
          isMultiplayerActor = false,
          damageMultiplier = 0.2,
          attackStationaryVehicle = false,
          desiredSpeed = 45,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = true,
          previewMovie = "blah blah",
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Cop car characters"] = {
        [1] = {},
        ["name"] = "Character"
      },
      ["Characters Tanner and Jones"] = {
        [1] = {
          ["Passenger id"] = "-1916574018",
          ["Behind passenger id"] = "-1",
          ["Driver id"] = "-673381849",
          ["Behind driver id"] = "-1"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      ["New MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Spawn type"] = "Always active",
          ["Hud logic file"] = "The debrief hud",
          ["Cutscene at mission end"] = "ch0_gp_Billboard_The_Debrief",
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "The debrief start",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["disablePlayerIgnoring"] = false,
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    SpawnTypes = {
      ["New Set position"] = {
        [1] = {
          ["Mission start teleport location"] = "The debrief tanner mission start spawn",
          ["Spawn location"] = "The debrief tanner spawn",
          ["missionStartSpawnType"] = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Static cop set position"] = {
        [1] = {
          ["Spawn location"] = "Static cop 01",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Static cop 02 set position"] = {
        [1] = {
          ["Spawn location"] = "Static cop 02",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["New Positions"] = {
        [1] = {
          ["1"] = "Tanner"
        },
        ["name"] = "Positions"
      },
      ["Static cop 04 set position"] = {
        [1] = {
          ["Spawn location"] = "Static cop 04",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Static cop 03 set position"] = {
        [1] = {
          ["Spawn location"] = "Static cop 03",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    Teams = {
      ["Static cop"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Tanner team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionCompletes = {
      ["New Mission Complete The debrief"] = {
        [1] = {
          ["Failure reason (wrecked)"] = "ID:178465",
          ["Success reason"] = "ID:231103",
          ["Pass condition"] = "ID:231103",
          ["Failure reason"] = "ID:178465"
        },
        ["name"] = "The debrief"
      }
    },
    WarmupTypes = {
      ["Tanner Static warmup"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          forceZapToVehicle = false,
          forceMissionAccept = false,
          lookToVehicle = false
        },
        ["name"] = "Static"
      },
      ["New warmup loop"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          warmupRouteName = "DebriefLoop",
          forceZapToVehicle = false,
          forceMissionAccept = false,
          matchTrafficSpeed = false,
          lookToVehicle = false
        },
        ["name"] = "Warmup route"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    MissionInfos = {
      ["New Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:245514",
          ["missionMarkers"] = {
            [1] = {
              value = "None",
              cardName = "Static cop 03",
              cardType = "Actor"
            },
            [2] = {
              value = "None",
              cardName = "Static cop 02",
              cardType = "Actor"
            },
            [3] = {
              value = "Objective",
              cardName = "Tanner",
              cardType = "Actor"
            },
            [4] = {
              value = "None",
              cardName = "Static cop 04",
              cardType = "Actor"
            },
            [5] = {
              value = "None",
              cardName = "Static cop 01",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New The debrief"] = {
        [1] = {
          ["Static police team"] = {
            instance = 1,
            type = "Teams",
            name = "Static cop"
          },
          ["Tanner team"] = {
            instance = 1,
            type = "Teams",
            name = "Tanner team"
          }
        },
        ["name"] = "The debrief"
      }
    }
  }
}
