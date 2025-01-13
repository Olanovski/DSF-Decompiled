cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["High plains drifter"] = {
  FileVersion = "2",
  name = "High plains drifter",
  title = "ID:183998",
  MissionID = "846",
  description = "ID:245574",
  cardInstances = {
    Actors = {
      ["Race team 2 member 2"] = {
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
            name = "Team oppo"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          accidentProbability = 0.001,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Justin"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          enableSiren = false,
          driveInOncoming = 0.1,
          driveOnPavements = 0.2,
          noOccupants = false,
          shaderParam = 0,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "HPD Warmup route"
          },
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          enableSimulationArea = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 217,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Strong",
          rubberbandingActor = "Race team 1 member 1",
          damageMultiplier = 0.7,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -30,
          desiredSpeed = 105,
          raceManagerRoute = false,
          routeName = "High plains drifter",
          stayInLockedArea = false,
          blockTow = false,
          avoidAttacks = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Race team 2 member 4"] = {
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
            name = "Team oppo"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          accidentProbability = 0.001,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Michael"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          enableSiren = false,
          driveInOncoming = 0.1,
          driveOnPavements = 0.2,
          noOccupants = false,
          shaderParam = 1,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "HPD Warmup route"
          },
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          enableSimulationArea = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 217,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Strong",
          rubberbandingActor = "Race team 1 member 1",
          damageMultiplier = 0.7,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -40,
          desiredSpeed = 100,
          raceManagerRoute = false,
          routeName = "High plains drifter",
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
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Team racer"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Ayumu"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          driveInOncoming = 0.3,
          driveOnPavements = 0.4,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "HPD Warmup route"
          },
          shaderParam = 3,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 195,
          enableSimulationArea = false,
          isMultiplayerActor = false,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          distanceBehindPlayer = 0,
          desiredSpeed = 60,
          raceManagerRoute = false,
          routeName = "High plains drifter",
          stayInLockedArea = false,
          blockTow = false,
          previewMovie = "preview",
          avoidAttacks = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
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
            name = "Team oppo"
          },
          drivingSkill = "Reckless",
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
          driveOnPavements = 0.2,
          noOccupants = false,
          shaderParam = 0,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "HPD Warmup route"
          },
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          enableSimulationArea = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 142,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Strong",
          rubberbandingActor = "Race team 1 member 1",
          damageMultiplier = 0.7,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -50,
          desiredSpeed = 100,
          raceManagerRoute = false,
          routeName = "High plains drifter",
          stayInLockedArea = false,
          blockTow = false,
          avoidAttacks = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Race team 2 member 5"] = {
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
            name = "Team oppo"
          },
          drivingSkill = "Reckless",
          disablePanelDetach = false,
          accidentProbability = 0.001,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Maggie"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          enableSiren = false,
          driveInOncoming = 0.1,
          driveOnPavements = 0.2,
          noOccupants = false,
          shaderParam = 2,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "HPD Warmup route"
          },
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          enableSimulationArea = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 195,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Strong",
          rubberbandingActor = "Race team 1 member 1",
          damageMultiplier = 0.7,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -60,
          desiredSpeed = 100,
          raceManagerRoute = false,
          routeName = "High plains drifter",
          stayInLockedArea = false,
          blockTow = false,
          avoidAttacks = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
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
            name = "Team oppo"
          },
          drivingSkill = "Reckless",
          disablePanelDetach = false,
          accidentProbability = 0.001,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Judith"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          enableSiren = false,
          driveInOncoming = 0.1,
          driveOnPavements = 0.2,
          noOccupants = false,
          shaderParam = 0,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "HPD Warmup route"
          },
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          enableSimulationArea = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 142,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Strong",
          rubberbandingActor = "Race team 1 member 1",
          damageMultiplier = 0.7,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -25,
          desiredSpeed = 110,
          raceManagerRoute = false,
          routeName = "High plains drifter",
          stayInLockedArea = false,
          blockTow = false,
          avoidAttacks = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      Judith = {
        [1] = {
          ["Passenger id"] = "-1711350673",
          ["Driver id"] = "753978192"
        },
        ["name"] = "Character"
      },
      Michael = {
        [1] = {
          ["Passenger id"] = "1466675806",
          ["Driver id"] = "76265956"
        },
        ["name"] = "Character"
      },
      Ayumu = {
        [1] = {
          ["Passenger id"] = "759755112",
          ["Driver id"] = "2135829601"
        },
        ["name"] = "Character"
      },
      Justin = {
        [1] = {
          ["Passenger id"] = "-849424421",
          ["Driver id"] = "-1156800003"
        },
        ["name"] = "Character"
      },
      Bernado = {
        [1] = {
          ["Passenger id"] = "1760344531",
          ["Driver id"] = "-500660492"
        },
        ["name"] = "Character"
      },
      Maggie = {
        [1] = {
          ["Passenger id"] = "-1233074219",
          ["Driver id"] = "570150525"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      MissionSettings = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Disable traffic"] = false,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "High plains drifter",
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
      ["Team oppo"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Team racer"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    SpawnTypes = {
      ["New Positions"] = {
        [1] = {
          ["1"] = "Race team 2 member 5",
          ["3"] = "Race team 2 member 2",
          ["2"] = "Race team 2 member 1",
          ["5"] = "Race team 2 member 4",
          ["4"] = "Race team 2 member 3",
          ["6"] = "Race team 1 member 1"
        },
        ["name"] = "Positions"
      }
    },
    WarmupTypes = {
      ["HPD Warmup route"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          warmupRouteName = "High plains drifter",
          forceZapToVehicle = false,
          forceMissionAccept = false,
          matchTrafficSpeed = false,
          lookToVehicle = false
        },
        ["name"] = "Warmup route"
      }
    },
    FelonySettings = {
      ["New FelonySettings 2"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    MissionInfos = {
      ["Race team Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:184013",
          ["Success reason"] = "ID:184018",
          ["showRouteArrows"] = "All",
          ["Failure reason"] = "ID:184036",
          ["Pass condition"] = "ID:184016",
          ["missionMarkers"] = {
            [1] = {
              value = "Opponent",
              cardName = "Race team 2 member 4",
              cardType = "Actor"
            },
            [2] = {
              value = "Opponent",
              cardName = "Race team 2 member 3",
              cardType = "Actor"
            },
            [3] = {
              value = "Opponent",
              cardName = "Race team 2 member 1",
              cardType = "Actor"
            },
            [4] = {
              value = "Opponent",
              cardName = "Race team 2 member 2",
              cardType = "Actor"
            },
            [5] = {
              value = "Objective",
              cardName = "Race team 1 member 1",
              cardType = "Actor"
            },
            [6] = {
              value = "Opponent",
              cardName = "Race team 2 member 5",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["checkpoint race Type"] = {
        [1] = {
          ["Slow motion on goal complete"] = false,
          ["Race team 7"] = {
            instance = 1,
            type = "Teams",
            name = "Team oppo"
          },
          ["Race team 4"] = {
            instance = 1,
            type = "Teams",
            name = "Team oppo"
          },
          ["Eject if in lead"] = false,
          ["Race team 6"] = {
            instance = 1,
            type = "Teams",
            name = "Team oppo"
          },
          ["Race team 5"] = {
            instance = 1,
            type = "Teams",
            name = "Team oppo"
          },
          ["Score jump distance"] = false,
          ["Overtake target (+ score)"] = false,
          ["Race team 2"] = {
            instance = 1,
            type = "Teams",
            name = "Team oppo"
          },
          ["Score drift distance"] = true,
          ["Race team 1"] = {
            instance = 1,
            type = "Teams",
            name = "Team racer"
          },
          ["Race team 8"] = {
            instance = 1,
            type = "Teams",
            name = "Team oppo"
          },
          ["Total laps"] = 0,
          ["Hide checkpoints"] = false,
          ["Race team 3"] = {
            instance = 1,
            type = "Teams",
            name = "Team oppo"
          },
          ["Destroy opposing teams"] = true,
          ["Score to win (non task complete)"] = 3500
        },
        ["name"] = "Generic checkpoint race"
      }
    }
  }
}
