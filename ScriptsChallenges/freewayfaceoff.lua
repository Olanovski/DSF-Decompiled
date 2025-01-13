cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.FreewayFaceoff = {
  FileVersion = "2",
  name = "FreewayFaceoff",
  title = "ID:214690",
  MissionID = "27973",
  description = "ID:245450",
  cardInstances = {
    Actors = {
      ["Race team 2 member 1"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 120,
          team = {
            instance = 1,
            type = "Teams",
            name = "FreewayFaceoff Team 2"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          enableSiren = false,
          driveInOncoming = 0.1,
          driveOnPavements = 0.5,
          noOccupants = false,
          shaderParam = 0,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "FreewayFaceoff Static"
          },
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          enableSimulationArea = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Positions"
          },
          vehicleId = 232,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 0,
          rubberbandingActor = "Race team 1 member 1",
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -60,
          avoidedByCivilianTraffic = true,
          raceManagerRoute = true,
          routeName = "FreewayFaceoffRoute",
          stayInLockedArea = false,
          blockTow = false,
          avoidAlleys = 1,
          avoidAttacks = false,
          ignoreCivilianTraffic = false,
          reactionTime = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Race team 1 member 1"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = true,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          routeName = "FreewayFaceoffRoute",
          team = {
            instance = 1,
            type = "Teams",
            name = "FreewayFaceoff Team 1"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "FreewayFaceoff Character"
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
            name = "FreewayFaceoff Static"
          },
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          shaderParam = 3,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Positions"
          },
          vehicleId = 224,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 0,
          damageMultiplier = 0.4,
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
      ["FreewayFaceoff Character"] = {
        [1] = {
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      }
    },
    FelonySettings = {
      ["New FelonySettings 3"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    Teams = {
      ["FreewayFaceoff Team 1"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["FreewayFaceoff Team 2"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    SpawnTypes = {
      Positions = {
        [1] = {
          ["1"] = "Race team 2 member 1",
          ["2"] = "Race team 1 member 1"
        },
        ["name"] = "Positions"
      }
    },
    WarmupTypes = {
      ["FreewayFaceoff Static"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          forceZapToVehicle = false,
          forceMissionAccept = false,
          lookToVehicle = false
        },
        ["name"] = "Static"
      }
    },
    MissionSettings = {
      ["FreewayFaceoff MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Disable traffic"] = false,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "FreewayFaceoffStart",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = true,
          ["disablePlayerIgnoring"] = false,
          ["Enable race status prompts"] = true
        },
        ["name"] = "MissionSettings"
      }
    },
    MissionInfos = {
      ["FreewayFaceoff Title"] = {
        [1] = {
          ["1 Text"] = "ID:245598",
          ["Success reason"] = "ID:245579",
          ["showRouteArrows"] = "All",
          ["missionMarkers"] = {
            [1] = {
              value = "Opponent",
              cardName = "Race team 2 member 1",
              cardType = "Actor"
            },
            [2] = {
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
      ["FreewayFaceoff settings"] = {
        [1] = {
          ["Slow motion on goal complete"] = true,
          ["Total laps"] = 0,
          ["Destroy opposing teams"] = false,
          ["Endless race"] = false,
          ["Overtake target (+ score)"] = false,
          ["Race team 2"] = {
            instance = 1,
            type = "Teams",
            name = "FreewayFaceoff Team 2"
          },
          ["Score drift distance"] = false,
          ["Race team 1"] = {
            instance = 1,
            type = "Teams",
            name = "FreewayFaceoff Team 1"
          },
          ["Score jump distance"] = false,
          ["Damage amount for fail"] = 1,
          ["Start prompt"] = "ID:245598",
          ["scoringType"] = "Time",
          ["Hide checkpoints"] = false,
          ["Checkpoint type"] = "Checkpoint Gate"
        },
        ["name"] = "Generic challenge race"
      }
    }
  }
}
