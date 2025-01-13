cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.HeartometerActivity2 = {
  FileVersion = "2",
  name = "HeartometerActivity2",
  title = "ID:244218",
  MissionID = "24784",
  description = "ID:245563",
  cardInstances = {
    Actors = {
      Learner = {
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
            name = "Learner Team "
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
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
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static"
          },
          enableSiren = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Learn to sceam Positions"
          },
          vehicleId = 224,
          enableSimulationArea = false,
          isMultiplayerActor = false,
          spawnSpeed = 25,
          damageMultiplier = 0.4,
          attackStationaryVehicle = false,
          desiredSpeed = 40,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = true,
          blockTow = false,
          previewMovie = "cs_taxi_mission_scare",
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      Character = {
        [1] = {
          ["Passenger id"] = "-1",
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      ["Mission Settings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Enable traffic at mission end"] = true,
          ["disablePlayerIgnoring"] = false,
          ["Spawn type"] = "Always active",
          ["Delete task object on reject preview"] = false,
          ["Start location"] = "HeartometerActivity2Spawn",
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["Learner Team "] = {
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
      ["Learn to sceam Positions"] = {
        [1] = {
          ["1"] = "Learner"
        },
        ["name"] = "Positions"
      }
    },
    MissionInfos = {
      ["Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:245563",
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
      ["New Learn to scream activity"] = {
        [1] = {
          ["Score up multiplier"] = 2.5,
          ["Score down multiplier"] = 1.3,
          ["Max score"] = 9000,
          ["Learner team"] = {
            instance = 1,
            type = "Teams",
            name = "Learner Team "
          }
        },
        ["name"] = "Learn to scream activity"
      }
    }
  }
}
