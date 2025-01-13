taskSystem.registerTask("MP Rush Down Team Score Tracking", {
  {
    name = "defenceScore",
    startingValue = 0,
    parseType = "integer8"
  },
  {
    name = "attackScore",
    startingValue = 0,
    parseType = "integer8"
  }
}, function(task)
  return nil
end)
