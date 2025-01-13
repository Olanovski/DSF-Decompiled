cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Exposition 02 I wish we could help"] = {
  FileVersion = "2",
  name = "Exposition 02 I wish we could help",
  title = "ID:172402",
  MissionID = "759",
  description = "ID:172361",
  cardInstances = {
    Actors = {
      ["Static ambulance 03"] = {
        [1] = {
          noOccupants = true,
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          stayInLockedArea = false,
          reactionTime = "Average",
          vehicleId = 276,
          avoidedByCivilianTraffic = false,
          aiIgnorePlayers = false,
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Static ambulance 03 Set position"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "Static ambulance"
          },
          shaderParam = 0,
          enableSimulationArea = true,
          avoidUTurns = false,
          avoidAlleys = 0,
          desiredSpeed = 0,
          drivingSkill = "Average",
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          forceHighLodCharacters = false,
          enableSiren = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          matchTrafficSpeed = false,
          avoidAttacks = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Static ambulance characters"
          },
          collisionResilience = "Average",
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      ["Static ambulance 01"] = {
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
            name = "Static ambulance"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Static ambulance characters"
          },
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
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Static ambulance 01 Set position"
          },
          vehicleId = 276,
          shaderParam = 0,
          enableSiren = false,
          enableSimulationArea = true,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          matchTrafficSpeed = false,
          aiIgnorePlayerInCivsUntilHit = false,
          stayInLockedArea = false,
          blockTow = false,
          collisionResilience = "Average",
          avoidAttacks = false,
          raceManagerRoute = false,
          desiredSpeed = 0,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Static ambulance 02"] = {
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
            name = "Static ambulance"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Static ambulance characters"
          },
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
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Static ambulance 02 Set position"
          },
          vehicleId = 276,
          shaderParam = 0,
          enableSiren = false,
          enableSimulationArea = true,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          matchTrafficSpeed = false,
          aiIgnorePlayerInCivsUntilHit = false,
          stayInLockedArea = false,
          blockTow = false,
          collisionResilience = "Average",
          avoidAttacks = false,
          raceManagerRoute = false,
          desiredSpeed = 0,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Tanner Actor"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = true,
          team = {
            instance = 1,
            type = "Teams",
            name = "New Team"
          },
          drivingSkill = "Over-cautious",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "New Character"
          },
          forceHighLodCharacters = true,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = true,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          enableSiren = true,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Cutscene"
          },
          shaderParam = 0,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Set position"
          },
          vehicleId = 276,
          enableSimulationArea = false,
          isMultiplayerActor = false,
          spawnSpeed = 20,
          damageMultiplier = 0.8,
          attackStationaryVehicle = false,
          desiredSpeed = 30,
          matchTrafficSpeed = true,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          previewMovie = "no preview",
          avoidAttacks = false,
          avoidedByCivilianTraffic = true,
          avoidAlleys = 0,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Static ambulance 04"] = {
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
            name = "Static ambulance"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Static ambulance characters"
          },
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
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Static ambulance 04 Set position"
          },
          vehicleId = 276,
          shaderParam = 0,
          enableSiren = false,
          enableSimulationArea = true,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          matchTrafficSpeed = false,
          aiIgnorePlayerInCivsUntilHit = false,
          stayInLockedArea = false,
          blockTow = false,
          collisionResilience = "Average",
          avoidAttacks = false,
          raceManagerRoute = false,
          desiredSpeed = 0,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Static ambulance characters"] = {
        [1] = {},
        ["name"] = "Character"
      },
      ["New Character"] = {
        [1] = {
          ["Passenger id"] = "-585280992",
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      }
    },
    SpawnTypes = {
      ["New Set position"] = {
        [1] = {
          ["Spawn location"] = "Exposition ambulance actor spawn location",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Static ambulance 01 Set position"] = {
        [1] = {
          ["Spawn location"] = "Static ambulance 01",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Static ambulance 04 Set position"] = {
        [1] = {
          ["Spawn location"] = "Static ambulance 04",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Static ambulance 02 Set position"] = {
        [1] = {
          ["Spawn location"] = "Static ambulance 02",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Static ambulance 03 Set position"] = {
        [1] = {
          ["Spawn location"] = "Static ambulance 03",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    MissionSettings = {
      ["New MissionSetting"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Disable traffic"] = false,
          ["Clear area around vehicles"] = 20,
          ["Cutscene at mission end"] = "ch0_gp_Billboard_Well_Done",
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Exposition ambulance start",
          ["Audio logic file"] = "Exposition ambulance",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["disablePlayerIgnoring"] = false,
          ["Enable race status prompts"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["Static ambulance"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["New Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionCompletes = {
      ["New Exposition part 2"] = {
        [1] = {
          ["Failure reason"] = "ID:184808"
        },
        ["name"] = "Exposition part 2"
      }
    },
    WarmupTypes = {
      ["New Static"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          forceZapToVehicle = true,
          forceMissionAccept = true,
          lookToVehicle = false
        },
        ["name"] = "Static"
      },
      ["New Cutscene"] = {
        [1] = {forceMissionAccept = true},
        ["name"] = "Cutscene"
      }
    },
    FelonySettings = {
      ["Expo 04 FelonySettings"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    MissionInfos = {
      ["New Title and description 2"] = {
        [1] = {
          ["1 Text"] = "ID:245762",
          ["missionMarkers"] = {
            [1] = {
              value = "None",
              cardName = "Static ambulance 01",
              cardType = "Actor"
            },
            [2] = {
              value = "Objective",
              cardName = "Tanner Actor",
              cardType = "Actor"
            },
            [3] = {
              value = "None",
              cardName = "Static ambulance 03",
              cardType = "Actor"
            },
            [4] = {
              value = "None",
              cardName = "Static ambulance 04",
              cardType = "Actor"
            },
            [5] = {
              value = "None",
              cardName = "Static ambulance 02",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New MissionType"] = {
        [1] = {
          ["Ambulance team"] = {
            instance = 1,
            type = "Teams",
            name = "New Team"
          },
          ["Static ambulance team"] = {
            instance = 1,
            type = "Teams",
            name = "Static ambulance"
          },
          ["Score to lose"] = 100,
          ["Non-linear checkpoints"] = false,
          ["Damage amount for fail"] = 1
        },
        ["name"] = "Exposition part 2"
      }
    }
  }
}
