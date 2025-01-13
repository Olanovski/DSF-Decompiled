cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.HeartometerActivity4 = {
  FileVersion = "2",
  name = "HeartometerActivity4",
  title = "ID:244220",
  MissionID = "729",
  description = "ID:245687",
  cardInstances = {
    Actors = {
      Player = {
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
            name = "Player team"
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
            name = "Heartometer positions"
          },
          vehicleId = 224,
          enableSimulationArea = false,
          isMultiplayerActor = false,
          spawnSpeed = 35,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          desiredSpeed = 60,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          previewMovie = "preview here",
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
          ["Start location"] = "HeartometerActivity4Spawn",
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["Player team"] = {
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
      ["Heartometer positions"] = {
        [1] = {
          ["1"] = "Player"
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
              cardName = "Player",
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
          ["Time limit"] = 270,
          ["Max score"] = 13000,
          ["Player team"] = {
            instance = 1,
            type = "Teams",
            name = "Player team"
          }
        },
        ["name"] = "DriveToSurviveActivity"
      }
    }
  }
}
