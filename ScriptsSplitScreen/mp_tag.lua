cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["MP tag"] = {
  FileVersion = "2",
  name = "MP tag",
  title = "ID:169349",
  MissionID = "1795",
  description = "ID:245810",
  cardInstances = {
    Actors = {
      ["Objective Team 1 member 1"] = {
        [1] = {
          noOccupants = false,
          lockedToPlayer = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          whenSpawned = "Never",
          reactionTime = "Average",
          wrongWayIndicator = false,
          avoidedByCivilianTraffic = false,
          enableSiren = false,
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          vehicleId = 241,
          team = {
            instance = 1,
            type = "Teams",
            name = "Objective Team 1"
          },
          matchTrafficSpeed = false,
          enableSimulationArea = false,
          obeyRaceTowingRules = false,
          spawnSpeed = 0,
          aiIgnorePlayers = false,
          restrictedVehicleType = 5,
          avoidUTurns = false,
          attackStationaryVehicle = false,
          forceHighLodCharacters = false,
          drivingSkill = "Average",
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          collisionResilience = "Average",
          stayInLockedArea = true,
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
      ["Mission Type Multiplayer Tag"] = {
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
        ["name"] = "Multiplayer tag"
      }
    }
  }
}
