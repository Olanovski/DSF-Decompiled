cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Checkpoint activity 3"] = {
  FileVersion = "2",
  name = "Checkpoint activity 3",
  title = "ID:244210",
  MissionID = "2989",
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
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Player Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          accidentProbability = 0,
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
          enableSiren = false,
          vehicleTrailerId = -1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static 3"
          },
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          enableSimulationArea = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Set position"
          },
          vehicleId = -1,
          desiredSpeed = 35,
          spawnSpeed = 30,
          isMultiplayerActor = false,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          previewMovie = " ",
          routeName = "Checkpoint activity 3 route",
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
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
      ["Checkpoint felony 3"] = {
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
    MissionSettings = {
      ["Checkpoint activity 3"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "CheckpointActivity3",
          ["disablePlayerIgnoring"] = false,
          ["Spawn type"] = "Always active",
          ["Delete task object on reject preview"] = false,
          ["Hud logic file"] = "Checkpoint activity 3 hud",
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    WarmupTypes = {
      ["New Static 3"] = {
        [1] = {},
        ["name"] = "Static"
      }
    },
    SpawnTypes = {
      ["Set position"] = {
        [1] = {
          ["Spawn location"] = "PlayerSpawn3",
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
          ["Substracted willpower per second"] = 150,
          ["Willpower per checkpoint"] = 1500,
          ["Maximum willpower"] = 5000,
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
