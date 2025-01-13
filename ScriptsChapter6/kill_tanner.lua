cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Kill Tanner"] = {
  FileVersion = "2",
  name = "Kill Tanner",
  title = "ID:186314",
  MissionID = "3330",
  description = "ID:186315",
  cardInstances = {
    Actors = {
      ["Tanner2"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = true,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 85,
          team = {
            instance = 1,
            type = "Teams",
            name = "Tanner team 2"
          },
          drivingSkill = "Reckless",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "tanner character"
          },
          forceHighLodCharacters = true,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = true,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          shaderParam = 0,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Tanner 2 position"
          },
          vehicleId = 172,
          enableSiren = false,
          enableSimulationArea = true,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          raceManagerRoute = true,
          routeName = "Kill Tanner Chase Route",
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = true,
          avoidAttacks = false,
          avoidAlleys = 0,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Ordell"] = {
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
            name = "Ordell team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Ordell character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 25,
          vehicleTrailerId = -1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Very tough",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Ordell Positions"
          },
          vehicleId = 203,
          shaderParam = 2,
          enableSiren = false,
          spawnSpeed = 65,
          enableSimulationArea = true,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          avoidedByCivilianTraffic = false,
          reactionTime = "Average",
          stayInLockedArea = false,
          blockTow = false,
          routeName = "Kill Tanner Ordell Drive",
          avoidAttacks = false,
          raceManagerRoute = true,
          desiredSpeed = 65,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Tanner"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Tanner team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "tanner character"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
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
          shaderParam = 0,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Positions"
          },
          vehicleId = 172,
          enableSimulationArea = false,
          isMultiplayerActor = true,
          spawnSpeed = 35,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          aiIgnorePlayerInCivsUntilHit = false,
          previewMovie = "Hello",
          routeName = "Kill Tanner Chase Route",
          stayInLockedArea = false,
          blockTow = false,
          desiredSpeed = 65,
          avoidAttacks = false,
          avoidAlleys = 0,
          reactionTime = "Average"
        },
        ["name"] = "Actor"
      },
      ["Dead vehicle 2"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Cop team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
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
            name = "dead position 2"
          },
          vehicleId = 291,
          attackStationaryVehicle = false,
          enableSiren = true,
          enableSimulationArea = false,
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = true,
          avoidAttacks = false,
          ignoreOtherAis = false,
          reactionTime = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Dead vehicle"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Cop team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
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
            name = "dead position"
          },
          vehicleId = 298,
          attackStationaryVehicle = false,
          enableSiren = true,
          enableSimulationArea = false,
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = true,
          avoidAttacks = false,
          ignoreOtherAis = false,
          reactionTime = "Average",
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Ordell character"] = {
        [1] = {
          ["Passenger id"] = "1535564652",
          ["Driver id"] = "454042078"
        },
        ["name"] = "Character"
      },
      ["Tanner with Jericho"] = {
        [1] = {
          ["Passenger id"] = "-673381849",
          ["Driver id"] = "-376150524"
        },
        ["name"] = "Character"
      },
      ["tanner character"] = {
        [1] = {
          ["Behind passenger id"] = "-1",
          ["Passenger id"] = "-1916574018",
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      MissionSettings = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Load traffic on start"] = "Chapter 6 - The target",
          ["Disable traffic"] = false,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Hud logic file"] = "Kill Tanner HUD",
          ["Cutscene at mission end"] = "ch6_sm6_02",
          ["Mission props"] = "KillTannerProps",
          ["Enable traffic at mission end"] = true,
          ["disablePlayerIgnoring"] = false,
          ["Audio logic file"] = "Kill Tanner APIP",
          ["freezeFrameOnMissionEndCutscene"] = true,
          ["Delete task object on reject preview"] = false,
          ["Start location"] = "Kill tanner Start",
          ["Enable race status prompts"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    Teams = {
      ["Cop team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Tanner team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Ordell team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Tanner team 2"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionCompletes = {
      ["Kill Tanner complete"] = {
        [1] = {
          ["Perfect condition"] = "ID:186329",
          ["Success reason"] = "ID:186329",
          ["Pass condition"] = "ID:186329"
        },
        ["name"] = "Kill Tanner"
      }
    },
    WarmupTypes = {
      ["New Static"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          forceZapToVehicle = false,
          forceMissionAccept = false,
          lookToVehicleTriggerRadius = 50,
          lookToVehicle = false
        },
        ["name"] = "Static"
      },
      ["New Warmup route"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          warmupRouteName = "KillTannerWarmupRoute",
          forceZapToVehicle = false,
          forceMissionAccept = false,
          matchTrafficSpeed = false,
          lookToVehicle = false
        },
        ["name"] = "Warmup route"
      }
    },
    SpawnTypes = {
      ["cop1 position"] = {
        [1] = {
          ["Spawn location"] = "Cop1 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["dead position"] = {
        [1] = {
          ["Spawn location"] = "Dead Vehicle Kill tanner spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["dead position 2"] = {
        [1] = {
          ["Spawn location"] = "Dead Vehicle 2 Kill tanner spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["tanner2 spawn"] = {
        [1] = {
          withVehicleDirection = true,
          actor = "Ordell",
          distance = 40,
          aheadOfVehicle = true
        },
        ["name"] = "Relative to Vehicle"
      },
      ["Ordell Positions"] = {
        [1] = {
          ["alternateLocation"] = "Ordell Kill tanner spawn",
          ["1"] = "Ordell"
        },
        ["name"] = "Positions"
      },
      ["Tanner 2 position"] = {
        [1] = {
          ["Spawn location"] = "Tanner2 Kill tanner spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["cop3 position"] = {
        [1] = {
          ["Spawn location"] = "Cop3 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["cop2 position"] = {
        [1] = {
          ["Spawn location"] = "Cop2 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["New Relative to Vehicle"] = {
        [1] = {
          withVehicleDirection = false,
          actor = "Tanner2",
          distance = 200,
          aheadOfVehicle = true
        },
        ["name"] = "Relative to Vehicle"
      },
      ["Tanner 1 set pos"] = {
        [1] = {
          ["Spawn location"] = "Tanner Kill tanner spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["cop4 position"] = {
        [1] = {
          ["Spawn location"] = "Cop4 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Tanner position"] = {
        [1] = {
          ["Spawn location"] = "Tanner Kill tanner spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Ordell position"] = {
        [1] = {
          ["Spawn location"] = "Ordell Kill tanner spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Behind ordell"] = {
        [1] = {
          withVehicleDirection = true,
          actor = "Ordell",
          distance = 15,
          aheadOfVehicle = false
        },
        ["name"] = "Relative to Vehicle"
      },
      ["Positions"] = {
        [1] = {
          ["alternateLocation"] = "Tanner Kill tanner spawn",
          ["1"] = "Tanner"
        },
        ["name"] = "Positions"
      }
    },
    MissionInfos = {
      ["Kill tanner Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:186324",
          ["showRouteArrows"] = "All",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective",
              cardName = "Tanner",
              cardType = "Actor"
            },
            [2] = {
              value = "Jericho Marker",
              cardName = "Tanner2",
              cardType = "Actor"
            },
            [3] = {
              value = "Objective",
              cardName = "Ordell",
              cardType = "Actor"
            }
          },
          ["4 Text"] = "ID:235441",
          ["3 Text"] = "ID:243094",
          ["2 Text"] = "ID:245552"
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["Kill Tanner mission"] = {
        [1] = {
          ["Tanner team"] = {
            instance = 1,
            type = "Teams",
            name = "Tanner team"
          },
          ["Cop team"] = {
            instance = 1,
            type = "Teams",
            name = "Cop team"
          },
          ["Tanner team 2"] = {
            instance = 1,
            type = "Teams",
            name = "Tanner team 2"
          },
          ["Ordell team"] = {
            instance = 1,
            type = "Teams",
            name = "Ordell team"
          },
          ["Damage amount for fail"] = 1
        },
        ["name"] = "Kill Tanner"
      }
    }
  }
}
