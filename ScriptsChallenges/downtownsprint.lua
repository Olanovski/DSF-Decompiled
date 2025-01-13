cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.DowntownSprint = {
  FileVersion = "2",
  name = "DowntownSprint",
  title = "ID:184011",
  MissionID = "16197",
  description = "ID:245443",
  cardInstances = {
    Actors = {
      ["Race Team 1 Member 1"] = {
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
            name = "Downtown Sprint Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Downtown Sprint Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          driveInOncoming = 0.1,
          driveOnPavements = 0.1,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Downtown Sprint Static"
          },
          shaderParam = 14,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Race Team 1 Member 1 Spawn"
          },
          vehicleId = 225,
          enableSimulationArea = false,
          spawnSpeed = 0,
          isMultiplayerActor = false,
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          desiredSpeed = 0,
          matchTrafficSpeed = false,
          routeName = "DowntownSprintRoute",
          raceManagerRoute = true,
          stayInLockedArea = false,
          blockTow = false,
          previewMovie = " ",
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 1,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Downtown Sprint Character"] = {
        [1] = {
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      ["Downtown Sprint Mission Settings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "DowntownSprintStart",
          ["Spawn type"] = "Always active",
          ["Delete task object on reject preview"] = true,
          ["Disable traffic"] = true
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["Downtown Sprint Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    SpawnTypes = {
      ["Race Team 1 Member 1 Spawn"] = {
        [1] = {
          ["Spawn location"] = "DowntownSprintRacer1Spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    WarmupTypes = {
      ["Downtown Sprint Static"] = {
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
      ["New FelonySettings 7"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    MissionInfos = {
      ["Downtown Sprint Title and Description"] = {
        [1] = {
          ["1 Text"] = "ID:245597",
          ["Success reason"] = "ID:245559",
          ["showRouteArrows"] = "All",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective",
              cardName = "Race Team 1 Member 1",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["Downtown Sprint Settings"] = {
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
            name = "Downtown Sprint Team"
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
