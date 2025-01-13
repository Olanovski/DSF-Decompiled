cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.Speed = {
  FileVersion = "2",
  name = "Speed",
  title = "ID:214697",
  MissionID = "32069",
  description = "ID:245447",
  cardInstances = {
    Actors = {
      ["Race team 1 member 1"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = true,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          routeName = "SpeedRoute",
          team = {
            instance = 1,
            type = "Teams",
            name = "Speed Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Speed Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          previewMovie = " ",
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Speed Static"
          },
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          shaderParam = 1,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Set position"
          },
          vehicleId = 211,
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
          reactionTime = "Average",
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          raceManagerRoute = true,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Speed Character"] = {
        [1] = {
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      ["Speed MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Enable traffic at mission end"] = true,
          ["disablePlayerIgnoring"] = false,
          ["Spawn type"] = "Always active",
          ["Delete task object on reject preview"] = true,
          ["Start location"] = "SpeedStart",
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["Speed Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    WarmupTypes = {
      ["Speed Static"] = {
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
      ["New Set position"] = {
        [1] = {
          ["Spawn location"] = "SpeedStart",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    MissionInfos = {
      ["Speed Title"] = {
        [1] = {
          ["1 Text"] = "ID:245597",
          ["Success reason"] = "ID:245559",
          ["showRouteArrows"] = "All",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective",
              cardName = "Race team 1 member 1",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["Speed settings"] = {
        [1] = {
          ["Slow motion on goal complete"] = false,
          ["Total laps"] = 0,
          ["Destroy opposing teams"] = false,
          ["Endless race"] = false,
          ["Overtake target (+ score)"] = false,
          ["Score drift distance"] = false,
          ["Race team 1"] = {
            instance = 1,
            type = "Teams",
            name = "Speed Team"
          },
          ["Score jump distance"] = false,
          ["Damage amount for fail"] = 1,
          ["Start prompt"] = "ID:245597",
          ["scoringType"] = "Time",
          ["Hide checkpoints"] = false,
          ["Checkpoint type"] = "Checkpoint Gate"
        },
        ["name"] = "Generic challenge race"
      }
    }
  }
}
