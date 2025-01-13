feedbackSystem.registerHUD("Tanner and Jones 6 HUD", nil, function(task)
  if task.specialName == "recce" then
    feedbackSystem.menusMaster.primaryTextPrompt("ID:245547", nil, true)
  else
    feedbackSystem.menusMaster.primaryTextPrompt("ID:242126", nil, true)
  end
  return nil, nil, nil, nil
end)
