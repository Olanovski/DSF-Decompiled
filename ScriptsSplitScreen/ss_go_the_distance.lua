cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["SS Go the Distance"] = {
  FileVersion = "2",
  name = "SS Go the Distance",
  title = "ID:245430",
  MissionID = "3395",
  description = "ID:245803",
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
          lockedToPlayer = false,
          wrongWayIndicator = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
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
          collisionResilience = "Unstoppable",
          raceManagerRoute = false,
          vehicleId = -1,
          spawnSpeed = 0,
          attackStationaryVehicle = false,
          vehicleTrailerId = -1,
          enableSiren = false,
          enableSimulationArea = false,
          stayInLockedArea = false,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          avoidedByCivilianTraffic = false,
          desiredSpeed = 90,
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
      }
    },
    Multiplayers = {
      Multiplayer = {
        [1] = {},
        ["name"] = "Multiplayer"
      }
    },
    MissionTypes = {
      ["Split Screen Go the Distance"] = {
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
        ["name"] = "Split Screen Go the Distance"
      }
    }
  }
}
