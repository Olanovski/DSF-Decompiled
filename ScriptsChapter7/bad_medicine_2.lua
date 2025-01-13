cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Bad medicine 2"] = {
  FileVersion = "2",
  name = "Bad medicine 2",
  title = "ID:186222",
  MissionID = "2835",
  description = "ID:184876",
  cardInstances = {
    Actors = {
      ["Convoy2"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = false,
          desiredSpeed = 70,
          team = {
            instance = 1,
            type = "Teams",
            name = "Convoy (Team)"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Enemy character 2"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Convoy2 SP (Spawn)"
          },
          vehicleId = 251,
          vehicleTrailerId = -1,
          enableSiren = false,
          enableSimulationArea = true,
          spawnSpeed = 20,
          shaderParam = 6,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          raceManagerRoute = false,
          routeName = "Bad medicine 2 convoy 2",
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = true,
          avoidAlleys = 0,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      },
      ["Attacker1 (Actor)"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 60,
          team = {
            instance = 1,
            type = "Teams",
            name = "Attacker (Team)"
          },
          drivingSkill = "Professional",
          characters = {
            instance = 1,
            type = "Characters",
            name = "Character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          driveInOncoming = 0,
          driveOnPavements = 0,
          previewMovie = " ",
          enableSiren = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Warmup route"
          },
          shaderParam = 11,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          avoidAlleys = 0,
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Positions 4"
          },
          vehicleId = 138,
          enableSimulationArea = false,
          isMultiplayerActor = false,
          spawnSpeed = 0,
          damageMultiplier = 0.3,
          attackStationaryVehicle = false,
          ignoreCivilianTraffic = false,
          routeName = "BadMedicince2HoldingRoute",
          noOccupants = false,
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average"
        },
        ["name"] = "Actor"
      },
      ["Convoy4"] = {
        [1] = {
          lockedToPlayer = true,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = true,
          aiIgnorePlayers = true,
          desiredSpeed = 65,
          team = {
            instance = 1,
            type = "Teams",
            name = "Convoy (Team)"
          },
          drivingSkill = "Professional",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Enemy character 3"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "Never",
          driveInOncoming = 0,
          driveOnPavements = 0,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Unstoppable",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Convoy4 SP (Spawn)"
          },
          vehicleId = 251,
          vehicleTrailerId = -1,
          enableSiren = false,
          enableSimulationArea = true,
          spawnSpeed = 20,
          shaderParam = 6,
          attackStationaryVehicle = false,
          reactionTime = "Average",
          raceManagerRoute = false,
          routeName = "Bad medicine 2 convoy 3",
          stayInLockedArea = false,
          blockTow = false,
          avoidedByCivilianTraffic = false,
          avoidAttacks = false,
          avoidAlleys = 0,
          ignoreCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Enemy character 3"] = {
        [1] = {
          ["Driver id"] = "1119988906"
        },
        ["name"] = "Character"
      },
      ["Character"] = {
        [1] = {
          ["Passenger id"] = "1738593945",
          ["Driver id"] = "507158672"
        },
        ["name"] = "Character"
      },
      ["Enemy character 2"] = {
        [1] = {
          ["Driver id"] = "1198907066"
        },
        ["name"] = "Character"
      }
    },
    SpawnTypes = {
      ["Attacker1 SP (Spawn)"] = {
        [1] = {
          ["Spawn location"] = "Bad medicine 2 attacker",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Convoy4 SP (Spawn)"] = {
        [1] = {
          ["Spawn location"] = "Bad medicine 2 convoy4",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Convoy2 SP (Spawn)"] = {
        [1] = {
          ["Spawn location"] = "Bad medicine 2 convoy2",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["New Positions 4"] = {
        [1] = {
          ["alternateLocation"] = "Bad medicine 2 attacker",
          ["1"] = "Attacker1 (Actor)"
        },
        ["name"] = "Positions"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {reenablePatrollingVehiclesAfterFelonyEnd = false, disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    Teams = {
      ["Attacker (Team)"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Convoy (Team)"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionCompletes = {
      ["Mission Complete"] = {
        [1] = {
          ["Perfect condition"] = "ID:186278",
          ["Success reason"] = "ID:236566",
          ["Failure reason"] = "ID:186148",
          ["Pass condition"] = "ID:186223",
          ["Success reason (perfect)"] = "ID:221948"
        },
        ["name"] = "Bad medicine 2"
      }
    },
    WarmupTypes = {
      ["Static (Warm up)"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          forceZapToVehicle = false,
          forceMissionAccept = false,
          lookToVehicle = false
        },
        ["name"] = "Static"
      },
      ["New Warmup route"] = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          warmupRouteName = "Bad medicine 2 warmup",
          forceZapToVehicle = false,
          forceMissionAccept = false,
          matchTrafficSpeed = true,
          lookToVehicle = false
        },
        ["name"] = "Warmup route"
      }
    },
    MissionSettings = {
      ["Mission Settings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Bad medicine 2 start",
          ["Audio logic file"] = "Bad medicine 2",
          ["Spawn type"] = "Always active",
          ["Delete task object on reject preview"] = false,
          ["disablePlayerIgnoring"] = false,
          ["Disable traffic"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    MissionInfos = {
      ["New Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:245545",
          ["missionMarkers"] = {
            [1] = {
              value = "Objective",
              cardName = "Attacker1 (Actor)",
              cardType = "Actor"
            },
            [2] = {
              value = "Opponent",
              cardName = "Convoy2",
              cardType = "Actor"
            },
            [3] = {
              value = "Opponent",
              cardName = "Convoy4",
              cardType = "Actor"
            }
          },
          ["4 Text"] = "ID:247305",
          ["3 Text"] = "ID:247309",
          ["2 Text"] = "ID:247305"
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["Mission Type"] = {
        [1] = {
          ["Chase team"] = {
            instance = 1,
            type = "Teams",
            name = "Attacker (Team)"
          },
          ["Race team"] = {
            instance = 1,
            type = "Teams",
            name = "Convoy (Team)"
          }
        },
        ["name"] = "Bad medicine 2"
      }
    }
  }
}
