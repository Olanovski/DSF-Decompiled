cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Tutorial Mission Rapid Shift"] = {
  FileVersion = "2",
  name = "Tutorial Mission Rapid Shift",
  title = "RAPID SHIFT TUTORIAL",
  MissionID = "5364",
  description = "RAPID SHIFT TUTORIAL",
  cardInstances = {
    MissionSettings = {
      ["New MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = true,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Hud logic file"] = "Tutorial mission Rapid shift HUD",
          ["Disable traffic"] = false,
          ["Enable traffic at mission end"] = true,
          ["disablePlayerIgnoring"] = false,
          ["Audio logic file"] = "Rapid shift APIP",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["Enable race status prompts"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["cop 2 team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["cop team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["New Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    SpawnTypes = {
      ["Relative to Vehicle Evader"] = {
        [1] = {
          withVehicleDirection = true,
          whichLane = "randomLane",
          distance = 10,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = true
        },
        ["name"] = "Relative to Vehicle"
      },
      ["New Positions"] = {
        [1] = {
          ["1"] = "Tutorial cop",
          ["alternateLocation"] = "Rapid shift tutorial start",
          ["2"] = "Tutorial cop 2"
        },
        ["name"] = "Positions"
      },
      ["Relative to Vehicle Backup"] = {
        [1] = {
          actor = "Tutorial evader",
          whichLane = "randomLane",
          withVehicleDirection = true,
          distance = 10,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = false
        },
        ["name"] = "Relative to Vehicle"
      },
      ["Relative to Vehicle Cops"] = {
        [1] = {
          withVehicleDirection = true,
          whichLane = "randomLane",
          distance = 10,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = false
        },
        ["name"] = "Relative to Vehicle"
      }
    },
    Actors = {
      ["Tutorial cop 2"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 100,
          team = {
            instance = 1,
            type = "Teams",
            name = "cop team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          maxAllowedDamage = 0.8,
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 271,
          enableSiren = true,
          rubberbandingToPlayerStrength = "Strong",
          enableSimulationArea = false,
          spawnSpeed = 35,
          rubberbandingActor = "Tutorial actor",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -20,
          reactionTime = "Average",
          raceManagerRoute = false,
          stayInLockedArea = true,
          blockTow = true,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          avoidAlleys = 1,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Tutorial actor"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 100,
          team = {
            instance = 1,
            type = "Teams",
            name = "New Team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          vehicleTrailerId = -1,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          enableSiren = true,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          vehicleId = 271,
          enableSimulationArea = false,
          rubberbandingToPlayerStrength = "Strong",
          spawnSpeed = 35,
          rubberbandingActor = "Tutorial actor",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -20,
          reactionTime = "Average",
          raceManagerRoute = false,
          previewMovie = "Preview",
          stayInLockedArea = true,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          avoidAlleys = 1,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Tutorial evader"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 50,
          team = {
            instance = 1,
            type = "Teams",
            name = "cop 2 team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          maxAllowedDamage = 0.5,
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          shaderParam = 5,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Relative to Vehicle Evader"
          },
          vehicleId = 158,
          enableSiren = true,
          rubberbandingToPlayerStrength = "Strong",
          enableSimulationArea = false,
          spawnSpeed = 90,
          rubberbandingActor = "Tutorial actor",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -20,
          reactionTime = "Average",
          raceManagerRoute = false,
          stayInLockedArea = true,
          blockTow = false,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          avoidAlleys = 1,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Tutorial cop backup"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 100,
          team = {
            instance = 1,
            type = "Teams",
            name = "cop 2 team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          maxAllowedDamage = 0.8,
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Relative to Vehicle Cops"
          },
          vehicleId = 271,
          enableSiren = true,
          rubberbandingToPlayerStrength = "Strong",
          enableSimulationArea = false,
          spawnSpeed = 35,
          rubberbandingActor = "Tutorial actor",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -20,
          reactionTime = "Average",
          raceManagerRoute = false,
          stayInLockedArea = true,
          blockTow = true,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          avoidAlleys = 1,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Tutorial cop"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 100,
          team = {
            instance = 1,
            type = "Teams",
            name = "cop team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          maxAllowedDamage = 0.8,
          forceHighLodCharacters = false,
          wanderType = "preferStraight",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          vehicleTrailerId = -1,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 271,
          enableSiren = true,
          rubberbandingToPlayerStrength = "Strong",
          enableSimulationArea = false,
          spawnSpeed = 35,
          rubberbandingActor = "Tutorial actor",
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          distanceBehindPlayer = -20,
          reactionTime = "Average",
          raceManagerRoute = false,
          stayInLockedArea = true,
          blockTow = true,
          aiIgnorePlayerInCivsUntilHit = false,
          avoidAttacks = false,
          avoidAlleys = 1,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {reenablePatrollingVehiclesAfterFelonyEnd = false, disablePoliceInTrafficDuringMission = false},
        ["name"] = "FelonySettings"
      }
    },
    MissionInfos = {
      ["New Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:231353",
          ["missionMarkers"] = {
            [1] = {
              value = "None",
              cardName = "Tutorial cop 2",
              cardType = "Actor"
            },
            [2] = {
              value = "None",
              cardName = "Tutorial actor",
              cardType = "Actor"
            },
            [3] = {
              value = "Red Marker, Fake Felony Radius",
              cardName = "Tutorial evader",
              cardType = "Actor"
            },
            [4] = {
              value = "Objective",
              cardName = "Tutorial cop",
              cardType = "Actor"
            },
            [5] = {
              value = "None",
              cardName = "Tutorial cop backup",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Tutorial Mission Rapid Shift"] = {
        [1] = {
          ["Tanner team"] = {
            instance = 1,
            type = "Teams",
            name = "New Team"
          },
          ["Cop team"] = {
            instance = 1,
            type = "Teams",
            name = "cop team"
          },
          ["Cop 2 team"] = {
            instance = 1,
            type = "Teams",
            name = "cop 2 team"
          }
        },
        ["name"] = "Tutorial Mission Rapid Shift"
      }
    }
  }
}
