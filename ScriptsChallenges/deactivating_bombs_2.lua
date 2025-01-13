cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Deactivating bombs 2"] = {
  FileVersion = "2",
  name = "Deactivating bombs 2",
  title = "ID:242162",
  MissionID = "12622",
  description = "ID:245451",
  cardInstances = {
    Actors = {
      Player = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 55,
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
            name = "Tanner"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          previewMovie = "no preview",
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Static"
          },
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          shaderParam = 1,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "positions"
          },
          vehicleId = 214,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 50,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          ignoreCivilianTraffic = false,
          noOccupants = false,
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          ignoreOtherAis = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      Tanner = {
        [1] = {
          ["Passenger id"] = "-1",
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      MissionSettings = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Enable traffic at mission end"] = true,
          ["disablePlayerIgnoring"] = false,
          ["Spawn type"] = "Always active",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["Start location"] = "Deactivating bombs 2 start",
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
    SpawnTypes = {
      positions = {
        [1] = {
          ["1"] = "Player"
        },
        ["name"] = "Positions"
      }
    },
    WarmupTypes = {
      Static = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          forceZapToVehicle = false,
          forceMissionAccept = false,
          lookToVehicle = false
        },
        ["name"] = "Static"
      }
    },
    FelonySettings = {
      ["New FelonySettings 12"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    MissionInfos = {
      ["Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:234228",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective (No light trails)",
              cardName = "Player",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["Deactivating bombs 2 type"] = {
        [1] = {
          ["Amount of trucks to drive under"] = 20,
          ["Player team"] = {
            instance = 1,
            type = "Teams",
            name = "Player team"
          }
        },
        ["name"] = "Deactivating bombs 2"
      }
    }
  }
}
