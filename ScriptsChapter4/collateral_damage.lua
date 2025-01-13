cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Collateral Damage"] = {
  FileVersion = "2",
  name = "Collateral Damage",
  title = "ID:184291",
  MissionID = "2306",
  description = "ID:184299",
  cardInstances = {
    Actors = {
      ["Jericho"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 90,
          team = {
            instance = 1,
            type = "Teams",
            name = "Jericho Team"
          },
          drivingSkill = "Cautious",
          disablePanelDetach = true,
          maxAllowedDamage = 0.7,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Character Jericho"
          },
          forceHighLodCharacters = true,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On mission start",
          driveInOncoming = 0.3,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          shaderParam = 3,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Jericho spawn position"
          },
          vehicleId = 164,
          enableSiren = false,
          rubberbandingToPlayerStrength = "Strong",
          enableSimulationArea = false,
          spawnSpeed = 30,
          rubberbandingActor = "Tanner",
          damageMultiplier = 0.85,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -25,
          reactionTime = "Fastest",
          routeName = "Collateral damage jericho route",
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = true,
          avoidAttacks = false,
          ignoreOtherAis = false,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["First civ"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "First Civ Team"
          },
          drivingSkill = "Reckless",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Character Jericho"
          },
          forceHighLodCharacters = true,
          wanderType = "preferStraight",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          tailingDistance = 0,
          driveOnPavements = 0.8,
          noOccupants = false,
          vehicleId = 187,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 7,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Very tough",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Civ spawn position"
          },
          ramInFrontDistance = 100,
          enableSiren = false,
          rubberbandingToPlayerStrength = "Weak",
          enableSimulationArea = false,
          spawnSpeed = 30,
          damageCauseScale = 1.5,
          damageMultiplier = 1,
          attackStationaryVehicle = true,
          distanceBehindPlayer = 0,
          driveInOncoming = 0.8,
          aiIgnorePlayerInCivsUntilHit = false,
          stayInLockedArea = false,
          blockTow = false,
          desiredSpeed = 90,
          avoidAttacks = false,
          reactionTime = "Fast",
          groupAggression = "Relentless"
        },
        ["name"] = "Actor"
      },
      ["Player"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Truck team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On mission start",
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
            name = "New As localPlayer"
          },
          vehicleId = -1,
          attackStationaryVehicle = false,
          stayInLockedArea = false,
          blockTow = false,
          enableSiren = false,
          avoidAttacks = false,
          enableSimulationArea = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["Tanner 2"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 65,
          team = {
            instance = 1,
            type = "Teams",
            name = "Tanner 2 Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          matchTrafficSpeedMultiplier = 1,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Character Tanner"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0.2,
          driveOnPavements = 0.5,
          noOccupants = false,
          takeNonPlayerDamage = true,
          isMultiplayerActor = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = true,
          vehicleTrailerId = -1,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Tanner 2 spawn position"
          },
          vehicleId = 62,
          shaderParam = 0,
          enableSiren = false,
          spawnSpeed = 30,
          enableSimulationArea = true,
          damageMultiplier = 0.55,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          routeName = "Collateral damage tanner route",
          stayInLockedArea = false,
          blockTow = false,
          raceManagerRoute = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
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
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 70,
          team = {
            instance = 1,
            type = "Teams",
            name = "Tanner 1 Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Character Tanner"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          driveInOncoming = 0.2,
          driveOnPavements = 0.5,
          previewMovie = "Hello",
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Warmup route"
          },
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          vehicleTrailerId = -1,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Tanner positions"
          },
          vehicleId = 62,
          shaderParam = 0,
          enableSiren = false,
          spawnSpeed = 30,
          enableSimulationArea = false,
          damageMultiplier = 0.6,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          aiIgnorePlayerInCivsUntilHit = false,
          stayInLockedArea = false,
          blockTow = false,
          noOccupants = false,
          avoidAttacks = false,
          ignoreCivilianTraffic = false,
          reactionTime = "Average"
        },
        ["name"] = "Actor"
      },
      ["Civ3"] = {
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
            name = "Civ Team"
          },
          drivingSkill = "Reckless",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Character Jericho"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 0,
          driveOnPavements = 0.8,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleId = 165,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Civ Ahead of Tanner"
          },
          ramInFrontDistance = 175,
          enableSiren = false,
          rubberbandingToPlayerStrength = "Weak",
          enableSimulationArea = true,
          spawnSpeed = 40,
          damageCauseScale = 1.5,
          damageMultiplier = 1,
          attackStationaryVehicle = true,
          distanceBehindPlayer = 0,
          driveInOncoming = 0.8,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          customAggression = "New CustomAggressionSetting",
          avoidAttacks = false,
          desiredSpeed = 60,
          avoidedByCivilianTraffic = true,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Civ"] = {
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
            name = "Civ Team"
          },
          drivingSkill = "Reckless",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Character Jericho"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 0,
          driveOnPavements = 0.8,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleId = 165,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Civ Ahead of Tanner"
          },
          ramInFrontDistance = 175,
          enableSiren = false,
          rubberbandingToPlayerStrength = "Weak",
          enableSimulationArea = true,
          spawnSpeed = 40,
          damageCauseScale = 1.5,
          damageMultiplier = 1,
          attackStationaryVehicle = true,
          distanceBehindPlayer = 0,
          driveInOncoming = 0.8,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          customAggression = "New CustomAggressionSetting",
          avoidAttacks = false,
          desiredSpeed = 60,
          avoidedByCivilianTraffic = true,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Civ2"] = {
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
            name = "Civ Team"
          },
          drivingSkill = "Reckless",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Character Jericho"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 0,
          driveOnPavements = 0.8,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleId = 165,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Civ Ahead of Tanner"
          },
          ramInFrontDistance = 175,
          enableSiren = false,
          rubberbandingToPlayerStrength = "Weak",
          enableSimulationArea = true,
          spawnSpeed = 40,
          damageCauseScale = 1.5,
          damageMultiplier = 1,
          attackStationaryVehicle = true,
          distanceBehindPlayer = 0,
          driveInOncoming = 0.8,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          customAggression = "New CustomAggressionSetting",
          avoidAttacks = false,
          desiredSpeed = 60,
          avoidedByCivilianTraffic = true,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Character Jericho"] = {
        [1] = {
          ["Passenger id"] = "-1",
          ["Driver id"] = "-376150524"
        },
        ["name"] = "Character"
      },
      ["Character Tanner"] = {
        [1] = {
          ["Passenger id"] = "-1916574018",
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      }
    },
    SpawnTypes = {
      ["Tanner 2 spawn position"] = {
        [1] = {
          ["Spawn location"] = "Collateral Damage tanner spawn 2",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Ahead of Tanner 2"] = {
        [1] = {
          actor = "Tanner 2",
          whichLane = "randomLane",
          withVehicleDirection = false,
          distance = 400,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = true
        },
        ["name"] = "Relative to Vehicle"
      },
      ["Jericho spawn position"] = {
        [1] = {
          ["Spawn location"] = "Collateral Damage jericho spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Civ Ahead of Tanner"] = {
        [1] = {
          actor = "Tanner 2",
          whichLane = "randomLane",
          withVehicleDirection = false,
          distance = 110,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = true
        },
        ["name"] = "Relative to Vehicle"
      },
      ["New As localPlayer"] = {
        [1] = {},
        ["name"] = "As localPlayer"
      },
      ["Civ spawn position"] = {
        [1] = {
          ["Spawn location"] = "Collateral Damage first attacker spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Tanner spawn position"] = {
        [1] = {
          ["Spawn location"] = "Collateral Damage tanner spawn 1",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Jericho positions"] = {
        [1] = {
          ["alternateLocation"] = "Collateral Damage jericho spawn",
          ["1"] = "Jericho"
        },
        ["name"] = "Positions"
      },
      ["Tanner positions"] = {
        [1] = {
          ["alternateLocation"] = "Collateral Damage tanner spawn 1",
          ["1"] = "Tanner"
        },
        ["name"] = "Positions"
      }
    },
    MissionSettings = {
      ["MISSION SETTINGS"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Load traffic on start"] = "SM4 Collateral Damage",
          ["disablePlayerIgnoring"] = false,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Collateral Damage Start",
          ["Audio logic file"] = "Collateral damage APIP",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    CustomAggressionSettings = {
      ["New CustomAggressionSetting"] = {
        [1] = {
          groupTakeDownMaxAttackersAtOnceIntercepting = 5,
          groupTakeDownMaxAttackersAtOnceStationary = 0,
          groupTakeDownTimeBetweenAttacks = 1,
          groupTakeDownPerformanceBoost = 1.25
        },
        ["name"] = "CustomAggressionSetting"
      }
    },
    Teams = {
      ["Tanner 1 Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Truck team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Civ Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Jericho Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Tanner 2 Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["First Civ Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionCompletes = {
      ["Collateral Damage complete"] = {
        [1] = {
          ["Perfect condition"] = "ID:184311",
          ["Success reason"] = "ID:184311",
          ["Failure reason"] = "ID:231193",
          ["Success reason (perfect)"] = "ID:184311",
          ["Pass condition"] = "ID:184311",
          ["Failure reason (wrecked)"] = "ID:184309"
        },
        ["name"] = "Collateral Damage"
      }
    },
    WarmupTypes = {
      ["New Warmup route"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          warmupRouteName = "Collateral damage warmup",
          forceZapToVehicle = false,
          forceMissionAccept = false,
          matchTrafficSpeed = true,
          lookToVehicle = false
        },
        ["name"] = "Warmup route"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {reenablePatrollingVehiclesAfterFelonyEnd = false, disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    MissionInfos = {
      ["MISSION INFO"] = {
        [1] = {
          ["1 Text"] = "ID:184301",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective",
              cardName = "Tanner 2",
              cardType = "Actor"
            },
            [2] = {
              value = "Black Marker, No Health Bar",
              cardName = "First civ",
              cardType = "Actor"
            },
            [3] = {
              value = "Black Marker, No Health Bar",
              cardName = "Civ2",
              cardType = "Actor"
            },
            [4] = {
              value = "Black Marker, No Health Bar",
              cardName = "Civ",
              cardType = "Actor"
            },
            [5] = {
              value = "Objective",
              cardName = "Tanner",
              cardType = "Actor"
            },
            [6] = {
              value = "Black Marker, No Health Bar",
              cardName = "Civ3",
              cardType = "Actor"
            },
            [7] = {
              value = "Yellow Marker, Destination Vehicle",
              cardName = "Jericho",
              cardType = "Actor"
            },
            [8] = {
              value = "None",
              cardName = "Player",
              cardType = "Actor"
            }
          },
          ["2 Text"] = "ID:245544"
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["Collateral Damage"] = {
        [1] = {
          ["Jericho team"] = {
            instance = 1,
            type = "Teams",
            name = "Jericho Team"
          },
          ["Truck team"] = {
            instance = 1,
            type = "Teams",
            name = "Truck team"
          },
          ["Tanner team 2"] = {
            instance = 1,
            type = "Teams",
            name = "Tanner 2 Team"
          },
          ["Tanner team 1"] = {
            instance = 1,
            type = "Teams",
            name = "Tanner 1 Team"
          },
          ["Civ team"] = {
            instance = 1,
            type = "Teams",
            name = "Civ Team"
          },
          ["First civ team"] = {
            instance = 1,
            type = "Teams",
            name = "First Civ Team"
          },
          ["Damage amount for fail"] = 1
        },
        ["name"] = "Collateral Damage"
      }
    }
  }
}
