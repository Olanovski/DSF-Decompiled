cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Exposition 01 he's getting away"] = {
  FileVersion = "2",
  name = "Exposition 01 he's getting away",
  title = "ID:182931",
  MissionID = "247",
  description = "ID:221954",
  cardInstances = {
    Actors = {
      ["Jericho"] = {
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
            name = "Jericho team"
          },
          applyDamage = 0,
          drivingSkill = "Reckless",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Jericho character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On mission start",
          driveInOncoming = 0.5,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          shaderParam = 1,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Jericho spawn type"
          },
          vehicleId = 277,
          enableSiren = false,
          enableSimulationArea = true,
          rubberbandingActor = "Tanner",
          damageMultiplier = 0,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          raceManagerRoute = true,
          routeName = "ExpositionPostCrashJerichoChaseRoute",
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
      ["cop 2"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          routeName = "Wake up cops",
          team = {
            instance = 1,
            type = "Teams",
            name = "Drive team"
          },
          applyDamage = 0,
          drivingSkill = "Professional",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0.2,
          driveOnPavements = 0,
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
            name = "Cop 2 spawn type"
          },
          vehicleId = 271,
          vehicleTrailerId = -1,
          enableSiren = true,
          enableSimulationArea = false,
          damageMultiplier = 0,
          attackStationaryVehicle = false,
          distanceBehindPlayer = 0,
          ignoreCivilianTraffic = false,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          raceManagerRoute = false,
          desiredSpeed = 80,
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
          applyDamage = 0,
          drivingSkill = "Professional",
          disablePanelDetach = false,
          maxAllowedDamage = 0.8,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Tanner Character"
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
            name = "Tanner Billboard"
          },
          shaderParam = 0,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Tanner spawn type"
          },
          vehicleId = 62,
          enableSimulationArea = false,
          isMultiplayerActor = false,
          spawnSpeed = 0,
          damageMultiplier = 0.2,
          attackStationaryVehicle = false,
          desiredSpeed = 40,
          raceManagerRoute = false,
          routeName = "ExpositionPostCrashJerichoChaseRoute",
          stayInLockedArea = false,
          blockTow = false,
          previewMovie = "Preview vehicle",
          avoidAttacks = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["cop 1"] = {
        [1] = {
          vehicleTrailerId = -1,
          vehicleId = 271,
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          reactionTime = "Average",
          avoidUTurns = false,
          enableSiren = true,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Cop 1 spawn type"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "Drive team"
          },
          applyDamage = 0,
          enableSimulationArea = false,
          matchTrafficSpeed = false,
          aiIgnorePlayers = false,
          routeName = "Wake up cops",
          drivingSkill = "Professional",
          damageMultiplier = 0,
          attackStationaryVehicle = false,
          forceHighLodCharacters = false,
          desiredSpeed = 80,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          stayInLockedArea = false,
          avoidAttacks = false,
          distanceBehindPlayer = 0,
          driveInOncoming = 0.2,
          driveOnPavements = 0
        },
        ["name"] = "Actor"
      },
      ["cop 3"] = {
        [1] = {
          wrongWayIndicator = false,
          matchTrafficSpeed = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Drive team"
          },
          applyDamage = 0,
          drivingSkill = "Professional",
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 0,
          driveOnPavements = 0.2,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Cop 3 spawn type"
          },
          ramInFrontDistance = 200,
          vehicleTrailerId = -1,
          vehicleId = 271,
          damageMultiplier = 0,
          attackStationaryVehicle = true,
          enableSiren = true,
          enableSimulationArea = false,
          desiredSpeed = 80,
          stayInLockedArea = false,
          distanceBehindPlayer = 0,
          reactionTime = "Fastest",
          avoidAttacks = false,
          groupAggression = "DejaVu",
          routeName = "Wake up cop 3",
          driveInOncoming = 0.2
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
      ["Jericho character"] = {
        [1] = {
          ["Driver id"] = "-376150524"
        },
        ["name"] = "Character"
      }
    },
    SpawnTypes = {
      ["Cop 2 spawn type"] = {
        [1] = {
          ["Spawn location"] = "He's getting away - cop 2",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Cop 1 spawn type"] = {
        [1] = {
          ["Spawn location"] = "He's getting away - cop 1",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Tanner spawn type"] = {
        [1] = {
          ["Spawn location"] = "Exposition part 1 tanner",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Cop 3 spawn type"] = {
        [1] = {
          ["Spawn location"] = "He's getting away - cop 3",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Jericho spawn type"] = {
        [1] = {
          ["Spawn location"] = "Exposition part 1 jericho",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
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
      ["Drive team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionCompletes = {
      ["New Exposition part 1"] = {
        [1] = {},
        ["name"] = "Exposition part 1"
      }
    },
    WarmupTypes = {
      ["Tanner Billboard"] = {
        [1] = {forceMissionAccept = true},
        ["name"] = "Cutscene"
      },
      ["Jericho static warmup"] = {
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
      ["New MissionSetting"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Spawn type"] = "Always active",
          ["disablePlayerIgnoring"] = false,
          ["Mission props"] = "WakeUp",
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "He's getting away",
          ["Audio logic file"] = "Exposition post crash jericho chase",
          ["Delete task object on reject preview"] = false,
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    MissionInfos = {
      ["New Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:170894",
          ["missionMarkers"] = {
            [1] = {
              value = "None",
              cardName = "cop 3",
              cardType = "Actor"
            },
            [2] = {
              value = "None",
              cardName = "cop 1",
              cardType = "Actor"
            },
            [3] = {
              value = "None",
              cardName = "cop 2",
              cardType = "Actor"
            },
            [4] = {
              value = "None",
              cardName = "Tanner",
              cardType = "Actor"
            },
            [5] = {
              value = "Opponent (objective)",
              cardName = "Jericho",
              cardType = "Actor"
            }
          },
          ["2 Text"] = "ID:245764"
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New MissionType"] = {
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
          ["Within radius of ditched prison van"] = 20,
          ["Drive team"] = {
            instance = 1,
            type = "Teams",
            name = "Drive team"
          }
        },
        ["name"] = "Exposition part 1"
      }
    }
  }
}
