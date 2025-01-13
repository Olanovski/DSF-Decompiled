cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.LuckyEscape = {
  FileVersion = "2",
  name = "LuckyEscape",
  title = "ID:214716",
  MissionID = "37701",
  description = "ID:245466",
  cardInstances = {
    Actors = {
      Evader = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          routeName = "LuckyEscapeRoute",
          team = {
            instance = 1,
            type = "Teams",
            name = "Evade Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Evader Character"
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
            name = "Static"
          },
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          shaderParam = 1,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Evader spawn"
          },
          vehicleId = 303,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 0,
          damageMultiplier = 1.2,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          ignoreCivilianTraffic = false,
          noOccupants = false,
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          raceManagerRoute = true,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      Chaser = {
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
            name = "Chase Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Chaser Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On mission start",
          vehicleTrailerId = -1,
          tailingDistance = 15,
          driveOnPavements = 0.6,
          noOccupants = false,
          vehicleId = 302,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 2,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Chaser spawn"
          },
          ramInFrontDistance = 1,
          enableSiren = true,
          enableSimulationArea = false,
          spawnSpeed = 0,
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          driveInOncoming = 0.5,
          groupAggression = "Low",
          raceManagerRoute = false,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          avoidAlleys = 0,
          avoidAttacks = false,
          desiredSpeed = 160,
          avoidedByCivilianTraffic = true,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Evader Character"] = {
        [1] = {
          ["Behind passenger id"] = "-1",
          ["Passenger id"] = "423141928",
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      },
      ["Chaser Character"] = {
        [1] = {
          ["Behind passenger id"] = "-1",
          ["Passenger id"] = "2106453917",
          ["Driver id"] = "1307138515"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      MissionSettings = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = true,
          ["Spawn type"] = "Always active",
          ["Mission props"] = "LuckyEscapeProps",
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "LuckyEscapeStart",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = true,
          ["disablePlayerIgnoring"] = false,
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["Chase Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Evade Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    FelonySettings = {
      FelonySettings = {
        [1] = {reenablePatrollingVehiclesAfterFelonyEnd = true, disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    WarmupTypes = {
      Static = {
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
      ["Evader spawn"] = {
        [1] = {
          ["Spawn location"] = "LuckyEscapePlayerSpawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Chaser spawn"] = {
        [1] = {
          ["Spawn location"] = "LuckyEscapeOpponentSpawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    MissionInfos = {
      ["Title and Info"] = {
        [1] = {
          ["1 Text"] = "ID:245608",
          ["Success reason"] = "ID:245590",
          ["showRouteArrows"] = "All",
          ["missionMarkers"] = {
            [1] = {
              value = "Opponent",
              cardName = "Chaser",
              cardType = "Actor"
            },
            [2] = {
              value = "None",
              cardName = "Evader",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["Lucky Escape Chase Challenge"] = {
        [1] = {
          ["Felony"] = false,
          ["Evade team"] = {
            instance = 1,
            type = "Teams",
            name = "Evade Team"
          },
          ["Chase team"] = {
            instance = 1,
            type = "Teams",
            name = "Chase Team"
          },
          ["Jump iCam Checkpoint Start"] = 4,
          ["Start prompt"] = "ID:245927",
          ["Checkpoint type"] = "Checkpoint Gate"
        },
        ["name"] = "Generic chase challenge"
      }
    }
  }
}
