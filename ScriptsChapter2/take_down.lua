cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Take down"] = {
  FileVersion = "2",
  name = "Take down",
  title = "ID:184450",
  MissionID = "1234",
  description = "ID:184449",
  cardInstances = {
    Actors = {
      ["Evade team member 1"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 80,
          team = {
            instance = 1,
            type = "Teams",
            name = "Chase (Team)"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Julius"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          distanceFromFrontOfGroup = 0,
          driveInOncoming = 0.5,
          driveOnPavements = 0.5,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Warmup route leader"
          },
          enableSiren = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = true,
          collisionResilience = "Very tough",
          raceManagerRoute = true,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Evader Positions"
          },
          vehicleId = 252,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 0,
          rubberbandingActor = "Player",
          damageCauseScale = 2.5,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          rubberbandingStrength = "Low",
          isMultiplayerActor = false,
          stayInLockedArea = true,
          blockTow = false,
          ignoreCivilianTraffic = false,
          avoidAttacks = true,
          reactionTime = "Average",
          aiIgnorePlayerInCivsUntilHit = false
        },
        ["name"] = "Actor"
      },
      ["Player"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Player team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
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
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New As localPlayer"
          },
          vehicleId = -1,
          attackStationaryVehicle = false,
          stayInLockedArea = false,
          blockTow = false,
          enableSiren = false,
          avoidAttacks = false,
          enableSimulationArea = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["Chase team member 1"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Fast",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 120,
          team = {
            instance = 1,
            type = "Teams",
            name = "Chase (Team)"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Willa"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          distanceFromFrontOfGroup = 20,
          driveOnPavements = 0.2,
          previewMovie = "csx_2",
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Warmup route leader"
          },
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          vehicleTrailerId = -1,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Cop Positions"
          },
          vehicleId = 280,
          enableSiren = true,
          enableSimulationArea = false,
          spawnSpeed = 40,
          damageMultiplier = 0.7,
          attackStationaryVehicle = false,
          rubberbandingStrength = "High",
          isMultiplayerActor = false,
          ignoreCivilianTraffic = false,
          stayInLockedArea = false,
          blockTow = false,
          noOccupants = false,
          avoidAttacks = false,
          matchTrafficSpeed = false,
          aiIgnorePlayerInCivsUntilHit = false
        },
        ["name"] = "Actor"
      },
      ["Chase team member 2"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Slow",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 120,
          team = {
            instance = 1,
            type = "Teams",
            name = "Chase (Team)"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Nori"
          },
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On mission start",
          distanceFromFrontOfGroup = 20,
          driveOnPavements = 0.2,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Spawn behind chaser"
          },
          vehicleId = 280,
          vehicleTrailerId = -1,
          spawnSpeed = 0,
          enableSiren = true,
          enableSimulationArea = false,
          damageMultiplier = 0.7,
          attackStationaryVehicle = false,
          rubberbandingStrength = "High",
          stayInLockedArea = false,
          blockTow = false,
          avoidAttacks = false,
          matchTrafficSpeed = false,
          aiIgnorePlayerInCivsUntilHit = false,
          ignoreCivilianTraffic = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      Willa = {
        [1] = {
          ["Passenger id"] = "-879852041",
          ["Driver id"] = "600862826"
        },
        ["name"] = "Character"
      },
      Nori = {
        [1] = {
          ["Passenger id"] = "-872299577",
          ["Driver id"] = "-1784376771"
        },
        ["name"] = "Character"
      },
      Julius = {
        [1] = {
          ["Passenger id"] = "819811740",
          ["Driver id"] = "1554913775"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      ["Mission Settings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Spawn type"] = "Always active",
          ["Enable traffic at mission end"] = true,
          ["disablePlayerIgnoring"] = false,
          ["Audio logic file"] = "Take down",
          ["Load traffic on start"] = "Chapter 2 God",
          ["Delete task object on reject preview"] = false,
          ["Start location"] = "Takedown the getaway start",
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["Chase (Team)"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Player team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    WarmupTypes = {
      ["Warmup route leader"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          matchTrafficSpeed = false,
          warmupRouteName = "Takedown the getaway warmup route",
          forceZapToVehicle = false,
          actorToChase = "Evade team member 1",
          forceMissionAccept = false,
          lookToVehicle = false
        },
        ["name"] = "Warmup route"
      }
    },
    SpawnTypes = {
      ["Cop Positions"] = {
        [1] = {
          ["alternateLocation"] = "Takedown the getaway cop spawn",
          ["1"] = "Chase team member 1"
        },
        ["name"] = "Positions"
      },
      ["New As localPlayer"] = {
        [1] = {},
        ["name"] = "As localPlayer"
      },
      ["Spawn behind chaser"] = {
        [1] = {
          actor = "Chase team member 1",
          whichLane = "randomLane",
          withVehicleDirection = true,
          distance = 20,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = false
        },
        ["name"] = "Relative to Vehicle"
      },
      ["Evader Positions"] = {
        [1] = {
          ["alternateLocation"] = "Takedown the getaway evade spawn",
          ["1"] = "Evade team member 1"
        },
        ["name"] = "Positions"
      }
    },
    MissionInfos = {
      ["Takedown the getaway (Title and description)"] = {
        [1] = {
          ["1 Text"] = "ID:184451",
          ["Success reason"] = "ID:184456",
          ["Failure reason"] = "ID:184452",
          ["Pass condition"] = "ID:184454",
          ["missionMarkers"] = {
            [1] = {
              value = "None",
              cardName = "Evade team member 1",
              cardType = "Actor"
            },
            [2] = {
              value = "None",
              cardName = "Chase team member 2",
              cardType = "Actor"
            },
            [3] = {
              value = "None",
              cardName = "Player",
              cardType = "Actor"
            },
            [4] = {
              value = "None",
              cardName = "Chase team member 1",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      MissionType = {
        [1] = {
          ["Evader damage for chaser win"] = 1,
          ["Player team"] = {
            instance = 1,
            type = "Teams",
            name = "Player team"
          },
          ["Chase team"] = {
            instance = 1,
            type = "Teams",
            name = "Chase (Team)"
          },
          ["Chaser damage for evader win"] = 1
        },
        ["name"] = "Take down the getaway"
      }
    }
  }
}
