cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.Uplaych4 = {
  FileVersion = "2",
  name = "Uplaych4",
  title = "ID:214688",
  MissionID = "27461",
  description = "ID:236747",
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
          desiredSpeed = 0,
          team = {
            instance = 1,
            type = "Teams",
            name = "Uplaych4 Team 1"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Uplaych4 Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          previewMovie = " ",
          enableSiren = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Uplaych4 Static"
          },
          shaderParam = 3,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = true,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Set position 2"
          },
          vehicleId = 162,
          enableSimulationArea = false,
          isMultiplayerActor = false,
          spawnSpeed = 0,
          damageMultiplier = 1.1,
          attackStationaryVehicle = false,
          ignoreCivilianTraffic = false,
          reactionTime = "Average",
          noOccupants = false,
          stayInLockedArea = false,
          blockTow = false,
          routeName = "Uplaych4Route",
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          ignoreOtherAis = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Uplaych4 Character"] = {
        [1] = {
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      ["Uplaych4 MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Uplaych4Start",
          ["Spawn type"] = "Always active",
          ["Delete task object on reject preview"] = true,
          ["Disable traffic"] = true
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["Uplaych4 Team 1"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    FelonySettings = {
      ["New FelonySettings 15"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    WarmupTypes = {
      ["Uplaych4 Static"] = {
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
      ["New Set position 2"] = {
        [1] = {
          ["Spawn location"] = "Uplaych4Start",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    MissionInfos = {
      ["Uplaych4 Title"] = {
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
      ["Uplaych4 settings"] = {
        [1] = {
          ["Slow motion on goal complete"] = true,
          ["Total laps"] = 0,
          ["Time limit"] = 195,
          ["Destroy opposing teams"] = false,
          ["Endless race"] = false,
          ["Overtake target (+ score)"] = false,
          ["Score drift distance"] = true,
          ["Race team 1"] = {
            instance = 1,
            type = "Teams",
            name = "Uplaych4 Team 1"
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
