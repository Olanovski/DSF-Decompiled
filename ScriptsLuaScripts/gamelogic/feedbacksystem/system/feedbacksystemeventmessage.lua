module("feedbackSystem.eventMessages", package.seeall)
local topSlotMessageType = 0
local priorityOneMessages = {}
local priorityTwoMessages = {}
local priorityThreeMessages = {}
local priorityThreeGroup = {}
local showGroup = false
local longDisplayTime = 5.5
local shortDisplayTime = 2
local messageLimit = 5
local prioThreeLastUpdate = 0
local prioThreeUpdateTime = shortDisplayTime
local function changeMessageGroupPriority(currentPrio, targetPrio)
  if currentPrio == 1 then
    for i, entry in ipairs(priorityOneMessages) do
      if targetPrio == 2 then
        table.insert(priorityTwoMessages, entry)
      elseif targetPrio == 3 then
        table.insert(priorityThreeMessages, entry)
      end
    end
    priorityOneMessages = {}
  elseif currentPrio == 2 then
    for i, entry in ipairs(priorityTwoMessages) do
      if targetPrio == 1 then
        table.insert(priorityOneMessages, entry)
      elseif targetPrio == 3 then
        table.insert(priorityThreeMessages, entry)
      end
    end
    priorityTwoMessages = {}
  elseif currentPrio == 3 then
    for i, entry in ipairs(priorityThreeMessages) do
      if targetPrio == 1 then
        table.insert(priorityOneMessages, entry)
      elseif targetPrio == 2 then
        table.insert(priorityTwoMessages, entry)
      end
    end
  end
end
function pushXPGroup()
  if #priorityThreeGroup > 0 then
    local endValue = 0
    for i, eventMessage in ipairs(priorityThreeGroup) do
      endValue = endValue + eventMessage.value
    end
    addMessage(3, "+" .. tostring(endValue) .. " XP", priorityThreeGroup[1].textLine2, tostring(#priorityThreeGroup), priorityThreeGroup[1].playerID, false, false)
    priorityThreeGroup = {}
  end
end
function addMessage(priority, textLine1, textLine2, parameter, playerID, groupable, value, groupLimit, displayRed)
  if priority == 1 then
    table.insert(priorityOneMessages, {
      textLine1 = textLine1,
      textLine2 = textLine2,
      parameter = parameter,
      playerID = playerID,
      displayTime = longDisplayTime,
      timeAdded = g_NetworkTime,
      displayRed = displayRed or false
    })
    if topSlotMessageType == 2 and priorityTwoMessages[1] then
      priorityTwoMessages[1].displayTime = shortDisplayTime
    end
    if #priorityOneMessages >= 2 and #priorityTwoMessages > 0 then
      changeMessageGroupPriority(2, 3)
    end
  elseif priority == 2 then
    if #priorityOneMessages >= 2 then
      table.insert(priorityThreeMessages, {
        textLine1 = textLine1,
        textLine2 = textLine2,
        parameter = parameter,
        playerID = playerID,
        displayTime = longDisplayTime,
        timeAdded = g_NetworkTime
      })
    else
      table.insert(priorityTwoMessages, {
        textLine1 = textLine1,
        textLine2 = textLine2,
        parameter = parameter,
        playerID = playerID,
        displayTime = longDisplayTime,
        timeAdded = g_NetworkTime,
        displayRed = displayRed or false
      })
    end
  elseif priority == 3 then
    if not groupable then
      table.insert(priorityThreeMessages, {
        textLine1 = textLine1,
        textLine2 = textLine2,
        parameter = parameter,
        playerID = playerID,
        displayTime = longDisplayTime,
        timeAdded = g_NetworkTime
      })
    elseif groupable then
      if #priorityThreeGroup > 0 then
        assert(priorityThreeGroup[1].textLine2 == textLine2, "Missmatch in priority 3 event message group")
      end
      table.insert(priorityThreeGroup, {
        textLine2 = textLine2,
        playerID = playerID,
        value = value
      })
      if groupLimit <= #priorityThreeGroup then
        pushXPGroup()
      end
    end
  end
end
function update()
  for i, message in ripairs(priorityOneMessages) do
    if g_NetworkTime - message.timeAdded >= 10 then
      table.remove(priorityOneMessages, i)
    end
  end
  for i, message in ripairs(priorityTwoMessages) do
    if g_NetworkTime - message.timeAdded >= 10 then
      table.remove(priorityOneMessages, i)
    end
  end
  for i, message in ripairs(priorityThreeMessages) do
    if g_NetworkTime - message.timeAdded >= 10 then
      table.remove(priorityOneMessages, i)
    end
  end
  if #priorityOneMessages > 0 then
    if not priorityOneMessages[1].startTime then
      PlayerGamePlay.setPlayerNotifIcon(priorityOneMessages[1].playerID)
      if priorityOneMessages[1].displayRed then
        feedbackSystem.menusMaster.currentHUDSetVariable("iMultiSessionAlert_NameColour", 2)
      else
        feedbackSystem.menusMaster.currentHUDSetVariable("iMultiSessionAlert_NameColour", 1)
      end
      OneShotSound.Play("HUD_Online_RightSide_SlideBar", false)
      Menu:AddMultiPlayerSessionAlert(priorityOneMessages[1].textLine1, priorityOneMessages[1].textLine2)
      priorityOneMessages[1].startTime = g_NetworkTime
      topSlotMessageType = 1
    elseif g_NetworkTime - priorityOneMessages[1].startTime > priorityOneMessages[1].displayTime then
      if priorityOneMessages[1].displayTime == shortDisplayTime then
        addMessage(3, priorityOneMessages[1].textLine1, priorityOneMessages[1].textLine2, priorityOneMessages[1].parameter, priorityOneMessages[1].playerID, false, false)
      end
      table.remove(priorityOneMessages, 1)
    end
  elseif #priorityTwoMessages > 0 then
    if not priorityTwoMessages[1].startTime then
      PlayerGamePlay.setPlayerNotifIcon(priorityTwoMessages[1].playerID)
      OneShotSound.Play("HUD_Online_RightSide_SlideBar", false)
      Menu:AddMultiPlayerSessionAlert(priorityTwoMessages[1].textLine1, priorityTwoMessages[1].textLine2)
      priorityTwoMessages[1].startTime = g_NetworkTime
      topSlotMessageType = 2
    elseif g_NetworkTime - priorityTwoMessages[1].startTime > priorityTwoMessages[1].displayTime then
      if priorityTwoMessages[1].displayTime == shortDisplayTime then
        addMessage(3, priorityTwoMessages[1].textLine1, priorityTwoMessages[1].textLine2, priorityTwoMessages[1].parameter, priorityTwoMessages[1].playerID, false, false)
      end
      table.remove(priorityTwoMessages, 1)
    end
  end
  local numQPrio3Messages = #priorityThreeMessages
  if numQPrio3Messages > 0 and g_NetworkTime - prioThreeLastUpdate > prioThreeUpdateTime then
    OneShotSound.Play("HUD_Online_RightSide_SlideBar", false)
    Menu:AddMultiPlayerEvent(priorityThreeMessages[1].textLine2, priorityThreeMessages[1].parameter, priorityThreeMessages[1].textLine1)
    table.remove(priorityThreeMessages, 1)
    prioThreeLastUpdate = g_NetworkTime
  end
end
function clearMessages()
  priorityOneMessages = {}
  priorityTwoMessages = {}
  priorityThreeMessages = {}
  priorityThreeGroup = {}
  prioThreeLastUpdate = 0
  showGroup = false
end
