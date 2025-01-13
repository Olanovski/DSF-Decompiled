challengeSystem.registerStartup("Static start", {fixedSpawning = true}, function(instance, settings)
  instance.position = settings.route[0].position
end)
