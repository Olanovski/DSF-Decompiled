cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Tanner and Jones 7"] = {
  FileVersion = "2",
  name = "Tanner and Jones 7",
  title = "ID:184081",
  MissionID = "7426",
  description = "ID:184082",
  cardInstances = {
    Actors = {
      ["Truck Start 3"] = {
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
            name = "Truck Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Goon Vehicle 1"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          tailingDistance = 0,
          driveOnPavements = 0.8,
          noOccupants = false,
          enableSimulationArea = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 0,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          enableSiren = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Truck Start 3 Position "
          },
          vehicleId = 158,
          distanceBehindPlayer = 0,
          spawnSpeed = 10,
          rubberbandingActor = "Tanner",
          damageMultiplier = 1,
          attackStationaryVehicle = true,
          driveInOncoming = 0,
          groupAggression = "Relentless",
          raceManagerRoute = false,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          avoidAlleys = 0,
          avoidAttacks = false,
          desiredSpeed = 170,
          avoidedByCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Player2"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Decoy team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Tanner Character"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0.5,
          driveOnPavements = 0.5,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New As localPlayer"
          },
          vehicleId = 62,
          vehicleTrailerId = -1,
          shaderParam = 0,
          enableSiren = true,
          enableSimulationArea = false,
          damageMultiplier = 0.3,
          attackStationaryVehicle = false,
          desiredSpeed = 100,
          stayInLockedArea = false,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          raceManagerRoute = true,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Decoy"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Decoy team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On mission start",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = true,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          vehicleTrailerId = -1,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Decoy spawn"
          },
          vehicleId = 266,
          shaderParam = 0,
          rubberbandingToPlayerStrength = "Strong",
          enableSiren = false,
          enableSimulationArea = false,
          damageMultiplier = 0,
          attackStationaryVehicle = false,
          rubberbandingStrength = "High",
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          desiredSpeed = 0,
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          raceManagerRoute = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Tanner"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 90,
          team = {
            instance = 1,
            type = "Teams",
            name = "Tanner Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          vehicleTrailerId = -1,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Tanner Character"
          },
          forceHighLodCharacters = false,
          aiIgnorePlayerInCivsUntilHit = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          enableSimulationArea = false,
          shaderParam = 0,
          tailingDistance = 15,
          driveOnPavements = 0.5,
          noOccupants = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static"
          },
          enableSiren = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Tanner position"
          },
          vehicleId = 62,
          isMultiplayerActor = false,
          rubberbandingActor = "Leila",
          distanceBehindPlayer = 15,
          damageMultiplier = 0.3,
          attackStationaryVehicle = false,
          rubberbandingStrength = "Average",
          previewMovie = "no preview",
          raceManagerRoute = true,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          ignoreCivilianTraffic = false,
          avoidAttacks = false,
          groupAggression = "Low",
          driveInOncoming = 0.5,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Leila"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 100,
          team = {
            instance = 1,
            type = "Teams",
            name = "Leila team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Leila Character"
          },
          forceHighLodCharacters = true,
          wanderType = "preferStraight",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0.9,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = true,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = true,
          vehicleTrailerId = -1,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Relative to Vehicle"
          },
          vehicleId = 203,
          shaderParam = 0,
          enableSiren = false,
          spawnSpeed = 0,
          enableSimulationArea = true,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          ignoreCivilianTraffic = false,
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Fast",
          avoidAttacks = true,
          avoidedByCivilianTraffic = true,
          ignoreOtherAis = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Truck Start 2"] = {
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
            name = "Truck Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Goon Vehicle 1"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          tailingDistance = 0,
          driveOnPavements = 0.8,
          noOccupants = false,
          enableSimulationArea = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 7,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          enableSiren = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Truck Start 2 Position "
          },
          vehicleId = 138,
          distanceBehindPlayer = 0,
          spawnSpeed = 10,
          rubberbandingActor = "Tanner",
          damageMultiplier = 1,
          attackStationaryVehicle = true,
          driveInOncoming = 0,
          groupAggression = "Relentless",
          raceManagerRoute = false,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          avoidAlleys = 0,
          avoidAttacks = false,
          desiredSpeed = 170,
          avoidedByCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Truck Start 5"] = {
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
            name = "Truck Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Goon Vehicle 1"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          tailingDistance = 0,
          driveOnPavements = 0.8,
          noOccupants = false,
          enableSimulationArea = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 0,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          enableSiren = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Truck Start 5 Position "
          },
          vehicleId = 158,
          distanceBehindPlayer = 0,
          spawnSpeed = 10,
          rubberbandingActor = "Tanner",
          damageMultiplier = 1,
          attackStationaryVehicle = true,
          driveInOncoming = 0,
          groupAggression = "Relentless",
          raceManagerRoute = false,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          avoidAlleys = 0,
          avoidAttacks = false,
          desiredSpeed = 170,
          avoidedByCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Tanner softsave"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Tanner Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Tanner Character"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          tailingDistance = 15,
          driveOnPavements = 0.5,
          noOccupants = false,
          enableSimulationArea = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 0,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          enableSiren = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Tanner softsave spawn"
          },
          vehicleId = 62,
          distanceBehindPlayer = 15,
          spawnSpeed = 70,
          rubberbandingActor = "Leila",
          damageMultiplier = 0.3,
          attackStationaryVehicle = false,
          rubberbandingStrength = "Average",
          driveInOncoming = 0.5,
          matchTrafficSpeed = false,
          raceManagerRoute = true,
          stayInLockedArea = false,
          blockTow = false,
          groupAggression = "Low",
          avoidAttacks = false,
          desiredSpeed = 90,
          avoidedByCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Truck Start 4"] = {
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
            name = "Truck Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Goon Vehicle 1"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          tailingDistance = 0,
          driveOnPavements = 0.8,
          noOccupants = false,
          enableSimulationArea = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 0,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          enableSiren = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Truck Start 4 Position "
          },
          vehicleId = 158,
          distanceBehindPlayer = 0,
          spawnSpeed = 10,
          rubberbandingActor = "Tanner",
          damageMultiplier = 1,
          attackStationaryVehicle = true,
          driveInOncoming = 0,
          groupAggression = "Relentless",
          raceManagerRoute = false,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          avoidAlleys = 0,
          avoidAttacks = false,
          desiredSpeed = 170,
          avoidedByCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Truck Start 1"] = {
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
            name = "Truck Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Goon Vehicle 1"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          tailingDistance = 0,
          driveOnPavements = 0.8,
          noOccupants = false,
          enableSimulationArea = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 7,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          enableSiren = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Truck Start 1 Position "
          },
          vehicleId = 138,
          distanceBehindPlayer = 0,
          spawnSpeed = 10,
          rubberbandingActor = "Tanner",
          damageMultiplier = 1,
          attackStationaryVehicle = true,
          driveInOncoming = 0,
          groupAggression = "Relentless",
          raceManagerRoute = false,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          avoidAlleys = 0,
          avoidAttacks = false,
          desiredSpeed = 170,
          avoidedByCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Tanner Character"] = {
        [1] = {
          ["Passenger id"] = "-1916574018",
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      },
      ["Goon Vehicle 1"] = {
        [1] = {
          ["Passenger id"] = "1200791648",
          ["Driver id"] = "-1083866763"
        },
        ["name"] = "Character"
      },
      ["Goon Vehicle 2"] = {
        [1] = {
          ["Passenger id"] = "-114664299",
          ["Driver id"] = "76265956"
        },
        ["name"] = "Character"
      },
      ["Goon Vehicle 3"] = {
        [1] = {
          ["Passenger id"] = "1200791648",
          ["Driver id"] = "-2095856815"
        },
        ["name"] = "Character"
      },
      ["Leila Character"] = {
        [1] = {
          ["Driver id"] = "1535564652"
        },
        ["name"] = "Character"
      }
    },
    SpawnTypes = {
      ["Truck Start 3 Position "] = {
        [1] = {
          ["Spawn location"] = "Tanner and Jones 7 truck 3 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Decoy spawn"] = {
        [1] = {
          ["Spawn location"] = "Tanner and Jones 7 decoy spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["New As localPlayer"] = {
        [1] = {},
        ["name"] = "As localPlayer"
      },
      ["Truck Start 4 Position "] = {
        [1] = {
          ["Spawn location"] = "Tanner and Jones 7 truck 4 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Leila Spawn"] = {
        [1] = {
          actor = "Tanner",
          whichLane = "randomLane",
          withVehicleDirection = true,
          distance = 200,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = true
        },
        ["name"] = "Relative to Vehicle"
      },
      ["Truck Start 1 Position "] = {
        [1] = {
          ["Spawn location"] = "Tanner and Jones 7 Merc 1 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Truck Start 5 Position "] = {
        [1] = {
          ["Spawn location"] = "Tanner and Jones 7 truck 5 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Tanner position"] = {
        [1] = {
          ["Spawn location"] = "Tanner and Jones 7 tanner spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["New Relative to Vehicle"] = {
        [1] = {
          actor = "Tanner",
          whichLane = "randomLane",
          withVehicleDirection = true,
          distance = 150,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = true
        },
        ["name"] = "Relative to Vehicle"
      },
      ["Tanner softsave spawn"] = {
        [1] = {
          ["Spawn location"] = "Tanner and Jones 7 tanner 2",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Truck Start 2 Position "] = {
        [1] = {
          ["Spawn location"] = "Tanner and Jones 7 Merc 2 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    Teams = {
      ["Leila team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Truck Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Tanner Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Decoy team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    FelonySettings = {
      FelonySettings = {
        [1] = {reenablePatrollingVehiclesAfterFelonyEnd = false, disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    WarmupTypes = {
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
          ["Load traffic on start"] = "Chapter 7 s",
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Disable traffic"] = false,
          ["Hud logic file"] = "Tanner and Jones 7 HUD",
          ["Cutscene at mission end"] = "ch7_leilaarrest",
          ["Enable traffic at mission end"] = true,
          ["disablePlayerIgnoring"] = false,
          ["Audio logic file"] = "Tanner and Jones Mission 7 APIP",
          ["freezeFrameOnMissionEndCutscene"] = true,
          ["Delete task object on reject preview"] = false,
          ["Start location"] = "Tanner and Jones 7 start",
          ["Enable race status prompts"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    MissionInfos = {
      ["Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:245554",
          ["Success reason"] = "ID:184245",
          ["missionMarkers"] = {
            [1] = {
              value = "None",
              cardName = "Truck Start 3",
              cardType = "Actor"
            },
            [2] = {
              value = "None",
              cardName = "Decoy",
              cardType = "Actor"
            },
            [3] = {
              value = "Red Marker, Getaway Radius",
              cardName = "Leila",
              cardType = "Actor"
            },
            [4] = {
              value = "Opponent",
              cardName = "Truck Start 1",
              cardType = "Actor"
            },
            [5] = {
              value = "Objective",
              cardName = "Tanner softsave",
              cardType = "Actor"
            },
            [6] = {
              value = "Objective",
              cardName = "Tanner",
              cardType = "Actor"
            },
            [7] = {
              value = "Opponent",
              cardName = "Truck Start 2",
              cardType = "Actor"
            },
            [8] = {
              value = "None",
              cardName = "Truck Start 4",
              cardType = "Actor"
            },
            [9] = {
              value = "None",
              cardName = "Truck Start 5",
              cardType = "Actor"
            },
            [10] = {
              value = "Blue Marker, Cop Radius",
              cardName = "Player2",
              cardType = "Actor"
            }
          },
          ["Failure reason"] = "ID:183989",
          ["3 Text"] = "ID:247341",
          ["Pass condition"] = "ID:184245",
          ["2 Text"] = "ID:246414"
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["Tanner and Jones 7"] = {
        [1] = {
          ["Truck team 1"] = {
            instance = 1,
            type = "Teams",
            name = "Truck Team"
          },
          ["Tanner team"] = {
            instance = 1,
            type = "Teams",
            name = "Tanner Team"
          },
          ["Leila team"] = {
            instance = 1,
            type = "Teams",
            name = "Leila team"
          },
          ["Decoy team"] = {
            instance = 1,
            type = "Teams",
            name = "Decoy team"
          },
          ["Damage amount for fail"] = 1
        },
        ["name"] = "Tanner and Jones 7"
      }
    }
  }
}
