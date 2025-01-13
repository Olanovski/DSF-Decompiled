taskSystem.registerTask("Warmup route", nil, function(task)
  local leader = false
  local target = false
  local raceId
  local behaviour = {
    traits = {
      spawnSpeed = 30,
      desiredSpeed = task.actor.desiredSpeed,
      driveOnPavements = 0,
      collisionResilience = "Unstoppable",
      drivingSkill = "Average",
      matchTrafficSpeed = task.actor.warmup.settings.matchTrafficSpeed,
      driveInOncoming = task.actor.warmup.settings.driveInOncoming or 0
    }
  }
  if task.actor.ID == task.instance.startActor then
    behaviour.traits.avoidedByCivilianTraffic = true
  end
  local function setUpRace()
    if not task.instance.raceId then
      raceId = RaceManager.CreateRace()
      task.instance.raceId = raceId
      if behaviour.roadRoute then
        RaceManager.AddRoute(raceId, behaviour.roadRoute)
        RaceManager.AddCheckpoints(raceId, routes[task.actor.warmup.settings.routeName].checkpoints)
      end
    end
  end
  if task.actor.warmup.settings.actorToChase then
    if task.actor.ID == task.actor.warmup.settings.actorToChase then
      leader = true
    else
      target = task.instance.taskObjectsByActorID[task.actor.warmup.settings.actorToChase].coreData.agent
    end
    if not leader and not target then
      leader = true
    end
    if leader then
      behaviour.roadRoute = routes[task.actor.warmup.settings.routeName].roads
      behaviour.routeName = task.actor.warmup.settings.routeName
      behaviour.traits.distanceFromFrontOfGroup = 0
      behaviour.traits.rubberbandingStrength = "Low"
      setUpRace()
      RaceManager.AddRacer(task.instance.raceId, task.agent.gameVehicle)
    else
      behaviour.traits.avoidedByCivilianTraffic = true
      behaviour.traits.rubberbandingStrength = "High"
      behaviour.traits.distanceFromFrontOfGroup = 15
      behaviour.traits.groupAggression = "None"
      behaviour.traits.tailingDistance = 25
      behaviour.traits.reactionTime = "Fastest"
      behaviour.traits.drivingSkill = "Professional"
      behaviour.traits.driveOnPavements = 0.5
      behaviour.traits.accidentProbability = 0
      behaviour.traits.driveInOncoming = 0.5
      behaviour.opponentGameVehicle = target.gameVehicle
    end
  else
    if task.actor.spawn.ranking then
      behaviour.traits.distanceFromFrontOfGroup = (task.actor.spawn.ranking - 1) * 15
    end
    behaviour.traits.rubberbandingStrength = "Unshakable"
    behaviour.roadRoute = routes[task.actor.warmup.settings.routeName].roads
    behaviour.routeName = task.actor.warmup.settings.routeName
    setUpRace()
    RaceManager.AddRacer(task.instance.raceId, task.agent.gameVehicle)
  end
  local function AIUpdate()
    task.agent:highSpeedDrive(behaviour)
  end
  local function cleanup()
    if raceId then
      task.instance.raceId = nil
      RaceManager.RemoveRace(raceId)
      raceId = nil
    end
  end
  return nil, AIUpdate, cleanup
end)
