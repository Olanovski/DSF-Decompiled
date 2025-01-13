cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["MP Vehicle Spawn Tutorial"] = {
  FileVersion = "2",
  name = "MP Vehicle Spawn Tutorial",
  title = "ID:235983",
  MissionID = "2371",
  description = "ID:235984",
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
      },
      ["Objective Team 1 member 1"] = {
        [1] = {
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          aiIgnorePlayers = false,
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Objective Team 1"
          },
          drivingSkill = "Average",
          routeName = "ShiftImpulseRoute",
          vehicleId = -1,
          enableSiren = false,
          enableSimulationArea = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          stayInLockedArea = true,
          whenSpawned = "Never",
          restrictedVehicleType = 0,
          matchTrafficSpeed = false,
          reactionTime = "Average",
          collisionResilience = "Average",
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
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
    Multiplayers = {
      Multiplayer = {
        [1] = {},
        ["name"] = "Multiplayer"
      }
    },
    MissionTypes = {
      ["Multiplayer vehicle spawn tutorial"] = {
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
        ["name"] = "Multiplayer vehicle spawn tutorial"
      }
    }
  }
}
