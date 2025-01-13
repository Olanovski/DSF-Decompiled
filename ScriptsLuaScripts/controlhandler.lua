module("controlHandler", package.seeall)
pad = controller.getPad("GAMEPAD1")
pad2 = controller.getPad("GAMEPAD2")
pad2Available = 0
updateQueue = {}
updateRequested = false
function getStatus(self, button)
  return pad:status(button)
end
function registerState(self, localID, key, t)
  pad:inputRegisterState(localID or 0, key, t)
end
function removeState(self, key, localID)
  pad:inputRemoveState(key, localID or 0)
end
function setState(self, key, thePad, localID)
  pad:inputSetState(key, thePad, localID or 0)
end
function resetState(self, key, thePad, localID)
  pad:inputResetState(key, thePad, localID or 0)
end
function clearInput(self, localID)
  pad:inputClear(localID)
end
function purge()
  pad:inputClear()
end
function enableRumble(enable)
  if enable then
    WwiseMotion.Enable()
  else
    WwiseMotion.Disable()
  end
end
