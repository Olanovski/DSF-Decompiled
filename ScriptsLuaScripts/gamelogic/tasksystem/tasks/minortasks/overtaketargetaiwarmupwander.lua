taskSystem.registerTask("Overtake player", nil, function(task)
  local behaviour = {}
  local leader = false
  local target = false
  for actorID, taskObject in next, task.instance.taskObjectsByActorID, nil do
    if taskObject.coreData.actor.warmup.settings.isLeader then
      if actorID == task.actor.ID then
        leader = true
        break
      end
      target = task.instance.taskObjectsByActorID[actorID].coreData.agent
      break
    end
  end
  if not leader and not target then
    leader = true
  end
  local leadTraits = {
    desiredSpeed = task.actor.desiredSpeed or 40,
    wanderType = task.actor.wanderType or "preferStraight",
    collisionResilience = task.actor.collisionResilience or "Unstoppable",
    drivingSkill = task.actor.drivingSkill or "Over-cautious",
    rubberbandingStrength = task.actor.rubberbandingStrength or "Unshakable",
    driveInOncoming = task.actor.driveInOncoming or 0,
    driveOnPavements = task.actor.driveOnPavements or 0,
    avoidAlleyways = task.actor.avoidAlleyways or 1,
    spawnSpeed = task.actor.spawnSpeed or 30,
    stayInLockedArea = true
  }
  local chaseTraits = taskSystem.buildChaseTraits(task)
  local function AIUpdate(nonGoalUpdate)
    if leader then
      if not localPlayer.inZap then
        behaviour.opponentGameVehicle = localPlayer.currentVehicle.gameVehicle
        behaviour.mode = "overtaker"
        behaviour.traits = leadTraits
      else
        behaviour.opponentGameVehicle = nil
        behaviour.mode = nil
        behaviour.traits = leadTraits
      end
    else
      behaviour.opponentGameVehicle = target.gameVehicle
      behaviour.traits = chaseTraits
    end
    task.agent:highSpeedDrive(behaviour)
  end
  local cleanup = function()
  end
  return goalCallback, AIUpdate, nil
end)
