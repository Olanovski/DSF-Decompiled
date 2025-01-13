cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.RaceAwayActivity2 = {
  FileVersion = "2",
  name = "RaceAwayActivity2",
  title = "ID:244251",
  MissionID = "20176",
  description = "ID:245574",
  cardInstances = {
    Actors = {
      ["Cop1"] = {
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
            name = "Cop character"
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
      ["Rolling cop"] = {
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
            name = "Cop character"
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
            name = "Rolling cop position"
          },
          ramInFrontDistance = 150,
          vehicleId = 265,
          rubberbandingToPlayerStrength = "Strong",
          enableSiren = false,
          spawnSpeed = 150,
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
          rubberBandMinVelocityTopSpeedFraction = 0.7,
          matchTrafficSpeedMultiplier = 1,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Racer 2"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          driveInOncoming = 0.1,
          driveOnPavements = 0.5,
          noOccupants = false,
          enableSimulationArea = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static to rolling"
          },
          shaderParam = 4,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          enableSiren = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions 2"
          },
          vehicleId = 248,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 40,
          rubberbandingActor = "player Actor",
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = -50,
          matchTrafficSpeed = false,
          routeName = "RaceAwayActivity2",
          stayInLockedArea = false,
          blockTow = false,
          raceManagerRoute = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = true,
          desiredSpeed = 120,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Fake cop 2"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Fake cop team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 0,
          driveOnPavements = 0.4,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Relative to racer 2"
          },
          ramInFrontDistance = 150,
          vehicleTrailerId = -1,
          vehicleId = 265,
          enableSiren = false,
          spawnSpeed = 80,
          enableSimulationArea = false,
          shaderParam = 0,
          attackStationaryVehicle = false,
          avoidedByCivilianTraffic = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          groupAggression = "High",
          desiredSpeed = 100,
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
          rubberBandMinVelocityTopSpeedFraction = 0.72,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Racer 1"
          },
          forceHighLodCharacters = false,
          vehicleTrailerId = -1,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          enableSimulationArea = false,
          shaderParam = 2,
          driveInOncoming = 0.1,
          driveOnPavements = 0.5,
          noOccupants = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static to rolling"
          },
          enableSiren = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions 2"
          },
          vehicleId = 126,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 40,
          rubberbandingActor = "player Actor",
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -25,
          desiredSpeed = 120,
          raceManagerRoute = false,
          routeName = "RaceAwayActivity2",
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
      ["Fake cop 1"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Fake cop team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 0,
          driveOnPavements = 0.4,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Relative to racer 1"
          },
          ramInFrontDistance = 150,
          vehicleTrailerId = -1,
          vehicleId = 265,
          enableSiren = false,
          spawnSpeed = 80,
          enableSimulationArea = false,
          shaderParam = 0,
          attackStationaryVehicle = false,
          avoidedByCivilianTraffic = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          groupAggression = "High",
          desiredSpeed = 100,
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
          desiredSpeed = 100,
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
          shaderParam = 5,
          distanceBehindPlayer = 20,
          enableSimulationArea = false,
          vehicleTrailerId = -1,
          previewMovie = "Preview",
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static to rolling"
          },
          enableSiren = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions 2"
          },
          vehicleId = 135,
          rubberbandingToPlayerStrength = "Medium",
          spawnSpeed = 30,
          rubberbandingActor = "racer2",
          isMultiplayerActor = false,
          damageMultiplier = 0.3,
          attackStationaryVehicle = false,
          ignoreCivilianTraffic = false,
          matchTrafficSpeed = false,
          routeName = "RaceAwayActivity2",
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
      ["Cop character"] = {
        [1] = {
          ["Passenger id"] = "-1",
          ["Driver id"] = "105509604"
        },
        ["name"] = "Character"
      },
      ["Player car"] = {
        [1] = {
          ["Passenger id"] = "-1",
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
      ["Racer 1"] = {
        [1] = {
          ["Passenger id"] = "536588697",
          ["Driver id"] = "-902779500"
        },
        ["name"] = "Character"
      }
    },
    SpawnTypes = {
      ["Relative to racer 3"] = {
        [1] = {
          withVehicleDirection = true,
          whichLane = "randomLane",
          distance = 10,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = false
        },
        ["name"] = "Relative to Vehicle"
      },
      ["Relative to racer 1"] = {
        [1] = {
          actor = "racer1",
          whichLane = "randomLane",
          withVehicleDirection = true,
          distance = 10,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = false
        },
        ["name"] = "Relative to Vehicle"
      },
      ["Rolling cop position"] = {
        [1] = {
          ["Spawn location"] = "Race away activity 2 rolling cop start",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["New Positions 2"] = {
        [1] = {
          ["1"] = "racer1",
          ["3"] = "player Actor",
          ["2"] = "racer2"
        },
        ["name"] = "Positions"
      },
      ["Set position cop1"] = {
        [1] = {
          ["Spawn location"] = "Race away activity 2 cop start",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Relative to racer 2"] = {
        [1] = {
          actor = "racer2",
          whichLane = "randomLane",
          withVehicleDirection = true,
          distance = 10,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = false
        },
        ["name"] = "Relative to Vehicle"
      }
    },
    Teams = {
      ["cop Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Fake cop team"] = {
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
    FelonySettings = {
      ["Felony Settings"] = {
        [1] = {reenablePatrollingVehiclesAfterFelonyEnd = true, disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    WarmupTypes = {
      ["New Static to rolling"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          forceZapToVehicle = false,
          forceMissionAccept = false,
          lookToVehicle = false
        },
        ["name"] = "Static to rolling"
      }
    },
    MissionSettings = {
      MissionSettings = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Disable traffic"] = false,
          ["Mission props"] = "RaceAway",
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Race away activity 2 start",
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
          ["showRouteArrows"] = "All",
          ["missionMarkers"] = {
            [1] = {
              value = "None",
              cardName = "Fake cop 1",
              cardType = "Actor"
            },
            [2] = {
              value = "None",
              cardName = "Fake cop 2",
              cardType = "Actor"
            },
            [3] = {
              value = "Opponent",
              cardName = "racer2",
              cardType = "Actor"
            },
            [4] = {
              value = "None",
              cardName = "Cop1",
              cardType = "Actor"
            },
            [5] = {
              value = "Opponent",
              cardName = "racer1",
              cardType = "Actor"
            },
            [6] = {
              value = "Objective",
              cardName = "player Actor",
              cardType = "Actor"
            }
          },
          ["3 Text"] = "ID:184893",
          ["2 Text"] = "ID:184930"
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Race away challenge"] = {
        [1] = {
          ["Chase team"] = {
            instance = 1,
            type = "Teams",
            name = "cop Team"
          },
          ["Race team"] = {
            instance = 1,
            type = "Teams",
            name = "player Team"
          },
          ["Total laps"] = 0,
          ["Fake cop team"] = {
            instance = 1,
            type = "Teams",
            name = "Fake cop team"
          },
          ["Race team 2"] = {
            instance = 1,
            type = "Teams",
            name = "racer Team"
          }
        },
        ["name"] = "Race away challenge"
      }
    }
  }
}
