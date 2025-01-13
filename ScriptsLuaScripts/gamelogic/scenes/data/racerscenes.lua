local Callback_3 = function()
  return {
    Menu.FireEvent("Challenge", "EVENT_CountDown3"),
    [3] = OneShotSound.Play("HUD_Challenge3_OneShot")
  }
end
local Callback_2 = function()
  return {
    Menu.FireEvent("Challenge", "EVENT_CountDown2"),
    [3] = OneShotSound.Play("HUD_Challenge2_OneShot")
  }
end
local Callback_1 = function()
  return {
    Menu.FireEvent("Challenge", "EVENT_CountDown1"),
    [3] = OneShotSound.Play("HUD_Challenge1_OneShot")
  }
end
local Callback_ChallengeStart = function()
  return {}
end
Scene = Scene or {}
Scene.SetCheckpointRace = {
  RacerStartScene = {
    {
      action = "fade",
      direction = "out",
      colour = vec.vector(0, 0, 0, 0),
      duration = 0.001
    },
    {
      {
        action = "fade",
        direction = "in",
        colour = vec.vector(0, 0, 0, 0),
        duration = 1
      },
      {
        action = "blend",
        lookFrom = false,
        lookFromOffset = vec.vector(-2.52, 1.17, 4.33, 1),
        lookAt = false,
        lookAtOffset = vec.vector(3.52, 1.38, -3.64, 1),
        fov = 1.8,
        blendFunction = "lerp",
        duration = 2
      },
      {
        action = "callback",
        callback = Callback_3,
        afterDuration = 0.1
      },
      {
        action = "callback",
        callback = Callback_2,
        afterDuration = 1
      },
      {
        action = "callback",
        callback = Callback_1,
        afterDuration = 2
      }
    },
    {duration = 1},
    {action = "callback", callback = Callback_ChallengeStart}
  },
  RacerEndScene = {}
}
