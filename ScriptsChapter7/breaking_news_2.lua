cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Breaking news 2"] = {
  FileVersion = "2",
  name = "Breaking news 2",
  title = "ID:184488",
  MissionID = "773",
  description = "ID:184489",
  cardInstances = {
    Actors = {
      ["Van 1 Actor"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = true,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Van team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "New Character"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = true,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Warmup route"
          },
          shaderParam = 5,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 198,
          enableSimulationArea = true,
          spawnSpeed = 30,
          isMultiplayerActor = false,
          damageMultiplier = 0.3,
          attackStationaryVehicle = false,
          desiredSpeed = 60,
          matchTrafficSpeed = true,
          routeName = "BreakingNews2WarmupAndMissionRoute",
          raceManagerRoute = true,
          stayInLockedArea = false,
          blockTow = false,
          previewMovie = "Breaking News 2",
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["New Character"] = {
        [1] = {
          ["Passenger id"] = "1600663248",
          ["Driver id"] = "-1669780055"
        },
        ["name"] = "Character"
      }
    },
    SpawnTypes = {
      ["New Positions"] = {
        [1] = {
          ["alternateLocation"] = "Breaking news 2 van 1",
          ["1"] = "Van 1 Actor"
        },
        ["name"] = "Positions"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {reenablePatrollingVehiclesAfterFelonyEnd = true, disablePoliceInTrafficDuringMission = false},
        ["name"] = "FelonySettings"
      }
    },
    Teams = {
      ["Van team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionCompletes = {
      ["Breaking News 2"] = {
        [1] = {
          ["Perfect condition"] = "ID:184502",
          ["Success reason"] = "ID:241402",
          ["Failure reason"] = "ID:184497",
          ["Success reason (perfect)"] = "ID:241401",
          ["Pass condition"] = "ID:184500",
          ["Failure reason (wrecked)"] = "ID:184497"
        },
        ["name"] = "Breaking news 2"
      }
    },
    WarmupTypes = {
      ["New Warmup route"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          warmupRouteName = "BreakingNews2WarmupAndMissionRoute",
          forceZapToVehicle = false,
          forceMissionAccept = false,
          matchTrafficSpeed = false,
          lookToVehicle = false
        },
        ["name"] = "Warmup route"
      }
    },
    MissionSettings = {
      ["New MissionSetting"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Spawn type"] = "Always active",
          ["Hud logic file"] = "Breaking news 2 hud",
          ["Load traffic on start"] = "Chapter 6 - Special Edition",
          ["disablePlayerIgnoring"] = false,
          ["Enable traffic at mission end"] = false,
          ["Start location"] = "Breaking news 2 start",
          ["Audio logic file"] = "Breaking news 2",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    MissionInfos = {
      ["Title : BREAKING NEWS 2"] = {
        [1] = {
          ["1 Text"] = "ID:184493",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective",
              cardName = "Van 1 Actor",
              cardType = "Actor"
            }
          },
          ["5 Text"] = "ID:184491",
          ["4 Text"] = "ID:221802",
          ["3 Text"] = "ID:246339",
          ["2 Text"] = "ID:243579"
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["Breaking News 2 Type"] = {
        [1] = {
          ["Time Limit"] = 45,
          ["Van team"] = {
            instance = 1,
            type = "Teams",
            name = "Van team"
          },
          ["Speed above"] = 150,
          ["Damage amount for fail"] = 1
        },
        ["name"] = "Breaking news 2"
      }
    }
  }
}
