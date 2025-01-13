cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Felony lure"] = {
  FileVersion = "2",
  name = "Felony lure",
  title = "ID:184965",
  MissionID = "1863",
  description = "ID:184966",
  cardInstances = {
    Actors = {
      MissionVehicle = {
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
            name = "PlayerTeam"
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
          previewMovie = "blah",
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Warmup route"
          },
          avoidUTurns = false,
          avoidedByCivilianTraffic = true,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "StartLocation"
          },
          vehicleId = 136,
          shaderParam = 7,
          enableSiren = false,
          enableSimulationArea = false,
          damageMultiplier = 0.25,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          noOccupants = false,
          stayInLockedArea = false,
          blockTow = true,
          reactionTime = "Average",
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          raceManagerRoute = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["New Character"] = {
        [1] = {
          ["Passenger id"] = "1347324191",
          ["Driver id"] = "-228045591"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      ["New MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Load traffic on start"] = "Chapter 4",
          ["Disable traffic"] = false,
          ["Cutscene at mission end"] = "mis_ch5_papermoney_01",
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Felony lure location A",
          ["Audio logic file"] = "Felony Lure APIP",
          ["freezeFrameOnMissionEndCutscene"] = true,
          ["Delete task object on reject preview"] = false,
          ["disablePlayerIgnoring"] = false,
          ["Enable race status prompts"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {
          onlyVehicleAbleToStartFelonies = "MissionVehicle",
          disablePoliceInTrafficDuringMission = true,
          reenablePatrollingVehiclesAfterFelonyEnd = true
        },
        ["name"] = "FelonySettings"
      }
    },
    Teams = {
      PlayerTeam = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionCompletes = {
      ["Felony lure Complete"] = {
        [1] = {
          ["Perfect condition"] = "ID:186156",
          ["Pass condition"] = "ID:186155",
          ["Success reason (perfect)"] = "ID:221949"
        },
        ["name"] = "Felony lure"
      }
    },
    WarmupTypes = {
      ["New Warmup route"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          warmupRouteName = "Felony lure warmup",
          forceZapToVehicle = false,
          forceMissionAccept = false,
          matchTrafficSpeed = true,
          lookToVehicle = false
        },
        ["name"] = "Warmup route"
      }
    },
    SpawnTypes = {
      ["StartLocation"] = {
        [1] = {
          ["1"] = "MissionVehicle"
        },
        ["name"] = "Positions"
      },
      ["New Set position"] = {
        [1] = {
          ["Spawn location"] = "Player spawn position",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    MissionInfos = {
      FelonyLure = {
        [1] = {
          ["1 Text"] = "ID:246231",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective",
              cardName = "MissionVehicle",
              cardType = "Actor"
            }
          },
          ["4 Text"] = "ID:186153",
          ["3 Text"] = "ID:246230",
          ["2 Text"] = "ID:186151"
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Felony lure"] = {
        [1] = {
          ["Player team"] = {
            instance = 1,
            type = "Teams",
            name = "PlayerTeam"
          }
        },
        ["name"] = "Felony lure"
      }
    }
  }
}
