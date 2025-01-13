cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Peroxide convoy"] = {
  FileVersion = "2",
  name = "Peroxide convoy",
  title = "ID:184635",
  MissionID = "5907",
  description = "ID:184636",
  cardInstances = {
    Actors = {
      Tanner = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Fastest",
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 50,
          team = {
            instance = 1,
            type = "Teams",
            name = "Team Tanner"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Tanner Character"
          },
          forceHighLodCharacters = false,
          vehicleTrailerId = -1,
          wanderType = "preferStraight",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          shaderParam = 0,
          tailingDistance = 75,
          driveOnPavements = 0.2,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Warmup route"
          },
          enableSimulationArea = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          driveInOncoming = 0.2,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Tanner positions"
          },
          vehicleId = 62,
          rubberbandingToPlayerStrength = "Strong",
          isMultiplayerActor = false,
          spawnSpeed = 30,
          rubberbandingActor = "Convoy1",
          distanceBehindPlayer = 180,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          previewMovie = " ",
          routeName = "Peroxide convoy initial drive",
          raceManagerRoute = false,
          matchTrafficSpeed = false,
          stayInLockedArea = true,
          blockTow = false,
          ignoreCivilianTraffic = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      Convoy2 = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          desiredSpeed = 70,
          team = {
            instance = 1,
            type = "Teams",
            name = "Convoy"
          },
          drivingSkill = "Reckless",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "New Character 2"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          vehicleTrailerId = -1,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Convoy spawn"
          },
          vehicleId = 291,
          enableSiren = false,
          enableSimulationArea = true,
          spawnSpeed = 90,
          damageMultiplier = 1.5,
          attackStationaryVehicle = false,
          reactionTime = "Fast",
          raceManagerRoute = true,
          routeName = "Peroxide Convoy Tanker 2 Route",
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          avoidAlleys = 1,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      Convoy3 = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Convoy"
          },
          drivingSkill = "Reckless",
          disablePanelDetach = false,
          accidentProbability = 0,
          characters = {
            instance = 1,
            type = "Characters",
            name = "New Character 2"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          enableSiren = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 1,
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Convoy spawn"
          },
          vehicleId = 291,
          enableSimulationArea = true,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 90,
          rubberbandingActor = "Convoy2",
          damageMultiplier = 1.5,
          attackStationaryVehicle = false,
          distanceBehindPlayer = 75,
          collisionResilience = "Unstoppable",
          routeName = "Peroxide Convoy Tanker 2 Route",
          raceManagerRoute = true,
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Fast",
          avoidAttacks = false,
          desiredSpeed = 70,
          aiIgnorePlayerInCivsUntilHit = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      Convoy1 = {
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
            name = "Initial tanker team"
          },
          drivingSkill = "Reckless",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "New Character"
          },
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
          vehicleTrailerId = 131,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          shaderParam = 3,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Convoy1 test"
          },
          vehicleId = 286,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 90,
          damageMultiplier = 1.4,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          raceManagerRoute = true,
          routeName = "Peroxide Convoy Tanker 1 Route",
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          avoidAlleys = 1,
          ignoreCivilianTraffic = true,
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
      ["New Character"] = {
        [1] = {
          ["Driver id"] = "-168158214"
        },
        ["name"] = "Character"
      },
      ["New Character 2"] = {
        [1] = {
          ["Driver id"] = "1030000186"
        },
        ["name"] = "Character"
      }
    },
    SpawnTypes = {
      ["Tanner positions"] = {
        [1] = {
          ["1"] = "Tanner"
        },
        ["name"] = "Positions"
      },
      ["Convoy spawn"] = {
        [1] = {
          ["1"] = "Convoy2",
          ["alternateLocation"] = "Peroxide convoy convoy2 spawn",
          ["2"] = "Convoy3"
        },
        ["name"] = "Positions"
      },
      ["Convoy1 test"] = {
        [1] = {
          ["Spawn location"] = "Peroxide convoy convoy1 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {reenablePatrollingVehiclesAfterFelonyEnd = false, disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    Teams = {
      ["Convoy"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Initial tanker team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Team Tanner"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionCompletes = {
      ["New Peroxide convoy"] = {
        [1] = {
          ["Camera shots"] = 2
        },
        ["name"] = "Peroxide convoy"
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
      },
      ["New Warmup route"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          lookToVehicleTriggerRadius = 50,
          forceMissionAccept = false,
          warmupRouteName = "Peroxide convoy warmup",
          forceZapToVehicle = false,
          matchTrafficSpeed = false,
          driveInOncoming = 0.1,
          lookToVehicle = false
        },
        ["name"] = "Warmup route"
      }
    },
    MissionSettings = {
      ["New MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Load traffic on start"] = "SM3 Peroxide Convoy",
          ["Disable traffic"] = false,
          ["Cutscene after mission end screen"] = "ch1_krugarrest",
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Peroxide convoy start",
          ["Audio logic file"] = "Peroxide Convoy APIP",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["disablePlayerIgnoring"] = true,
          ["Enable race status prompts"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    MissionInfos = {
      ["New Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:245537",
          ["Success reason"] = "ID:184644 ",
          ["missionMarkers"] = {
            [1] = {
              value = "Opponent",
              cardName = "Convoy1",
              cardType = "Actor"
            },
            [2] = {
              value = "Opponent",
              cardName = "Convoy3",
              cardType = "Actor"
            },
            [3] = {
              value = "Objective (No light trails)",
              cardName = "Tanner",
              cardType = "Actor"
            },
            [4] = {
              value = "Opponent",
              cardName = "Convoy2",
              cardType = "Actor"
            }
          },
          ["6 Text"] = "ID:245538",
          ["5 Text"] = "ID:184641",
          ["4 Text"] = "ID:184640",
          ["3 Text"] = "ID:184640",
          ["2 Text"] = "ID:184638"
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Peroxide convoy 2"] = {
        [1] = {
          ["Chase team"] = {
            instance = 1,
            type = "Teams",
            name = "Team Tanner"
          },
          ["Race team"] = {
            instance = 1,
            type = "Teams",
            name = "Convoy"
          },
          ["Initial tanker team"] = {
            instance = 1,
            type = "Teams",
            name = "Initial tanker team"
          }
        },
        ["name"] = "Peroxide convoy"
      }
    }
  }
}
