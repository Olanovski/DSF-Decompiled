gameStatus.registerEvent("preLaunch", "Distributed builder", function()
  Menu.ShowHUD = 0
  collectgarbage("collect")
  gameStatus.preLaunchComplete()
end)
