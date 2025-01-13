cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["MP burning rubber"] = {
  FileVersion = "2",
  name = "MP burning rubber",
  title = "ID:168506",
  MissionID = "771",
  description = "ID:169943",
  cardInstances = {
    Actors = {
      ["Objective Team 1 member 1"] = {
        [1] = {
          noOccupants = false,
          lockedToPlayer = false,
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          reactionTime = "Average",
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          restrictedVehicleType = 4,
          team = {
            instance = 1,
            type = "Teams",
            name = "Objective Team 1"
          },
          maintainLane = false,
          drivingSkill = "Average",
          vehicleId = -1,
          enableSiren = false,
          enableSimulationArea = false,
          attackStationaryVehicle = false,
          forceHighLodCharacters = false,
          avoidUTurns = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          stayInLockedArea = true,
          whenSpawned = "Never",
          matchTrafficSpeed = false,
          avoidAttacks = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      ["Player 2"] = {
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
      ["Objective Team 2 member 1"] = {
        [1] = {
          noOccupants = false,
          lockedToPlayer = false,
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          reactionTime = "Average",
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          restrictedVehicleType = 4,
          team = {
            instance = 1,
            type = "Teams",
            name = "Objective Team 2"
          },
          maintainLane = false,
          drivingSkill = "Average",
          vehicleId = -1,
          enableSiren = false,
          enableSimulationArea = false,
          attackStationaryVehicle = false,
          forceHighLodCharacters = false,
          avoidUTurns = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          stayInLockedArea = true,
          whenSpawned = "Never",
          matchTrafficSpeed = false,
          avoidAttacks = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      ["Player 1"] = {
        [1] = {
          enableSiren = false,
          whenSpawned = "Never",
          restrictedVehicleType = 0,
          isMultiplayerActor = true,
          team = {
            instance = 1,
            type = "Teams",
            name = "Player Pool"
          },
          vehicleId = -1
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
      ["Player 8"] = {
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
      }
    },
    Multiplayers = {
      ["Multiplayer Mission Flag"] = {
        [1] = {},
        ["name"] = "Multiplayer"
      }
    },
    Teams = {
      ["Objective Team 2"] = {
        [1] = {},
        ["name"] = "Team"
      },
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
      ["Mission Type Multiplayer Burning Rubber"] = {
        [1] = {
          ["Objective Team 2"] = {
            instance = 1,
            type = "Teams",
            name = "Objective Team 2"
          },
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
        ["name"] = "Multiplayer burning rubber"
      }
    }
  }
}
