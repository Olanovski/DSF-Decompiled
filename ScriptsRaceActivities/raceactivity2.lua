cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.RaceActivity2 = {
  FileVersion = "2",
  name = "RaceActivity2",
  title = "ID:244240",
  MissionID = "19152",
  description = "ID:245574",
  cardInstances = {
    Actors = {
      ["Player Actor"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = true,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 100,
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
            name = "New Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          previewMovie = "Preview",
          enableSiren = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static to rolling"
          },
          shaderParam = 0,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0.5,
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Spawn Positions"
          },
          vehicleId = 133,
          enableSimulationArea = false,
          spawnSpeed = 30,
          isMultiplayerActor = false,
          damageMultiplier = 0.6,
          attackStationaryVehicle = false,
          ignoreCivilianTraffic = false,
          matchTrafficSpeed = false,
          routeName = "Race activity 2",
          noOccupants = false,
          stayInLockedArea = false,
          blockTow = false,
          raceManagerRoute = true,
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Enemy Actor 3"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 140,
          team = {
            instance = 1,
            type = "Teams",
            name = "Enemy team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          rubberBandMinVelocityTopSpeedFraction = 0.8,
          characters = {
            instance = 1,
            type = "Characters",
            name = "New Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          driveInOncoming = 0.2,
          driveOnPavements = 0.4,
          noOccupants = false,
          enableSimulationArea = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static to rolling"
          },
          shaderParam = 3,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          enableSiren = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Spawn Positions"
          },
          vehicleId = 124,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 35,
          rubberbandingActor = "Player Actor",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = -95,
          ignoreCivilianTraffic = false,
          routeName = "Race activity 2",
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          raceManagerRoute = false,
          aiIgnorePlayerInCivsUntilHit = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Enemy Actor 2"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 130,
          team = {
            instance = 1,
            type = "Teams",
            name = "Enemy team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          rubberBandMinVelocityTopSpeedFraction = 0.8,
          characters = {
            instance = 1,
            type = "Characters",
            name = "New Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          driveInOncoming = 0.2,
          driveOnPavements = 0.4,
          noOccupants = false,
          enableSimulationArea = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static to rolling"
          },
          shaderParam = 5,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          enableSiren = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Spawn Positions"
          },
          vehicleId = 127,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 30,
          rubberbandingActor = "Player Actor",
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = -90,
          ignoreCivilianTraffic = false,
          routeName = "Race activity 2",
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          raceManagerRoute = false,
          aiIgnorePlayerInCivsUntilHit = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Enemy Actor 1"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 130,
          team = {
            instance = 1,
            type = "Teams",
            name = "Enemy team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          rubberBandMinVelocityTopSpeedFraction = 0.8,
          characters = {
            instance = 1,
            type = "Characters",
            name = "New Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          driveInOncoming = 0.2,
          driveOnPavements = 0.4,
          noOccupants = false,
          enableSimulationArea = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static to rolling"
          },
          shaderParam = 1,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          enableSiren = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Spawn Positions"
          },
          vehicleId = 127,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 25,
          rubberbandingActor = "Player Actor",
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = -85,
          ignoreCivilianTraffic = false,
          routeName = "Race activity 2",
          stayInLockedArea = false,
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
      ["New Character"] = {
        [1] = {},
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      ["New MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Disable traffic"] = false,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Race activity 2 start",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["disablePlayerIgnoring"] = false,
          ["Enable race status prompts"] = true
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["Enemy team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Player Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
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
      ["New Static to rolling"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          forceZapToVehicle = false,
          forceMissionAccept = false,
          lookToVehicle = false
        },
        ["name"] = "Static to rolling"
      }
    },
    SpawnTypes = {
      ["Spawn Positions"] = {
        [1] = {
          ["1"] = "Enemy Actor 1",
          ["4"] = "Player Actor",
          ["3"] = "Enemy Actor 3",
          ["2"] = "Enemy Actor 2"
        },
        ["name"] = "Positions"
      }
    },
    MissionInfos = {
      ["New Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:184013",
          ["showRouteArrows"] = "All",
          ["missionMarkers"] = {
            [1] = {
              value = "Opponent",
              cardName = "Enemy Actor 1",
              cardType = "Actor"
            },
            [2] = {
              value = "Opponent",
              cardName = "Enemy Actor 2",
              cardType = "Actor"
            },
            [3] = {
              value = "Opponent",
              cardName = "Enemy Actor 3",
              cardType = "Actor"
            },
            [4] = {
              value = "Objective",
              cardName = "Player Actor",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Generic race activity"] = {
        [1] = {
          ["Willpower reward"] = 0,
          ["Destroy opposing teams"] = true,
          ["Endless race"] = false,
          ["Race team 2"] = {
            instance = 1,
            type = "Teams",
            name = "Enemy team"
          },
          ["Race team 1"] = {
            instance = 1,
            type = "Teams",
            name = "Player Team"
          },
          ["Start countdown"] = false,
          ["Damage amount for fail"] = 1,
          ["Hide checkpoints"] = false,
          ["Disable Shift"] = false,
          ["Checkpoint type"] = "Checkpoint Gate"
        },
        ["name"] = "Generic race activity"
      }
    }
  }
}
