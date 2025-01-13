cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Escape the law"] = {
  FileVersion = "2",
  name = "Escape the law",
  title = "ID:184080",
  MissionID = "4816",
  description = "ID:184071",
  cardInstances = {
    Actors = {
      ["evade team member 1"] = {
        [1] = {
          lockedToPlayer = false,
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
            name = "evade team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Player character"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          driveInOncoming = 0.2,
          driveOnPavements = 0.5,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Getaway Warmup"
          },
          shaderParam = 2,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Player Positions"
          },
          vehicleId = 159,
          enableSimulationArea = false,
          isMultiplayerActor = false,
          damageMultiplier = 0.3,
          attackStationaryVehicle = false,
          desiredSpeed = 50,
          matchTrafficSpeed = false,
          routeName = "Meet the Heat evader loop",
          raceManagerRoute = false,
          stayInLockedArea = true,
          blockTow = false,
          previewMovie = "csx_1",
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Dropoff vehicle"] = {
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
            name = "Dropoff Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Dropoff"
          },
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
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Dropoff spawn"
          },
          vehicleId = 147,
          enableSiren = false,
          shaderParam = 2,
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
      ["chase team member 1"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "chase team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cops 1"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          tailingDistance = 5,
          driveOnPavements = 0.4,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Getaway Warmup"
          },
          enableSiren = true,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          enableSimulationArea = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Cop Positions"
          },
          vehicleId = 271,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Strong",
          rubberbandingActor = "evade team member 1",
          attackStationaryVehicle = false,
          distanceBehindPlayer = 5,
          driveInOncoming = 0.2,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          groupAggression = "Low",
          desiredSpeed = 75,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["chase team member 2"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 75,
          team = {
            instance = 1,
            type = "Teams",
            name = "chase team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cops 2"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          tailingDistance = 5,
          driveOnPavements = 0.3,
          noOccupants = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Getaway Warmup"
          },
          vehicleTrailerId = -1,
          avoidUTurns = false,
          groupAggression = "Low",
          collisionResilience = "Average",
          raceManagerRoute = false,
          enableSiren = true,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Cop Positions"
          },
          vehicleId = 271,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Strong",
          rubberbandingActor = "evade team member 1",
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = 5,
          driveInOncoming = 0.2,
          ignoreCivilianTraffic = false,
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          aiIgnorePlayerInCivsUntilHit = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Cops 2"] = {
        [1] = {
          ["Passenger id"] = "-1748422665",
          ["Driver id"] = "-197606133"
        },
        ["name"] = "Character"
      },
      ["Cops 1"] = {
        [1] = {
          ["Passenger id"] = "-2032721806",
          ["Driver id"] = "2045201419"
        },
        ["name"] = "Character"
      },
      ["Player character"] = {
        [1] = {
          ["Passenger id"] = "454042078",
          ["Driver id"] = "-1783400622"
        },
        ["name"] = "Character"
      },
      ["Dropoff"] = {
        [1] = {
          ["Passenger id"] = "-1",
          ["Driver id"] = "-114664299"
        },
        ["name"] = "Character"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {
          onlyVehicleAbleToStartFelonies = "evade team member 1",
          disablePoliceInTrafficDuringMission = true,
          reenablePatrollingVehiclesAfterFelonyEnd = false
        },
        ["name"] = "FelonySettings"
      }
    },
    SpawnTypes = {
      ["Cop Positions"] = {
        [1] = {
          ["1"] = "chase team member 1",
          ["alternateLocation"] = "Escape the law cop spawn",
          ["2"] = "chase team member 2"
        },
        ["name"] = "Positions"
      },
      ["Dropoff spawn"] = {
        [1] = {
          ["Spawn location"] = "Escape the law dropoff spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Player Positions"] = {
        [1] = {
          ["1"] = "evade team member 1"
        },
        ["name"] = "Positions"
      }
    },
    Teams = {
      ["chase team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["evade team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Dropoff Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionCompletes = {
      Complete = {
        [1] = {
          ["Perfect condition"] = "ID:184077",
          ["Success reason"] = "ID:184078",
          ["Success reason (perfect)"] = "ID:184079",
          ["Pass condition"] = "ID:184078",
          ["Failure reason (wrecked)"] = "ID:184015",
          ["Failure reason"] = "ID:184075",
          ["Arrested"] = "ID:184073",
          ["Out of time"] = "ID:184074"
        },
        ["name"] = "Escape the law"
      }
    },
    WarmupTypes = {
      ["Getaway Warmup"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          warmupRouteName = "Escape the law warmup",
          forceZapToVehicle = false,
          forceMissionAccept = false,
          actorToChase = "evade team member 1",
          lookToVehicle = false
        },
        ["name"] = "Warmup route"
      }
    },
    MissionSettings = {
      ["New MissionSetting"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Spawn type"] = "Always active",
          ["Cutscene at mission end"] = "mis_ch1_meet_the_heat_01",
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Escape the law start",
          ["Audio logic file"] = "Escape the law",
          ["freezeFrameOnMissionEndCutscene"] = true,
          ["Delete task object on reject preview"] = false,
          ["disablePlayerIgnoring"] = false,
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    MissionInfos = {
      ["New Title and description 3"] = {
        [1] = {
          ["1 Text"] = "ID:245527",
          ["missionMarkers"] = {
            [1] = {
              value = "None",
              cardName = "Dropoff vehicle",
              cardType = "Actor"
            },
            [2] = {
              value = "Objective",
              cardName = "evade team member 1",
              cardType = "Actor"
            },
            [3] = {
              value = "None",
              cardName = "chase team member 2",
              cardType = "Actor"
            },
            [4] = {
              value = "None",
              cardName = "chase team member 1",
              cardType = "Actor"
            }
          },
          ["2 Text"] = "ID:245528"
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Escape the law"] = {
        [1] = {
          ["Chase team"] = {
            instance = 1,
            type = "Teams",
            name = "chase team"
          },
          ["Evade team"] = {
            instance = 1,
            type = "Teams",
            name = "evade team"
          },
          ["Time limit text"] = "GET TO RENDEZVOUS IN:",
          ["Time limit"] = 210,
          ["Dropoff team"] = {
            instance = 1,
            type = "Teams",
            name = "Dropoff Team"
          }
        },
        ["name"] = "Escape the law"
      }
    }
  }
}
