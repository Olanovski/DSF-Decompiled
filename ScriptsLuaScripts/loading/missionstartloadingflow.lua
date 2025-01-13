module("missionStartLoading", package.seeall)
state = "inactive"
local debugOutput = function(output)
  print("[missionStartLoading] : " .. tostring(output))
end
function purge()
  if state ~= "inactive" then
    removeUserUpdateFunction("missionStartLoading")
  end
end
function handleMissionStartLoading(challengeName, cutscene, trafficSet, positionToSpool, callback)
  debugOutput("challengeName = " .. tostring(challengeName))
  debugOutput("cutscene = " .. tostring(cutscene))
  debugOutput("trafficSet = " .. tostring(trafficSet))
  debugOutput("positionToSpool = " .. tostring(positionToSpool))
  debugOutput("settings to Load" .. tostring(settings))
  state = "initialFadeDown"
  loadingSystem.loadingStart()
  local f = handleMissionStartLoading_update(challengeName, cutscene, trafficSet, positionToSpool, callback)
  addUserUpdateFunction("missionStartLoading", f, 1)
end
function handleMissionStartLoading_update(challengeName, cutscene, trafficSet, positionToSpool, callback)
  return function()
    if state == "initialFadeDown" then
      debugOutput("Initial Fade Down")
      state = "initialFadeDown - active"
      local fadeCallback = function()
        if localPlayer.challenge.retryingMission then
          state = "playCutscene"
        else
          state = "loadTraffic"
        end
      end
      fades.down(fadeCallback)
      if successful and afterEndScreenCutscene then
        Cutscene.HintNext(engineCutscene.GetCutsceneId(cutscene))
      end
    elseif state == "loadTraffic" then
      debugOutput("Load Traffic")
      state = "loadTraffic - active"
      local mission, potID, subType, type = progressionSystem.findMissionInProgression(challengeName)
      if moodSystem.missionStartMoods[challengeName] then
        loadingSystem.requestMood(challengeName)
      elseif type == "challenge" then
        local chapter = mission.settings.chapter
        if chapter then
          local chapterMood
          if chapter ~= 10 then
            chapterMood = "Chapter" .. chapter
          else
            chapterMood = "FreeDrive"
          end
          loadingSystem.requestMood(chapterMood)
        end
      end
      if trafficSet and mission.trafficFrequencyOverride then
        loadingSystem.requestVehicleSettings(trafficSet, nil, mission.trafficFrequencyOverride)
      elseif trafficSet then
        loadingSystem.requestVehicleSettings(trafficSet, nil, nil)
      else
        spooling.spoolSafety()
      end
      loadingSystem.triggerLoadRequest("Loading Traffic Data", function()
        state = "playCutscene"
      end)
    elseif state == "playCutscene" then
      debugOutput("Play Cutscene")
      if cutscene then
        state = "active - playing Cutscene"
        engineCutscene.triggerCutscene(cutscene, nil, function()
          state = "cityLocking"
        end)
      else
        state = "cityLocking"
        debugOutput("No cutsene to play")
      end
    elseif state == "cityLocking" then
      debugOutput("City Locking")
      local mission, potID, subType, type = progressionSystem.findMissionInProgression(challengeName)
      if mission.cityLockingRequired then
        loadingSystem.requestCityLocking(challengeProgressionTable[potID].settings.cityLocking)
      end
      state = "spoolArea"
    elseif state == "spoolArea" then
      debugOutput("Spool Area")
      state = "spoolArea - active"
      localPlayer:exitCutsceneMode()
      if positionToSpool then
        debugOutput("area to spool")
        loadingSystem.requestSpoolPosition(positionToSpool, headingForSpool)
      end
      loadingSystem.triggerLoadRequest("Loading City Data", function()
        state = "loadAudio"
      end)
    elseif state == "loadAudio" then
      debugOutput("Load Audio")
      state = "loadAudio - active"
      local mission, potID, subType, type = progressionSystem.findMissionInProgression(challengeName)
      if type ~= "challenge" and type ~= "activity" then
        loadingSystem.requestCommentary(cards.Missions[challengeName].MissionID)
        loadingSystem.requestAudio(cards.Missions[challengeName].MissionID, challengeProgressionTable[potID].settings.chapter)
      else
        loadingSystem.requestAudio(cards.Missions[challengeName].MissionID, mission.settings.chapter)
      end
      loadingSystem.triggerLoadRequest("Loading Audio Data", function()
        state = "fadeUp"
      end)
    elseif state == "fadeUp" then
      debugOutput("fade up")
      initialise.allLoadingComplete()
      loadingSystem.loadingComplete()
      if callback then
        callback()
        localPlayer:enterCutsceneMode()
      end
      state = "inactive"
      removeUserUpdateFunction("missionStartLoading")
    end
  end
end
