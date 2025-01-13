cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.Trunked = {
  FileVersion = "2",
  name = "Trunked",
  title = "ID:184665",
  MissionID = "770",
  description = "ID:184666",
  cardInstances = {
    Actors = {
      ["TrunkedActor"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          desiredSpeed = 50,
          team = {
            instance = 1,
            type = "Teams",
            name = "Opponent Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "TrunkedActor Character"
          },
          forceHighLodCharacters = true,
          wanderType = "preferStraight",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0.2,
          driveOnPavements = 0.5,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = true,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          shaderParam = 3,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Trunked Actor Spwan"
          },
          vehicleId = 144,
          enableSiren = false,
          enableSimulationArea = true,
          spawnSpeed = 0,
          maximumDamagePerCollision = 0.4,
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          raceManagerRoute = false,
          routeName = "TrunkedRoute",
          stayInLockedArea = true,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          avoidAlleys = 1,
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
          reactionTime = "Fastest",
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
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          enableSiren = false,
          tailingDistance = 20,
          driveOnPavements = 0.5,
          noOccupants = false,
          shaderParam = 0,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Warmup route"
          },
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          enableSimulationArea = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Tanner Spawn"
          },
          vehicleId = 62,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Strong",
          rubberbandingActor = "TrunkedActor",
          damageMultiplier = 0.3,
          attackStationaryVehicle = false,
          distanceBehindPlayer = 20,
          desiredSpeed = 50,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          previewMovie = "Hello",
          avoidAttacks = false,
          driveInOncoming = 0.5,
          avoidedByCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Ambulance 3"] = {
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
            name = "Ambulance Team"
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
            name = "Ambulance3 Set position"
          },
          vehicleId = 276,
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
      ["Ambulance 2"] = {
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
            name = "Ambulance Team"
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
            name = "Ambulance2 Set position"
          },
          vehicleId = 276,
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
      ["TrunkedBootViewActor1"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = true,
          matchTrafficSpeed = true,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 60,
          team = {
            instance = 1,
            type = "Teams",
            name = "BootCam Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "TrunkedBootViewActorCharacter"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = true,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          shaderParam = 3,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "TrunkedBootViewActor1 Spawn"
          },
          vehicleId = 144,
          enableSiren = false,
          enableSimulationArea = true,
          damageMultiplier = 0,
          attackStationaryVehicle = false,
          reactionTime = "Fastest",
          raceManagerRoute = false,
          routeName = "TrunkedBootView1",
          stayInLockedArea = true,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          avoidAlleys = 0,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Head on Actor"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = true,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 50,
          team = {
            instance = 1,
            type = "Teams",
            name = "Head on Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "HeadOnVehicle Character"
          },
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
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Head On Positions Spawner"
          },
          vehicleId = 176,
          vehicleTrailerId = -1,
          enableSiren = false,
          spawnSpeed = 40,
          enableSimulationArea = false,
          shaderParam = 1,
          attackStationaryVehicle = false,
          ignoreCivilianTraffic = false,
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          ignoreOtherAis = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["TrunkedBootViewActor2"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = true,
          matchTrafficSpeed = true,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "BootCam Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          matchTrafficSpeedMultiplier = 1,
          characters = {
            instance = 1,
            type = "Characters",
            name = "TrunkedBootViewActorCharacter"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = true,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 1,
          ignoreOtherAis = false,
          shaderParam = 3,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "TrunkedBootViewActor2 Spawn"
          },
          vehicleId = 144,
          enableSiren = false,
          enableSimulationArea = true,
          damageMultiplier = 0,
          attackStationaryVehicle = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          routeName = "TrunkedBootView2",
          stayInLockedArea = true,
          blockTow = false,
          reactionTime = "Fastest",
          avoidAttacks = false,
          desiredSpeed = 60,
          aiIgnorePlayerInCivsUntilHit = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Ambulance 1"] = {
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
            name = "Ambulance Team"
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
            name = "Ambulance1 Set position"
          },
          vehicleId = 276,
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
      ["TrunkedBootViewActorCharacter"] = {
        [1] = {
          ["Driver id"] = "-526321096",
          ["Passenger id"] = "-1",
          ["Behind driver id"] = "-1"
        },
        ["name"] = "Character"
      },
      ["HeadOnVehicle Character"] = {
        [1] = {
          ["Driver id"] = "-902779500"
        },
        ["name"] = "Character"
      },
      ["TrunkedActor Character"] = {
        [1] = {
          ["Driver id"] = "-526321096",
          ["Passenger id"] = "-1",
          ["Behind driver id"] = "-390985623"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      ["Trunked settings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = true,
          ["Spawn type"] = "Always active",
          ["Load traffic on start"] = "Chapter 1 Kidnapped",
          ["disablePlayerIgnoring"] = false,
          ["Cutscene after mission end screen"] = "ch1_sm1_01",
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Trunked",
          ["Audio logic file"] = "Trunked APIP",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["Head on Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Tanner Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Opponent Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Ambulance Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["BootCam Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {reenablePatrollingVehiclesAfterFelonyEnd = false, disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    WarmupTypes = {
      ["New Warmup route"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          warmupRouteName = "TrunkedWarmupRoute",
          forceZapToVehicle = false,
          forceMissionAccept = false,
          matchTrafficSpeed = false,
          lookToVehicle = false
        },
        ["name"] = "Warmup route"
      }
    },
    SpawnTypes = {
      ["Tanner Spawn"] = {
        [1] = {
          ["1"] = "Tanner"
        },
        ["name"] = "Positions"
      },
      ["Ambulance1 Set position"] = {
        [1] = {
          ["Spawn location"] = "Trunked Ambulance1",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Trunked Actor Spwan"] = {
        [1] = {
          ["Spawn location"] = "Trunked 01",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Ambulance2 Set position"] = {
        [1] = {
          ["Spawn location"] = "Trunked Ambulance2",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Ambulance3 Set position"] = {
        [1] = {
          ["Spawn location"] = "Trunked Ambulance3",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["TrunkedBootViewActor2 Spawn"] = {
        [1] = {
          ["alternateLocation"] = "Trunked BootCamActor2",
          ["1"] = "TrunkedBootViewActor2"
        },
        ["name"] = "Positions"
      },
      ["Head On Positions Spawner"] = {
        [1] = {
          ["alternateLocation"] = "Trunked Head On",
          ["1"] = "Head on Actor"
        },
        ["name"] = "Positions"
      },
      ["TrunkedBootViewActor1 Spawn"] = {
        [1] = {
          ["Spawn location"] = "Trunked BootCamActor1",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    MissionInfos = {
      ["Trunked Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:184667",
          ["Success reason"] = "ID:184769",
          ["missionMarkers"] = {
            [1] = {
              value = "Opponent",
              cardName = "TrunkedActor",
              cardType = "Actor"
            },
            [2] = {
              value = "None",
              cardName = "Ambulance 3",
              cardType = "Actor"
            },
            [3] = {
              value = "Objective",
              cardName = "Tanner",
              cardType = "Actor"
            },
            [4] = {
              value = "Yellow Marker, Destination Vehicle",
              cardName = "Head on Actor",
              cardType = "Actor"
            },
            [5] = {
              value = "None",
              cardName = "Ambulance 1",
              cardType = "Actor"
            },
            [6] = {
              value = "None",
              cardName = "Ambulance 2",
              cardType = "Actor"
            },
            [7] = {
              value = "None",
              cardName = "TrunkedBootViewActor2",
              cardType = "Actor"
            },
            [8] = {
              value = "None",
              cardName = "TrunkedBootViewActor1",
              cardType = "Actor"
            }
          },
          ["3 Text"] = "ID:243294",
          ["2 Text"] = "ID:243168"
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["Trunked Mission Type"] = {
        [1] = {
          ["Head on team"] = {
            instance = 1,
            type = "Teams",
            name = "Head on Team"
          },
          ["Ambulance team"] = {
            instance = 1,
            type = "Teams",
            name = "Ambulance Team"
          },
          ["Tanner team"] = {
            instance = 1,
            type = "Teams",
            name = "Tanner Team"
          },
          ["Opponent team"] = {
            instance = 1,
            type = "Teams",
            name = "Opponent Team"
          },
          ["BootCam Team"] = {
            instance = 1,
            type = "Teams",
            name = "BootCam Team"
          }
        },
        ["name"] = "Trunked"
      }
    }
  }
}
