challengeSystem.registerWarmup("Player present custom task", nil, function(instance, settings)
  return function()
    for actorID, taskObject in next, instance.taskObjectsByActorID, nil do
      if taskObject.playerTask then
        return true
      end
    end
  end
end)
