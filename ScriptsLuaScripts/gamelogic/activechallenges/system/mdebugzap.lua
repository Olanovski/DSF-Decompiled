module("activeChallenges")
local debugZapMenu = {}
local createDebugZapChallenge = function(challenge, actor)
  return function()
    if not localPlayer.inZap then
      local instance = challengeSystem.createInstance(challenge, localPlayer.currentVehicle.gameVehicle.matrix)
      local taskObject = instance.taskObjectsByActorID[actor.ID]
      localPlayer.missionSupport:setInstanceHook(instance)
      localPlayer.missionSupport:setMainTaskObject(taskObject)
    end
    PauseMenu.resume()
  end
end
function initiateDebugZap()
  for i, challenge in ipairs(challengeSystem.challenges) do
    table.insert(debugZapMenu, {
      name = challenge.name,
      action = changePauseMenu(challenge.name)
    })
    local challengeMenu = {}
    for j, actor in ipairs(challenge.actorPool) do
      if actor.whenSpawned == "On warmup" then
        table.insert(challengeMenu, {
          name = actor.ID,
          action = createDebugZapChallenge(challenge, actor)
        })
      end
    end
    table.insert(challengeMenu, {
      name = "Back",
      action = changePauseMenu("DebugZap")
    })
    addPauseMenu(challenge.name, challengeMenu)
  end
  table.insert(debugZapMenu, {
    name = "Back",
    action = changePauseMenu("Pause")
  })
  addPauseMenu("DebugZap", debugZapMenu)
end
