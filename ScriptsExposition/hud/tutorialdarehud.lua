feedbackSystem.registerHUD("Tutorial dare HUD", function(task, settings)
end, function(task, settings)
  local function goalComplete(conditionKey)
    print("HUD goalComplete for " .. tostring(task.specialName) .. " with conditionKey " .. tostring(conditionKey))
    if task.specialName == "Dare accepted" then
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      if conditionKey == 1 then
        feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:246210", everyTenSeconds = true})
      elseif conditionKey == 2 then
        feedbackSystem.menusMaster.primaryTextPromptParam({
          prompt = "ID:245956",
          icon1 = localPlayer.buttonLayout.previewDare,
          permanent = true
        })
      end
    end
  end
  local function taskComplete()
    print("HUD taskComplete for " .. tostring(task.specialName))
    if task.specialName == "Dare accepted" then
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    end
  end
  return nil, goalComplete, taskComplete, nil
end)
