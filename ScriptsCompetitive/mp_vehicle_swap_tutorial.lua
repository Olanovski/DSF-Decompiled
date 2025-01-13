cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["MP Vehicle Swap Tutorial"] = {
  FileVersion = "2",
  name = "MP Vehicle Swap Tutorial",
  title = "ID:235989",
  MissionID = "1859",
  description = "ID:235990",
  cardInstances = {
    Actors = {
      ["Player 1"] = {
        [1] = {
          ignoreCivilianTraffic = false,
          vehicleId = -1,
          enableSimulationArea = false,
          isMultiplayerActor = true,
          enableSiren = false,
          reactionTime = "Average",
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
      }
    },
    MissionTypes = {
      ["Multiplayer vehicle swap tutorial"] = {
        [1] = {
          ["Player Pool"] = {
            instance = 1,
            type = "Teams",
            name = "Player Pool"
          }
        },
        ["name"] = "Multiplayer vehicle swap tutorial"
      }
    }
  }
}
