cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Tanner & Jones Mission 4"] = {
  FileVersion = "2",
  name = "Tanner & Jones Mission 4",
  title = "ID:184758",
  MissionID = "5890",
  description = "ID:184759",
  cardInstances = {
    Actors = {
      ["Tanner and Jones"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 50,
          team = {
            instance = 1,
            type = "Teams",
            name = "Tanner and Jones Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Tanner and Jones Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          tailingDistance = 100,
          driveOnPavements = 0.1,
          noOccupants = false,
          enableSimulationArea = false,
          takeNonPlayerDamage = true,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Tanner and Jones 4 Warmup"
          },
          shaderParam = 0,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          enableSiren = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Tanner and Jones Spawn"
          },
          vehicleId = 62,
          spawnSpeed = 0,
          rubberbandingActor = "Krug",
          isMultiplayerActor = false,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          driveInOncoming = 0.1,
          previewMovie = "Hello",
          raceManagerRoute = false,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          ignoreCivilianTraffic = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Attacker 01"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Team Attacker"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          accidentProbability = 0.2,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Attacker goon characters 01"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 5,
          vehicleTrailerId = -1,
          noOccupants = false,
          vehicleId = 173,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 3,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = true,
          avoidAlleys = 0.2,
          ignoreOtherAis = false,
          enableSiren = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Attacker 01 spawn"
          },
          ramInFrontDistance = 150,
          enableSimulationArea = false,
          rubberbandingActor = "Krug",
          damageMultiplier = 2,
          attackStationaryVehicle = true,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          collisionResilience = "Average",
          avoidAttacks = false,
          groupAggression = "Evil",
          desiredSpeed = 20,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Attacker 02"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Team Attacker"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          accidentProbability = 0,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Attacker goon characters 02"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 15,
          vehicleTrailerId = -1,
          noOccupants = false,
          vehicleId = 173,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 3,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAlleys = 0.2,
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Attacker 02 spawn"
          },
          ramInFrontDistance = 150,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 0,
          damageMultiplier = 2,
          attackStationaryVehicle = true,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          collisionResilience = "Average",
          avoidAttacks = false,
          groupAggression = "Evil",
          desiredSpeed = 20,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Attacker 03"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Team Attacker"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          accidentProbability = 0.2,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Attacker goon characters 01"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          tailingDistance = 20,
          vehicleTrailerId = -1,
          noOccupants = false,
          vehicleId = 173,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          shaderParam = 3,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAlleys = 0.2,
          ignoreOtherAis = false,
          enableSiren = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Attacker 03 spawn"
          },
          ramInFrontDistance = 150,
          enableSimulationArea = false,
          spawnSpeed = 0,
          rubberbandingActor = "Krug",
          damageMultiplier = 2,
          attackStationaryVehicle = true,
          avoidedByCivilianTraffic = false,
          matchTrafficSpeed = false,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          collisionResilience = "Average",
          avoidAttacks = false,
          groupAggression = "Evil",
          desiredSpeed = 20,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Krug"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 70,
          team = {
            instance = 1,
            type = "Teams",
            name = "Krug Team"
          },
          drivingSkill = "Cautious",
          disablePanelDetach = false,
          accidentProbability = 0,
          characters = {
            instance = 1,
            type = "Characters",
            name = "New Character"
          },
          forceHighLodCharacters = true,
          wanderType = "preferStraight",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On mission start",
          distanceFromFrontOfGroup = 0,
          driveInOncoming = 0.2,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = true,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          avoidedByCivilianTraffic = true,
          avoidAlleys = 0,
          raceManagerRoute = true,
          shaderParam = 2,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Krug spawn"
          },
          vehicleId = 266,
          enableSiren = false,
          enableSimulationArea = true,
          spawnSpeed = 20,
          rubberbandingActor = "Tanner and Jones",
          damageMultiplier = 0.4,
          attackStationaryVehicle = false,
          reactionTime = "Fastest",
          matchTrafficSpeedMultiplier = 1,
          routeName = "TannerAndJones4Route",
          stayInLockedArea = false,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          collisionResilience = "Unstoppable",
          ignoreCivilianTraffic = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Attacker goon characters 01"] = {
        [1] = {
          ["Passenger id"] = "-1",
          ["Driver id"] = "-1490034552"
        },
        ["name"] = "Character"
      },
      ["New Character"] = {
        [1] = {
          ["Driver id"] = "1030000186"
        },
        ["name"] = "Character"
      },
      ["Attacker goon characters 02"] = {
        [1] = {
          ["Passenger id"] = "-1",
          ["Driver id"] = "-1895221169"
        },
        ["name"] = "Character"
      },
      ["Tanner and Jones Character"] = {
        [1] = {
          ["Passenger id"] = "-1916574018",
          ["Behind passenger id"] = "-1",
          ["Driver id"] = "-673381849",
          ["Behind driver id"] = "-1"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      ["Tanner and Jones Settings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Disable traffic"] = false,
          ["Cutscene at mission end"] = "mis_ch4_conversation_01",
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Tanner and Jones 4 start",
          ["Audio logic file"] = "Tanner and Jones Mission 4 APIP",
          ["freezeFrameOnMissionEndCutscene"] = true,
          ["Delete task object on reject preview"] = false,
          ["disablePlayerIgnoring"] = false,
          ["Enable race status prompts"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    SpawnTypes = {
      ["Behind Tanner"] = {
        [1] = {
          actor = "Tanner and Jones",
          whichLane = "randomLane",
          withVehicleDirection = true,
          distance = 30,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = false
        },
        ["name"] = "Relative to Vehicle"
      },
      ["Tanner and Jones Spawn"] = {
        [1] = {
          ["1"] = "Tanner and Jones"
        },
        ["name"] = "Positions"
      },
      ["Attacker 01 spawn"] = {
        [1] = {
          ["Spawn location"] = "Attacker 01 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Attacker 02 spawn"] = {
        [1] = {
          ["Spawn location"] = "Attacker 02 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["In front of Krug3"] = {
        [1] = {
          actor = "Krug",
          whichLane = "randomLane",
          withVehicleDirection = false,
          distance = 225,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = true
        },
        ["name"] = "Relative to Vehicle"
      },
      ["Krug spawn"] = {
        [1] = {
          ["Spawn location"] = "Tanner and Jones 4 Krug spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["In front of Krug2"] = {
        [1] = {
          actor = "Krug",
          whichLane = "randomLane",
          withVehicleDirection = false,
          distance = 150,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = true
        },
        ["name"] = "Relative to Vehicle"
      },
      ["In front of Krug"] = {
        [1] = {
          actor = "Krug",
          whichLane = "randomLane",
          withVehicleDirection = false,
          distance = 35,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = true
        },
        ["name"] = "Relative to Vehicle"
      },
      ["Attacker 03 spawn"] = {
        [1] = {
          ["Spawn location"] = "Attacker 03 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    CustomAggressionSettings = {
      ["TJ4 CustomAggressionSetting"] = {
        [1] = {
          groupTakeDownMaxAttackersAtOnceIntercepting = 2,
          groupTakeDownMaxAttackersAtOnceFollowing = 2,
          groupTakeDownPerformanceBoost = 2,
          groupTakeDownTimeBetweenAttacks = 5,
          groupTakeDownMaxAttackersAtOnceStationary = 0,
          groupTakeDownFollowDistanceforNonAttackers = 25
        },
        ["name"] = "CustomAggressionSetting"
      }
    },
    Teams = {
      ["Tanner and Jones Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Team Attacker"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Krug Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionCompletes = {
      ["New Tanner and Jones Mission 4"] = {
        [1] = {
          ["Failure reason (Lost)"] = "ID:184763",
          ["Success reason (perfect)"] = "ID:184764",
          ["Failure reason (wrecked)"] = "ID:182731",
          ["Success reason"] = "ID:184764",
          ["Pass condition"] = "ID:233820",
          ["Failure reason"] = "ID:184761"
        },
        ["name"] = "Tanner and Jones Mission 4"
      }
    },
    WarmupTypes = {
      ["Tanner and Jones 4 Warmup"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          warmupRouteName = "TannerAndJones4WarmupRoute",
          forceZapToVehicle = false,
          forceMissionAccept = false,
          matchTrafficSpeed = true,
          lookToVehicle = false
        },
        ["name"] = "Warmup route"
      }
    },
    FelonySettings = {
      ["Tanner and Jones Felony Settings"] = {
        [1] = {reenablePatrollingVehiclesAfterFelonyEnd = false, disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    MissionInfos = {
      ["Tanner and Jones Title"] = {
        [1] = {
          ["1 Text"] = "ID:245543",
          ["missionMarkers"] = {
            [1] = {
              value = "Yellow Marker, Getaway Radius",
              cardName = "Krug",
              cardType = "Actor"
            },
            [2] = {
              value = "Objective",
              cardName = "Tanner and Jones",
              cardType = "Actor"
            },
            [3] = {
              value = "Opponent",
              cardName = "Attacker 01",
              cardType = "Actor"
            },
            [4] = {
              value = "Opponent",
              cardName = "Attacker 02",
              cardType = "Actor"
            },
            [5] = {
              value = "Opponent",
              cardName = "Attacker 03",
              cardType = "Actor"
            }
          },
          ["5 Text"] = "ID:236655",
          ["4 Text"] = "ID:243772",
          ["3 Text"] = "ID:243774",
          ["2 Text"] = "ID:236655"
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["Tanner and Jones Mission 4 Type"] = {
        [1] = {
          ["Krug team"] = {
            instance = 1,
            type = "Teams",
            name = "Krug Team"
          },
          ["Tickup time"] = 2,
          ["Tanner and Jones team"] = {
            instance = 1,
            type = "Teams",
            name = "Tanner and Jones Team"
          },
          ["Attacking team"] = {
            instance = 1,
            type = "Teams",
            name = "Team Attacker"
          },
          ["Furthest distance from target vehicle warning"] = 140,
          ["Furthest distance from target vehicle"] = 170,
          ["Closest distance to target vehicle warning"] = 40,
          ["Overall fail distance"] = 170,
          ["Start trigger distance"] = 100,
          ["Perfect Payload"] = 100,
          ["Closest distance to target vehicle"] = 20,
          ["Failure time"] = 5
        },
        ["name"] = "Tanner and Jones Mission 4"
      }
    }
  }
}
