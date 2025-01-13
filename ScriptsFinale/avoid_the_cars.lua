cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Avoid The Cars"] = {
  FileVersion = "2",
  name = "Avoid The Cars",
  title = "ID:186112",
  MissionID = "4869",
  description = "ID:186113",
  cardInstances = {
    Actors = {
      ["Jericho Actor"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Slow",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = true,
          team = {
            instance = 1,
            type = "Teams",
            name = "Jericho Team"
          },
          drivingSkill = "Reckless",
          disablePanelDetach = false,
          rubberBandMinVelocityTopSpeedFraction = 0.3,
          accidentProbability = 1,
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
          enableSimulationArea = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 0,
          avoidUTurns = false,
          avoidedByCivilianTraffic = true,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          enableSiren = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Jericho Closest point on route"
          },
          vehicleId = 181,
          maximumDamagePerCollision = 0.05,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 40,
          rubberbandingActor = "Tanner Actor",
          damageCauseScale = 1.5,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -20,
          desiredSpeed = 120,
          routeName = "Avoid the cars",
          stayInLockedArea = false,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = true,
          raceManagerRoute = true,
          aiIgnorePlayerInCivsUntilHit = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Civ"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 40,
          team = {
            instance = 1,
            type = "Teams",
            name = "Civ Team"
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
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 1,
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
            name = "New Relative to Vehicle"
          },
          ramInFrontDistance = 75,
          vehicleId = 135,
          enableSiren = false,
          spawnSpeed = 60,
          enableSimulationArea = false,
          attackStationaryVehicle = true,
          groupAggression = "Low",
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Slow",
          avoidAttacks = false,
          ignoreCivilianTraffic = false,
          avoidedByCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["Tanner Actor"] = {
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
          previewMovie = "Hello",
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Tanner Warmup"
          },
          vehicleTrailerId = -1,
          avoidUTurns = false,
          avoidedByCivilianTraffic = true,
          collisionResilience = "Average",
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
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          desiredSpeed = 70,
          noOccupants = false,
          stayInLockedArea = false,
          blockTow = false,
          routeName = "tanner vehicle launcher route",
          avoidAttacks = false,
          reactionTime = "Average",
          aiIgnorePlayerInCivsUntilHit = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Tanner Character"] = {
        [1] = {
          ["Passenger id"] = "-1",
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
    SpawnTypes = {
      ["New Positions"] = {
        [1] = {
          ["1"] = "Tanner Actor"
        },
        ["name"] = "Positions"
      },
      ["Jericho Closest point on route"] = {
        [1] = {
          distanceInFrontOfActor = 40,
          directionOnRoute = "with",
          route = "Avoid the cars",
          spawnInRelationToActor = "Tanner Actor"
        },
        ["name"] = "Closest point on route"
      },
      ["New Relative to Vehicle"] = {
        [1] = {
          actor = "Tanner Actor",
          whichLane = "outsideLane",
          withVehicleDirection = false,
          distance = 200,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = true
        },
        ["name"] = "Relative to Vehicle"
      }
    },
    MissionSettings = {
      ["Placeholder MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Disable traffic"] = false,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Avoid the cars",
          ["Audio logic file"] = "Avoid the Cars APIP",
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
      },
      ["Civ Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {reenablePatrollingVehiclesAfterFelonyEnd = false, disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    WarmupTypes = {
      ["Tanner Warmup"] = {
        [1] = {forceMissionAccept = true},
        ["name"] = "Cutscene"
      }
    },
    CustomAggressionSettings = {
      ["New CustomAggressionSetting"] = {
        [1] = {
          groupTakeDownMaxAttackersAtOnceIntercepting = 3,
          groupTakeDownMaxAttackersAtOnceFollowing = 10,
          groupTakeDownPerformanceBoost = 2,
          groupTakeDownTimeBetweenAttacks = 10,
          groupTakeDownMaxAttackersAtOnceStationary = 1,
          groupTakeDownFollowDistanceforNonAttackers = 10
        },
        ["name"] = "CustomAggressionSetting"
      }
    },
    MissionInfos = {
      ["Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:170893",
          ["showRouteArrows"] = "All",
          ["missionMarkers"] = {
            [1] = {
              value = "Red Marker, Fake Felony Radius",
              cardName = "Jericho Actor",
              cardType = "Actor"
            },
            [2] = {
              value = "Objective",
              cardName = "Tanner Actor",
              cardType = "Actor"
            },
            [3] = {
              value = "Black Marker, No Health Bar",
              cardName = "Civ",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Avoid the cars"] = {
        [1] = {
          ["Jericho team"] = {
            instance = 1,
            type = "Teams",
            name = "Jericho Team"
          },
          ["Civ team"] = {
            instance = 1,
            type = "Teams",
            name = "Civ Team"
          },
          ["Tanner team"] = {
            instance = 1,
            type = "Teams",
            name = "Tanner Team"
          }
        },
        ["name"] = "Avoid the cars"
      }
    }
  }
}
