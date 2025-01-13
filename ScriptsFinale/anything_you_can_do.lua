cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Anything you can do"] = {
  FileVersion = "2",
  name = "Anything you can do",
  title = "ID:186258",
  MissionID = "16592",
  description = "ID:186256",
  cardInstances = {
    Actors = {
      ["Jericho Actor"] = {
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
            name = "Jericho Team"
          },
          drivingSkill = "Reckless",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "New Character"
          },
          forceHighLodCharacters = true,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On mission start",
          vehicleTrailerId = -1,
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 0,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Closest point on route"
          },
          vehicleId = 181,
          enableSimulationArea = true,
          rubberbandingToPlayerStrength = "Strong",
          maximumDamagePerCollision = 0.1,
          spawnSpeed = 30,
          rubberbandingActor = "Tanner Actor",
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -30,
          reactionTime = "Average",
          raceManagerRoute = true,
          routeName = "Anything you can do",
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
      ["Tanner Actor"] = {
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
            name = "Tanner Team"
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
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Cutscene 3"
          },
          vehicleTrailerId = -1,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          enableSiren = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Tanner positions"
          },
          vehicleId = 62,
          enableSimulationArea = true,
          maximumDamagePerCollision = 0.1,
          isMultiplayerActor = false,
          shaderParam = 0,
          attackStationaryVehicle = false,
          desiredSpeed = 80,
          raceManagerRoute = true,
          routeName = "Anything you can do",
          stayInLockedArea = false,
          blockTow = false,
          previewMovie = "Hello",
          avoidAttacks = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
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
      ["New Character"] = {
        [1] = {
          ["Driver id"] = "-376150524"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      ["Placeholder MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = true,
          ["Spawn type"] = "Always active",
          ["Disable traffic"] = false,
          ["Clear area around vehicles"] = 60,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Anything you can do",
          ["Audio logic file"] = "Anything you can do APIP",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["disablePlayerIgnoring"] = false,
          ["Enable race status prompts"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["Tanner Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Jericho Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    SpawnTypes = {
      ["Tanner positions"] = {
        [1] = {
          ["1"] = "Tanner Actor"
        },
        ["name"] = "Positions"
      },
      ["Jericho relative to vehicle"] = {
        [1] = {
          actor = "Tanner Actor",
          whichLane = "randomLane",
          withVehicleDirection = true,
          distance = 40,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = true
        },
        ["name"] = "Relative to Vehicle"
      },
      ["New Closest point on route"] = {
        [1] = {
          distanceInFrontOfActor = 45,
          directionOnRoute = "with",
          route = "Anything you can do",
          spawnInRelationToActor = "Tanner Actor"
        },
        ["name"] = "Closest point on route"
      }
    },
    WarmupTypes = {
      ["New Cutscene 3"] = {
        [1] = {forceMissionAccept = true},
        ["name"] = "Cutscene"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    MissionInfos = {
      ["Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:184960",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective",
              cardName = "Tanner Actor",
              cardType = "Actor"
            },
            [2] = {
              value = "Red Marker, Fake Felony Radius",
              cardName = "Jericho Actor",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Anything you can do"] = {
        [1] = {
          ["Jericho team"] = {
            instance = 1,
            type = "Teams",
            name = "Jericho Team"
          },
          ["Laps"] = 999,
          ["Tanner team"] = {
            instance = 1,
            type = "Teams",
            name = "Tanner Team"
          }
        },
        ["name"] = "Anything you can do"
      }
    }
  }
}
