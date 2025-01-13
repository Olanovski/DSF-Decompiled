cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Team colours 01"] = {
  FileVersion = "2",
  name = "Team colours 01",
  title = "ID:182602",
  MissionID = "1245",
  description = "ID:182601",
  cardInstances = {
    Actors = {
      ["Player team member 02"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          routeName = "TeamColoursCh3Route",
          team = {
            instance = 1,
            type = "Teams",
            name = "team_yel"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Player team member 02 character"
          },
          forceHighLodCharacters = true,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Leader warmup route"
          },
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Tough",
          raceManagerRoute = true,
          shaderParam = 3,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 299,
          rubberbandingToPlayerStrength = "Strong",
          enableSiren = false,
          enableSimulationArea = false,
          damageMultiplier = 0.3,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = 20,
          ignoreCivilianTraffic = false,
          reactionTime = "Average",
          stayInLockedArea = false,
          blockTow = false,
          ignoreOtherAis = false,
          avoidAttacks = false,
          desiredSpeed = 105,
          aiIgnorePlayerInCivsUntilHit = false,
          unaffectedByRaceSpeedTweaks = true
        },
        ["name"] = "Actor"
      },
      ["Race team 2 member 2"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          routeName = "TeamColoursCh3Route",
          team = {
            instance = 1,
            type = "Teams",
            name = "team_red"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Team 2 car 2"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Leader warmup route"
          },
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          shaderParam = 5,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 162,
          rubberbandingToPlayerStrength = "Medium",
          enableSiren = false,
          enableSimulationArea = false,
          damageMultiplier = 0.7,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = -35,
          ignoreCivilianTraffic = false,
          reactionTime = "Average",
          stayInLockedArea = false,
          blockTow = false,
          ignoreOtherAis = false,
          avoidAttacks = false,
          desiredSpeed = 115,
          aiIgnorePlayerInCivsUntilHit = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Race team 2 member 1"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          routeName = "TeamColoursCh3Route",
          team = {
            instance = 1,
            type = "Teams",
            name = "team_red"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Team 2 car 1"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Leader warmup route"
          },
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = true,
          shaderParam = 5,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 162,
          rubberbandingToPlayerStrength = "Medium",
          enableSiren = false,
          enableSimulationArea = false,
          damageMultiplier = 0.7,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          distanceBehindPlayer = -30,
          ignoreCivilianTraffic = false,
          reactionTime = "Average",
          stayInLockedArea = false,
          blockTow = false,
          ignoreOtherAis = false,
          avoidAttacks = false,
          desiredSpeed = 115,
          aiIgnorePlayerInCivsUntilHit = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Player team member 01"] = {
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
            name = "team_yel"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Player team member 01 character"
          },
          forceHighLodCharacters = true,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          enableSiren = false,
          driveInOncoming = 0.1,
          vehicleTrailerId = -1,
          noOccupants = false,
          shaderParam = 2,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Leader warmup route"
          },
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          ignoreOtherAis = false,
          enableSimulationArea = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 229,
          distanceBehindPlayer = 20,
          rubberbandingToPlayerStrength = "Strong",
          isMultiplayerActor = false,
          damageMultiplier = 0.3,
          attackStationaryVehicle = false,
          desiredSpeed = 90,
          previewMovie = "start_vehicle ",
          routeName = "TeamColoursCh3Route",
          raceManagerRoute = true,
          stayInLockedArea = false,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 1,
          unaffectedByRaceSpeedTweaks = true
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Team 2 car 1"] = {
        [1] = {
          ["Passenger id"] = "317540154",
          ["Driver id"] = "-1107229965"
        },
        ["name"] = "Character"
      },
      ["Team 2 car 2"] = {
        [1] = {
          ["Passenger id"] = "1643322846",
          ["Driver id"] = "-1269137079"
        },
        ["name"] = "Character"
      },
      ["Player team member 01 character"] = {
        [1] = {
          ["Passenger id"] = "-2068928907",
          ["Driver id"] = "987770728"
        },
        ["name"] = "Character"
      },
      ["Player team member 02 character"] = {
        [1] = {
          ["Passenger id"] = "255972301",
          ["Driver id"] = "-70535787"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      ["mission settings_10"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Load traffic on start"] = "Chapter 3 Team Colours ",
          ["Disable traffic"] = false,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "TeamColoursCh3Start",
          ["Audio logic file"] = "Team colours APIP",
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
      team_yel = {
        [1] = {},
        ["name"] = "Team"
      },
      team_red = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionCompletes = {
      ["mission complete team checkpoint race_1"] = {
        [1] = {
          ["Perfect condition"] = "ID:182720",
          ["Success reason"] = "ID:182719",
          ["Failure reason"] = "ID:182606",
          ["Pass condition"] = "ID:182606",
          ["Success reason (perfect)"] = "ID:182720"
        },
        ["name"] = "Team checkpoint race"
      }
    },
    WarmupTypes = {
      ["Follower warmup route"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          warmupRouteName = "teamcoloursch3warmup",
          forceZapToVehicle = false,
          forceMissionAccept = false,
          matchTrafficSpeed = false,
          lookToVehicle = false
        },
        ["name"] = "Warmup route"
      },
      ["Leader warmup route"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          warmupRouteName = "teamcoloursch3warmup",
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
          ["1"] = "Race team 2 member 1",
          ["4"] = "Player team member 01",
          ["3"] = "Player team member 02",
          ["2"] = "Race team 2 member 2"
        },
        ["name"] = "Positions"
      }
    },
    MissionInfos = {
      ["New Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:182606",
          ["showRouteArrows"] = "All",
          ["missionMarkers"] = {
            [1] = {
              value = "Opponent",
              cardName = "Race team 2 member 1",
              cardType = "Actor"
            },
            [2] = {
              value = "Opponent",
              cardName = "Race team 2 member 2",
              cardType = "Actor"
            },
            [3] = {
              value = "Objective",
              cardName = "Player team member 01",
              cardType = "Actor"
            },
            [4] = {
              value = "Objective",
              cardName = "Player team member 02",
              cardType = "Actor"
            }
          },
          ["3 Text"] = "ID:182606",
          ["2 Text"] = "ID:182606"
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["mission type checkpoint race"] = {
        [1] = {
          ["Slow motion on goal complete"] = false,
          ["Destroy opposing teams"] = false,
          ["Eject if in lead"] = false,
          ["Overtake target (+ score)"] = false,
          ["Race team 2"] = {
            instance = 1,
            type = "Teams",
            name = "team_red"
          },
          ["Score drift distance"] = false,
          ["Race team 1"] = {
            instance = 1,
            type = "Teams",
            name = "team_yel"
          },
          ["Total laps"] = 0,
          ["Score jump distance"] = false,
          ["Hide checkpoints"] = false,
          ["Team race prompt"] = true,
          ["Any team member damage above"] = 1,
          ["Damage amount for fail"] = 1
        },
        ["name"] = "Generic checkpoint race"
      }
    }
  }
}
