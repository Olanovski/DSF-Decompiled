feedbackSystem.registerHUD("SS Freedrive HUD", function(task, settings)
end, function(task)
  local localPlayerID = task.agent.localID
  local update = function()
  end
  local function cleanup()
    if localPlayerID == 0 then
      coopSystem.ss_hud.removeAll()
    end
  end
  return update, nil, nil, cleanup
end)
