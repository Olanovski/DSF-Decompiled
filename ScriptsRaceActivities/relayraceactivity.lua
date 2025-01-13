cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.RelayRaceActivity = {
  FileVersion = "2",
  name = "RelayRaceActivity",
  title = "ID:244253",
  MissionID = "23760",
  description = "ID:245571",
  cardInstances = {
    Actors = {
      ["Team 3 Racer 3"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 110,
          team = {
            instance = 1,
            type = "Teams",
            name = "Team 3"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Team 3 Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          driveInOncoming = 0.2,
          driveOnPavements = 0.5,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 6,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Team 3 Spawn"
          },
          vehicleId = 275,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Medium",
          spawnSpeed = 30,
          rubberbandingActor = "Team 1 Racer 3",
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -65,
          reactionTime = "Average",
          raceManagerRoute = false,
          routeName = "RelayRaceActivityRoute",
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          avoidAlleys = 0,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Team 1 Racer 1"] = {
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
            name = "Team 1"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          matchTrafficSpeedMultiplier = 1,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Player Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          driveInOncoming = 0.2,
          driveOnPavements = 0.2,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static to rolling"
          },
          shaderParam = 2,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Race Start"
          },
          vehicleId = 208,
          enableSimulationArea = false,
          spawnSpeed = 30,
          isMultiplayerActor = false,
          damageMultiplier = 1.1,
          attackStationaryVehicle = false,
          desiredSpeed = 70,
          matchTrafficSpeed = false,
          routeName = "RelayRaceActivityRoute",
          raceManagerRoute = true,
          stayInLockedArea = false,
          blockTow = false,
          previewMovie = "No Preview",
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Team 2 Racer 3"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 110,
          team = {
            instance = 1,
            type = "Teams",
            name = "Team 2"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Team 2 Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          distanceFromFrontOfGroup = 0,
          driveInOncoming = 0.2,
          driveOnPavements = 0.5,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 3,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Team 2 Spawn"
          },
          vehicleId = 275,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Medium",
          spawnSpeed = 30,
          rubberbandingActor = "Team 1 Racer 3",
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -70,
          reactionTime = "Average",
          raceManagerRoute = false,
          routeName = "RelayRaceActivityRoute",
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          avoidAlleys = 0,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Team 3 Racer 2"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 90,
          team = {
            instance = 1,
            type = "Teams",
            name = "Team 3"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Team 3 Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          driveInOncoming = 0.2,
          driveOnPavements = 0.5,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 3,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Team 3 Spawn"
          },
          vehicleId = 293,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Medium",
          spawnSpeed = 30,
          rubberbandingActor = "Team 1 Racer 2",
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -80,
          reactionTime = "Average",
          raceManagerRoute = false,
          routeName = "RelayRaceActivityRoute",
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          avoidAlleys = 0,
          ignoreCivilianTraffic = true,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Team 2 Racer 1"] = {
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
            name = "Team 2"
          },
          drivingSkill = "Reckless",
          disablePanelDetach = false,
          rubberBandMinVelocityTopSpeedFraction = 0.85,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Team 2 Character"
          },
          forceHighLodCharacters = false,
          vehicleTrailerId = -1,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          enableSimulationArea = false,
          shaderParam = 3,
          distanceFromFrontOfGroup = 0,
          driveInOncoming = 1,
          driveOnPavements = 1,
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
            name = "Race Start"
          },
          vehicleId = 208,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Medium",
          spawnSpeed = 40,
          rubberbandingActor = "Team 1 Racer 1",
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -150,
          desiredSpeed = 95,
          raceManagerRoute = false,
          routeName = "RelayRaceActivityRoute",
          stayInLockedArea = false,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Team 1 Racer 2"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = true,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 60,
          team = {
            instance = 1,
            type = "Teams",
            name = "Team 1"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Player Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0.2,
          driveOnPavements = 0.5,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          shaderParam = 2,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Team 1 Spawn"
          },
          vehicleId = 293,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 30,
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          raceManagerRoute = false,
          routeName = "RelayRaceActivityRoute",
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          avoidAlleys = 0,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Team 2 Racer 2"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 90,
          team = {
            instance = 1,
            type = "Teams",
            name = "Team 2"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Team 2 Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          distanceFromFrontOfGroup = 0,
          driveInOncoming = 0.2,
          driveOnPavements = 0.5,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 5,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Team 2 Spawn"
          },
          vehicleId = 293,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Medium",
          spawnSpeed = 30,
          rubberbandingActor = "Team 1 Racer 2",
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -80,
          reactionTime = "Average",
          raceManagerRoute = false,
          routeName = "RelayRaceActivityRoute",
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          avoidAlleys = 0,
          ignoreCivilianTraffic = true,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Team 1 Racer 3"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = true,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 60,
          team = {
            instance = 1,
            type = "Teams",
            name = "Team 1"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Player Character"
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
          raceManagerRoute = false,
          shaderParam = 5,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Team 1 Spawn"
          },
          vehicleId = 275,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 30,
          damageMultiplier = 1.1,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          avoidAlleys = 0,
          avoidedByCivilianTraffic = false,
          stayInLockedArea = false,
          blockTow = false,
          ignoreOtherAis = false,
          avoidAttacks = false,
          ignoreCivilianTraffic = false,
          routeName = "RelayRaceActivityRoute",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Team 3 Racer 1"] = {
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
            name = "Team 3"
          },
          drivingSkill = "Reckless",
          disablePanelDetach = false,
          rubberBandMinVelocityTopSpeedFraction = 0.85,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Team 3 Character"
          },
          forceHighLodCharacters = false,
          vehicleTrailerId = -1,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          enableSimulationArea = false,
          shaderParam = 0,
          driveInOncoming = 1,
          driveOnPavements = 1,
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
            name = "Race Start"
          },
          vehicleId = 208,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Medium",
          spawnSpeed = 40,
          rubberbandingActor = "Team 1 Racer 1",
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -140,
          desiredSpeed = 95,
          raceManagerRoute = false,
          routeName = "RelayRaceActivityRoute",
          stayInLockedArea = false,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Player Character"] = {
        [1] = {
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      },
      ["Team 2 Character"] = {
        [1] = {
          ["Driver id"] = "724947615"
        },
        ["name"] = "Character"
      },
      ["Team 3 Character"] = {
        [1] = {
          ["Driver id"] = "-1816364440"
        },
        ["name"] = "Character"
      }
    },
    SpawnTypes = {
      ["Team 2 Spawn"] = {
        [1] = {
          ["Spawn location"] = "Relay Race Activity Team 2 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Team 3 Spawn"] = {
        [1] = {
          ["Spawn location"] = "Relay Race Activity Team 3 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Team 1 Spawn"] = {
        [1] = {
          ["Spawn location"] = "Relay Race Activity Team 1 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Race Start"] = {
        [1] = {
          ["1"] = "Team 2 Racer 1",
          ["3"] = "Team 1 Racer 1",
          ["2"] = "Team 3 Racer 1"
        },
        ["name"] = "Positions"
      }
    },
    Teams = {
      ["Team 2"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Team 1"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Team 3"] = {
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
      ["New MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Enable traffic at mission end"] = true,
          ["disablePlayerIgnoring"] = false,
          ["Spawn type"] = "Always active",
          ["Delete task object on reject preview"] = false,
          ["Start location"] = "RelayRaceActivityStart",
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    MissionInfos = {
      ["New Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:245571",
          ["showRouteArrows"] = "All",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective",
              cardName = "Team 1 Racer 2",
              cardType = "Actor"
            },
            [2] = {
              value = "Opponent",
              cardName = "Team 2 Racer 1",
              cardType = "Actor"
            },
            [3] = {
              value = "Opponent",
              cardName = "Team 2 Racer 2",
              cardType = "Actor"
            },
            [4] = {
              value = "Opponent",
              cardName = "Team 3 Racer 1",
              cardType = "Actor"
            },
            [5] = {
              value = "Objective",
              cardName = "Team 1 Racer 1",
              cardType = "Actor"
            },
            [6] = {
              value = "Opponent",
              cardName = "Team 2 Racer 3",
              cardType = "Actor"
            },
            [7] = {
              value = "Opponent",
              cardName = "Team 3 Racer 3",
              cardType = "Actor"
            },
            [8] = {
              value = "Objective",
              cardName = "Team 1 Racer 3",
              cardType = "Actor"
            },
            [9] = {
              value = "Opponent",
              cardName = "Team 3 Racer 2",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Relay race activity"] = {
        [1] = {
          ["Slow motion on goal complete"] = false,
          ["Score jump distance"] = false,
          ["Overtake target (+ score)"] = false,
          ["Race team 2"] = {
            instance = 1,
            type = "Teams",
            name = "Team 3"
          },
          ["Score drift distance"] = false,
          ["Race team 1"] = {
            instance = 1,
            type = "Teams",
            name = "Team 1"
          },
          ["Destroy opposing teams"] = true,
          ["Hide checkpoints"] = false,
          ["Race team 3"] = {
            instance = 1,
            type = "Teams",
            name = "Team 2"
          },
          ["Any team member damage above"] = 1,
          ["Damage amount for fail"] = 1
        },
        ["name"] = "Relay race activity"
      }
    }
  }
}
