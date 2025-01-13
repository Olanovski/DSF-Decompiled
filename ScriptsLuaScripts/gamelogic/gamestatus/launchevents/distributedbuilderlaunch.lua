gameStatus.registerEvent("launch", "Distributed builder", function()
  Menu.ShowMain = 0
  print("Launching distributed builder")
  BuildFarm.RunFarmTask()
end)
