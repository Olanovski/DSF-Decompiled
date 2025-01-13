cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.Alone = {
  FileVersion = "2",
  name = "Alone",
  title = "ID:184908",
  MissionID = "3842",
  description = "ID:184909",
  cardInstances = {
    Actors = {
      ["Evader"] = {
        [1] = {
          wrongWayIndicator = false,
          matchTrafficSpeed = false,
          aiIgnorePlayers = false,
          desiredSpeed = 100,
          team = {
            instance = 1,
            type = "Teams",
            name = "EvaderTeam"
          },
          drivingSkill = "Professional",
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          noOccupants = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = true,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Evader spawn"
          },
          vehicleId = 139,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 30,
          rubberbandingActor = "Tanner",
          damageMultiplier = 0,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          stayInLockedArea = false,
          distanceBehindPlayer = -50,
          enableSiren = false,
          avoidAttacks = false,
          restrictedVehicleType = 0,
          enableSimulationArea = false,
          ignoreCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["Chaser 3"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Fastest",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = true,
          team = {
            instance = 1,
            type = "Teams",
            name = "Chase team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Jericho Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          driveInOncoming = 1,
          driveOnPavements = 0,
          noOccupants = false,
          vehicleId = 181,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 3,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Relative to Vehicle (Ahead)"
          },
          ramInFrontDistance = 600,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 90,
          rubberbandingActor = "Tanner",
          damageMultiplier = 1,
          attackStationaryVehicle = true,
          distanceBehindPlayer = 0,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          customAggression = "JerochosCustomAggressionSetting",
          avoidAttacks = false,
          avoidAlleys = 0,
          desiredSpeed = 30,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Chaser 1"] = {
        [1] = {
          lockedToPlayer = false,
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
            name = "Chase team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Jericho Character"
          },
          forceHighLodCharacters = true,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          driveInOncoming = 1,
          driveOnPavements = 0,
          noOccupants = false,
          vehicleId = 181,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 3,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "200 Relative to Vehicle (Ahead)"
          },
          ramInFrontDistance = 600,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 50,
          rubberbandingActor = "Tanner",
          damageMultiplier = 1,
          attackStationaryVehicle = true,
          distanceBehindPlayer = 0,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          customAggression = "JerochosCustomAggressionSetting",
          avoidAttacks = false,
          avoidAlleys = 0,
          desiredSpeed = 50,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Tanner"] = {
        [1] = {
          noOccupants = false,
          lockedToPlayer = false,
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          maintainLane = false,
          matchTrafficSpeed = false,
          previewMovie = "Hello",
          avoidedByCivilianTraffic = true,
          enableSiren = false,
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions 2"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "Tanner Team"
          },
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Warmup route"
          },
          drivingSkill = "Average",
          vehicleId = 62,
          reactionTime = "Average",
          collisionResilience = "Average",
          enableSimulationArea = false,
          damageMultiplier = 0.48,
          attackStationaryVehicle = false,
          forceHighLodCharacters = false,
          avoidUTurns = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          stayInLockedArea = false,
          whenSpawned = "On warmup",
          shaderParam = 0,
          avoidAttacks = false,
          aiIgnorePlayers = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Tanner Character"
          },
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      ["Chaser 2"] = {
        [1] = {
          lockedToPlayer = false,
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
            name = "Chase team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Jericho Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          driveInOncoming = 1,
          driveOnPavements = 0,
          noOccupants = false,
          vehicleId = 181,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 3,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "150 Relative to Vehicle (Ahead)"
          },
          ramInFrontDistance = 600,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 60,
          rubberbandingActor = "Tanner",
          damageMultiplier = 1,
          attackStationaryVehicle = true,
          distanceBehindPlayer = 0,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          customAggression = "JerochosCustomAggressionSetting",
          avoidAttacks = false,
          avoidAlleys = 0,
          desiredSpeed = 40,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Chaser Temp behind 2"] = {
        [1] = {
          lockedToPlayer = false,
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
            name = "Chase team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Jericho Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          driveInOncoming = 1,
          driveOnPavements = 1,
          noOccupants = false,
          vehicleId = 181,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 3,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          enableSiren = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Relative to Vehicle"
          },
          ramInFrontDistance = 150,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "VeryWeak",
          spawnSpeed = 140,
          rubberbandingActor = "Tanner",
          damageMultiplier = 1,
          attackStationaryVehicle = true,
          distanceBehindPlayer = 0,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          customAggression = "JerochosCustomAggressionSetting",
          avoidAttacks = false,
          avoidAlleys = 0,
          desiredSpeed = 30,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Chaser Temp behind 1"] = {
        [1] = {
          lockedToPlayer = false,
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
            name = "Chase team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Jericho Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          driveInOncoming = 1,
          driveOnPavements = 1,
          noOccupants = false,
          vehicleId = 181,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 3,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          enableSiren = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Relative to Vehicle"
          },
          ramInFrontDistance = 150,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "VeryWeak",
          spawnSpeed = 140,
          rubberbandingActor = "Tanner",
          damageMultiplier = 1,
          attackStationaryVehicle = true,
          distanceBehindPlayer = 0,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          customAggression = "JerochosCustomAggressionSetting",
          avoidAttacks = false,
          avoidAlleys = 0,
          desiredSpeed = 30,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Chaser 4"] = {
        [1] = {
          lockedToPlayer = false,
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
            name = "Chase team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Jericho Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          driveInOncoming = 1,
          driveOnPavements = 1,
          noOccupants = false,
          vehicleId = 181,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 3,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          enableSiren = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Relative to Vehicle"
          },
          ramInFrontDistance = 150,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 140,
          rubberbandingActor = "Tanner",
          damageMultiplier = 1,
          attackStationaryVehicle = true,
          distanceBehindPlayer = 0,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          customAggression = "JerochosCustomAggressionSetting",
          avoidAttacks = false,
          avoidAlleys = 0,
          desiredSpeed = 90,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Alley Chaser"] = {
        [1] = {
          lockedToPlayer = false,
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
            name = "Alley Chaser Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Jericho Character"
          },
          forceHighLodCharacters = true,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = 0,
          driveInOncoming = 1,
          driveOnPavements = 1,
          noOccupants = false,
          vehicleId = 118,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          enableSiren = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Relative to Vehicle"
          },
          ramInFrontDistance = 200,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 70,
          rubberbandingActor = "Tanner",
          damageMultiplier = 1,
          attackStationaryVehicle = true,
          distanceBehindPlayer = 0,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          groupAggression = "DejaVu",
          avoidAttacks = false,
          avoidAlleys = 0,
          desiredSpeed = 120,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Chaser 5"] = {
        [1] = {
          lockedToPlayer = false,
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
            name = "Chase team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Jericho Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          driveInOncoming = 1,
          driveOnPavements = 1,
          noOccupants = false,
          vehicleId = 181,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 3,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          enableSiren = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Relative to Vehicle"
          },
          ramInFrontDistance = 150,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 150,
          rubberbandingActor = "Tanner",
          damageMultiplier = 1,
          attackStationaryVehicle = true,
          distanceBehindPlayer = 0,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          customAggression = "JerochosCustomAggressionSetting",
          avoidAttacks = false,
          avoidAlleys = 0,
          desiredSpeed = 110,
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
      ["Jericho Character"] = {
        [1] = {
          ["Driver id"] = "-376150524"
        },
        ["name"] = "Character"
      }
    },
    SpawnTypes = {
      ["New Positions 2"] = {
        [1] = {
          ["1"] = "Tanner"
        },
        ["name"] = "Positions"
      },
      ["New Relative to Vehicle"] = {
        [1] = {
          actor = "Tanner",
          whichLane = "randomLane",
          withVehicleDirection = true,
          distance = 30,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = false
        },
        ["name"] = "Relative to Vehicle"
      },
      ["200 Relative to Vehicle (Ahead)"] = {
        [1] = {
          actor = "Tanner",
          whichLane = "outsideLane",
          withVehicleDirection = false,
          distance = 300,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = true
        },
        ["name"] = "Relative to Vehicle"
      },
      ["150 Relative to Vehicle (Ahead)"] = {
        [1] = {
          actor = "Tanner",
          whichLane = "outsideLane",
          withVehicleDirection = false,
          distance = 250,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = true
        },
        ["name"] = "Relative to Vehicle"
      },
      ["Relative to Vehicle (Ahead)"] = {
        [1] = {
          actor = "Tanner",
          whichLane = "outsideLane",
          withVehicleDirection = false,
          distance = 200,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = true
        },
        ["name"] = "Relative to Vehicle"
      },
      ["New Swarm"] = {
        [1] = {
          actorToSwarmAround = {
            [1] = {
              value = "false",
              cardName = "Chaser Temp behind 2",
              cardType = "Actor"
            },
            [2] = {
              value = "false",
              cardName = "Evader",
              cardType = "Actor"
            },
            [3] = {
              value = "false",
              cardName = "Chaser 1",
              cardType = "Actor"
            },
            [4] = {
              value = "false",
              cardName = "Chaser 5",
              cardType = "Actor"
            },
            [5] = {
              value = "true",
              cardName = "Tanner",
              cardType = "Actor"
            },
            [6] = {
              value = "false",
              cardName = "Chaser 2",
              cardType = "Actor"
            },
            [7] = {
              value = "false",
              cardName = "Chaser 3",
              cardType = "Actor"
            },
            [8] = {
              value = "false",
              cardName = "Alley Chaser",
              cardType = "Actor"
            }
          },
          maximumDistance = 120,
          minimumDistance = 100
        },
        ["name"] = "Swarm"
      },
      ["Evader spawn"] = {
        [1] = {
          ["Spawn location"] = "Alone evader",
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
      ["EvaderTeam"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Alley Chaser Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Chase team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Tanner Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionSettings = {
      ["Alone Settings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Spawn type"] = "Always active",
          ["Load traffic on start"] = "Chapter 7 Alone",
          ["Hud logic file"] = "Alone HUD",
          ["disablePlayerIgnoring"] = false,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Alone",
          ["Audio logic file"] = "Alone APIP",
          ["Delete task object on reject preview"] = false,
          ["Cutscene at mission end"] = "ch7_sm7_01",
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    WarmupTypes = {
      ["Warmup"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          forceZapToVehicle = false,
          forceMissionAccept = false,
          lookToVehicle = false
        },
        ["name"] = "Static"
      },
      ["New Warmup route"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          warmupRouteName = "Alone warmup",
          forceZapToVehicle = false,
          forceMissionAccept = false,
          lookToVehicle = false
        },
        ["name"] = "Warmup route"
      }
    },
    CustomAggressionSettings = {
      JerochosCustomAggressionSetting = {
        [1] = {
          groupTakeDownMaxAttackersAtOnceIntercepting = 3,
          groupTakeDownMaxAttackersAtOnceFollowing = 5,
          groupTakeDownPerformanceBoost = 1.1,
          groupTakeDownTimeBetweenAttacks = 2,
          groupTakeDownMaxAttackersAtOnceStationary = 3,
          groupTakeDownFollowDistanceforNonAttackers = 1
        },
        ["name"] = "CustomAggressionSetting"
      }
    },
    MissionInfos = {
      ["Alone Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:245553",
          ["missionMarkers"] = {
            [1] = {
              value = "Opponent",
              cardName = "Chaser 2",
              cardType = "Actor"
            },
            [2] = {
              value = "Opponent",
              cardName = "Alley Chaser",
              cardType = "Actor"
            },
            [3] = {
              value = "Opponent",
              cardName = "Chaser 1",
              cardType = "Actor"
            },
            [4] = {
              value = "Opponent",
              cardName = "Chaser 4",
              cardType = "Actor"
            },
            [5] = {
              value = "Opponent",
              cardName = "Chaser 3",
              cardType = "Actor"
            },
            [6] = {
              value = "Opponent",
              cardName = "Chaser 5",
              cardType = "Actor"
            },
            [7] = {
              value = "Objective",
              cardName = "Tanner",
              cardType = "Actor"
            },
            [8] = {
              value = "None",
              cardName = "Evader",
              cardType = "Actor"
            },
            [9] = {
              value = "Opponent",
              cardName = "Chaser Temp behind 2",
              cardType = "Actor"
            },
            [10] = {
              value = "Opponent",
              cardName = "Chaser Temp behind 1",
              cardType = "Actor"
            }
          },
          ["4 Text"] = "ID:245544",
          ["3 Text"] = "ID:245544",
          ["2 Text"] = "ID:184912"
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Alone"] = {
        [1] = {
          ["Chase team"] = {
            instance = 1,
            type = "Teams",
            name = "Chase team"
          },
          ["Tanner team"] = {
            instance = 1,
            type = "Teams",
            name = "Tanner Team"
          },
          ["Alley Chaser team"] = {
            instance = 1,
            type = "Teams",
            name = "Alley Chaser Team"
          },
          ["Evader team"] = {
            instance = 1,
            type = "Teams",
            name = "EvaderTeam"
          }
        },
        ["name"] = "Alone"
      }
    }
  }
}
