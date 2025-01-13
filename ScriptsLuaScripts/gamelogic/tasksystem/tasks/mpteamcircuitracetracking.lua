taskSystem.registerTask("MP Team Circuit Race Tracking", {
  {
    name = "leadCheckPoint",
    startingValue = 1,
    parseType = "uinteger8"
  },
  {
    name = "totalCheckPoints",
    startingValue = 1,
    parseType = "uinteger8"
  },
  {
    name = "blueTeamScore",
    startingValue = 0,
    parseType = "uinteger16"
  },
  {
    name = "redTeamScore",
    startingValue = 0,
    parseType = "uinteger16"
  },
  {
    name = "blueTeamTotalCheckPoints",
    startingValue = 0,
    parseType = "uinteger16"
  },
  {
    name = "redTeamTotalCheckPoints",
    startingValue = 0,
    parseType = "uinteger16"
  },
  {
    name = "leadPlayerID",
    startingValue = 255,
    parseType = "uinteger8"
  }
}, function(task)
  return nil
end)
