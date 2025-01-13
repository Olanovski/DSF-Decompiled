cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Checkpoint activity 4"] = {
  FileVersion = "2",
  name = "Checkpoint activity 4",
  title = "ID:244211",
  MissionID = "3501",
  description = "ID:245558",
  cardInstances = {
    Actors = {
      Player = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = true,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 45,
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
            name = "Tanner"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          previewMovie = " ",
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static 4"
          },
          enableSiren = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Set position"
          },
          vehicleId = -1,
          enableSimulationArea = false,
          spawnSpeed = 30,
          isMultiplayerActor = false,
          damageMultiplier = 0.6,
          attackStationaryVehicle = false,
          ignoreCivilianTraffic = false,
          matchTrafficSpeed = false,
          routeName = "Checkpoint activity 4 route",
          noOccupants = false,
          stayInLockedArea = false,
          blockTow = false,
          raceManagerRoute = false,
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      Tanner = {
        [1] = {
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      }
    },
    FelonySettings = {
      ["Checkpoint felony 4"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    Teams = {
      ["Player Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionSettings = {
      ["Checkpoint activity 4"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "CheckpointActivity4",
          ["disablePlayerIgnoring"] = false,
          ["Spawn type"] = "Always active",
          ["Delete task object on reject preview"] = false,
          ["Hud logic file"] = "Checkpoint activity 4 hud",
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    WarmupTypes = {
      ["New Static 4"] = {
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
      ["Set position"] = {
        [1] = {
          ["Spawn location"] = "PlayerSpawn4",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    MissionInfos = {
      ["Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:245558",
          ["showRouteArrows"] = "All",
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
      ["Generic checkpoint activity"] = {
        [1] = {
          ["Substracted willpower per second"] = 450,
          ["Willpower per checkpoint"] = 2500,
          ["Maximum willpower"] = 15000,
          ["Player Team"] = {
            instance = 1,
            type = "Teams",
            name = "Player Team"
          }
        },
        ["name"] = "Generic checkpoint activity"
      }
    }
  }
}
