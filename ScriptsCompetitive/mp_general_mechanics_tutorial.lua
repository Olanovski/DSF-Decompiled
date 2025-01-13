cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["MP general mechanics tutorial"] = {
  FileVersion = "2",
  name = "MP general mechanics tutorial",
  title = "ID:235997",
  MissionID = "2904",
  description = "ID:235999",
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
      ["Objective Team 2 member 1"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          routeName = "ShiftImpulseRoute",
          team = {
            instance = 1,
            type = "Teams",
            name = "Objective Team 2"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Tough",
          raceManagerRoute = false,
          vehicleId = -1,
          attackStationaryVehicle = false,
          enableSiren = false,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          enableSimulationArea = false,
          avoidAttacks = false,
          desiredSpeed = 40,
          aiIgnorePlayerInCivsUntilHit = false,
          ignoreCivilianTraffic = false
        },
        ["name"] = "Actor"
      },
      ["Objective Team 1 member 1"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 40,
          team = {
            instance = 1,
            type = "Teams",
            name = "Objective Team 1"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          raceManagerRoute = false,
          vehicleId = -1,
          attackStationaryVehicle = false,
          enableSiren = false,
          enableSimulationArea = false,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          avoidAlleys = 1,
          ignoreCivilianTraffic = false,
          routeName = "ShiftImpulseRoute"
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
      },
      ["Objective Team 2"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionTypes = {
      ["Multiplayer general mechanics tutorial"] = {
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
        ["name"] = "Multiplayer general mechanics tutorial"
      }
    }
  }
}
