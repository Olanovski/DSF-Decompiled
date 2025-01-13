cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.DriveToSurvive2 = {
  FileVersion = "2",
  name = "DriveToSurvive2",
  title = "ID:242166",
  MissionID = "12110",
  description = "ID:245453",
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
          previewMovie = "no preview",
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Static warmup"
          },
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          shaderParam = 4,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 248,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 0,
          damageMultiplier = 0.7,
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
          ["Start location"] = "Drive to survive 2 start",
          ["Spawn type"] = "Always active",
          ["Delete task object on reject preview"] = false,
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {reenablePatrollingVehiclesAfterFelonyEnd = false, disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    Teams = {
      ["Player Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionCompletes = {
      ["DriveToSurvive2 complete"] = {
        [1] = {
          ["Perfect condition"] = "ID:184810",
          ["Success reason"] = "ID:184809",
          ["Failure reason"] = "ID:184808",
          ["Success reason (perfect)"] = "ID:184812",
          ["Failure reason (wrecked)"] = "ID:183989"
        },
        ["name"] = "DriveToSurvive2"
      }
    },
    WarmupTypes = {
      ["Static warmup"] = {
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
          ["1 Text"] = "ID:234230",
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
      ["DriveToSurvive2 mission type"] = {
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
        ["name"] = "DriveToSurvive2"
      }
    }
  }
}
