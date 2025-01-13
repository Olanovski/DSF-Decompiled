cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Smash activity 3"] = {
  FileVersion = "2",
  name = "Smash activity 3",
  title = "ID:244206",
  MissionID = "7597",
  description = "ID:245556",
  cardInstances = {
    Actors = {
      Player = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = true,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 60,
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
          previewMovie = " ",
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static 11"
          },
          enableSiren = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Set position"
          },
          vehicleId = -1,
          enableSimulationArea = false,
          isMultiplayerActor = false,
          spawnSpeed = 30,
          damageMultiplier = 0.6,
          attackStationaryVehicle = false,
          ignoreCivilianTraffic = false,
          reactionTime = "Average",
          noOccupants = false,
          stayInLockedArea = false,
          blockTow = false,
          routeName = "Smash activity 3 route",
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
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      }
    },
    FelonySettings = {
      ["Smash felony 3"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    Teams = {
      ["Player team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionSettings = {
      ["Smash activity 3"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Spawn type"] = "Always active",
          ["Hud logic file"] = "Generic smash activity HUD",
          ["Mission props"] = "Smash activity 3",
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "SmashActivity3",
          ["Delete task object on reject preview"] = false,
          ["disablePlayerIgnoring"] = false,
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    WarmupTypes = {
      ["New Static 11"] = {
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
          ["Spawn location"] = "SmashPlayerSpawn3",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    MissionInfos = {
      ["Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:245556",
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
      ["Generic smash activity"] = {
        [1] = {
          ["Substracted willpower per second"] = 2000,
          ["Maximum willpower"] = 25000,
          ["Player team"] = {
            instance = 1,
            type = "Teams",
            name = "Player team"
          },
          ["Willpower per prop"] = 5500,
          ["Damage amount for fail"] = 1
        },
        ["name"] = "Generic smash activity"
      }
    }
  }
}
