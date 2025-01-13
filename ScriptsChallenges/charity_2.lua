cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Charity 2"] = {
  FileVersion = "2",
  name = "Charity 2",
  title = "ID:242165",
  MissionID = "13134",
  description = "ID:245454",
  cardInstances = {
    Actors = {
      ["Spawner 3"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Spawner Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          tailingDistance = 0,
          driveOnPavements = 0.2,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 6,
          avoidUTurns = false,
          groupAggression = "High",
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Relative to Car 4 Vehicle"
          },
          vehicleId = 288,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Medium",
          spawnSpeed = 100,
          rubberbandingActor = "Car 4",
          damageMultiplier = 2,
          attackStationaryVehicle = false,
          distanceBehindPlayer = 10,
          driveInOncoming = 0.2,
          raceManagerRoute = false,
          reactionTime = "Fast",
          stayInLockedArea = false,
          blockTow = false,
          desiredSpeed = 130,
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          aiIgnorePlayerInCivsUntilHit = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Car 2"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Car team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Tanner Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Set position - car 2"
          },
          vehicleId = 274,
          shaderParam = 3,
          enableSiren = false,
          damageMultiplier = 0.9,
          attackStationaryVehicle = false,
          enableSimulationArea = false,
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
      ["Car 3"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Car team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Tanner Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
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
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Set position - car 3"
          },
          vehicleId = 142,
          spawnSpeed = 0,
          enableSiren = false,
          enableSimulationArea = false,
          damageMultiplier = 1.1,
          attackStationaryVehicle = false,
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          ignoreOtherAis = false,
          reactionTime = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Truck 4"] = {
        [1] = {
          trailerPanelSet = 1,
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = true,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          desiredSpeed = 30,
          team = {
            instance = 1,
            type = "Teams",
            name = "Truck team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = true,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = true,
          trailerShaderParam = 1,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          vehicleTrailerId = 289,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Set position - Truck 4"
          },
          vehicleId = 286,
          shaderParam = 6,
          enableSiren = false,
          spawnSpeed = 10,
          enableSimulationArea = true,
          damageMultiplier = 0.2,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          raceManagerRoute = false,
          stayInLockedArea = true,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          avoidAlleys = 0,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Truck 3"] = {
        [1] = {
          trailerPanelSet = 1,
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          desiredSpeed = 30,
          team = {
            instance = 1,
            type = "Teams",
            name = "Truck team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = 289,
          avoidUTurns = true,
          trailerShaderParam = 1,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          shaderParam = 6,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Set position - Truck 3"
          },
          vehicleId = 286,
          enableSiren = false,
          enableSimulationArea = true,
          spawnSpeed = 10,
          damageMultiplier = 0.2,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          aiIgnorePlayerInCivsUntilHit = false,
          routeName = "Charity 2 truck 4 route",
          stayInLockedArea = true,
          blockTow = false,
          avoidAlleys = 0,
          avoidAttacks = false,
          ignoreOtherAis = false,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Car 1"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Car team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Tanner Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          previewMovie = "no preview",
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Static"
          },
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Set position - car 1"
          },
          vehicleId = 202,
          shaderParam = 0,
          enableSiren = false,
          spawnSpeed = 0,
          enableSimulationArea = false,
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          noOccupants = false,
          avoidAttacks = false,
          reactionTime = "Average",
          aiIgnorePlayerInCivsUntilHit = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Spawner 1"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Spawner Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          tailingDistance = 0,
          driveOnPavements = 0.2,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 6,
          avoidUTurns = false,
          groupAggression = "High",
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Relative to Car 4 Vehicle"
          },
          vehicleId = 288,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 100,
          rubberbandingActor = "Car 4",
          damageMultiplier = 2,
          attackStationaryVehicle = false,
          distanceBehindPlayer = 6,
          driveInOncoming = 0.2,
          raceManagerRoute = false,
          reactionTime = "Fast",
          stayInLockedArea = true,
          blockTow = false,
          desiredSpeed = 130,
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          aiIgnorePlayerInCivsUntilHit = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Spawner 2"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Spawner Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          tailingDistance = 0,
          driveOnPavements = 0.2,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 6,
          avoidUTurns = false,
          groupAggression = "High",
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Relative to Car 4 Vehicle"
          },
          vehicleId = 288,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Medium",
          spawnSpeed = 100,
          rubberbandingActor = "Car 4",
          damageMultiplier = 2,
          attackStationaryVehicle = false,
          distanceBehindPlayer = 8,
          driveInOncoming = 0.2,
          raceManagerRoute = false,
          reactionTime = "Fast",
          stayInLockedArea = false,
          blockTow = false,
          desiredSpeed = 130,
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          aiIgnorePlayerInCivsUntilHit = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Truck 1"] = {
        [1] = {
          trailerPanelSet = 1,
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          desiredSpeed = 30,
          team = {
            instance = 1,
            type = "Teams",
            name = "Truck team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On mission start",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          trailerShaderParam = 1,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          vehicleTrailerId = 289,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Set position - Truck 1"
          },
          vehicleId = 286,
          shaderParam = 6,
          enableSiren = false,
          spawnSpeed = 10,
          enableSimulationArea = true,
          damageMultiplier = 0.2,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          avoidAlleys = 0,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Car 4"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Car team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Tanner Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
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
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Set position - car 4"
          },
          vehicleId = 200,
          shaderParam = 2,
          spawnSpeed = 40,
          enableSiren = false,
          enableSimulationArea = false,
          damageMultiplier = 0.8,
          attackStationaryVehicle = false,
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          ignoreOtherAis = false,
          reactionTime = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Truck 2"] = {
        [1] = {
          trailerPanelSet = 1,
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          desiredSpeed = 30,
          team = {
            instance = 1,
            type = "Teams",
            name = "Truck team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          trailerShaderParam = 1,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          vehicleTrailerId = 289,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Set position - Truck 2"
          },
          vehicleId = 286,
          shaderParam = 6,
          enableSiren = false,
          spawnSpeed = 10,
          enableSimulationArea = true,
          damageMultiplier = 0.2,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          avoidAlleys = 0,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Tanner Character"] = {
        [1] = {
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      }
    },
    FelonySettings = {
      ["Felony Settings"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    SpawnTypes = {
      ["Set position - Truck 3"] = {
        [1] = {
          ["Spawn location"] = "Charity 2 truck 3 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Set position - Truck 1"] = {
        [1] = {
          ["Spawn location"] = "Charity 2 truck 1 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Relative to Car 4 Vehicle"] = {
        [1] = {
          actor = "Car 4",
          whichLane = "randomLane",
          withVehicleDirection = true,
          distance = 80,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = false
        },
        ["name"] = "Relative to Vehicle"
      },
      ["Set position - car 4"] = {
        [1] = {
          ["Spawn location"] = "Charity 2 car 4 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Set position - car 2"] = {
        [1] = {
          ["Spawn location"] = "Charity 2 car 2 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Set position - car 3"] = {
        [1] = {
          ["Spawn location"] = "Charity 2 car 3 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Set position - Truck 4"] = {
        [1] = {
          ["Spawn location"] = "Charity 2 truck 4 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Set position - Truck 2"] = {
        [1] = {
          ["Spawn location"] = "Charity 2 truck 2 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Set position - car 1"] = {
        [1] = {
          ["Spawn location"] = "Charity 2 car 1 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    Teams = {
      ["Truck team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Car team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Spawner Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionCompletes = {
      ["Charity 2 complete"] = {
        [1] = {
          ["Perfect condition"] = "ID:184833",
          ["Pass condition"] = "ID:184832",
          ["Success reason (perfect)"] = "ID:221950"
        },
        ["name"] = "Charity 2"
      }
    },
    WarmupTypes = {
      Static = {
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
          ["Disable traffic"] = false,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Charity 2 start",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["disablePlayerIgnoring"] = false,
          ["Enable race status prompts"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    MissionInfos = {
      ["New Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:234229",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective (No light trails/health)",
              cardName = "Truck 2",
              cardType = "Actor"
            },
            [2] = {
              value = "None",
              cardName = "Car 4",
              cardType = "Actor"
            },
            [3] = {
              value = "Opponent",
              cardName = "Spawner 1",
              cardType = "Actor"
            },
            [4] = {
              value = "Opponent",
              cardName = "Spawner 2",
              cardType = "Actor"
            },
            [5] = {
              value = "Objective (No light trails/health)",
              cardName = "Truck 1",
              cardType = "Actor"
            },
            [6] = {
              value = "None",
              cardName = "Car 3",
              cardType = "Actor"
            },
            [7] = {
              value = "Opponent",
              cardName = "Spawner 3",
              cardType = "Actor"
            },
            [8] = {
              value = "None",
              cardName = "Car 2",
              cardType = "Actor"
            },
            [9] = {
              value = "None",
              cardName = "Car 1",
              cardType = "Actor"
            },
            [10] = {
              value = "Objective (No light trails/health)",
              cardName = "Truck 4",
              cardType = "Actor"
            },
            [11] = {
              value = "Objective (No light trails/health)",
              cardName = "Truck 3",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["Charity 2 type"] = {
        [1] = {
          ["Truck team"] = {
            instance = 1,
            type = "Teams",
            name = "Truck team"
          },
          ["Spawner team"] = {
            instance = 1,
            type = "Teams",
            name = "Spawner Team"
          },
          ["Car team"] = {
            instance = 1,
            type = "Teams",
            name = "Car team"
          }
        },
        ["name"] = "Charity 2"
      }
    }
  }
}
