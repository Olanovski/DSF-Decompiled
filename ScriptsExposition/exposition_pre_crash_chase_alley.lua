cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Exposition pre crash chase alley"] = {
  FileVersion = "2",
  name = "Exposition pre crash chase alley",
  title = "ID:182836",
  MissionID = "6903",
  description = "ID:221953",
  cardInstances = {
    Actors = {
      Tanner = {
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
            name = "Tanner Team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Tanner car characters"
          },
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On warmup",
          vehicleTrailerId = -1,
          previewMovie = "no preview",
          takeNonPlayerDamage = false,
          warmupType = {
            instance = 1,
            type = "WarmupTypes",
            name = "New Cutscene"
          },
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Tanner Set position"
          },
          vehicleId = 62,
          spawnSpeed = 0,
          shaderParam = 0,
          attackStationaryVehicle = false,
          enableSiren = false,
          enableSimulationArea = false,
          stayInLockedArea = false,
          blockTow = false,
          noOccupants = false,
          avoidAttacks = false,
          isMultiplayerActor = false,
          matchTrafficSpeed = false,
          aiIgnorePlayerInCivsUntilHit = false
        },
        ["name"] = "Actor"
      },
      Jericho = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Jericho Team"
          },
          enableSimulationArea = true,
          disablePanelDetach = false,
          characters = {
            instance = 1,
            type = "Characters",
            name = "Jericho character"
          },
          forceHighLodCharacters = true,
          wanderType = "random",
          selfRightIfOverturned = false,
          maintainLane = false,
          whenSpawned = "On mission start",
          vehicleTrailerId = -1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          avoidedByCivilianTraffic = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          spawnType = {
            instance = 1,
            type = "SpawnTypes",
            name = "Jerciho Set position"
          },
          vehicleId = 277,
          shaderParam = 0,
          attackStationaryVehicle = false,
          stayInLockedArea = false,
          blockTow = false,
          reactionTime = "Average",
          avoidAttacks = false,
          enableSiren = false,
          drivingSkill = "Average",
          aiIgnorePlayerInCivsUntilHit = false
        },
        ["name"] = "Actor"
      }
    },
    Characters = {
      ["Jericho character"] = {
        [1] = {
          ["Driver id"] = "-376150524"
        },
        ["name"] = "Character"
      },
      ["Tanner car characters"] = {
        [1] = {
          ["Passenger id"] = "-1916574018",
          ["Driver id"] = "-673381849"
        },
        ["name"] = "Character"
      }
    },
    MissionSettings = {
      ["New MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = false,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Disable traffic"] = false,
          ["Mission props"] = "Bull run props",
          ["Enable traffic at mission end"] = true,
          ["Start location"] = "Exposition pre crash drive to mission start",
          ["Audio logic file"] = "Exposition post crash jericho chase alley",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["disablePlayerIgnoring"] = false,
          ["Enable race status prompts"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["Tanner Team"] = {
        [1] = {},
        ["name"] = "Team"
      },
      ["Jericho Team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    FelonySettings = {
      ["New FelonySettings"] = {
        [1] = {disablePoliceInTrafficDuringMission = true},
        ["name"] = "FelonySettings"
      }
    },
    WarmupTypes = {
      ["New Cutscene"] = {
        [1] = {forceMissionAccept = true},
        ["name"] = "Cutscene"
      }
    },
    SpawnTypes = {
      ["Jerciho Set position"] = {
        [1] = {
          ["Spawn location"] = "Exposition pre crash alleyway jericho",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      },
      ["Tanner Set position"] = {
        [1] = {
          ["Spawn location"] = "Exposition pre crash alleyway tanner",
          ["Snap to closest road"] = false
        },
        ["name"] = "Set position"
      }
    },
    MissionInfos = {
      ["New Title and description"] = {
        [1] = {
          missionMarkers = {
            [1] = {
              value = "None",
              cardName = "Tanner",
              cardType = "Actor"
            },
            [2] = {
              value = "None",
              cardName = "Jericho",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Exposition pre crash chase alleyway"] = {
        [1] = {
          ["Jericho team"] = {
            instance = 1,
            type = "Teams",
            name = "Jericho Team"
          },
          ["Tanner team"] = {
            instance = 1,
            type = "Teams",
            name = "Tanner Team"
          }
        },
        ["name"] = "Exposition pre crash chase alleyway"
      }
    }
  }
}
