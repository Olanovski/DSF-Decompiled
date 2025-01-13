module("felony_feedback", package.seeall)
local felonySettingsByChapter = {
  [1] = {
    reward = 1000,
    decayRate = 1,
    decayTime = 0.24,
    baseLevel = 250
  },
  [2] = {
    reward = 3000,
    decayRate = 1,
    decayTime = 0.08,
    baseLevel = 750
  },
  [3] = {
    reward = 5000,
    decayRate = 1,
    decayTime = 0.048,
    baseLevel = 1250
  },
  [4] = {
    reward = 7000,
    decayRate = 1,
    decayTime = 0.034,
    baseLevel = 2250
  },
  [5] = {
    reward = 9000,
    decayRate = 1,
    decayTime = 0.025,
    baseLevel = 3250
  },
  [6] = {
    reward = 11000,
    decayRate = 1,
    decayTime = 0.018,
    baseLevel = 4750
  },
  [7] = {
    reward = 13000,
    decayRate = 1,
    decayTime = 0.012,
    baseLevel = 6500
  }
}
felonyHUDTable = {slot = 1}
local currentFelonySettings
local function updateFelonyHUD()
  if felonyHUDTable.value > currentFelonySettings.baseLevel then
    felonyHUDTable.value = felonyHUDTable.value - currentFelonySettings.decayRate
    if felonyHUDTable.value < currentFelonySettings.baseLevel then
      felonyHUDTable.value = currentFelonySettings.baseLevel
      removeUserUpdateFunction("updateFelonyHUD")
    end
    feedbackSystem.updateFelonyReward(felonyHUDTable)
  end
end
function setupFelonyHUD()
  currentFelonySettings = felonySettingsByChapter[challengeProgressionTable[progressionSystem.currentProgression].settings.chapter] or felonySettingsByChapter[7]
  felonyHUDTable.value = currentFelonySettings.reward
  feedbackSystem.updateFelonyReward(felonyHUDTable)
  addUserUpdateFunction("updateFelonyHUD", updateFelonyHUD, 120 * currentFelonySettings.decayTime, true)
end
function pauseFelonyHUD()
  removeUserUpdateFunction("updateFelonyHUD")
  feedbackSystem.removeSlot(felonyHUDTable.slot)
end
function resumeFelonyHUD()
  print("RESUMING FELONY WILLPOWER DETERIATION")
  feedbackSystem.updateFelonyReward(felonyHUDTable)
  addUserUpdateFunction("updateFelonyHUD", updateFelonyHUD, 120 * currentFelonySettings.decayTime, true)
end
local clearFelonyHUD = function()
  removeUserUpdateFunction("updateFelonyHUD")
  feedbackSystem.removeSlot(felonyHUDTable.slot)
end
function endFelony()
  feedbackSystem.menusMaster.focusHintButtonState(true)
  clearFelonyHUD()
end
