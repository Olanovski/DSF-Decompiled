cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.ChinatownDrift = {
  FileVersion = "2",
  name = "ChinatownDrift",
  title = "ID:214694",
  MissionID = "28997",
  description = "ID:245444",
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
          routeName = "ChinatownDriftRoute",
          team = {
            instance = 1,
            type = "Teams",
            name = "ChinatownDrift Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "ChinatownDrift Character"
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
            name = "ChinatownDrift Static"
          },
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          shaderParam = 5,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Positions spawn"
          },
          vehicleId = 299,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 0,
          damageMultiplier = 1.2,
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
      ["ChinatownDrift Character"] = {
        [1] = {
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      ["ChinatownDrift MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Enable traffic at mission end"] = true,
          ["disablePlayerIgnoring"] = false,
          ["Spawn type"] = "Always active",
          ["Delete task object on reject preview"] = true,
          ["Start location"] = "ChinatownDriftStart",
          ["Disable traffic"] = true
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["ChinatownDrift Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    FelonySettings = {
      ["New FelonySettings 8"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    WarmupTypes = {
      ["ChinatownDrift Static"] = {
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
      ["Positions spawn"] = {
        [1] = {
          ["1"] = "Race team 1 member 1"
        },
        ["name"] = "Positions"
      },
      ["New Set position"] = {
        [1] = {
          ["Spawn location"] = "ChinatownDriftSpawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    MissionInfos = {
      ChinatownDrift = {
        [1] = {
          ["1 Text"] = "ID:184026",
          ["Success reason"] = "ID:245578",
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
      ["ChinatownDrift settings"] = {
        [1] = {
          ["Slow motion on goal complete"] = false,
          ["Total laps"] = 1,
          ["Time limit"] = 130,
          ["Destroy opposing teams"] = false,
          ["Endless race"] = false,
          ["Overtake target (+ score)"] = false,
          ["Score drift distance"] = true,
          ["Race team 1"] = {
            instance = 1,
            type = "Teams",
            name = "ChinatownDrift Team"
          },
          ["Score jump distance"] = false,
          ["Damage amount for fail"] = 1,
          ["Start prompt"] = "ID:245941",
          ["scoringType"] = "Drift",
          ["Hide checkpoints"] = false,
          ["Checkpoint type"] = "Checkpoint Gate"
        },
        ["name"] = "Generic challenge race"
      }
    }
  }
}
