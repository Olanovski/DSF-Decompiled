cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.RallyFaceOff = {
  FileVersion = "2",
  name = "RallyFaceOff",
  title = "ID:214701",
  MissionID = "33093",
  description = "ID:245448",
  cardInstances = {
    Actors = {
      ["Race team 2 member 2"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 65,
          team = {
            instance = 1,
            type = "Teams",
            name = "New Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          enableSiren = false,
          distanceFromFrontOfGroup = 0,
          driveInOncoming = 0.9,
          driveOnPavements = 0.9,
          noOccupants = false,
          shaderParam = 3,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "RallyFaceOff Static"
          },
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Weak",
          ignoreOtherAis = false,
          enableSimulationArea = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions 2"
          },
          vehicleId = 217,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Weaker",
          spawnSpeed = 0,
          rubberbandingActor = "Race team 1 member 1",
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -20,
          avoidedByCivilianTraffic = false,
          raceManagerRoute = false,
          routeName = "RallyFaceOffRoute",
          stayInLockedArea = false,
          blockTow = false,
          avoidAlleys = 1,
          avoidAttacks = false,
          ignoreCivilianTraffic = false,
          reactionTime = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Race team 2 member 4"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 75,
          team = {
            instance = 1,
            type = "Teams",
            name = "New Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          enableSiren = false,
          distanceFromFrontOfGroup = 0,
          driveInOncoming = 0.9,
          driveOnPavements = 0.9,
          noOccupants = false,
          shaderParam = 1,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "RallyFaceOff Static"
          },
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          enableSimulationArea = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions 2"
          },
          vehicleId = 217,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Medium",
          spawnSpeed = 0,
          rubberbandingActor = "Race team 1 member 1",
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -30,
          avoidedByCivilianTraffic = false,
          raceManagerRoute = false,
          routeName = "RallyFaceOffRoute",
          stayInLockedArea = false,
          blockTow = false,
          avoidAlleys = 1,
          avoidAttacks = false,
          ignoreCivilianTraffic = false,
          reactionTime = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Race team 1 member 1"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = true,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "RallyFaceOff Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "RallyFaceOff Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          driveInOncoming = 0.9,
          driveOnPavements = 0.9,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "RallyFaceOff Static"
          },
          shaderParam = 4,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions 2"
          },
          vehicleId = 217,
          enableSimulationArea = false,
          isMultiplayerActor = false,
          spawnSpeed = 0,
          damageMultiplier = 0.7,
          attackStationaryVehicle = false,
          desiredSpeed = 0,
          raceManagerRoute = true,
          routeName = "RallyFaceOffRoute",
          stayInLockedArea = false,
          blockTow = false,
          previewMovie = " ",
          avoidAttacks = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Race team 2 member 1"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 65,
          team = {
            instance = 1,
            type = "Teams",
            name = "New Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          enableSiren = false,
          distanceFromFrontOfGroup = 0,
          driveInOncoming = 0.9,
          driveOnPavements = 0.9,
          noOccupants = false,
          shaderParam = 2,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "RallyFaceOff Static"
          },
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          enableSimulationArea = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions 2"
          },
          vehicleId = 217,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Weak",
          spawnSpeed = 0,
          rubberbandingActor = "Race team 1 member 1",
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -15,
          avoidedByCivilianTraffic = false,
          raceManagerRoute = false,
          routeName = "RallyFaceOffRoute",
          stayInLockedArea = false,
          blockTow = false,
          avoidAlleys = 1,
          avoidAttacks = false,
          ignoreCivilianTraffic = false,
          reactionTime = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Race team 2 member 5"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 70,
          team = {
            instance = 1,
            type = "Teams",
            name = "New Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          enableSiren = false,
          distanceFromFrontOfGroup = 0,
          driveInOncoming = 0.9,
          driveOnPavements = 0.9,
          noOccupants = false,
          shaderParam = 3,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "RallyFaceOff Static"
          },
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          enableSimulationArea = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions 2"
          },
          vehicleId = 217,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Medium",
          spawnSpeed = 0,
          rubberbandingActor = "Race team 1 member 1",
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -35,
          avoidedByCivilianTraffic = false,
          raceManagerRoute = false,
          routeName = "RallyFaceOffRoute",
          stayInLockedArea = false,
          blockTow = false,
          avoidAlleys = 1,
          avoidAttacks = false,
          ignoreCivilianTraffic = false,
          reactionTime = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Race team 2 member 3"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 75,
          team = {
            instance = 1,
            type = "Teams",
            name = "New Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          enableSiren = false,
          distanceFromFrontOfGroup = 0,
          driveInOncoming = 0.9,
          driveOnPavements = 0.9,
          noOccupants = false,
          shaderParam = 5,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "RallyFaceOff Static"
          },
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          enableSimulationArea = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions 2"
          },
          vehicleId = 217,
          isMultiplayerActor = false,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 0,
          rubberbandingActor = "Race team 1 member 1",
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -25,
          avoidedByCivilianTraffic = false,
          raceManagerRoute = false,
          routeName = "RallyFaceOffRoute",
          stayInLockedArea = false,
          blockTow = false,
          avoidAlleys = 1,
          avoidAttacks = false,
          ignoreCivilianTraffic = false,
          reactionTime = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["RallyFaceOff Character"] = {
        [1] = {
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      ["RallyFaceOff MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Disable traffic"] = true,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "RallyFaceOffStart",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = true,
          ["disablePlayerIgnoring"] = false,
          ["Enable race status prompts"] = true
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["New Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["RallyFaceOff Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    FelonySettings = {
      ["New FelonySettings 2"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    WarmupTypes = {
      ["RallyFaceOff Static"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          forceZapToVehicle = false,
          forceMissionAccept = false,
          lookToVehicle = false
        },
        ["name"] = "Static"
      }
    },
    SpawnTypes = {
      ["New Positions 2"] = {
        [1] = {
          ["1"] = "Race team 2 member 1",
          ["3"] = "Race team 2 member 3",
          ["2"] = "Race team 2 member 2",
          ["5"] = "Race team 2 member 5",
          ["4"] = "Race team 2 member 4",
          ["6"] = "Race team 1 member 1"
        },
        ["name"] = "Positions"
      }
    },
    MissionInfos = {
      ["RallyFaceOff Title"] = {
        [1] = {
          ["1 Text"] = "ID:245600",
          ["Success reason"] = "ID:183987",
          ["showRouteArrows"] = "All",
          ["missionMarkers"] = {
            [1] = {
              value = "Opponent",
              cardName = "Race team 2 member 3",
              cardType = "Actor"
            },
            [2] = {
              value = "Opponent",
              cardName = "Race team 2 member 4",
              cardType = "Actor"
            },
            [3] = {
              value = "Opponent",
              cardName = "Race team 2 member 2",
              cardType = "Actor"
            },
            [4] = {
              value = "Objective",
              cardName = "Race team 1 member 1",
              cardType = "Actor"
            },
            [5] = {
              value = "Opponent",
              cardName = "Race team 2 member 1",
              cardType = "Actor"
            },
            [6] = {
              value = "Opponent",
              cardName = "Race team 2 member 5",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["RallyFaceOff settings"] = {
        [1] = {
          ["Slow motion on goal complete"] = false,
          ["Total laps"] = 0,
          ["Destroy opposing teams"] = false,
          ["Endless race"] = false,
          ["Overtake target (+ score)"] = false,
          ["Race team 2"] = {
            instance = 1,
            type = "Teams",
            name = "New Team"
          },
          ["Score drift distance"] = false,
          ["Race team 1"] = {
            instance = 1,
            type = "Teams",
            name = "RallyFaceOff Team"
          },
          ["Score jump distance"] = false,
          ["Damage amount for fail"] = 1,
          ["Start prompt"] = "ID:245600",
          ["scoringType"] = "Time",
          ["Hide checkpoints"] = false,
          ["Checkpoint type"] = "Checkpoint Gate"
        },
        ["name"] = "Generic challenge race"
      }
    }
  }
}
