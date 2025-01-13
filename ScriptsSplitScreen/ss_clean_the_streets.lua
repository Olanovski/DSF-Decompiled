cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["SS Clean the streets"] = {
  FileVersion = "2",
  name = "SS Clean the streets",
  title = "ID:245431",
  MissionID = "2883",
  description = "ID:245804",
  cardInstances = {
    Actors = {
      ["Objective Team 2 member 1"] = {
        [1] = {
          noOccupants = false,
          lockedToPlayer = false,
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          vehicleId = -1,
          team = {
            instance = 1,
            type = "Teams",
            name = "Objective Team 2"
          },
          drivingSkill = "Average",
          matchTrafficSpeed = false,
          enableSiren = false,
          takeNonPlayerDamage = false,
          enableSimulationArea = false,
          attackStationaryVehicle = false,
          forceHighLodCharacters = false,
          obeyRaceTowingRules = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          stayInLockedArea = false,
          whenSpawned = "Never",
          aiIgnorePlayers = false,
          avoidAttacks = false,
          reactionTime = "Average",
          maintainLane = false,
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      },
      ["Objective Team 1 member 2"] = {
        [1] = {
          noOccupants = false,
          lockedToPlayer = false,
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          avoidUTurns = true,
          vehicleTrailerId = -1,
          avoidedByCivilianTraffic = false,
          aiIgnorePlayers = true,
          raceManagerRoute = false,
          restrictedVehicleType = 5,
          vehicleId = -1,
          team = {
            instance = 1,
            type = "Teams",
            name = "Objective Team 1"
          },
          reactionTime = "Average",
          enableSimulationArea = false,
          collisionResilience = "Very tough",
          desiredSpeed = 85,
          ignoreCivilianTraffic = false,
          enableSiren = false,
          drivingSkill = "Professional",
          attackStationaryVehicle = false,
          forceHighLodCharacters = false,
          matchTrafficSpeed = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          stayInLockedArea = false,
          avoidAttacks = true,
          distanceFromFrontOfGroup = 0,
          driveInOncoming = 0.5,
          driveOnPavements = 0.3
        },
        ["name"] = "Actor"
      },
      ["Objective Team 1 member 1"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Objective Team 1"
          },
          drivingSkill = "Professional",
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0.3,
          driveOnPavements = 0.3,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = true,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          raceManagerRoute = false,
          vehicleId = -1,
          attackStationaryVehicle = false,
          vehicleTrailerId = -1,
          enableSiren = false,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          enableSimulationArea = false,
          desiredSpeed = 90,
          avoidAttacks = false,
          avoidAlleys = 1,
          avoidedByCivilianTraffic = false,
          restrictedVehicleType = 5
        },
        ["name"] = "Actor"
      },
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
      ["Objective Team 1 member 3"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Objective Team 1"
          },
          drivingSkill = "Professional",
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0.3,
          driveOnPavements = 0.3,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = true,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          raceManagerRoute = false,
          vehicleId = -1,
          attackStationaryVehicle = false,
          vehicleTrailerId = -1,
          enableSiren = false,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          enableSimulationArea = false,
          desiredSpeed = 90,
          avoidAttacks = false,
          avoidAlleys = 1,
          avoidedByCivilianTraffic = false,
          restrictedVehicleType = 5
        },
        ["name"] = "Actor"
      },
      ["Objective Team 1 member 4"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = true,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Objective Team 1"
          },
          drivingSkill = "Professional",
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0.3,
          driveOnPavements = 0.3,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = true,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Tough",
          raceManagerRoute = false,
          vehicleId = -1,
          attackStationaryVehicle = false,
          vehicleTrailerId = -1,
          enableSiren = false,
          matchTrafficSpeed = false,
          stayInLockedArea = false,
          enableSimulationArea = false,
          desiredSpeed = 90,
          avoidAttacks = false,
          avoidAlleys = 1,
          avoidedByCivilianTraffic = false,
          restrictedVehicleType = 5
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
      },
      ["Objective Team 2"] = {
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
      ["Split Screen Clean the Streets"] = {
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
        ["name"] = "Split Screen Clean the Streets"
      }
    }
  }
}
