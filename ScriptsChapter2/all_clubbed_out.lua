cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["All clubbed out"] = {
  FileVersion = "2",
  name = "All clubbed out",
  title = "ID:184310",
  MissionID = "244",
  description = "ID:184296",
  cardInstances = {
    Actors = {
      Agent = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          routeName = "All clubbed out route",
          team = {
            instance = 1,
            type = "Teams",
            name = "Player team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "limo character"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "all clubbed out Warmup route"
          },
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 151,
          shaderParam = 0,
          panelSet = 0,
          enableSiren = false,
          enableSimulationArea = true,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          previewMovie = "UID00244_MPR01",
          stayInLockedArea = false,
          blockTow = false,
          ignoreCivilianTraffic = false,
          avoidAttacks = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
          desiredSpeed = 60
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["limo character"] = {
        [1] = {
          ["Behind passenger id"] = "-1",
          ["Passenger id"] = "-1406424428",
          ["Driver id"] = "-150074126"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      ["New MissionSetting"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Disable traffic"] = false,
          ["Mission props"] = "All clubbed out",
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "All clubbed out",
          ["Audio logic file"] = "All clubbed out APIP",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["disablePlayerIgnoring"] = false,
          ["Enable race status prompts"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {reenablePatrollingVehiclesAfterFelonyEnd = false, disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    Teams = {
      ["Player team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionCompletes = {
      ["New All clubbed out"] = {
        [1] = {
          ["Perfect condition"] = "ID:243122",
          ["Success reason"] = "ID:243121",
          ["Failure reason"] = "ID:184293",
          ["Pass condition"] = "ID:184294",
          ["Success reason (perfect)"] = "ID:221945"
        },
        ["name"] = "All clubbed out"
      }
    },
    WarmupTypes = {
      ["all clubbed out Warmup route"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          warmupRouteName = "All clubbed out warmup",
          forceZapToVehicle = false,
          forceMissionAccept = false,
          matchTrafficSpeed = false,
          lookToVehicle = false
        },
        ["name"] = "Warmup route"
      }
    },
    SpawnTypes = {
      ["New Positions"] = {
        [1] = {
          ["1"] = "Agent"
        },
        ["name"] = "Positions"
      }
    },
    MissionInfos = {
      ["New Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:245943",
          ["showRouteArrows"] = "All",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective",
              cardName = "Agent",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New MissionType"] = {
        [1] = {
          ["Within radius of props"] = 35,
          ["Prop group type to smash"] = "advertisingGroup",
          ["Player team"] = {
            instance = 1,
            type = "Teams",
            name = "Player team"
          },
          ["Time limit"] = 50,
          ["Proximity detection type"] = "Slipstream",
          ["Score to win"] = 8,
          ["Damage amount for fail"] = 1
        },
        ["name"] = "All clubbed out"
      }
    }
  }
}
