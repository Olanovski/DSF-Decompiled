cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["MP team circuit race"] = {
  FileVersion = "2",
  name = "MP team circuit race",
  title = "ID:231134",
  MissionID = "1368",
  description = "ID:245969",
  cardInstances = {
    Actors = {
      ["Objective Team 1 member 1"] = {
        [1] = {
          restrictedVehicleType = 0,
          vehicleId = -1,
          whenSpawned = "Never",
          isMultiplayerActor = false,
          enableSiren = false,
          reactionTime = "Average",
          wanderType = "random",
          collisionResilience = "Average",
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          avoidedByCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Objective Team 1"
          },
          aiIgnorePlayers = false,
          drivingSkill = "Average",
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      ["Player 2"] = {
        [1] = {
          ignoreCivilianTraffic = false,
          isMultiplayerActor = true,
          vehicleId = -1,
          reactionTime = "Average",
          enableSiren = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          whenSpawned = "Never",
          wanderType = "random",
          team = {
            instance = 1,
            type = "Teams",
            name = "Player Pool"
          },
          aiIgnorePlayers = false,
          drivingSkill = "Average",
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
      ["Player 1"] = {
        [1] = {
          ignoreCivilianTraffic = false,
          isMultiplayerActor = true,
          vehicleId = -1,
          reactionTime = "Average",
          enableSiren = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          whenSpawned = "Never",
          wanderType = "random",
          team = {
            instance = 1,
            type = "Teams",
            name = "Player Pool"
          },
          aiIgnorePlayers = false,
          drivingSkill = "Average",
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      ["Player 6"] = {
        [1] = {
          ignoreCivilianTraffic = false,
          isMultiplayerActor = true,
          vehicleId = -1,
          reactionTime = "Average",
          enableSiren = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          whenSpawned = "Never",
          wanderType = "random",
          team = {
            instance = 1,
            type = "Teams",
            name = "Player Pool"
          },
          aiIgnorePlayers = false,
          drivingSkill = "Average",
          vehicleTrailerId = -1
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
      }
    },
    Multiplayers = {
      ["Multiplayer Mission Flag"] = {
        [1] = {},
        ["name"] = "Multiplayer"
      }
    },
    Teams = {
      ["Player Pool"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Objective Team 1"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionTypes = {
      ["New Multiplayer team circuit race"] = {
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
        ["name"] = "Multiplayer team circuit race"
      }
    }
  }
}
