cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.HeartometerActivity3 = {
  FileVersion = "2",
  name = "HeartometerActivity3",
  title = "ID:244219",
  MissionID = "25296",
  description = "ID:245687",
  cardInstances = {
    Actors = {
      player = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 75,
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
          previewMovie = "preview here",
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static"
          },
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 224,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 35,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          ignoreCivilianTraffic = false,
          noOccupants = false,
          stayInLockedArea = false,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          raceManagerRoute = false,
          aiIgnorePlayerInCivsUntilHit = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Player Character"] = {
        [1] = {
          ["Passenger id"] = "-1",
          ["Driver id"] = "-673381849"
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
          ["Start location"] = "HeartometerActivity3Spawn",
          ["Disable traffic"] = false
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
          ["1"] = "player"
        },
        ["name"] = "Positions"
      }
    },
    MissionInfos = {
      ["Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:245687",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective",
              cardName = "player",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New DriveToSurviveActivity"] = {
        [1] = {
          ["Time limit"] = 180,
          ["Max score"] = 11000,
          ["Player team"] = {
            instance = 1,
            type = "Teams",
            name = "Player Team"
          }
        },
        ["name"] = "DriveToSurviveActivity"
      }
    }
  }
}
