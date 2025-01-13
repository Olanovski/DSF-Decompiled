cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Race away"] = {
  FileVersion = "2",
  name = "Race away",
  title = "ID:184890",
  MissionID = "334",
  description = "ID:245574",
  cardInstances = {
    Actors = {
      ["cop1"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 85,
          team = {
            instance = 1,
            type = "Teams",
            name = "cop Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop 1"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Set position cop1"
          },
          ramInFrontDistance = 150,
          vehicleId = 265,
          rubberbandingToPlayerStrength = "Strong",
          enableSiren = false,
          spawnSpeed = 80,
          enableSimulationArea = false,
          shaderParam = 0,
          attackStationaryVehicle = false,
          avoidedByCivilianTraffic = false,
          reactionTime = "Fastest",
          stayInLockedArea = false,
          blockTow = false,
          raceManagerRoute = false,
          avoidAttacks = false,
          ignoreCivilianTraffic = false,
          groupAggression = "High",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["racer3"] = {
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
            name = "racer Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Racer 3"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          enableSiren = false,
          driveInOncoming = 0.1,
          driveOnPavements = 0.5,
          noOccupants = false,
          shaderParam = 4,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Race Route (Warmup)"
          },
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          enableSimulationArea = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions 2"
          },
          vehicleId = 243,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 40,
          rubberbandingActor = "player Actor",
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -25,
          desiredSpeed = 110,
          raceManagerRoute = false,
          routeName = "RaceAwayRoute",
          stayInLockedArea = false,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = true,
          avoidAlleys = 1,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["player Actor"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = true,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 85,
          team = {
            instance = 1,
            type = "Teams",
            name = "player Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Player car"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          distanceFromFrontOfGroup = 60,
          shaderParam = 1,
          vehicleTrailerId = -1,
          previewMovie = "UID00334_MPR01",
          enableSiren = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Race Route (Warmup)"
          },
          enableSimulationArea = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          ignoreOtherAis = false,
          ignoreCivilianTraffic = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions 2"
          },
          vehicleId = 216,
          rubberbandingToPlayerStrength = "Strong",
          isMultiplayerActor = false,
          spawnSpeed = 40,
          rubberbandingActor = "racer2",
          distanceBehindPlayer = 20,
          damageMultiplier = 0.3,
          attackStationaryVehicle = false,
          rubberbandingStrength = "High",
          matchTrafficSpeed = false,
          routeName = "RaceAwayRoute",
          noOccupants = false,
          stayInLockedArea = false,
          blockTow = false,
          raceManagerRoute = false,
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["racer1"] = {
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
            name = "racer Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Racer 1"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          enableSiren = false,
          driveInOncoming = 0.1,
          driveOnPavements = 0.5,
          noOccupants = false,
          shaderParam = 3,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Race Route (Warmup)"
          },
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          enableSimulationArea = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions 2"
          },
          vehicleId = 212,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 40,
          rubberbandingActor = "player Actor",
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -100,
          desiredSpeed = 110,
          raceManagerRoute = false,
          routeName = "RaceAwayRoute",
          stayInLockedArea = false,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = true,
          avoidAlleys = 1,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["cop2"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 85,
          team = {
            instance = 1,
            type = "Teams",
            name = "cop Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop 2"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Set position cop2 "
          },
          ramInFrontDistance = 150,
          vehicleId = 265,
          rubberbandingToPlayerStrength = "Strong",
          enableSiren = false,
          spawnSpeed = 80,
          enableSimulationArea = false,
          shaderParam = 0,
          attackStationaryVehicle = false,
          avoidedByCivilianTraffic = false,
          reactionTime = "Fastest",
          stayInLockedArea = false,
          blockTow = false,
          raceManagerRoute = false,
          avoidAttacks = false,
          ignoreCivilianTraffic = false,
          groupAggression = "High",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["racer2"] = {
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
            name = "racer Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          matchTrafficSpeedMultiplier = 1,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Racer 2"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          driveInOncoming = 0.1,
          driveOnPavements = 0.5,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Race Route (Warmup)"
          },
          shaderParam = 1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions 2"
          },
          vehicleId = 243,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 40,
          rubberbandingActor = "player Actor",
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = -50,
          matchTrafficSpeed = false,
          routeName = "RaceAwayRoute",
          stayInLockedArea = false,
          blockTow = false,
          raceManagerRoute = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = true,
          desiredSpeed = 110,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Racer 2"] = {
        [1] = {
          ["Passenger id"] = "-115975107",
          ["Driver id"] = "-1490034552"
        },
        ["name"] = "Character"
      },
      ["Cop 2"] = {
        [1] = {
          ["Passenger id"] = "-872299577",
          ["Driver id"] = "1307138515"
        },
        ["name"] = "Character"
      },
      ["Player car"] = {
        [1] = {
          ["Passenger id"] = "-333097352",
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      },
      ["Racer 3"] = {
        [1] = {
          ["Passenger id"] = "-1879468723",
          ["Driver id"] = "77551189"
        },
        ["name"] = "Character"
      },
      ["Cop 1"] = {
        [1] = {
          ["Passenger id"] = "-879852041",
          ["Driver id"] = "600862826"
        },
        ["name"] = "Character"
      },
      ["Racer 1"] = {
        [1] = {
          ["Passenger id"] = "536588697",
          ["Driver id"] = "-902779500"
        },
        ["name"] = "Character"
      }
    },
    SpawnTypes = {
      ["Set position cop1"] = {
        [1] = {
          ["Spawn location"] = "Race Away Cop1 Position1",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Set position cop2 "] = {
        [1] = {
          ["Spawn location"] = "Race Away Cop2 Position1",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["New Positions 2"] = {
        [1] = {
          ["1"] = "racer1",
          ["4"] = "player Actor",
          ["3"] = "racer3",
          ["2"] = "racer2"
        },
        ["name"] = "Positions"
      }
    },
    FelonySettings = {
      ["Felony Settings"] = {
        [1] = {
          onlyVehicleAbleToStartFelonies = "player Actor",
          disablePoliceInTrafficDuringMission = true,
          reenablePatrollingVehiclesAfterFelonyEnd = false
        },
        ["name"] = "FelonySettings"
      }
    },
    Teams = {
      ["cop Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["racer Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["player Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionCompletes = {
      ["Race away (Complete Text)"] = {
        [1] = {
          ["Perfect condition"] = "ID:184896",
          ["Success reason"] = "ID:184897",
          ["Failure reason"] = "ID:184894",
          ["Success reason (perfect)"] = "ID:184898",
          ["Pass condition"] = "ID:184895",
          ["Failure reason (wrecked)"] = "ID:182731"
        },
        ["name"] = "Race away"
      }
    },
    WarmupTypes = {
      ["Race Route (Warmup)"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          warmupRouteName = "raceawaywarmup",
          forceZapToVehicle = false,
          forceMissionAccept = false,
          matchTrafficSpeed = false,
          lookToVehicle = false
        },
        ["name"] = "Warmup route"
      },
      ["New Static"] = {
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
      MissionSettings = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Load traffic on start"] = "Chapter 5 Raceaway",
          ["Disable traffic"] = false,
          ["Mission props"] = "RaceAway",
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Race away start",
          ["Audio logic file"] = "Race away",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["disablePlayerIgnoring"] = false,
          ["Enable race status prompts"] = true
        },
        ["name"] = "MissionSettings"
      }
    },
    MissionInfos = {
      ["Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:184014",
          ["Success reason"] = "ID:247178",
          ["showRouteArrows"] = "All",
          ["missionMarkers"] = {
            [1] = {
              value = "Opponent",
              cardName = "racer2",
              cardType = "Actor"
            },
            [2] = {
              value = "Opponent",
              cardName = "racer1",
              cardType = "Actor"
            },
            [3] = {
              value = "Objective",
              cardName = "player Actor",
              cardType = "Actor"
            },
            [4] = {
              value = "None",
              cardName = "cop1",
              cardType = "Actor"
            },
            [5] = {
              value = "Opponent",
              cardName = "racer3",
              cardType = "Actor"
            },
            [6] = {
              value = "None",
              cardName = "cop2",
              cardType = "Actor"
            }
          },
          ["3 Text"] = "ID:184893",
          ["Success reason (perfect)"] = "ID:247177",
          ["2 Text"] = "ID:184930"
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["type Race away"] = {
        [1] = {
          ["Total laps"] = 0,
          ["Radius for evader escape win"] = 250,
          ["Race team 2"] = {
            instance = 1,
            type = "Teams",
            name = "racer Team"
          },
          ["Don't highlight starting car"] = false,
          ["Chaser eliminates all racers"] = false,
          ["Racer dont destroy chasers"] = false,
          ["Racer damage for chaser win"] = 1,
          ["Chase team"] = {
            instance = 1,
            type = "Teams",
            name = "cop Team"
          },
          ["Race team"] = {
            instance = 1,
            type = "Teams",
            name = "player Team"
          }
        },
        ["name"] = "Race away"
      }
    }
  }
}
