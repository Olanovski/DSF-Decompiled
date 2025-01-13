cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.TankerOnFireActivity1 = {
  FileVersion = "2",
  name = "TankerOnFireActivity1",
  title = "ID:244221",
  MissionID = "25808",
  description = "ID:245560",
  cardInstances = {
    Actors = {
      ["Tanker1"] = {
        [1] = {
          lockedToPlayer = true,
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
            name = "Tanker Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Tankers"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On mission start",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = true,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Tanker1 spawn"
          },
          vehicleId = 286,
          vehicleTrailerId = 131,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 50,
          shaderParam = 0,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          raceManagerRoute = false,
          routeName = "Tanker on fire activity 1 tanker 1",
          stayInLockedArea = true,
          blockTow = false,
          avoidedByCivilianTraffic = true,
          avoidAttacks = false,
          avoidAlleys = 1,
          ignoreCivilianTraffic = true,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Fire team member 2"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = true,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 35,
          team = {
            instance = 1,
            type = "Teams",
            name = "Fire team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Fire truck 2"
          },
          forceHighLodCharacters = false,
          wanderType = "preferLeft",
          selfRightIfOverturned = false,
          maintainLane = true,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = true,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          vehicleTrailerId = -1,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Truck 2 Position"
          },
          vehicleId = 186,
          enableSiren = true,
          enableSimulationArea = true,
          damageMultiplier = 1.2,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          raceManagerRoute = false,
          routeName = "Tanker 1 Route",
          stayInLockedArea = true,
          blockTow = false,
          avoidedByCivilianTraffic = true,
          avoidAttacks = false,
          avoidAlleys = 0,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Tanker2"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 0,
          team = {
            instance = 1,
            type = "Teams",
            name = "Tanker Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Tankers"
          },
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
          avoidUTurns = true,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Tanker2 spawn"
          },
          vehicleId = 286,
          vehicleTrailerId = 131,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 0,
          shaderParam = 0,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          raceManagerRoute = false,
          routeName = "Tanker on fire activity 1 tanker",
          stayInLockedArea = true,
          blockTow = false,
          avoidedByCivilianTraffic = true,
          avoidAttacks = false,
          avoidAlleys = 1,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Tanker3"] = {
        [1] = {
          lockedToPlayer = true,
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
            name = "Tanker Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Tankers"
          },
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
          avoidUTurns = true,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Tanker3 spawn"
          },
          vehicleId = 286,
          vehicleTrailerId = 131,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 50,
          shaderParam = 0,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          raceManagerRoute = false,
          routeName = "Tanker on fire activity 1 tanker",
          stayInLockedArea = true,
          blockTow = false,
          avoidedByCivilianTraffic = true,
          avoidAttacks = false,
          avoidAlleys = 1,
          ignoreCivilianTraffic = true,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Fire team member 3"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 30,
          team = {
            instance = 1,
            type = "Teams",
            name = "Fire team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Fire truck 2"
          },
          forceHighLodCharacters = false,
          wanderType = "preferLeft",
          selfRightIfOverturned = false,
          maintainLane = true,
          whenSpawned = "Never",
          tailingDistance = 30,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = true,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Relative to Tanker 5"
          },
          vehicleId = 186,
          enableSiren = true,
          enableSimulationArea = false,
          spawnSpeed = 30,
          damageMultiplier = 1.2,
          attackStationaryVehicle = false,
          driveInOncoming = 0,
          matchTrafficSpeed = true,
          routeName = "Tanker on fire activity 1 tanker",
          raceManagerRoute = false,
          stayInLockedArea = true,
          blockTow = false,
          avoidedByCivilianTraffic = true,
          avoidAttacks = false,
          avoidAlleys = 0,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["New Actor"] = {
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
            name = "Player Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Fire truck 3 characters"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          previewMovie = "Preview",
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
            name = "Player"
          },
          vehicleId = 149,
          enableSiren = false,
          enableSimulationArea = false,
          damageMultiplier = 1.2,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          noOccupants = false,
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          raceManagerRoute = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Tanker5"] = {
        [1] = {
          lockedToPlayer = true,
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
            name = "Tanker Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Tankers"
          },
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
          avoidUTurns = true,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Tanker5 spawn"
          },
          vehicleId = 286,
          vehicleTrailerId = 131,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 50,
          shaderParam = 0,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          raceManagerRoute = false,
          routeName = "Tanker on fire activity 1 tanker",
          stayInLockedArea = true,
          blockTow = false,
          avoidedByCivilianTraffic = true,
          avoidAttacks = false,
          avoidAlleys = 1,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Fire team member 1"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = true,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 30,
          team = {
            instance = 1,
            type = "Teams",
            name = "Fire team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Fire truck 1"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = true,
          whenSpawned = "On mission start",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = true,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          vehicleTrailerId = -1,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Relative to Tanker 1"
          },
          vehicleId = 186,
          enableSiren = true,
          enableSimulationArea = true,
          spawnSpeed = 30,
          damageMultiplier = 1.2,
          attackStationaryVehicle = false,
          distanceBehindPlayer = 50,
          reactionTime = "Fastest",
          raceManagerRoute = false,
          routeName = "Tanker on fire activity 1 tanker 1",
          stayInLockedArea = true,
          blockTow = false,
          avoidedByCivilianTraffic = true,
          avoidAttacks = false,
          avoidAlleys = 1,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Tanker4"] = {
        [1] = {
          lockedToPlayer = true,
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
            name = "Tanker Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Tankers"
          },
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
          avoidUTurns = true,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Tanker4 spawn"
          },
          vehicleId = 286,
          vehicleTrailerId = 131,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 50,
          shaderParam = 0,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          raceManagerRoute = false,
          routeName = "Tanker on fire activity 1 tanker",
          stayInLockedArea = true,
          blockTow = false,
          avoidedByCivilianTraffic = true,
          avoidAttacks = false,
          avoidAlleys = 1,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Fire truck 2"] = {
        [1] = {
          ["Passenger id"] = "-1656694476",
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      },
      ["Tankers"] = {
        [1] = {
          ["Passenger id"] = "1568132437",
          ["Driver id"] = "1221009583"
        },
        ["name"] = "Character"
      },
      ["Fire truck 3 characters"] = {
        [1] = {
          ["Passenger id"] = "-1",
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      },
      ["Fire truck 1"] = {
        [1] = {
          ["Passenger id"] = "-1809471421",
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      }
    },
    FelonySettings = {
      FelonySettings = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    Teams = {
      ["Fire team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Player Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Tanker Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    SpawnTypes = {
      ["Tanker1 spawn"] = {
        [1] = {
          ["Spawn location"] = "TankerOnFireActivity1SpawnTanker1",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Tanker2 spawn"] = {
        [1] = {
          ["Spawn location"] = "TankerOnFireActivity1SpawnTanker2",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Tanker5 spawn"] = {
        [1] = {
          ["Spawn location"] = "TankerOnFireActivity1SpawnTanker3c",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Truck 3 Position"] = {
        [1] = {
          ["Spawn location"] = "TankerOnFireActivity1SpawnTruck3",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Player"] = {
        [1] = {
          ["Spawn location"] = "TankerOnFireActivity1Spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Truck 2 Position"] = {
        [1] = {
          ["Spawn location"] = "TankerOnFireActivity1SpawnTruck2",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Tanker4 spawn"] = {
        [1] = {
          ["Spawn location"] = "TankerOnFireActivity1SpawnTanker3b",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Relative to Tanker 5"] = {
        [1] = {
          actor = "Tanker5",
          whichLane = "randomLane",
          withVehicleDirection = true,
          distance = 100,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = false
        },
        ["name"] = "Relative to Vehicle"
      },
      ["Tanker3 spawn"] = {
        [1] = {
          ["Spawn location"] = "TankerOnFireActivity1SpawnTanker3a",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Relative to Tanker 1"] = {
        [1] = {
          actor = "Tanker1",
          whichLane = "insideLane",
          withVehicleDirection = true,
          distance = 100,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = false
        },
        ["name"] = "Relative to Vehicle"
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
      MissionSetting = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "TankerOnFireActivity1Spawn",
          ["disablePlayerIgnoring"] = false,
          ["Spawn type"] = "Always active",
          ["Delete task object on reject preview"] = false,
          ["Hud logic file"] = "Tanker on fire activity hud 2",
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    MissionInfos = {
      ["Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:245560",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective",
              cardName = "Fire team member 1",
              cardType = "Actor"
            },
            [2] = {
              value = "Yellow Marker, Destination Vehicle",
              cardName = "Tanker1",
              cardType = "Actor"
            },
            [3] = {
              value = "None",
              cardName = "New Actor",
              cardType = "Actor"
            },
            [4] = {
              value = "Objective",
              cardName = "Fire team member 2",
              cardType = "Actor"
            },
            [5] = {
              value = "Yellow Marker, Destination Vehicle",
              cardName = "Tanker4",
              cardType = "Actor"
            },
            [6] = {
              value = "Yellow Marker, Destination Vehicle",
              cardName = "Tanker5",
              cardType = "Actor"
            },
            [7] = {
              value = "Yellow Marker, Destination Vehicle",
              cardName = "Tanker3",
              cardType = "Actor"
            },
            [8] = {
              value = "Yellow Marker, Destination Vehicle",
              cardName = "Tanker2",
              cardType = "Actor"
            },
            [9] = {
              value = "Objective",
              cardName = "Fire team member 3",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Tanker on fire activity 2"] = {
        [1] = {
          ["Fire team"] = {
            instance = 1,
            type = "Teams",
            name = "Fire team"
          },
          ["Tanker team"] = {
            instance = 1,
            type = "Teams",
            name = "Tanker Team"
          },
          ["Player team"] = {
            instance = 1,
            type = "Teams",
            name = "Player Team"
          }
        },
        ["name"] = "Tanker on fire activity 2"
      }
    }
  }
}
