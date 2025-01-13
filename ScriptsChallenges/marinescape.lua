cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.MarinEscape = {
  FileVersion = "2",
  name = "MarinEscape",
  title = "ID:231200",
  MissionID = "38725",
  description = "ID:245462",
  cardInstances = {
    Actors = {
      ["Asian"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 120,
          team = {
            instance = 1,
            type = "Teams",
            name = "Opponent Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Default Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          driveInOncoming = 0.4,
          driveOnPavements = 0.2,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "MarinEscape Static"
          },
          shaderParam = 5,
          avoidUTurns = false,
          avoidedByCivilianTraffic = true,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Asian position"
          },
          vehicleId = 229,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 0,
          rubberbandingActor = "Race team 1 member 1",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = -80,
          ignoreCivilianTraffic = false,
          routeName = "MarinEscapeRoute",
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          ignoreOtherAis = false,
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
          routeName = "MarinEscapeRoute",
          team = {
            instance = 1,
            type = "Teams",
            name = "Player Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "MarinEscape Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          previewMovie = "no preview",
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "MarinEscape Static"
          },
          avoidUTurns = false,
          avoidedByCivilianTraffic = true,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          shaderParam = 0,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "player position"
          },
          vehicleId = 210,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 0,
          damageMultiplier = 0.5,
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
      },
      ["Priest"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 130,
          team = {
            instance = 1,
            type = "Teams",
            name = "Opponent Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Priest Character"
          },
          forceHighLodCharacters = true,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          driveInOncoming = 0.4,
          driveOnPavements = 0.2,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "MarinEscape Static"
          },
          shaderParam = 3,
          avoidUTurns = false,
          avoidedByCivilianTraffic = true,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Priest position"
          },
          vehicleId = 213,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 0,
          rubberbandingActor = "Race team 1 member 1",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = -120,
          ignoreCivilianTraffic = false,
          routeName = "MarinEscapeRoute",
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          ignoreOtherAis = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Arab"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 110,
          team = {
            instance = 1,
            type = "Teams",
            name = "Opponent Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Default Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          driveInOncoming = 0.4,
          driveOnPavements = 0.2,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "MarinEscape Static"
          },
          shaderParam = 1,
          avoidUTurns = false,
          avoidedByCivilianTraffic = true,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Arab position"
          },
          vehicleId = 300,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 0,
          rubberbandingActor = "Race team 1 member 1",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = -90,
          ignoreCivilianTraffic = false,
          routeName = "MarinEscapeRoute",
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          ignoreOtherAis = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Aston"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 110,
          team = {
            instance = 1,
            type = "Teams",
            name = "Opponent Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Default Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          driveInOncoming = 0.4,
          driveOnPavements = 0.2,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "MarinEscape Static"
          },
          shaderParam = 2,
          avoidUTurns = false,
          avoidedByCivilianTraffic = true,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Aston position"
          },
          vehicleId = 132,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 0,
          rubberbandingActor = "Race team 1 member 1",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = -70,
          ignoreCivilianTraffic = false,
          routeName = "MarinEscapeRoute",
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          ignoreOtherAis = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Ambulance"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = true,
          desiredSpeed = 100,
          team = {
            instance = 1,
            type = "Teams",
            name = "Opponent Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Default Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          driveInOncoming = 0.4,
          driveOnPavements = 0.2,
          noOccupants = false,
          enableSiren = true,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "MarinEscape Static"
          },
          shaderParam = 0,
          avoidUTurns = false,
          avoidedByCivilianTraffic = true,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Ambulance position"
          },
          vehicleId = 276,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 0,
          rubberbandingActor = "Race team 1 member 1",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = -60,
          ignoreCivilianTraffic = false,
          routeName = "MarinEscapeRoute",
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          ignoreOtherAis = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Priest Character"] = {
        [1] = {
          ["Passenger id"] = "-1",
          ["Driver id"] = "-1399067545"
        },
        ["name"] = "Character"
      },
      ["Default Character"] = {
        [1] = {
          ["Passenger id"] = "-1",
          ["Driver id"] = "1989331258"
        },
        ["name"] = "Character"
      },
      ["MarinEscape Character"] = {
        [1] = {
          ["Passenger id"] = "-1662061033",
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      ["MarinEscape MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = true,
          ["Spawn type"] = "Always active",
          ["Disable traffic"] = false,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "MarinEscapeStart",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = true,
          ["disablePlayerIgnoring"] = false,
          ["Enable race status prompts"] = true
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["Opponent Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Player Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    SpawnTypes = {
      ["Asian position"] = {
        [1] = {
          ["Spawn location"] = "MarinEscapeAsianSpawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["New Positions"] = {
        [1] = {
          ["1"] = "Ambulance",
          ["3"] = "Aston",
          ["2"] = "Arab",
          ["5"] = "Priest",
          ["4"] = "Asian",
          ["6"] = "Race team 1 member 1"
        },
        ["name"] = "Positions"
      },
      ["player position"] = {
        [1] = {
          ["Spawn location"] = "MarinEscapeSpawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Arab position"] = {
        [1] = {
          ["Spawn location"] = "MarinEscapeArabSpawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Priest position"] = {
        [1] = {
          ["Spawn location"] = "MarinEscapePriestSpawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Ambulance position"] = {
        [1] = {
          ["Spawn location"] = "MarinEscapeAmbulanceSpawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Aston position"] = {
        [1] = {
          ["Spawn location"] = "MarinEscapeAstonSpawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    WarmupTypes = {
      ["MarinEscape Static"] = {
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
      ["New FelonySettings"] = {
        [1] = {reenablePatrollingVehiclesAfterFelonyEnd = false, disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    MissionInfos = {
      ["MarinEscape Title"] = {
        [1] = {
          ["1 Text"] = "ID:245928",
          ["Success reason"] = "ID:245589",
          ["showRouteArrows"] = "All",
          ["missionMarkers"] = {
            [1] = {
              value = "Opponent",
              cardName = "Asian",
              cardType = "Actor"
            },
            [2] = {
              value = "Objective",
              cardName = "Race team 1 member 1",
              cardType = "Actor"
            },
            [3] = {
              value = "Opponent",
              cardName = "Priest",
              cardType = "Actor"
            },
            [4] = {
              value = "Opponent",
              cardName = "Arab",
              cardType = "Actor"
            },
            [5] = {
              value = "Opponent",
              cardName = "Ambulance",
              cardType = "Actor"
            },
            [6] = {
              value = "Opponent",
              cardName = "Aston",
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
          ["Destroy opposing teams"] = false,
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
            name = "Player Team"
          },
          ["Damage amount for fail"] = 1,
          ["Hide checkpoints"] = false,
          ["scoringType"] = "Time",
          ["Start prompt"] = "ID:245928",
          ["Checkpoint type"] = "Checkpoint Gate"
        },
        ["name"] = "Generic challenge race"
      }
    }
  }
}
