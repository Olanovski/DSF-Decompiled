cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.TheSneakout = {
  FileVersion = "2",
  name = "TheSneakout",
  title = "ID:184534",
  MissionID = "406",
  description = "ID:184535",
  cardInstances = {
    Actors = {
      ["Suspicious vehicle 2"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          reactionTime = "Average",
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Suspicious vehicle team"
          },
          drivingSkill = "Average",
          characters = {
            instance = 1,
            type = "Characters",
            name = "Suspicious vehicle character 2"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On mission start",
          driveInOncoming = 0.5,
          driveOnPavements = 0.5,
          noOccupants = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Suspicious vehicle 2 set position"
          },
          vehicleId = 154,
          spawnSpeed = 0,
          shaderParam = 0,
          attackStationaryVehicle = false,
          vehicleTrailerId = -1,
          stayInLockedArea = false,
          desiredSpeed = 35,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          enableSiren = false,
          avoidAlleys = 0,
          enableSimulationArea = false
        },
        ["name"] = "Actor"
      },
      ["Player"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 50,
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
            name = "New Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          previewMovie = "no preview",
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Player warmup"
          },
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Player start position"
          },
          vehicleId = 221,
          shaderParam = 0,
          enableSiren = false,
          enableSimulationArea = false,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          noOccupants = false,
          reactionTime = "Average",
          stayInLockedArea = false,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          ignoreCivilianTraffic = false,
          routeName = "Paranoia route",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Suspicious vehicle 1"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          reactionTime = "Average",
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Suspicious vehicle team"
          },
          drivingSkill = "Average",
          characters = {
            instance = 1,
            type = "Characters",
            name = "Suspicious vehicle character 1"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On mission start",
          driveInOncoming = 0.5,
          driveOnPavements = 0.5,
          noOccupants = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Suspicious vehicle 1 set position"
          },
          vehicleId = 154,
          spawnSpeed = 0,
          shaderParam = 0,
          attackStationaryVehicle = false,
          vehicleTrailerId = -1,
          stayInLockedArea = false,
          desiredSpeed = 35,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          enableSiren = false,
          avoidAlleys = 0,
          enableSimulationArea = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Suspicious vehicle character 1"] = {
        [1] = {
          ["Passenger id"] = "-1",
          ["Driver id"] = "-1269137079"
        },
        ["name"] = "Character"
      },
      ["New Character"] = {
        [1] = {
          ["Passenger id"] = "49939481",
          ["Driver id"] = "1882964014"
        },
        ["name"] = "Character"
      },
      ["Suspicious vehicle character 2"] = {
        [1] = {
          ["Passenger id"] = "-1",
          ["Driver id"] = "-114664299"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      ["Sneakout settings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Load traffic on start"] = "Chapter 3 Shakedown",
          ["Disable traffic"] = false,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "The Sneakout start",
          ["Audio logic file"] = "Paranoia APIP",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["disablePlayerIgnoring"] = false,
          ["Enable race status prompts"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    FelonySettings = {
      ["The Sneakout FelonySettings"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    Teams = {
      ["Suspicious vehicle team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Player team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionCompletes = {
      ["Sneakout complete"] = {
        [1] = {
          ["Perfect condition"] = "ID:184539",
          ["Success reason"] = "ID:184540",
          ["Failure reason"] = "ID:184536",
          ["Success reason (perfect)"] = "ID:184541",
          ["Pass condition"] = "ID:184538",
          ["Failure reason (wrecked)"] = "ID:184537"
        },
        ["name"] = "The Sneakout"
      }
    },
    WarmupTypes = {
      ["Player warmup"] = {
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
      ["Player start position"] = {
        [1] = {
          ["Spawn location"] = "Sneakout player start position",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Suspicious SUV positions 1"] = {
        [1] = {
          ["alternateLocation"] = "Suspicious vehicle start position 1",
          ["1"] = "Suspicious vehicle 1"
        },
        ["name"] = "Positions"
      },
      ["Suspicious vehicle 1 set position"] = {
        [1] = {
          ["Spawn location"] = "Suspicious vehicle start position 1",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Suspicious vehicle 2 set position"] = {
        [1] = {
          ["Spawn location"] = "Suspicious vehicle start position 2",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Suspicious SUV positions 2"] = {
        [1] = {
          ["alternateLocation"] = "Suspicious vehicle start position 2",
          ["1"] = "Suspicious vehicle 2"
        },
        ["name"] = "Positions"
      }
    },
    MissionInfos = {
      ["Sneakout info"] = {
        [1] = {
          ["1 Text"] = "ID:236248",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective",
              cardName = "Player",
              cardType = "Actor"
            }
          },
          ["2 Text"] = "ID:236249"
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["Sneakout type"] = {
        [1] = {
          ["Suspicious vehicle team"] = {
            instance = 1,
            type = "Teams",
            name = "Suspicious vehicle team"
          },
          ["Player team"] = {
            instance = 1,
            type = "Teams",
            name = "Player team"
          }
        },
        ["name"] = "The Sneakout"
      }
    }
  }
}
