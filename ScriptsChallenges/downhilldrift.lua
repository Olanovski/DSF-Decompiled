cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.DownhillDrift = {
  FileVersion = "2",
  name = "DownhillDrift",
  title = "ID:214718",
  MissionID = "38213",
  description = "ID:245461",
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
          routeName = "DownhillDriftRoute",
          team = {
            instance = 1,
            type = "Teams",
            name = "DownhillDrift Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "DownhillDrift Character"
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
            name = "DownhillDrift Static"
          },
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          shaderParam = 7,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Positions"
          },
          vehicleId = 241,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 0,
          damageMultiplier = 1.1,
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
      ["DownhillDrift Character"] = {
        [1] = {
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      ["DownhillDrift MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = true,
          ["Spawn type"] = "Always active",
          ["Enable traffic at mission end"] = true,
          ["disablePlayerIgnoring"] = false,
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = true,
          ["Start location"] = "DownhillDriftStart",
          ["Disable traffic"] = true
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["DownhillDrift Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    FelonySettings = {
      ["New FelonySettings 6"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    WarmupTypes = {
      ["DownhillDrift Static"] = {
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
      ["Positions"] = {
        [1] = {
          ["alternateLocation"] = "DownhillDriftSpawn",
          ["1"] = "Race team 1 member 1"
        },
        ["name"] = "Positions"
      },
      ["New Set position"] = {
        [1] = {
          ["Spawn location"] = "DownhillDriftSpawn",
          ["Snap to closest road"] = true
        },
        ["name"] = "Set position"
      }
    },
    MissionInfos = {
      ["DownhillDrift Title"] = {
        [1] = {
          ["1 Text"] = "ID:245597",
          ["Success reason"] = "ID:245587",
          ["showRouteArrows"] = "All",
          ["missionMarkers"] = {
            [1] = {
              value = "None",
              cardName = "Race team 1 member 1",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["DownhillDrift settings"] = {
        [1] = {
          ["Slow motion on goal complete"] = true,
          ["Total laps"] = 0,
          ["Destroy opposing teams"] = false,
          ["Endless race"] = false,
          ["Overtake target (+ score)"] = false,
          ["Score drift distance"] = false,
          ["Race team 1"] = {
            instance = 1,
            type = "Teams",
            name = "DownhillDrift Team"
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
