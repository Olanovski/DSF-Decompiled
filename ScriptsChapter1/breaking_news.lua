cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Breaking news"] = {
  FileVersion = "2",
  name = "Breaking news",
  title = "ID:182563",
  MissionID = "720",
  description = "ID:182562",
  cardInstances = {
    Actors = {
      ["Van Actor"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Van Team"
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
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Warmup route"
          },
          vehicleTrailerId = -1,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          shaderParam = 2,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 198,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 0,
          damageMultiplier = 0.3,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          aiIgnorePlayerInCivsUntilHit = false,
          previewMovie = " ",
          stayInLockedArea = true,
          blockTow = true,
          desiredSpeed = 30,
          avoidAttacks = false,
          avoidAlleys = 0,
          reactionTime = "Average"
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["New Character"] = {
        [1] = {
          ["Passenger id"] = "1600663248",
          ["Driver id"] = "-1669780055"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      ["New MissionSetting"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = true,
          ["Spawn type"] = "Always active",
          ["Load traffic on start"] = "Chapter 1 Breaking News",
          ["Hud logic file"] = "Breaking news hud",
          ["Disable traffic"] = false,
          ["Enable traffic at mission end"] = true,
          ["disablePlayerIgnoring"] = false,
          ["Audio logic file"] = "Breaking News APIP",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["Start location"] = "Breaking news start",
          ["Enable race status prompts"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["New Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Van Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {reenablePatrollingVehiclesAfterFelonyEnd = true, disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    WarmupTypes = {
      ["New Warmup route"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          warmupRouteName = "BreakingNewsWarmupRoute",
          forceZapToVehicle = false,
          forceMissionAccept = false,
          matchTrafficSpeed = false,
          lookToVehicle = false
        },
        ["name"] = "Warmup route"
      }
    },
    SpawnTypes = {
      ["New Positions"] = {
        [1] = {
          ["alternateLocation"] = "Breaking news spawn",
          ["1"] = "Van Actor"
        },
        ["name"] = "Positions"
      }
    },
    MissionInfos = {
      ["Title : BREAKING NEWS"] = {
        [1] = {
          ["9 Text"] = "ID:183943",
          ["Success reason"] = "ID:182574",
          ["7 Text"] = "ID:243146",
          ["6 Text"] = "ID:243188",
          ["Failure reason"] = "ID:182569",
          ["1 Text"] = "ID:245529",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective",
              cardName = "Van Actor",
              cardType = "Actor"
            }
          },
          ["8 Text"] = "ID:243149",
          ["3 Text"] = "ID:243144",
          ["5 Text"] = "ID:184496",
          ["4 Text"] = "ID:182567",
          ["Pass condition"] = "ID:182570",
          ["2 Text"] = "ID:243788"
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["Mission Type : Breaking News"] = {
        [1] = {
          ["Scoring team"] = {
            instance = 1,
            type = "Teams",
            name = "Van Team"
          },
          ["Hotspot radius"] = 43,
          ["Damage amount for fail"] = 1
        },
        ["name"] = "Breaking news"
      }
    }
  }
}
