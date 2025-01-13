cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.DriveToSurvive = {
  FileVersion = "2",
  name = "DriveToSurvive",
  title = "ID:186754",
  MissionID = "4852",
  description = "ID:184807",
  cardInstances = {
    Actors = {
      player = {
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
            name = "Player Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Player Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          driveInOncoming = 0.8,
          vehicleTrailerId = -1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Warmup route"
          },
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Very tough",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 162,
          shaderParam = 6,
          enableSiren = false,
          enableSimulationArea = false,
          damageMultiplier = 0.3,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          aiIgnorePlayerInCivsUntilHit = false,
          previewMovie = "preview here",
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          desiredSpeed = 75,
          routeName = "Cranked Route"
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Player Character"] = {
        [1] = {
          ["Passenger id"] = "162938988",
          ["Driver id"] = "-1988729637"
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
          ["Disable traffic"] = false,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Cranked",
          ["Audio logic file"] = "Drive to survive APIP",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["disablePlayerIgnoring"] = false,
          ["Enable race status prompts"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["Player Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {reenablePatrollingVehiclesAfterFelonyEnd = false, disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    WarmupTypes = {
      ["New Warmup route"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          warmupRouteName = "CrankedWarmupRoute",
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
          ["1"] = "player"
        },
        ["name"] = "Positions"
      }
    },
    MissionInfos = {
      ["Title and description"] = {
        [1] = {
          ["Perfect condition"] = "ID:184810",
          ["Success reason"] = "ID:184809",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective",
              cardName = "player",
              cardType = "Actor"
            }
          },
          ["Failure reason"] = "ID:184808",
          ["1 Text"] = "ID:245511",
          ["Success reason (perfect)"] = "ID:184812",
          ["2 Text"] = "ID:245946"
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New DriveToSurvive"] = {
        [1] = {
          ["Duration below speed"] = 5,
          ["Duration above speed"] = 5,
          ["Score to win"] = 180,
          ["Speed above (+ score)"] = 100,
          ["Score to lose"] = 0,
          ["Speed below (- score)"] = 65,
          ["Player team"] = {
            instance = 1,
            type = "Teams",
            name = "Player Team"
          },
          ["Score to start countdown"] = 10,
          ["Damage amount for fail"] = 1
        },
        ["name"] = "DriveToSurvive"
      }
    }
  }
}
