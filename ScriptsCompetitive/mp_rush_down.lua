cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["MP rush down"] = {
  FileVersion = "2",
  name = "MP rush down",
  title = "ID:169332",
  MissionID = "323",
  description = "ID:169948",
  cardInstances = {
    Actors = {
      ["Objective Team 1 member 1"] = {
        [1] = {
          enableSiren = false,
          vehicleId = -1,
          whenSpawned = "Never",
          isMultiplayerActor = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Objective Team 1"
          }
        },
        ["name"] = "Actor"
      },
      ["Player 2"] = {
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
      ["New Multiplayer rush down"] = {
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
        ["name"] = "Multiplayer rush down"
      }
    }
  }
}
