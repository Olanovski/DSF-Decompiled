cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Big break 2"] = {
  FileVersion = "2",
  name = "Big break 2",
  title = "ID:242164",
  MissionID = "13646",
  description = "ID:245446",
  cardInstances = {
    Actors = {
      Player = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          reactionTime = "Average",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          desiredSpeed = 60,
          team = {
            instance = 1,
            type = "Teams",
            name = "Player team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Tanner character"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          driveOnPavements = 0.1,
          previewMovie = "no preview",
          enableSiren = false,
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "Static"
          },
          shaderParam = 5,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          ignoreOtherAis = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "New Set position"
          },
          vehicleId = 273,
          enableSimulationArea = false,
          isMultiplayerActor = false,
          spawnSpeed = 0,
          damageMultiplier = 1,
          attackStationaryVehicle = false,
          ignoreCivilianTraffic = false,
          noOccupants = false,
          routeName = "BigBreak2Route",
          stayInLockedArea = false,
          blockTow = false,
          matchTrafficSpeed = false,
          avoidAttacks = false,
          raceManagerRoute = false,
          aiIgnorePlayerInCivsUntilHit = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Tanner character"] = {
        [1] = {
          ["Behind passenger id"] = "-1",
          ["Passenger id"] = "-1",
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      }
    },
    SpawnTypes = {
      ["New Set position"] = {
        [1] = {
          ["Spawn location"] = "Big break 2 spawn",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["New Positions"] = {
        [1] = {
          ["1"] = "Player"
        },
        ["name"] = "Positions"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {disablePoliceInTrafficDuringMission = false},
        ["name"] = "FelonySettings"
      },
      ["New FelonySettings 10"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    Teams = {
      ["Player team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionCompletes = {
      ["Big break 2 complete"] = {
        [1] = {
          ["Perfect condition"] = "ID:184295",
          ["Success reason"] = "ID:184294",
          ["Failure reason"] = "ID:184293",
          ["Pass condition"] = "ID:184294",
          ["Success reason (perfect)"] = "ID:221945"
        },
        ["name"] = "Big break 2"
      }
    },
    WarmupTypes = {
      Static = {
        [1] = {
          forceZapToVehicleFromPlayerVehicle = false,
          forceZapToVehicle = false,
          forceMissionAccept = false,
          lookToVehicle = false
        },
        ["name"] = "Static"
      }
    },
    MissionSettings = {
      ["New MissionSetting"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Disable traffic"] = true,
          ["Mission props"] = "BigBreak2Props2",
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Big break 2 start",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["disablePlayerIgnoring"] = false,
          ["Enable race status prompts"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    MissionInfos = {
      ["New Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:245599",
          ["missionMarkers"] = {
            [1] = {
              value = "None",
              cardName = "Player",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["Big break 2 type"] = {
        [1] = {
          ["Time limit"] = 20,
          ["Prop group type to smash"] = "advertisingGroup",
          ["Player team"] = {
            instance = 1,
            type = "Teams",
            name = "Player team"
          }
        },
        ["name"] = "Big break 2"
      }
    }
  }
}
