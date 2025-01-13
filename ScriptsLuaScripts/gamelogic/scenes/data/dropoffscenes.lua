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
local copSirenCallback = function()
  return {}
end
local Callback_ChallengeStart = function()
  return {}
end
Scene = Scene or {}
Scene.DropOffChallenge = {
  CopDropOffStartScene = {
    {
      {
        action = "blend",
        lookFrom = false,
        lookFromOffset = vec.vector(15, 5, 15, 1),
        lookAt = false,
        fov = 1.8,
        blendFunction = "lerp",
        duration = 0.5
      }
    },
    {
      {
        action = "callback",
        callback = Callback_3,
        afterDuration = 0
      },
      {
        action = "attach",
        lookAt = false,
        fov = 1.8,
        duration = 2
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
  GetawayDropOffStartScene = {
    {
      {
        action = "attach",
        lookFrom = false,
        lookFromOffset = vec.vector(0.14, 1.84, -5.9, 1),
        lookAt = false,
        fov = 1.8,
        duration = 2.5
      },
      {
        action = "callback",
        callback = Callback_3,
        afterDuration = 0.5
      },
      {
        action = "callback",
        callback = Callback_2,
        afterDuration = 1.5
      },
      {
        action = "callback",
        callback = Callback_1,
        afterDuration = 2.5
      }
    },
    {duration = 1},
    {action = "callback", callback = Callback_ChallengeStart}
  },
  SecurityCameraDropOffStartScene = {
    {
      {
        action = "attach",
        lookFrom = false,
        lookFromOffset = vec.vector(75.5, 15, 23, 1),
        lookAt = false,
        fov = 1.8,
        duration = 2.5
      },
      {
        action = "callback",
        callback = Callback_3,
        afterDuration = 0.5
      },
      {
        action = "callback",
        callback = Callback_2,
        afterDuration = 1.5
      },
      {
        action = "callback",
        callback = Callback_1,
        afterDuration = 2.5
      }
    },
    {duration = 1},
    {action = "callback", callback = Callback_ChallengeStart}
  },
  DropOffEndScene = {}
}
