module("chapterBookendLoading", package.seeall)
local debugOutput = function(output)
  print("[chapterBookendLoading] == |  " .. tostring(output))
end
local chapterChange = false
state = "inactive"
function purge()
  if state ~= "inactive" then
    removeUserUpdateFunction("chapterBookendLoading")
  end
end
function handleChapterBookendLoading(noSpoolingOrInitialCutscene)
  debugOutput("Start load")
  callStack()
  loadingSystem.loadingStart()
  chapterChange = progressionSystem.getLoadNextPot()
  if noSpoolingOrInitialCutscene then
    state = "postCutsceneLoad"
  else
    state = "initialFadeDown"
  end
  local f = handleChapterBookendLoading_update(noSpoolingOrInitialCutscene)
  addUserUpdateFunction("chapterBookendLoading", f, 1)
end
function handleChapterBookendLoading_update(noSpoolingOrInitialCutscene)
  local pot = progressionSystem.currentProgression
  local settings = challengeProgressionTable[pot].settings
  local chapter = settings.chapter
  localPlayer.missionSupport.setFreedriveMode()
  local unlockedAbility, abilityLevel, hospitalCutscene = progressionSystem.tutorialCheck("potEnd")
  if chapterChange and chapter > 0 and chapter <= 8 and not ProfileSettings.GetToolTipShown(toolTipLookupTable["Reached Finale"]) then
    local previousChapter = chapter - 1
    print("Presence set to Just Completed Chapter " .. tostring(previousChapter))
    presenceSystem.setPresence(11, previousChapter)
  end
  return function()
    if state == "initialFadeDown" then
      state = "initialFadeDown - active"
      fades.down(function()
        state = "playHospitalCutscene"
      end)
    elseif state == "playHospitalCutscene" then
      debugOutput("Play hospital cutscene")
      state = "active - playing hospital Cutscene"
      if hospitalCutscene then
        engineCutscene.triggerCutscene(hospitalCutscene, nil, function()
          state = "fadeDownAfterCutscene"
        end)
      else
        state = "postCutsceneLoad"
        debugOutput("No cutsene to play")
      end
    elseif state == "fadeDownAfterCutscene" then
      debugOutput("Fade down")
      state = "active - fading"
      fades.down(function()
        state = "postCutsceneLoad"
      end)
    elseif state == "postCutsceneLoad" then
      debugOutput("Fade Up")
      state = "inactive"
      removeUserUpdateFunction("chapterBookendLoading")
      if unlockedAbility then
        tutorialLoading.handleTutorialLoading(unlockedAbility, abilityLevel)
      else
        progressionSystem.initialiseProgressionPot(nil, nil, noSpoolingOrInitialCutscene)
      end
      progressionSystem.setLoadNextPot(false)
      debugOutput("============ | DONE")
    end
  end
end
