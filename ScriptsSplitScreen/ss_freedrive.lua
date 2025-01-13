cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["SS Freedrive"] = {
  FileVersion = "2",
  name = "SS Freedrive",
  title = "ID:235348",
  MissionID = "3928",
  description = "#HAVE FUN!",
  cardInstances = {
    Actors = {
      ["Player 1"] = {
        [1] = {
          noOccupants = false,
          lockedToPlayer = false,
          wrongWayIndicator = false,
          isMultiplayerActor = true,
          reactionTime = "Average",
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Player Pool"
          },
          maintainLane = false,
          drivingSkill = "Average",
          vehicleId = -1,
          enableSimulationArea = false,
          enableSiren = false,
          attackStationaryVehicle = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          stayInLockedArea = false,
          whenSpawned = "On mission start",
          avoidUTurns = false,
          avoidAttacks = false,
          matchTrafficSpeed = false,
          aiIgnorePlayers = false,
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      ["Player 2"] = {
        [1] = {
          noOccupants = false,
          lockedToPlayer = false,
          wrongWayIndicator = false,
          isMultiplayerActor = true,
          reactionTime = "Average",
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Player Pool"
          },
          maintainLane = false,
          drivingSkill = "Average",
          vehicleId = -1,
          enableSimulationArea = false,
          enableSiren = false,
          attackStationaryVehicle = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          stayInLockedArea = false,
          whenSpawned = "On mission start",
          avoidUTurns = false,
          avoidAttacks = false,
          matchTrafficSpeed = false,
          aiIgnorePlayers = false,
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
      }
    },
    MissionTypes = {
      ["Split Screen Freedrive"] = {
        [1] = {
          ["Player Pool"] = {
            instance = 1,
            type = "Teams",
            name = "Player Pool"
          }
        },
        ["name"] = "Split Screen Freedrive"
      }
    }
  }
}
