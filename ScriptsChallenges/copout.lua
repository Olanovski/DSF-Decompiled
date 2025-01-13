cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.CopOut = {
  FileVersion = "2",
  name = "CopOut",
  title = "ID:231197",
  MissionID = "40261",
  description = "ID:245471",
  cardInstances = {
    Actors = {
      ["Evader"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = true,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          routeName = "CopOutRoute",
          team = {
            instance = 1,
            type = "Teams",
            name = "EvadeTeam"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Player Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          previewMovie = "no preview",
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
          shaderParam = 2,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Positions"
          },
          vehicleId = 178,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 0,
          damageMultiplier = 0.4,
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
      ["Chaser"] = {
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
            name = "Chase Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Character"
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
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Relative to Evader"
          },
          vehicleId = 302,
          shaderParam = 2,
          enableSiren = true,
          enableSimulationArea = false,
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          raceManagerRoute = false,
          desiredSpeed = 90,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Chaser 2"] = {
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
            name = "Chase Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Cop Character"
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
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Relative to Evader"
          },
          vehicleId = 302,
          shaderParam = 2,
          enableSiren = true,
          enableSimulationArea = false,
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          raceManagerRoute = false,
          desiredSpeed = 90,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Cop Character"] = {
        [1] = {
          ["Driver id"] = "-922446650"
        },
        ["name"] = "Character"
      },
      ["Player Character"] = {
        [1] = {
          ["Passenger id"] = "-150074126",
          ["Driver id"] = "-673381849"
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
          ["Enable traffic at mission end"] = true,
          ["disablePlayerIgnoring"] = false,
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = true,
          ["Start location"] = "CopOutStart",
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
      ["EvadeTeam"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    SpawnTypes = {
      ["Positions"] = {
        [1] = {
          ["1"] = "Evader"
        },
        ["name"] = "Positions"
      },
      ["Relative to Evader"] = {
        [1] = {
          actor = "Evader",
          whichLane = "randomLane",
          withVehicleDirection = true,
          distance = 60,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = false
        },
        ["name"] = "Relative to Vehicle"
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
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {reenablePatrollingVehiclesAfterFelonyEnd = false, disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    MissionInfos = {
      ["Title and Info"] = {
        [1] = {
          ["1 Text"] = "ID:245609",
          ["Success reason"] = "ID:245584",
          ["showRouteArrows"] = "All",
          ["missionMarkers"] = {
            [1] = {
              value = "None",
              cardName = "Evader",
              cardType = "Actor"
            },
            [2] = {
              value = "None",
              cardName = "Chaser 2",
              cardType = "Actor"
            },
            [3] = {
              value = "None",
              cardName = "Chaser",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["Generic chase challenge"] = {
        [1] = {
          ["Chase team"] = {
            instance = 1,
            type = "Teams",
            name = "Chase Team"
          },
          ["Evade team"] = {
            instance = 1,
            type = "Teams",
            name = "EvadeTeam"
          },
          ["Start prompt"] = "ID:245927",
          ["Felony"] = true,
          ["Checkpoint type"] = "Checkpoint Gate"
        },
        ["name"] = "Generic chase challenge"
      }
    }
  }
}
