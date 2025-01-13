module("progressionSystem", package.seeall)
saveProgessionTags = {
  [0] = {subtitle = "ID:235406", description = "ID:223074"},
  [1] = {subtitle = "ID:235406", description = "ID:223076"},
  [2] = {subtitle = "ID:235406", description = "ID:223077"},
  [3] = {subtitle = "ID:235406", description = "ID:223078"},
  [4] = {subtitle = "ID:235406", description = "ID:223079"},
  [5] = {subtitle = "ID:235406", description = "ID:223080"},
  [6] = {subtitle = "ID:235406", description = "ID:223081"},
  [7] = {subtitle = "ID:235406", description = "ID:223082"},
  [8] = {subtitle = "ID:235406", description = "ID:223083"},
  [9] = {subtitle = "ID:235406", description = "ID:223084"},
  [10] = {subtitle = "ID:235406", description = "ID:223084"},
  ["default"] = {subtitle = "ERROR", description = "ERROR"}
}
function _G.getDetailsForSaveGame()
  local returnData = saveProgessionTags.default
  local currentProgression = ProfileSettings.GetProgression()
  if challengeProgressionTable[currentProgression] then
    local chapter = challengeProgressionTable[currentProgression].settings.chapter
    if saveProgessionTags[chapter] then
      returnData = saveProgessionTags[chapter]
    end
  end
  return returnData.subtitle, returnData.description
end
