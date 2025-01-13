cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["MP shift impulse tutorial"] = {
  FileVersion = "2",
  name = "MP shift impulse tutorial",
  title = "ID:235995",
  MissionID = "1880",
  description = "ID:235996",
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
          whenSpawned = "On warmup",
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
          aiIgnorePlayers = false,
          isMultiplayerActor = false,
          vehicleId = -1,
          reactionTime = "Average",
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          enableSiren = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Objective Team 1"
          },
          drivingSkill = "Average",
          enableSimulationArea = false,
          avoidUTurns = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          stayInLockedArea = true,
          whenSpawned = "On warmup",
          desiredSpeed = 60,
          routeName = "ShiftImpulseRoute",
          matchTrafficSpeed = false,
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      }
    },
    Multiplayers = {
      ["New Multiplayer"] = {
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
      ["Multiplayer shift impulse tutorial"] = {
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
        ["name"] = "Multiplayer shift impulse tutorial"
      }
    }
  }
}
