cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Something weird"] = {
  FileVersion = "2",
  name = "Something weird",
  title = "ID:184935",
  MissionID = "2818",
  description = "ID:184936",
  cardInstances = {
    Actors = {
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
            name = "Tanner Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Tanner Character"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          driveInOncoming = 0.5,
          driveOnPavements = 0.5,
          noOccupants = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Warmup route"
          },
          vehicleTrailerId = -1,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Tough",
          raceManagerRoute = false,
          shaderParam = 0,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 62,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 0,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          aiIgnorePlayerInCivsUntilHit = false,
          previewMovie = " ",
          stayInLockedArea = false,
          blockTow = false,
          desiredSpeed = 50,
          avoidAttacks = false,
          avoidAlleys = 0,
          reactionTime = "Average"
        },
        ["name"] = "Actor"
      },
      ["Ambulance 2"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 65,
          team = {
            instance = 1,
            type = "Teams",
            name = "Ambulance Team"
          },
          drivingSkill = "Frozen-Ambulance",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "New Character"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 1,
          driveOnPavements = 0.5,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          enableSiren = true,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Amb 2 closest point"
          },
          vehicleId = 276,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 30,
          rubberbandingActor = "Tanner",
          shaderParam = 0,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -50,
          reactionTime = "Average",
          raceManagerRoute = true,
          routeName = "Drive to second loop",
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          avoidAlleys = 0,
          ignoreCivilianTraffic = true,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Ambulance 1"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 80,
          team = {
            instance = 1,
            type = "Teams",
            name = "Ambulance Team"
          },
          drivingSkill = "Frozen-Ambulance",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "New Character"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0.5,
          driveOnPavements = 0.2,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          enableSiren = true,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Amb 1 closest point"
          },
          vehicleId = 276,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Weaker",
          spawnSpeed = 50,
          rubberbandingActor = "Tanner",
          shaderParam = 0,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -50,
          reactionTime = "Average",
          raceManagerRoute = true,
          routeName = "Drive to loop 1",
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          avoidAlleys = 0,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Tanner Character"] = {
        [1] = {
          ["Passenger id"] = "-1916574018",
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      },
      ["New Character"] = {
        [1] = {
          ["Passenger id"] = "-1",
          ["Driver id"] = "-1"
        },
        ["name"] = "Character"
      }
    },
    SpawnTypes = {
      ["Ambulance position"] = {
        [1] = {
          ["Spawn location"] = "Something weird ambulance",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["New Positions"] = {
        [1] = {
          ["1"] = "Tanner"
        },
        ["name"] = "Positions"
      },
      ["Amb 1 closest point"] = {
        [1] = {
          distanceInFrontOfActor = 50,
          directionOnRoute = "with",
          route = "Drive to loop 1",
          spawnInRelationToActor = "Tanner"
        },
        ["name"] = "Closest point on route"
      },
      ["Ambulance 2 position"] = {
        [1] = {
          ["Spawn location"] = "Something weird ambulance 2",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Amb 2 closest point"] = {
        [1] = {
          distanceInFrontOfActor = 50,
          directionOnRoute = "with",
          route = "Drive to second loop",
          spawnInRelationToActor = "Tanner"
        },
        ["name"] = "Closest point on route"
      }
    },
    MissionSettings = {
      MissionSettings = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Spawn type"] = "Always active",
          ["Load traffic on start"] = "SM5 Something Weird ",
          ["disablePlayerIgnoring"] = false,
          ["Cutscene on mission start"] = "ch5_sm5_01",
          ["Cutscene after mission end screen"] = "ch5_sm5_02",
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Something weird tanner",
          ["Audio logic file"] = "Something Weird APIP",
          ["Delete task object on reject preview"] = false,
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["Tanner Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Ambulance Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionCompletes = {
      ["New Something weird"] = {
        [1] = {
          ["Failure reason"] = "ID:184941",
          ["Pass condition"] = "ID:184940"
        },
        ["name"] = "Something weird"
      }
    },
    WarmupTypes = {
      ["New Warmup route"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          warmupRouteName = "Something weird warmup",
          forceZapToVehicle = false,
          forceMissionAccept = false,
          matchTrafficSpeed = true,
          lookToVehicle = false
        },
        ["name"] = "Warmup route"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    MissionInfos = {
      ["Something Weird "] = {
        [1] = {
          ["1 Text"] = "ID:243769",
          ["Success reason"] = "ID:245628",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective",
              cardName = "Tanner",
              cardType = "Actor"
            },
            [2] = {
              value = "Yellow Marker, Getaway Radius",
              cardName = "Ambulance 2",
              cardType = "Actor"
            },
            [3] = {
              value = "Yellow Marker, Getaway Radius",
              cardName = "Ambulance 1",
              cardType = "Actor"
            }
          },
          ["4 Text"] = "ID:243768",
          ["3 Text"] = "ID:246401",
          ["2 Text"] = "ID:243661"
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Something weird 2"] = {
        [1] = {
          ["Tanner team"] = {
            instance = 1,
            type = "Teams",
            name = "Tanner Team"
          },
          ["Ambulance team"] = {
            instance = 1,
            type = "Teams",
            name = "Ambulance Team"
          }
        },
        ["name"] = "Something weird"
      }
    }
  }
}
