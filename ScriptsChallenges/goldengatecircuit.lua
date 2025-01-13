cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions.GoldenGateCircuit = {
  FileVersion = "2",
  name = "GoldenGateCircuit",
  title = "ID:214695",
  MissionID = "31045",
  description = "ID:245445",
  cardInstances = {
    Actors = {
      ["Race team 1 member 1"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = true,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          routeName = "GoldenGateCircuitRoute",
          team = {
            instance = 1,
            type = "Teams",
            name = "GoldenGateCircuit Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "GoldenGateCircuit Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          previewMovie = " ",
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "GoldenGateCircuit Static"
          },
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          shaderParam = 8,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions 2"
          },
          vehicleId = 242,
          enableSiren = false,
          enableSimulationArea = false,
          spawnSpeed = 0,
          damageMultiplier = 1.2,
          attackStationaryVehicle = false,
          isMultiplayerActor = false,
          ignoreCivilianTraffic = false,
          noOccupants = false,
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          raceManagerRoute = true,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["GoldenGateCircuit Character"] = {
        [1] = {
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      ["GoldenGateCircuit MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "GoldenGateCircuitStart",
          ["Spawn type"] = "Always active",
          ["Delete task object on reject preview"] = true,
          ["Disable traffic"] = true
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["GoldenGateCircuit Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    SpawnTypes = {
      ["New Positions 2"] = {
        [1] = {
          ["1"] = "Race team 1 member 1"
        },
        ["name"] = "Positions"
      }
    },
    WarmupTypes = {
      ["GoldenGateCircuit Static"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          forceZapToVehicle = false,
          forceMissionAccept = false,
          lookToVehicle = false
        },
        ["name"] = "Static"
      }
    },
    FelonySettings = {
      ["New FelonySettings 9"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    MissionInfos = {
      ["GoldenGateCircuit Title"] = {
        [1] = {
          ["1 Text"] = "ID:245597",
          ["Success reason"] = "ID:245559",
          ["showRouteArrows"] = "All",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective",
              cardName = "Race team 1 member 1",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["GoldenGateCircuit settings"] = {
        [1] = {
          ["Slow motion on goal complete"] = false,
          ["Total laps"] = 1,
          ["Destroy opposing teams"] = false,
          ["Endless race"] = false,
          ["Overtake target (+ score)"] = false,
          ["Score drift distance"] = false,
          ["Race team 1"] = {
            instance = 1,
            type = "Teams",
            name = "GoldenGateCircuit Team"
          },
          ["Score jump distance"] = false,
          ["Damage amount for fail"] = 1,
          ["Start prompt"] = "ID:245597",
          ["scoringType"] = "Time",
          ["Hide checkpoints"] = false,
          ["Checkpoint type"] = "Checkpoint Gate"
        },
        ["name"] = "Generic challenge race"
      }
    }
  }
}
