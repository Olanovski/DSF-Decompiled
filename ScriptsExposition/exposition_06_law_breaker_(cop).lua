cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Exposition 06 Law Breaker (cop)"] = {
  FileVersion = "2",
  name = "Exposition 06 Law Breaker (cop)",
  title = "ID:178461",
  MissionID = "2807",
  description = "ID:232273",
  cardInstances = {
    Actors = {
      Evader = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 70,
          team = {
            instance = 1,
            type = "Teams",
            name = "Evader team"
          },
          drivingSkill = "Cautious",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Criminal"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          driveInOncoming = 0.2,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Warmup"
          },
          vehicleTrailerId = -1,
          avoidUTurns = true,
          avoidedByCivilianTraffic = true,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          shaderParam = 3,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Evade team member 1 Set position"
          },
          vehicleId = 160,
          enableSiren = false,
          rubberbandingToPlayerStrength = "Medium",
          enableSimulationArea = true,
          spawnSpeed = 20,
          rubberbandingActor = "Chaser",
          damageMultiplier = 1.5,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = -20,
          ignoreCivilianTraffic = false,
          stayInLockedArea = true,
          blockTow = false,
          reactionTime = "Fast",
          avoidAttacks = false,
          raceManagerRoute = true,
          aiIgnorePlayerInCivsUntilHit = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      Player = {
        [1] = {
          noOccupants = false,
          lockedToPlayer = false,
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          reactionTime = "Average",
          whenSpawned = "On mission start",
          aiIgnorePlayerInCivsUntilHit = false,
          aiIgnorePlayers = false,
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New As localPlayer"
          },
          team = {
            instance = 1,
            type = "Teams",
            name = "Player team"
          },
          takeNonPlayerDamage = false,
          enableSimulationArea = false,
          vehicleId = -1,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          matchTrafficSpeed = false,
          attackStationaryVehicle = false,
          forceHighLodCharacters = false,
          drivingSkill = "Average",
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          blockTow = false,
          enableSiren = false,
          avoidAttacks = false,
          obeyRaceTowingRules = false,
          stayInLockedArea = false,
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      Chaser = {
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
            name = "Chaser team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop car characters"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          tailingDistance = 30,
          vehicleTrailerId = -1,
          previewMovie = "preview vehicle",
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Warmup"
          },
          avoidUTurns = true,
          avoidedByCivilianTraffic = true,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          shaderParam = 0,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Chase team member 1 Set position"
          },
          vehicleId = 269,
          enableSiren = true,
          enableSimulationArea = false,
          rubberbandingActor = "Evader",
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          ignoreCivilianTraffic = false,
          noOccupants = false,
          stayInLockedArea = true,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          raceManagerRoute = false,
          aiIgnorePlayerInCivsUntilHit = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Cop car characters"] = {
        [1] = {
          ["Passenger id"] = "-1907524522",
          ["Driver id"] = "105509604"
        },
        ["name"] = "Character"
      },
      ["Criminal"] = {
        [1] = {
          ["Passenger id"] = "-1156800003",
          ["Behind passenger id"] = "-1",
          ["Driver id"] = "-1840058621",
          ["Behind driver id"] = "-1"
        },
        ["name"] = "Character"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    SpawnTypes = {
      ["New Positions"] = {
        [1] = {
          ["1"] = "Evader",
          ["2"] = "Chaser"
        },
        ["name"] = "Positions"
      },
      ["Chase team member 1 Set position"] = {
        [1] = {
          ["Spawn location"] = "ExpositionLawbreakerCopStart",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Evade team member 1 Set position"] = {
        [1] = {
          ["Spawn location"] = "ExpositionLawbreakerGetawayStart",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["New As localPlayer"] = {
        [1] = {},
        ["name"] = "As localPlayer"
      }
    },
    Teams = {
      ["Chaser team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Evader team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Player team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionCompletes = {
      ["New Exposition takedown the getaway"] = {
        [1] = {
          ["Failure reason (wrecked)"] = "ID:178465",
          ["Success reason"] = "ID:178466",
          ["Pass condition"] = "ID:178466",
          ["Failure reason"] = "ID:178464"
        },
        ["name"] = "Exposition takedown the getaway"
      }
    },
    WarmupTypes = {
      Warmup = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          matchTrafficSpeed = false,
          warmupRouteName = "ExpositionLawBreakerCopWarmupRoute",
          forceZapToVehicle = false,
          actorToChase = "Evader",
          forceMissionAccept = false,
          lookToVehicle = false
        },
        ["name"] = "Warmup route"
      }
    },
    MissionSettings = {
      ["New MissionSetting"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Disable traffic"] = false,
          ["Hud logic file"] = "Takedown HUD",
          ["Mission end location"] = "Takedown",
          ["Enable traffic at mission end"] = false,
          ["disablePlayerIgnoring"] = false,
          ["Audio logic file"] = "Exposition takedown the getaway APIP",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["Start location"] = "ExpositionLawbreakerCopStart",
          ["Enable race status prompts"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    MissionInfos = {
      ["Mission Description"] = {
        [1] = {
          ["1 Text"] = "ID:178462",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective",
              cardName = "Chaser",
              cardType = "Actor"
            },
            [2] = {
              value = "Red Marker, Fake Felony Radius",
              cardName = "Evader",
              cardType = "Actor"
            },
            [3] = {
              value = "None",
              cardName = "Player",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Exposition takedown the getaway 2"] = {
        [1] = {
          ["Chase team"] = {
            instance = 1,
            type = "Teams",
            name = "Chaser team"
          },
          ["Player"] = {
            instance = 1,
            type = "Teams",
            name = "Player team"
          },
          ["Evade team"] = {
            instance = 1,
            type = "Teams",
            name = "Evader team"
          }
        },
        ["name"] = "Exposition takedown the getaway"
      }
    }
  }
}
