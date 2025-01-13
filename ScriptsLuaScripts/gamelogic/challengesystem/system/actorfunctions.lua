module("challengeSystem")
function setVehicleListActors(vehicleList, instance)
  for i = #vehicleList, 1, -1 do
    local vehicle = vehicleList[i]
    local actor = getAvailableMatchingInstanceActor(vehicle, instance)
    if actor then
      taskSystem.createTaskObject(instance, actor, vehicle, true)
      table.remove(vehicleList, i)
    end
  end
  for i = #vehicleList, 1, -1 do
    local vehicle = vehicleList[i]
    local actor = getAnyAvailableInstanceActor(vehicle, instance)
    if actor then
      taskSystem.createTaskObject(instance, actor, vehicle, true)
      table.remove(vehicleList, i)
    end
  end
  if #vehicleList > 0 then
    print("CHALLENGESYSTEM - setVehicleListActors: vehicleList has unassigned vehicles remaining. Probably not enough actor slots in challenge")
  end
end
function getAvailableMatchingInstanceActor(agent, instance)
  return false
end
function getAnyAvailableInstanceActor(agent, instance)
  for i, actor in ipairs(instance.challenge.actorPool) do
    if not instance.taskObjectsByActorID[actor.ID] and actor.whenSpawned == "On warmup" then
      return actor
    end
  end
  return false
end
