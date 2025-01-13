cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Final destination"] = {
  FileVersion = "2",
  name = "Final destination",
  title = "ID:186263",
  MissionID = "408",
  description = "ID:186095",
  cardInstances = {
    Actors = {
      ["Big Rig"] = {
        [1] = {
          trailerPanelSet = 0,
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Big rig team"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "New Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          driveInOncoming = 0.1,
          driveOnPavements = 0.1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Warmup route"
          },
          vehicleTrailerId = 123,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          shaderParam = 4,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions"
          },
          vehicleId = 286,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 55,
          damageMultiplier = 0.5,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          desiredSpeed = 48,
          raceManagerRoute = false,
          stayInLockedArea = false,
          blockTow = false,
          previewMovie = "finalDestActor",
          avoidAttacks = false,
          matchTrafficSpeed = false,
          avoidedByCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["New Character"] = {
        [1] = {
          ["Passenger id"] = "1568132437",
          ["Driver id"] = "1221009583"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      ["New MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "FinalDestinationStart",
          ["Audio logic file"] = "Final Destination APIP",
          ["Spawn type"] = "Always active",
          ["Delete task object on reject preview"] = false,
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    Teams = {
      ["Big rig team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionCompletes = {
      ["New Final destination complete"] = {
        [1] = {
          ["Perfect condition"] = "ID:186121",
          ["Success reason"] = "ID:186122",
          ["Failure reason"] = "ID:186134",
          ["Success reason (perfect)"] = "ID:186123",
          ["Pass condition"] = "ID:186120",
          ["Failure reason (wrecked)"] = "ID:186134"
        },
        ["name"] = "Final destination"
      }
    },
    WarmupTypes = {
      ["New Warmup route"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          warmupRouteName = "Final destination route",
          forceZapToVehicle = false,
          forceMissionAccept = false,
          matchTrafficSpeed = false,
          lookToVehicle = false
        },
        ["name"] = "Warmup route"
      }
    },
    SpawnTypes = {
      ["New Positions"] = {
        [1] = {
          ["1"] = "Big Rig"
        },
        ["name"] = "Positions"
      }
    },
    MissionInfos = {
      ["New Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:186124",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective",
              cardName = "Big Rig",
              cardType = "Actor"
            }
          },
          ["3 Text"] = "ID:186126",
          ["2 Text"] = "ID:186125"
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Final destination"] = {
        [1] = {
          ["Big rig team"] = {
            instance = 1,
            type = "Teams",
            name = "Big rig team"
          }
        },
        ["name"] = "Final destination"
      }
    }
  }
}
