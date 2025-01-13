cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.TheGetaway = {
  FileVersion = "2",
  name = "TheGetaway",
  title = "ID:214712",
  MissionID = "36165",
  description = "ID:245470",
  cardInstances = {
    Actors = {
      Evader = {
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
            name = "Getaway team"
          },
          drivingSkill = "Reckless",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Opponent Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          driveInOncoming = 0.4,
          driveOnPavements = 0.3,
          noOccupants = false,
          enableSimulationArea = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "TheGetaway Static"
          },
          shaderParam = 2,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          enableSiren = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "TheGetaway Set position"
          },
          vehicleId = 164,
          rubberbandingToPlayerStrength = "Strong",
          isMultiplayerActor = false,
          spawnSpeed = 0,
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -50,
          desiredSpeed = 90,
          raceManagerRoute = true,
          routeName = "TheGetawayRoute",
          stayInLockedArea = true,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = true,
          avoidAlleys = 0,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      localPlayer = {
        [1] = {
          noOccupants = false,
          lockedToPlayer = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          blockTow = false,
          matchTrafficSpeed = false,
          wrongWayIndicator = false,
          obeyRaceTowingRules = false,
          enableSiren = false,
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
            name = "Player Team"
          },
          vehicleId = -1,
          drivingSkill = "Average",
          disablePanelDetach = false,
          reactionTime = "Average",
          aiIgnorePlayerInCivsUntilHit = false,
          aiIgnorePlayers = false,
          enableSimulationArea = false,
          attackStationaryVehicle = false,
          forceHighLodCharacters = false,
          avoidUTurns = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          stayInLockedArea = false,
          whenSpawned = "On mission start",
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          collisionResilience = "Average",
          maintainLane = false,
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
          routeName = "TheGetawayRoute",
          team = {
            instance = 1,
            type = "Teams",
            name = "Chaser Team"
          },
          drivingSkill = "Reckless",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "TheGetaway Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          previewMovie = " ",
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "TheGetaway Static"
          },
          panelSet = 1,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          shaderParam = 0,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "GetAway Player Set position"
          },
          vehicleId = 188,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 0,
          restrictedVehicleType = 0,
          damageMultiplier = 0.6,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          ignoreCivilianTraffic = false,
          noOccupants = false,
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          raceManagerRoute = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Opponent Character"] = {
        [1] = {
          ["Driver id"] = "236852288"
        },
        ["name"] = "Character"
      },
      ["TheGetaway Character"] = {
        [1] = {
          ["Passenger id"] = "1548270126",
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      }
    },
    SpawnTypes = {
      ["TheGetaway Set position"] = {
        [1] = {
          ["Spawn location"] = "TheGetawaySpawn2",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["New As localPlayer"] = {
        [1] = {},
        ["name"] = "As localPlayer"
      },
      ["GetAway Player Set position"] = {
        [1] = {
          ["Spawn location"] = "TheGetawaySpawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    Teams = {
      ["Chaser Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Getaway team"] = {
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
        [1] = {reenablePatrollingVehiclesAfterFelonyEnd = false, disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    WarmupTypes = {
      ["TheGetaway Static"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          forceZapToVehicle = false,
          forceMissionAccept = false,
          lookToVehicle = false
        },
        ["name"] = "Static"
      }
    },
    MissionSettings = {
      ["TheGetaway MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = true,
          ["Spawn type"] = "Always active",
          ["Disable traffic"] = false,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "TheGetawayStart",
          ["Clear area around vehicles"] = 40,
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = true,
          ["disablePlayerIgnoring"] = false,
          ["Enable race status prompts"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    MissionInfos = {
      ["TheGetaway Title"] = {
        [1] = {
          ["1 Text"] = "ID:231353",
          ["Success reason"] = "ID:245207",
          ["missionMarkers"] = {
            [1] = {
              value = "None",
              cardName = "localPlayer",
              cardType = "Actor"
            },
            [2] = {
              value = "Objective",
              cardName = "Chaser",
              cardType = "Actor"
            },
            [3] = {
              value = "Opponent",
              cardName = "Evader",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Felony chase challenge"] = {
        [1] = {
          ["Chase team"] = {
            instance = 1,
            type = "Teams",
            name = "Chaser Team"
          },
          ["Player"] = {
            instance = 1,
            type = "Teams",
            name = "Player Team"
          },
          ["Evade team"] = {
            instance = 1,
            type = "Teams",
            name = "Getaway team"
          },
          ["Start prompt"] = "ID:231353",
          ["Initial route"] = "TheGetawayRoute",
          ["Final looped route"] = "TheGetawayLoop"
        },
        ["name"] = "Felony chase challenge"
      }
    }
  }
}
