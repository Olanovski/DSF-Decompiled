cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Learn to scream"] = {
  FileVersion = "2",
  name = "Learn to scream",
  title = "ID:184055",
  MissionID = "1232",
  description = "ID:184056",
  cardInstances = {
    Actors = {
      Learner = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Learner Team "
          },
          drivingSkill = "Average",
          characters = {
            instance = 1,
            type = "Characters",
            name = "Character"
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
            name = "Warmup route"
          },
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          vehicleTrailerId = -1,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Learn to sceam Positions"
          },
          vehicleId = 184,
          shaderParam = 3,
          enableSiren = false,
          enableSimulationArea = false,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          aiIgnorePlayerInCivsUntilHit = false,
          previewMovie = "cs_taxi_mission_scare",
          stayInLockedArea = true,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          avoidAlleys = 0,
          desiredSpeed = 40
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      Character = {
        [1] = {
          ["Passenger id"] = "1396723842",
          ["Driver id"] = "-547488997"
        },
        ["name"] = "Character"
      }
    },
    SpawnTypes = {
      ["Learn to sceam Positions"] = {
        [1] = {
          ["1"] = "Learner"
        },
        ["name"] = "Positions"
      }
    },
    Teams = {
      ["Learner Team "] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionSettings = {
      ["Mission Settings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Learn to scream start",
          ["Audio logic file"] = "Learn to scream",
          ["Spawn type"] = "Always active",
          ["Delete task object on reject preview"] = false,
          ["disablePlayerIgnoring"] = false,
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    WarmupTypes = {
      ["Warmup route"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          warmupRouteName = "Learn to scream warmup",
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
      ["Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:243010",
          ["Success reason"] = "ID:184058",
          ["Failure reason"] = "ID:184015",
          ["Pass condition"] = "ID:184058",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective",
              cardName = "Learner",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Learn to scream"] = {
        [1] = {
          ["Learner team"] = {
            instance = 1,
            type = "Teams",
            name = "Learner Team "
          },
          ["Speed above (+ score)"] = 70,
          ["Duration below speed"] = 1,
          ["Speed below (- score)"] = 40,
          ["Duration above speed"] = 1,
          ["Score to win"] = 90,
          ["Damage amount for fail"] = 1
        },
        ["name"] = "Learn to scream"
      }
    }
  }
}
