cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Speed Race"] = {
  FileVersion = "2",
  name = "Speed Race",
  title = "ID:184008",
  MissionID = "3866",
  description = "ID:245574",
  cardInstances = {
    Actors = {
      ["Race team 2 member 1"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Race team 1"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          accidentProbability = 0.001,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Bernado"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          enableSiren = false,
          driveInOncoming = 0.1,
          driveOnPavements = 0.1,
          noOccupants = false,
          shaderParam = 1,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Speed race warmup"
          },
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          enableSimulationArea = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 293,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Medium",
          rubberbandingActor = "Race team 1 member 1",
          damageMultiplier = 0.7,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -40,
          desiredSpeed = 80,
          raceManagerRoute = false,
          routeName = "Speed Race",
          stayInLockedArea = false,
          blockTow = false,
          avoidAttacks = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Race team 2 member 2"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 80,
          team = {
            instance = 1,
            type = "Teams",
            name = "Race team 1"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          accidentProbability = 0.001,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Mal"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          driveInOncoming = 0.1,
          vehicleTrailerId = -1,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Speed race warmup"
          },
          shaderParam = 3,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 292,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Medium",
          rubberbandingActor = "Race team 1 member 1",
          damageMultiplier = 0.7,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = -25,
          ignoreCivilianTraffic = false,
          routeName = "Speed Race",
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          raceManagerRoute = false,
          aiIgnorePlayerInCivsUntilHit = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Race team 2 member 3"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Race team 1"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          accidentProbability = 0.001,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Hannah"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          enableSiren = false,
          driveInOncoming = 0.15,
          driveOnPavements = 0.15,
          noOccupants = false,
          shaderParam = 0,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Speed race warmup"
          },
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          enableSimulationArea = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 292,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Strong",
          rubberbandingActor = "Race team 1 member 1",
          damageMultiplier = 0.7,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -15,
          desiredSpeed = 80,
          raceManagerRoute = false,
          routeName = "Speed Race",
          stayInLockedArea = false,
          blockTow = false,
          avoidAttacks = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Race team 1 member 1"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = true,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 66,
          team = {
            instance = 1,
            type = "Teams",
            name = "Race team player"
          },
          drivingSkill = "Cautious",
          accidentProbability = 0.001,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Ehmu"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          driveInOncoming = 0.15,
          driveOnPavements = 0.15,
          previewMovie = "8",
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Speed race warmup"
          },
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = true,
          vehicleTrailerId = -1,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 293,
          shaderParam = 3,
          rubberbandingToPlayerStrength = "Medium",
          enableSiren = false,
          rubberbandingActor = "Race team 2 member 3",
          enableSimulationArea = false,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          stayInLockedArea = false,
          distanceBehindPlayer = 20,
          noOccupants = false,
          avoidAttacks = false,
          reactionTime = "Average",
          ignoreCivilianTraffic = false,
          routeName = "Speed Race"
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      Mal = {
        [1] = {
          ["Passenger id"] = "-234707716",
          ["Driver id"] = "-1490034552"
        },
        ["name"] = "Character"
      },
      Hannah = {
        [1] = {
          ["Passenger id"] = "-1744858750",
          ["Driver id"] = "1989331258"
        },
        ["name"] = "Character"
      },
      Bernado = {
        [1] = {
          ["Passenger id"] = "1760344531",
          ["Driver id"] = "343389279"
        },
        ["name"] = "Character"
      },
      Ehmu = {
        [1] = {
          ["Passenger id"] = "759755112",
          ["Driver id"] = "2135829601"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      ["New MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Disable traffic"] = false,
          ["Mission props"] = "Baja race props",
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Speed Race start",
          ["Audio logic file"] = "Race audio",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["disablePlayerIgnoring"] = false,
          ["Enable race status prompts"] = true
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["Race team player"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Race team 1"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    FelonySettings = {
      ["Speed Race felony"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    WarmupTypes = {
      ["Speed race warmup"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          warmupRouteName = "SpeedRaceWarmUpRoute",
          forceZapToVehicle = false,
          forceMissionAccept = false,
          matchTrafficSpeed = false,
          lookToVehicle = false
        },
        ["name"] = "Warmup route"
      }
    },
    SpawnTypes = {
      ["New Positions"] = {
        [1] = {
          ["1"] = "Race team 2 member 1",
          ["4"] = "Race team 1 member 1",
          ["3"] = "Race team 2 member 3",
          ["2"] = "Race team 2 member 2"
        },
        ["name"] = "Positions"
      }
    },
    MissionInfos = {
      ["Speed Race"] = {
        [1] = {
          ["1 Text"] = "ID:184013",
          ["Success reason"] = "ID:184018",
          ["showRouteArrows"] = "All",
          ["Failure reason"] = "ID:184036",
          ["Pass condition"] = "ID:184016",
          ["missionMarkers"] = {
            [1] = {
              value = "Opponent",
              cardName = "Race team 2 member 2",
              cardType = "Actor"
            },
            [2] = {
              value = "Opponent",
              cardName = "Race team 2 member 1",
              cardType = "Actor"
            },
            [3] = {
              value = "Opponent",
              cardName = "Race team 2 member 3",
              cardType = "Actor"
            },
            [4] = {
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
      ["Speed Race settings"] = {
        [1] = {
          ["Total laps"] = 0,
          ["Destroy opposing teams"] = false,
          ["Eject if in lead"] = false,
          ["Overtake target (+ score)"] = false,
          ["Race team 2"] = {
            instance = 1,
            type = "Teams",
            name = "Race team 1"
          },
          ["Score drift distance"] = false,
          ["Race team 1"] = {
            instance = 1,
            type = "Teams",
            name = "Race team player"
          },
          ["Hide checkpoints"] = false,
          ["Slow motion on goal complete"] = false,
          ["Score jump distance"] = false,
          ["Damage amount for fail"] = 1
        },
        ["name"] = "Generic checkpoint race"
      }
    }
  }
}
