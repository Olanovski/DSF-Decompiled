cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["SS ShowDown"] = {
  FileVersion = "2",
  name = "SS ShowDown",
  title = "#SHOWDOWN",
  MissionID = "4419",
  description = "<Description>",
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
          whenSpawned = "Never",
          avoidUTurns = false,
          avoidAttacks = false,
          matchTrafficSpeed = false,
          aiIgnorePlayers = false,
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
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
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Objective Team 1"
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
          whenSpawned = "Never",
          avoidUTurns = false,
          avoidAttacks = false,
          matchTrafficSpeed = false,
          aiIgnorePlayers = false,
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
      ["Split Screen Show Down"] = {
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
        ["name"] = "Split Screen Show Down"
      }
    }
  }
}
