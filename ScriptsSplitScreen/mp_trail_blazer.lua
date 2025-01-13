cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["MP trail blazer"] = {
  FileVersion = "2",
  name = "MP trail blazer",
  title = "ID:169361",
  MissionID = "835",
  description = "ID:169950",
  cardInstances = {
    Actors = {
      ["Objective Team 1 member 1"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          desiredSpeed = 80,
          team = {
            instance = 1,
            type = "Teams",
            name = "Objective Team 1"
          },
          drivingSkill = "Professional",
          accidentProbability = 0,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0.2,
          driveOnPavements = 0.2,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = true,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          vehicleId = 171,
          vehicleTrailerId = -1,
          spawnSpeed = 0,
          enableSiren = false,
          damageMultiplier = 0,
          attackStationaryVehicle = false,
          enableSimulationArea = false,
          restrictedVehicleType = 4,
          stayInLockedArea = true,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 1,
          ignoreCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["Player 2"] = {
        [1] = {
          isMultiplayerActor = true,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Player Pool"
          },
          drivingSkill = "Average",
          reactionTime = "Average",
          wanderType = "random",
          selfRightIfOverturned = false,
          vehicleId = -1,
          whenSpawned = "Never",
          enableSiren = false,
          enableSimulationArea = false,
          aiIgnorePlayers = false,
          avoidUTurns = false,
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      ["Player 4"] = {
        [1] = {
          enableSiren = false,
          vehicleId = -1,
          whenSpawned = "Never",
          isMultiplayerActor = true,
          team = {
            instance = 1,
            type = "Teams",
            name = "Player Pool"
          }
        },
        ["name"] = "Actor"
      },
      ["Player 3"] = {
        [1] = {
          enableSiren = false,
          vehicleId = -1,
          whenSpawned = "Never",
          isMultiplayerActor = true,
          team = {
            instance = 1,
            type = "Teams",
            name = "Player Pool"
          }
        },
        ["name"] = "Actor"
      },
      ["Player 5"] = {
        [1] = {
          enableSiren = false,
          vehicleId = -1,
          whenSpawned = "Never",
          isMultiplayerActor = true,
          team = {
            instance = 1,
            type = "Teams",
            name = "Player Pool"
          }
        },
        ["name"] = "Actor"
      },
      ["Player 1"] = {
        [1] = {
          enableSiren = false,
          vehicleId = -1,
          whenSpawned = "Never",
          isMultiplayerActor = true,
          team = {
            instance = 1,
            type = "Teams",
            name = "Player Pool"
          }
        },
        ["name"] = "Actor"
      },
      ["Player 8"] = {
        [1] = {
          isMultiplayerActor = true,
          collisionResilience = "Average",
          reactionTime = "Average",
          wanderType = "random",
          enableSiren = false,
          vehicleId = -1,
          whenSpawned = "Never",
          team = {
            instance = 1,
            type = "Teams",
            name = "Player Pool"
          },
          drivingSkill = "Average"
        },
        ["name"] = "Actor"
      },
      ["Player 7"] = {
        [1] = {
          enableSiren = false,
          vehicleId = -1,
          whenSpawned = "Never",
          isMultiplayerActor = true,
          team = {
            instance = 1,
            type = "Teams",
            name = "Player Pool"
          }
        },
        ["name"] = "Actor"
      },
      ["Player 6"] = {
        [1] = {
          enableSiren = false,
          vehicleId = -1,
          whenSpawned = "Never",
          isMultiplayerActor = true,
          team = {
            instance = 1,
            type = "Teams",
            name = "Player Pool"
          }
        },
        ["name"] = "Actor"
      }
    },
    Multiplayers = {
      ["Multiplayer Mission Flag"] = {
        [1] = {},
        ["name"] = "Multiplayer"
      }
    },
    Teams = {
      ["Objective Team 1"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Player Pool"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionTypes = {
      ["Multiplayer Trail Blazer"] = {
        [1] = {
          ["Objective Team 1"] = {
            instance = 1,
            type = "Teams",
            name = "Objective Team 1"
          },
          ["Player Pool"] = {
            instance = 1,
            type = "Teams",
            name = "Player Pool"
          }
        },
        ["name"] = "Multiplayer trail blazer"
      }
    }
  }
}
