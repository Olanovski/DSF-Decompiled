cards = cards or {}
cards.Missions = cards.Missions or {}
cards.Missions["Tutorial garage"] = {
  FileVersion = "2",
  name = "Tutorial garage",
  title = "TUTORIAL MISSION WILLPOWER",
  MissionID = "2258",
  description = "WILLPOWER TUTORIAL",
  cardInstances = {
    Actors = {
      ["Tutorial actor"] = {
        [1] = {
          lockedToPlayer = false,
          wrongWayIndicator = false,
          unableToStartFelonies = false,
          forceHighLodAi = false,
          matchTrafficSpeed = false,
          obeyRaceTowingRules = false,
          aiIgnorePlayers = false,
          ignoreCivilianTraffic = false,
          team = {
            instance = 1,
            type = "Teams",
            name = "Player team"
          },
          drivingSkill = "Average",
          disablePanelDetach = false,
          forceHighLodCharacters = false,
          wanderType = "random",
          selfRightIfOverturned = true,
          maintainLane = false,
          whenSpawned = "Never",
          vehicleTrailerId = -1,
          noOccupants = false,
          takeNonPlayerDamage = false,
          isMultiplayerActor = false,
          avoidUTurns = false,
          aiIgnorePlayerInCivsUntilHit = false,
          collisionResilience = "Average",
          raceManagerRoute = false,
          vehicleId = 272,
          shaderParam = 0,
          attackStationaryVehicle = false,
          enableSiren = false,
          enableSimulationArea = false,
          previewMovie = "PREVIEW VEHICLE",
          stayInLockedArea = false,
          blockTow = false,
          ignoreOtherAis = false,
          avoidAttacks = false,
          reactionTime = "Average",
          avoidedByCivilianTraffic = false,
          unaffectedByRaceSpeedTweaks = false
        },
        ["name"] = "Actor"
      }
    },
    Teams = {
      ["Player team"] = {
        [1] = {},
        ["name"] = "Team"
      }
    },
    MissionSettings = {
      ["New MissionSettings"] = {
        [1] = {
          ["Disable auto-zap out on mission complete"] = true,
          ["Disable interesting vehicles"] = false,
          ["Spawn type"] = "Always active",
          ["Hud logic file"] = "Tutorial garage HUD",
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
    MissionInfos = {
      ["New Title and description"] = {
        [1] = {
          ["1 Text"] = "ID:246417",
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
      ["New Tutorial garage"] = {
        [1] = {
          ["Player team"] = {
            instance = 1,
            type = "Teams",
            name = "Player team"
          }
        },
        ["name"] = "Tutorial garage"
      }
    }
  }
}
