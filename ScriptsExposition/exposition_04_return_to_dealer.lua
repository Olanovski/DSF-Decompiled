cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Exposition 04 return to dealer"] = {
  FileVersion = "2",
  name = "Exposition 04 return to dealer",
  title = "ID:173959",
  MissionID = "1783",
  description = "ID:173958",
  cardInstances = {
    Actors = {
      Lamborghini = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          matchTrafficSpeed = true,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 35,
          team = {
            instance = 1,
            type = "Teams",
            name = "Lamborghini Team"
          },
          drivingSkill = "Professional",
          characters = {
            instance = 1,
            type = "Characters",
            name = "Lamborghini characters"
          },
          forceHighLodCharacters = true,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "On warmup",
          driveInOncoming = 0,
          driveOnPavements = 0,
          previewMovie = "Preview vehicle",
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Overtake player"
          },
          vehicleTrailerId = -1,
          avoidUTurns = true,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Tough",
          raceManagerRoute = true,
          shaderParam = 3,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Relative to Vehicle"
          },
          vehicleId = 189,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 20,
          restrictedVehicleType = 0,
          damageMultiplier = 0.2,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          routeName = "Go for a spin",
          noOccupants = false,
          stayInLockedArea = true,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          ignoreCivilianTraffic = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Lamborghini characters"] = {
        [1] = {
          ["Passenger id"] = "267737180",
          ["Driver id"] = "1129624570"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      ["New MissionSetting"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Enable traffic at mission end"] = true,
          ["Spawn type"] = "Player position based",
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
      ["Lamborghini Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionCompletes = {
      ["New Exposition part 4 complete"] = {
        [1] = {
          ["Failure reason (wrecked)"] = "ID:173965",
          ["Success reason"] = "ID:173966",
          ["Pass condition"] = "ID:173966",
          ["Failure reason"] = "ID:173965"
        },
        ["name"] = "Exposition part 4"
      }
    },
    WarmupTypes = {
      ["New Overtake player"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          isLeader = true,
          forceZapToVehicle = false,
          forceMissionAccept = false,
          lookToVehicleTriggerRadius = 75,
          lookToVehicle = true
        },
        ["name"] = "Overtake player"
      }
    },
    SpawnTypes = {
      ["New Relative to Vehicle"] = {
        [1] = {
          withVehicleDirection = false,
          whichLane = "insideLane",
          missionStartLocation = "Go for a spin",
          distance = 75,
          useCameraPositionIfInZap = false,
          aheadOfVehicle = true
        },
        ["name"] = "Relative to Vehicle"
      }
    },
    MissionInfos = {
      ["New Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:173955",
          ["showRouteArrows"] = "All",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective",
              cardName = "Lamborghini",
              cardType = "Actor"
            }
          },
          ["4 Text"] = "ID:245513",
          ["3 Text"] = "ID:173950",
          ["2 Text"] = "ID:236468"
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Exposition part 4"] = {
        [1] = {
          ["Return to dealer team"] = {
            instance = 1,
            type = "Teams",
            name = "Lamborghini Team"
          },
          ["Damage amount for fail"] = 1
        },
        ["name"] = "Exposition part 4"
      }
    }
  }
}
