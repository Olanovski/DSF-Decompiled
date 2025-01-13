cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.Smoketrail = {
  FileVersion = "2",
  name = "Smoketrail",
  title = "ID:214720",
  MissionID = "35141",
  description = "ID:245458",
  cardInstances = {
    Actors = {
      ["Opponent 1"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 90,
          team = {
            instance = 1,
            type = "Teams",
            name = "Opponent Team"
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
          driveInOncoming = 0.5,
          driveOnPavements = 0.6,
          noOccupants = false,
          shaderParam = 1,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Smoketrail Static"
          },
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          enableSimulationArea = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Opponent 1 position"
          },
          vehicleId = 272,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 0,
          rubberbandingActor = "Race team 1 member 1",
          damageMultiplier = 0.7,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -30,
          avoidedByCivilianTraffic = false,
          raceManagerRoute = false,
          routeName = "SmoketrailRoute",
          stayInLockedArea = false,
          blockTow = false,
          avoidAlleys = 1,
          avoidAttacks = false,
          ignoreCivilianTraffic = false,
          reactionTime = "Fastest",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Opponent 2"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 90,
          team = {
            instance = 1,
            type = "Teams",
            name = "Opponent Team"
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
          driveInOncoming = 0.5,
          driveOnPavements = 0.6,
          noOccupants = false,
          shaderParam = 2,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Smoketrail Static"
          },
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          enableSimulationArea = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Opponent 2 position"
          },
          vehicleId = 282,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 0,
          rubberbandingActor = "Race team 1 member 1",
          damageMultiplier = 0.7,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -30,
          avoidedByCivilianTraffic = false,
          raceManagerRoute = false,
          routeName = "SmoketrailRoute",
          stayInLockedArea = false,
          blockTow = false,
          avoidAlleys = 1,
          avoidAttacks = false,
          ignoreCivilianTraffic = false,
          reactionTime = "Fastest",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Race team 1 member 1"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 80,
          team = {
            instance = 1,
            type = "Teams",
            name = "Smoketrail Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Smoketrail Character"
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
            name = "Smoketrail Static"
          },
          shaderParam = 0,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0.1,
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Player position"
          },
          vehicleId = 270,
          enableSimulationArea = false,
          spawnSpeed = 0,
          isMultiplayerActor = false,
          damageMultiplier = 0.7,
          attackStationaryVehicle = false,
          ignoreCivilianTraffic = false,
          matchTrafficSpeed = false,
          routeName = "SmoketrailRoute",
          noOccupants = false,
          stayInLockedArea = false,
          blockTow = false,
          raceManagerRoute = true,
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Smoketrail Character"] = {
        [1] = {
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      ["Smoketrail MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Disable traffic"] = false,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "SmoketrailStart",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = true,
          ["disablePlayerIgnoring"] = false,
          ["Enable race status prompts"] = true
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["Smoketrail Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Opponent Team"] = {
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
      ["Smoketrail Static"] = {
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
      ["Opponent 2 position"] = {
        [1] = {
          ["Spawn location"] = "Smoketrail opponent 2 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["New Positions"] = {
        [1] = {
          ["1"] = "Race team 1 member 1",
          ["3"] = "Opponent 2",
          ["2"] = "Opponent 1"
        },
        ["name"] = "Positions"
      },
      ["Player position"] = {
        [1] = {
          ["Spawn location"] = "Smoketrail player spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Opponent 1 position"] = {
        [1] = {
          ["Spawn location"] = "Smoketrail opponent 1 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    MissionInfos = {
      Smoketrail = {
        [1] = {
          ["1 Text"] = "ID:231170",
          ["showRouteArrows"] = "All",
          ["missionMarkers"] = {
            [1] = {
              value = "Opponent",
              cardName = "Opponent 1",
              cardType = "Actor"
            },
            [2] = {
              value = "Objective",
              cardName = "Race team 1 member 1",
              cardType = "Actor"
            },
            [3] = {
              value = "Opponent",
              cardName = "Opponent 2",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Generic challenge race"] = {
        [1] = {
          ["Slow motion on goal complete"] = false,
          ["Destroy opposing teams"] = true,
          ["Score jump distance"] = false,
          ["Endless race"] = false,
          ["Overtake target (+ score)"] = false,
          ["Race team 2"] = {
            instance = 1,
            type = "Teams",
            name = "Opponent Team"
          },
          ["Score drift distance"] = false,
          ["Race team 1"] = {
            instance = 1,
            type = "Teams",
            name = "Smoketrail Team"
          },
          ["Damage amount for fail"] = 1,
          ["Hide checkpoints"] = false,
          ["scoringType"] = "Time",
          ["Start prompt"] = "ID:243843",
          ["Checkpoint type"] = "Hotspot"
        },
        ["name"] = "Generic challenge race"
      }
    }
  }
}
