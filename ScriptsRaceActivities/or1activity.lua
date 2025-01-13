cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.OR1Activity = {
  FileVersion = "2",
  name = "OR1Activity",
  title = "ID:244242",
  MissionID = "193",
  description = "ID:245573",
  cardInstances = {
    Actors = {
      ["Player"] = {
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
            name = "Player Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          accidentProbability = 0,
          characters = {
            instance = 1,
            type = "Characters",
            name = "New Character 1"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          enableSiren = false,
          driveInOncoming = 0.5,
          driveOnPavements = 0.5,
          noOccupants = false,
          shaderParam = 0,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static to rolling"
          },
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          enableSimulationArea = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 184,
          desiredSpeed = 80,
          spawnSpeed = 30,
          isMultiplayerActor = false,
          damageMultiplier = 0.6,
          attackStationaryVehicle = false,
          matchTrafficSpeed = false,
          routeName = "OpenRace1Route1",
          raceManagerRoute = true,
          stayInLockedArea = false,
          blockTow = false,
          previewMovie = "PreviewVehicle",
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0.5,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Opponent 2"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 110,
          team = {
            instance = 1,
            type = "Teams",
            name = "Opponent Team 1"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          rubberBandMinVelocityTopSpeedFraction = 0.8,
          accidentProbability = 0,
          characters = {
            instance = 1,
            type = "Characters",
            name = "New Character 2"
          },
          forceHighLodCharacters = false,
          vehicleTrailerId = -1,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          enableSimulationArea = false,
          shaderParam = 2,
          driveInOncoming = 0.2,
          driveOnPavements = 0.4,
          noOccupants = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static to rolling"
          },
          enableSiren = false,
          avoidUTurns = true,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 184,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Medium",
          spawnSpeed = 40,
          rubberbandingActor = "Player",
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          distanceBehindPlayer = 10,
          aiIgnorePlayerInCivsUntilHit = false,
          routeName = "OpenRace1Route1",
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          ignoreCivilianTraffic = false,
          collisionResilience = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Opponent 3"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 80,
          team = {
            instance = 1,
            type = "Teams",
            name = "Opponent Team 2"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          rubberBandMinVelocityTopSpeedFraction = 0.85,
          accidentProbability = 0,
          characters = {
            instance = 1,
            type = "Characters",
            name = "New Character 2"
          },
          forceHighLodCharacters = false,
          vehicleTrailerId = -1,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          enableSimulationArea = false,
          shaderParam = 0,
          driveInOncoming = 0.2,
          driveOnPavements = 0.4,
          noOccupants = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static to rolling"
          },
          enableSiren = false,
          avoidUTurns = true,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 183,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Medium",
          spawnSpeed = 40,
          rubberbandingActor = "Player",
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -60,
          aiIgnorePlayerInCivsUntilHit = false,
          routeName = "OpenRace1Route1",
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          ignoreCivilianTraffic = false,
          collisionResilience = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Opponent 1"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 80,
          team = {
            instance = 1,
            type = "Teams",
            name = "Opponent Team 1"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          rubberBandMinVelocityTopSpeedFraction = 0.85,
          accidentProbability = 0,
          characters = {
            instance = 1,
            type = "Characters",
            name = "New Character 2"
          },
          forceHighLodCharacters = false,
          vehicleTrailerId = -1,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          enableSimulationArea = false,
          shaderParam = 1,
          driveInOncoming = 0.2,
          driveOnPavements = 0.4,
          noOccupants = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static to rolling"
          },
          enableSiren = false,
          avoidUTurns = true,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 183,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Medium",
          spawnSpeed = 40,
          rubberbandingActor = "Player",
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -60,
          aiIgnorePlayerInCivsUntilHit = false,
          routeName = "OpenRace1Route1",
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          ignoreCivilianTraffic = false,
          collisionResilience = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Opponent 4"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 115,
          team = {
            instance = 1,
            type = "Teams",
            name = "Opponent Team 2"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          rubberBandMinVelocityTopSpeedFraction = 0.8,
          accidentProbability = 0,
          characters = {
            instance = 1,
            type = "Characters",
            name = "New Character 2"
          },
          forceHighLodCharacters = false,
          vehicleTrailerId = -1,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          enableSimulationArea = false,
          shaderParam = 6,
          driveInOncoming = 0.2,
          driveOnPavements = 0.4,
          noOccupants = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Static to rolling"
          },
          enableSiren = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 184,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Medium",
          spawnSpeed = 40,
          rubberbandingActor = "Player",
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          distanceBehindPlayer = 20,
          aiIgnorePlayerInCivsUntilHit = false,
          routeName = "OpenRace1Route1",
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          ignoreCivilianTraffic = false,
          collisionResilience = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["New Character 4"] = {
        [1] = {
          ["Driver id"] = "600862826"
        },
        ["name"] = "Character"
      },
      ["New Character 1"] = {
        [1] = {
          ["Driver id"] = "-70535787"
        },
        ["name"] = "Character"
      },
      ["New Character 2"] = {
        [1] = {
          ["Driver id"] = "759755112"
        },
        ["name"] = "Character"
      },
      ["New Character 3"] = {
        [1] = {
          ["Driver id"] = "-1612258239"
        },
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
          ["Start location"] = "OR1ActivityStart",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["disablePlayerIgnoring"] = false,
          ["Enable race status prompts"] = true
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["Opponent Team 2"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Opponent Team 1"] = {
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
      ["New Positions"] = {
        [1] = {
          ["1"] = "Opponent 1",
          ["3"] = "Opponent 3",
          ["2"] = "Opponent 2",
          ["5"] = "Player",
          ["4"] = "Opponent 4"
        },
        ["name"] = "Positions"
      }
    },
    MissionInfos = {
      ["New Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:184014",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective",
              cardName = "Player",
              cardType = "Actor"
            },
            [2] = {
              value = "Opponent",
              cardName = "Opponent 3",
              cardType = "Actor"
            },
            [3] = {
              value = "Opponent",
              cardName = "Opponent 1",
              cardType = "Actor"
            },
            [4] = {
              value = "Opponent",
              cardName = "Opponent 2",
              cardType = "Actor"
            },
            [5] = {
              value = "Opponent",
              cardName = "Opponent 4",
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
          ["Willpower reduction rate"] = 0,
          ["Disable Shift"] = false,
          ["Willpower reward"] = 0,
          ["Destroy opposing teams"] = true,
          ["Endless race"] = false,
          ["Willpower reduction time"] = 0,
          ["Race team 2"] = {
            instance = 1,
            type = "Teams",
            name = "Opponent Team 1"
          },
          ["Damage amount for fail"] = 1,
          ["Race team 1"] = {
            instance = 1,
            type = "Teams",
            name = "Player Team"
          },
          ["Start countdown"] = false,
          ["Hide checkpoints"] = false,
          ["Start prompt"] = "ID:243843",
          ["Race team 3"] = {
            instance = 1,
            type = "Teams",
            name = "Opponent Team 2"
          },
          ["Secondary start prompt"] = "ID:245573",
          ["Checkpoint type"] = "Hotspot"
        },
        ["name"] = "Generic race activity"
      }
    }
  }
}
