cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Epilogue pt 2"] = {
  FileVersion = "2",
  name = "Epilogue pt 2",
  title = "ID:186378",
  MissionID = "6931",
  description = "ID:186378",
  cardInstances = {
    Actors = {
      ["Ramp truck"] = {
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
            name = "Static"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          noOccupants = true,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Rampers set position"
          },
          vehicleId = 298,
          attackStationaryVehicle = false,
          enableSiren = true,
          enableSimulationArea = false,
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
      ["Emergency convoy cop 2"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 50,
          team = {
            instance = 1,
            type = "Teams",
            name = "Drive by team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Random characters"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0.5,
          driveOnPavements = 0.2,
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
            name = "Emergency Convoy Positions"
          },
          vehicleId = 271,
          vehicleTrailerId = -1,
          enableSiren = true,
          enableSimulationArea = false,
          shaderParam = 0,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          routeName = "Epilogue Emergency Route",
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          ignoreOtherAis = false,
          ignoreCivilianTraffic = false,
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
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Tanner team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Tanner character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Cutscene"
          },
          shaderParam = 4,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 158,
          enableSimulationArea = false,
          isMultiplayerActor = false,
          spawnSpeed = 30,
          damageMultiplier = 0.3,
          attackStationaryVehicle = false,
          desiredSpeed = 0,
          raceManagerRoute = false,
          routeName = "Epilogue jericho",
          stayInLockedArea = false,
          blockTow = false,
          previewMovie = " ",
          avoidAttacks = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Tanker explode"] = {
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
            name = "Static"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On mission start",
          vehicleTrailerId = -1,
          noOccupants = true,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Tanker explode position"
          },
          vehicleId = 291,
          attackStationaryVehicle = false,
          enableSiren = true,
          enableSimulationArea = false,
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
      ["RoadblockJackknife"] = {
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
            name = "Static"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = 123,
          noOccupants = true,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Roadblock jackknife"
          },
          vehicleId = 286,
          attackStationaryVehicle = false,
          enableSiren = true,
          enableSimulationArea = false,
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
      ["RoadblockTanker"] = {
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
            name = "Static"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          noOccupants = true,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Roadblock Tanker"
          },
          vehicleId = 291,
          attackStationaryVehicle = false,
          enableSiren = true,
          enableSimulationArea = false,
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
      ["Jericho"] = {
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
            name = "Jericho team"
          },
          drivingSkill = "Reckless",
          disablePanelDetach = false,
          maxAllowedDamage = 0.8,
          accidentProbability = 0,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Jericho character"
          },
          forceHighLodCharacters = true,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On mission start",
          vehicleTrailerId = -1,
          distanceFromFrontOfGroup = 0,
          driveInOncoming = 0.5,
          driveOnPavements = 0.5,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 0,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Relative to Vehicle"
          },
          vehicleId = 181,
          enableSimulationArea = true,
          rubberbandingToPlayerStrength = "Medium",
          spawnSpeed = 40,
          rubberbandingActor = "Tanner",
          damageMultiplier = 1.7,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -20,
          collisionResilience = "Unstoppable",
          routeName = "Epilogue jericho",
          raceManagerRoute = true,
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Fast",
          avoidAttacks = false,
          desiredSpeed = 90,
          aiIgnorePlayerInCivsUntilHit = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Emergency convoy cop"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 75,
          team = {
            instance = 1,
            type = "Teams",
            name = "Drive by team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Random characters"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0.5,
          driveOnPavements = 0.2,
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
            name = "Emergency Convoy Positions"
          },
          vehicleId = 271,
          vehicleTrailerId = -1,
          enableSiren = true,
          enableSimulationArea = false,
          shaderParam = 0,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          routeName = "Epilogue Emergency Route",
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          ignoreOtherAis = false,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Cop Explode"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Cop Team"
          },
          drivingSkill = "Reckless",
          disablePanelDetach = false,
          accidentProbability = 0,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 0,
          driveOnPavements = 0.2,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          vehicleId = 286,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Epilogue Cop Explode"
          },
          ramInFrontDistance = 200,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 80,
          shaderParam = 4,
          attackStationaryVehicle = true,
          groupAggression = "DejaVu",
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          driveInOncoming = 0.2,
          avoidAttacks = false,
          desiredSpeed = 100,
          avoidedByCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Headon1"] = {
        [1] = {
          noOccupants = false,
          lockedToPlayer = false,
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          matchTrafficSpeed = false,
          vehicleId = 149,
          avoidedByCivilianTraffic = false,
          aiIgnorePlayers = false,
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Headon 1 Spawn"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "HeadonTeam"
          },
          avoidUTurns = false,
          drivingSkill = "Average",
          enableSiren = false,
          spawnSpeed = 80,
          desiredSpeed = 100,
          ramInFrontDistance = 0,
          reactionTime = "Slow",
          attackStationaryVehicle = false,
          forceHighLodCharacters = false,
          enableSimulationArea = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          stayInLockedArea = false,
          whenSpawned = "Never",
          collisionResilience = "Average",
          avoidAttacks = false,
          maintainLane = false,
          driveInOncoming = 0,
          driveOnPavements = 0
        },
        ["name"] = "Actor"
      },
      ["Emergency convoy ambulance"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 60,
          team = {
            instance = 1,
            type = "Teams",
            name = "Drive by team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Random characters"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0.5,
          driveOnPavements = 0.2,
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
            name = "Emergency Convoy Positions"
          },
          vehicleId = 276,
          vehicleTrailerId = -1,
          enableSiren = true,
          enableSimulationArea = false,
          shaderParam = 0,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          routeName = "Epilogue Emergency Route",
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          ignoreOtherAis = false,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Random characters"] = {
        [1] = {
          ["Driver id"] = "-1840058621",
          ["Behind driver id"] = "-1"
        },
        ["name"] = "Character"
      },
      ["Jericho character"] = {
        [1] = {
          ["Driver id"] = "-376150524"
        },
        ["name"] = "Character"
      },
      ["Tanner character"] = {
        [1] = {
          ["Driver id"] = "-673381849",
          ["Behind driver id"] = "-1"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      ["New MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = true,
          ["Spawn type"] = "Always active",
          ["Disable traffic"] = false,
          ["Clear area around vehicles"] = 100,
          ["Cutscene at mission end"] = "ch9_finale_03",
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Epilogue part 2",
          ["Audio logic file"] = "Epilogue APIP",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["disablePlayerIgnoring"] = false,
          ["Enable race status prompts"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    SpawnTypes = {
      ["Emergency Convoy Positions"] = {
        [1] = {
          ["1"] = "Emergency convoy cop",
          ["alternateLocation"] = "Epilogue emergency convoy",
          ["3"] = "Emergency convoy cop 2",
          ["2"] = "Emergency convoy ambulance"
        },
        ["name"] = "Positions"
      },
      ["Roadblock jackknife"] = {
        [1] = {
          ["Spawn location"] = "Epilogue jackknife",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Roadblock Tanker"] = {
        [1] = {
          ["Spawn location"] = "Epilogue RoadBlock Tanker",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Tanker explode position"] = {
        [1] = {
          ["Spawn location"] = "Exploding truck 01",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["New Relative to Vehicle"] = {
        [1] = {
          actor = "Tanner",
          whichLane = "randomLane",
          withVehicleDirection = true,
          distance = 30,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = true
        },
        ["name"] = "Relative to Vehicle"
      },
      ["New Positions"] = {
        [1] = {
          ["1"] = "Tanner"
        },
        ["name"] = "Positions"
      },
      ["Tanner spawn"] = {
        [1] = {
          ["Spawn location"] = "Epilogue part 2 tanner",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Rampers set position"] = {
        [1] = {
          ["Spawn location"] = "Ramp truck 01",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Epilogue Cop Explode"] = {
        [1] = {
          ["Spawn location"] = "Epilogue Cop Explode",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Headon 1 Spawn"] = {
        [1] = {
          ["Spawn location"] = "Headon 1 Spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Jericho Set position"] = {
        [1] = {
          ["Spawn location"] = "Epilogue part 2 jericho",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    Teams = {
      ["Jericho team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Tanner team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Drive by team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Static"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["HeadonTeam"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Cop Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionCompletes = {
      ["New Epilogue pt 2 complete"] = {
        [1] = {},
        ["name"] = "Epilogue pt 2"
      }
    },
    WarmupTypes = {
      ["New Static"] = {
        [1] = {forceZapToVehicle = true, lookToVehicle = false},
        ["name"] = "Static"
      },
      ["New Cutscene"] = {
        [1] = {forceMissionAccept = true},
        ["name"] = "Cutscene"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {reenablePatrollingVehiclesAfterFelonyEnd = false, disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    MissionInfos = {
      ["EPILOGUE PT 2"] = {
        [1] = {
          ["1 Text"] = "ID:186300",
          ["missionMarkers"] = {
            [1] = {
              value = "None",
              cardName = "Emergency convoy cop 2",
              cardType = "Actor"
            },
            [2] = {
              value = "None",
              cardName = "Cop Explode",
              cardType = "Actor"
            },
            [3] = {
              value = "None",
              cardName = "RoadblockJackknife",
              cardType = "Actor"
            },
            [4] = {
              value = "Red Marker, Getaway Radius",
              cardName = "Jericho",
              cardType = "Actor"
            },
            [5] = {
              value = "Objective",
              cardName = "Tanner",
              cardType = "Actor"
            },
            [6] = {
              value = "None",
              cardName = "Emergency convoy ambulance",
              cardType = "Actor"
            },
            [7] = {
              value = "None",
              cardName = "Emergency convoy cop",
              cardType = "Actor"
            },
            [8] = {
              value = "None",
              cardName = "Headon1",
              cardType = "Actor"
            },
            [9] = {
              value = "None",
              cardName = "RoadblockTanker",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Epilogue pt 2"] = {
        [1] = {
          ["Jericho team"] = {
            instance = 1,
            type = "Teams",
            name = "Jericho team"
          },
          ["Tanner team"] = {
            instance = 1,
            type = "Teams",
            name = "Tanner team"
          },
          ["Cop team"] = {
            instance = 1,
            type = "Teams",
            name = "Cop Team"
          },
          ["Drive by team"] = {
            instance = 1,
            type = "Teams",
            name = "Drive by team"
          },
          ["Headon team"] = {
            instance = 1,
            type = "Teams",
            name = "HeadonTeam"
          },
          ["Static"] = {
            instance = 1,
            type = "Teams",
            name = "Static"
          }
        },
        ["name"] = "Epilogue pt 2"
      }
    }
  }
}
