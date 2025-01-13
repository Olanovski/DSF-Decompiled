taskSystem.registerTask("TaskObject Swap", nil, function(task)
  local goalCallback, AIUpdate, cleanup
  function goalCallback(success, condition, null, agent)
    taskSystem.taskObjects[task.taskObjectID]:setAgent(agent)
  end
  return goalCallback, AIUpdate, cleanup
end)
