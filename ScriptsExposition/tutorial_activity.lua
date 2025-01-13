cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Tutorial activity"] = {
  FileVersion = "2",
  name = "Tutorial activity",
  title = "TUTORIAL MISSION WILLPOWER",
  MissionID = "2770",
  description = "WILLPOWER TUTORIAL",
  cardInstances = {
    MissionSettings = {
      ["New MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = true,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Hud logic file"] = "Tutorial activity HUD",
          ["Disable traffic"] = false,
          ["Enable traffic at mission end"] = true,
          ["disablePlayerIgnoring"] = false,
          ["Audio logic file"] = "Dare activity and garage APIP",
          ["freezeFrameOnMissionEndCutscene"] = false,
          ["Delete task object on reject preview"] = false,
          ["Enable race status prompts"] = false
        },
        ["name"] = "MissionSettings"
      }
    },
    Teams = {
      ["Player team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    Actors = {
      ["Tutorial actor"] = {
        [1] = {
          noOccupants = false,
          lockedToPlayer = false,
          wrongWayIndicator = false,
          isMultiplayerActor = false,
          whenSpawned = "Never",
          avoidUTurns = false,
          previewMovie = "PREVIEW VEHICLE",
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          raceManagerRoute = false,
          ignoreCivilianTraffic = false,
          takeNonPlayerDamage = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Player team"
          },
          vehicleId = 272,
          enableSimulationArea = false,
          reactionTime = "Average",
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          avoidedByCivilianTraffic = false,
          shaderParam = 0,
          attackStationaryVehicle = false,
          forceHighLodCharacters = false,
          enableSiren = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          stayInLockedArea = false,
          blockTow = false,
          drivingSkill = "Average",
          avoidAttacks = false,
          matchTrafficSpeed = false,
          maintainLane = false,
          vehicleTrailerId = -1
        },
        ["name"] = "Actor"
      }
    },
    MissionInfos = {
      ["New Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:246214",
          ["missionMarkers"] = {
            [1] = {
              value = "None",
              cardName = "Tutorial actor",
              cardType = "Actor"
            }
          }
        },
        ["name"] = "Title and description"
      }
    },
    MissionTypes = {
      ["New Tutorial activity"] = {
        [1] = {
          ["Player team"] = {
            instance = 1,
            type = "Teams",
            name = "Player team"
          }
        },
        ["name"] = "Tutorial activity"
      }
    }
  }
}
