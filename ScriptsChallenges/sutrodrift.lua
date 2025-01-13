cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.SutroDrift = {
  FileVersion = "2",
  name = "SutroDrift",
  title = "ID:231199",
  MissionID = "39237",
  description = "ID:245467",
  cardInstances = {
    Actors = {
      Evader = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = true,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 80,
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
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          previewMovie = "preview vehicle",
          enableSiren = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Static"
          },
          shaderParam = 0,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = true,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Chaser spawn"
          },
          vehicleId = 172,
          enableSimulationArea = false,
          isMultiplayerActor = false,
          spawnSpeed = 0,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          ignoreCivilianTraffic = false,
          reactionTime = "Average",
          noOccupants = false,
          stayInLockedArea = false,
          blockTow = false,
          routeName = "SutroDriftRoute",
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          ignoreOtherAis = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      Cop = {
        [1] = {
          lockedToPlayer = true,
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
          drivingSkill = "Professional",
          disablePanelDetach = false,
          accidentProbability = 0.2,
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
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Cop spawn"
          },
          vehicleId = 302,
          shaderParam = 5,
          enableSiren = true,
          spawnSpeed = 0,
          enableSimulationArea = false,
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          desiredSpeed = 80,
          stayInLockedArea = false,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          raceManagerRoute = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Evader Character"] = {
        [1] = {
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      },
      ["Chaser Character"] = {
        [1] = {
          ["Driver id"] = "105509604"
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
          ["Start location"] = "SutroDriftStart",
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["Evade Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Chase Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    FelonySettings = {
      FelonySettings = {
        [1] = {reenablePatrollingVehiclesAfterFelonyEnd = false, disablePoliceInTrafficDuringMission = true},
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
      ["Cop spawn"] = {
        [1] = {
          actor = "Evader",
          whichLane = "randomLane",
          withVehicleDirection = true,
          distance = 40,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = false
        },
        ["name"] = "Relative to Vehicle"
      },
      ["Chaser spawn"] = {
        [1] = {
          ["Spawn location"] = "SutroDriftSpawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    MissionInfos = {
      ["Title and Info"] = {
        [1] = {
          ["1 Text"] = "ID:245608",
          ["showRouteArrows"] = "All",
          ["missionMarkers"] = {
            [1] = {
              value = "None",
              cardName = "Cop",
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
            name = "Evade Team"
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
