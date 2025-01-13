cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Final fight"] = {
  FileVersion = "2",
  name = "Final fight",
  title = "ID:184958",
  MissionID = "8526",
  description = "ID:184958",
  cardInstances = {
    CustomAggressionSettings = {
      ["New CustomAggressionSetting"] = {
        [1] = {groupTakeDownFollowDistanceforNonAttackers = 30, groupTakeDownPerformanceBoost = 1.25},
        ["name"] = "CustomAggressionSetting"
      }
    },
    Characters = {
      ["Jericho Character"] = {
        [1] = {
          ["Driver id"] = "-376150524"
        },
        ["name"] = "Character"
      },
      ["Character"] = {
        [1] = {
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      }
    },
    SpawnTypes = {
      ["Player spawn"] = {
        [1] = {},
        ["name"] = "As localPlayer"
      },
      ["Tanner Positions"] = {
        [1] = {
          ["1"] = "Tanner"
        },
        ["name"] = "Positions"
      },
      ["Jericho Relative to Tanner"] = {
        [1] = {
          actor = "Tanner",
          whichLane = "randomLane",
          withVehicleDirection = true,
          distance = 30,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = true
        },
        ["name"] = "Relative to Vehicle"
      }
    },
    FelonySettings = {
      FelonySettings = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    Actors = {
      ["Jericho"] = {
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
            name = "Jericho Team"
          },
          drivingSkill = "Reckless",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Jericho Character"
          },
          forceHighLodCharacters = true,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On mission start",
          vehicleTrailerId = -1,
          distanceFromFrontOfGroup = 10,
          driveInOncoming = 0.5,
          driveOnPavements = 0.3,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 0,
          avoidUTurns = true,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Jericho Relative to Tanner"
          },
          vehicleId = 181,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 40,
          rubberbandingActor = "Tanner",
          damageMultiplier = 0.75,
          attackStationaryVehicle = false,
          rubberbandingStrength = "High",
          distanceBehindPlayer = -20,
          reactionTime = "Fastest",
          raceManagerRoute = true,
          stayInLockedArea = true,
          blockTow = true,
          avoidedByCivilianTraffic = false,
          avoidAttacks = true,
          avoidAlleys = 0.5,
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
          reactionTime = "Average",
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
            name = "Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
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
            name = "New Cutscene"
          },
          shaderParam = 0,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Tanner Positions"
          },
          vehicleId = 62,
          enableSimulationArea = true,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 30,
          rubberbandingActor = "Jericho",
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = 40,
          desiredSpeed = 60,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          previewMovie = "no preview",
          avoidAttacks = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Player Actor"] = {
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
            name = "Player Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
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
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Player spawn"
          },
          vehicleId = -1,
          attackStationaryVehicle = false,
          enableSiren = false,
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
    Teams = {
      ["Tanner Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Jericho Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Player Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionCompletes = {
      COMPLETION = {
        [1] = {
          ["Perfect condition"] = "ID:184962",
          ["Success reason"] = "ID:184962",
          ["Failure reason"] = "ID:184961",
          ["Success reason (perfect)"] = "ID:184962",
          ["Pass condition"] = "ID:184962",
          ["Failure reason (wrecked)"] = "ID:184961"
        },
        ["name"] = "Final fight"
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
      ["New Cutscene"] = {
        [1] = {forceMissionAccept = true},
        ["name"] = "Cutscene"
      }
    },
    MissionSettings = {
      ["MISSION SETTINGS"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = true,
          ["Spawn type"] = "Always active",
          ["Disable traffic"] = false,
          ["Cutscene on mission start"] = "mis_ch8_finale_01",
          ["Clear area around vehicles"] = 100,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Final fight start",
          ["Audio logic file"] = "Final Fight APIP",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["disablePlayerIgnoring"] = false,
          ["Enable race status prompts"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    MissionInfos = {
      ["MISSION INFO"] = {
        [1] = {
          ["1 Text"] = "ID:184960",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective",
              cardName = "Tanner",
              cardType = "Actor"
            },
            [2] = {
              value = "None",
              cardName = "Player Actor",
              cardType = "Actor"
            },
            [3] = {
              value = "Red Marker, Getaway Radius",
              cardName = "Jericho",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["MISSION TYPE"] = {
        [1] = {
          ["Jericho team"] = {
            instance = 1,
            type = "Teams",
            name = "Jericho Team"
          },
          ["Tanner team"] = {
            instance = 1,
            type = "Teams",
            name = "Tanner Team"
          },
          ["Player team"] = {
            instance = 1,
            type = "Teams",
            name = "Player Team"
          }
        },
        ["name"] = "Final fight"
      }
    }
  }
}
