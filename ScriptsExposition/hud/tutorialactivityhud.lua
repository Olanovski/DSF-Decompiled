feedbackSystem.registerHUD("Tutorial activity HUD", function(task, settings)
end, function(task, settings)
  if task.specialName == "Activity unlocked" then
    feedbackSystem.menusMaster.clearPrimaryTextPrompt()
    feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:246213"})
  end
  local function goalComplete(conditionKey)
    print("HUD goalComplete for " .. tostring(task.specialName) .. " with conditionKey " .. tostring(conditionKey))
    if task.specialName == "Activity accepted" then
      feedbackSystem.menusMaster.clearPrimaryTextPrompt()
      if conditionKey == 1 then
        feedbackSystem.menusMaster.primaryTextPromptParam({prompt = "ID:246214"})
      elseif conditionKey == 2 then
        feedbackSystem.menusMaster.primaryTextPromptParam({
          prompt = "ID:245958",
          icon1 = localPlayer.buttonLayout.previewDare
        })
      end
    end
  end
  local function taskComplete()
    print("HUD taskComplete for " .. tostring(task.specialName))
  end
  return nil, goalComplete, taskComplete, nil
end)
