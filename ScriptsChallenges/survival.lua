cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.Survival = {
  FileVersion = "2",
  name = "Survival",
  title = "ID:231201",
  MissionID = "17104",
  description = "ID:245460",
  cardInstances = {
    Actors = {
      Tanner = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 70,
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
            name = "Tanner Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          previewMovie = "preview vehicle",
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Static warmup"
          },
          avoidUTurns = false,
          avoidedByCivilianTraffic = true,
          collisionResilience = "Average",
          raceManagerRoute = false,
          shaderParam = 0,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Set position"
          },
          vehicleId = 62,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 0,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          routeName = "Survival Route",
          noOccupants = false,
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          ignoreCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      Jericho = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 100,
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
          driveInOncoming = 0,
          driveOnPavements = 1,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 0,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = true,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Jericho Closest point on route"
          },
          vehicleId = 181,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Strong",
          maximumDamagePerCollision = 0.05,
          spawnSpeed = 30,
          rubberbandingActor = "Tanner",
          damageCauseScale = 1.5,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -30,
          ignoreCivilianTraffic = true,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          routeName = "Survival Route",
          avoidAttacks = true,
          avoidedByCivilianTraffic = true,
          avoidAlleys = 1
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Tanner Character"] = {
        [1] = {
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      },
      ["Jericho Character"] = {
        [1] = {
          ["Driver id"] = "-376150524"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      ["Mission Settings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = true,
          ["Spawn type"] = "Always active",
          ["Disable traffic"] = false,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Survival",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = true,
          ["disablePlayerIgnoring"] = false,
          ["Enable race status prompts"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["Jericho Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Player Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    SpawnTypes = {
      ["Jericho Closest point on route"] = {
        [1] = {
          distanceInFrontOfActor = 35,
          directionOnRoute = "with",
          route = "Survival Route",
          spawnInRelationToActor = "Tanner"
        },
        ["name"] = "Closest point on route"
      },
      ["Set position"] = {
        [1] = {
          ["Spawn location"] = "Survival",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    WarmupTypes = {
      ["Static warmup"] = {
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
      FelonySettings = {
        [1] = {reenablePatrollingVehiclesAfterFelonyEnd = false, disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    MissionInfos = {
      ["Mission Info"] = {
        [1] = {
          ["1 Text"] = "ID:231366",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective",
              cardName = "Tanner",
              cardType = "Actor"
            },
            [2] = {
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
      Survival = {
        [1] = {
          ["Jericho team"] = {
            instance = 1,
            type = "Teams",
            name = "Jericho Team"
          },
          ["Player team"] = {
            instance = 1,
            type = "Teams",
            name = "Player Team"
          },
          ["Minimum time to survive"] = 60
        },
        ["name"] = "Survival"
      }
    }
  }
}
