local pickerColor = vec.vector(1, 0.5, 0, 1)
local pickerPosition = vec.vector(0, 0, 0, 1)
local pickerRadius = 1
local pickerRadiusVec = vec.vector(pickerRadius, pickerRadius, pickerRadius, pickerRadius)
local pickerDist = 10
local pickerDistVec = vec.vector(pickerDist, pickerDist, pickerDist, pickerDist)
local cameraHeading = vec.vector(1, 0.5, 0.5, 1)
local pickerCamOffset = vec.vector(0, 0, 0, 1)
local objectListX = 0.05
local objectListY = 0.05
local objectListColor = vec.vector(0.5, 0.25, 0, 1)
local objectListSpacing = 0.02
local pickedObjectX = 0.075
local categoryStringX = 0.075
local pickedObjectColor = vec.vector(1, 0.5, 0, 1)
local numPickedObjects = 0
local currentPickedObject = 0
local textStartID = 50000
local prevTextID = textStartID
local pickerIDOffset = 50
local pickerId = textStartID + pickerIDOffset
local pickerPrintOutput = false
local pulse = 1
local pulseBigger = true
local function pulsePicker(pulseInVec)
  if pulseBigger == true then
    if pulse < 1.25 then
      pulse = pulse + 0.01
    else
      pulseBigger = false
    end
  elseif pulseBigger == false then
    if pulse > 0.75 then
      pulse = pulse - 0.01
    else
      pulseBigger = true
    end
  end
  local pulseVec = vec.vector(pulse, pulse, pulse, 1)
  pulseInVec = pulseVec * pulse
end
local function displayObjectList()
  local startPoint = 0
  local textID = textStartID
  local yPos = objectListY
  if startPoint <= numPickedObjects then
    for objectIndex = startPoint, numPickedObjects - 1 do
      if objectIndex == currentPickedObject then
        if pickerPrintOutput == true then
          print(" ")
          print("Object UID = " .. objectpicker.GetObject(objectIndex))
        end
        Development:add2DText(textID, objectpicker.GetObject(objectIndex), vec.vector(objectListX, yPos, 0, 0), pickedObjectColor, 1, -1)
        textID = textID + 1
        yPos = yPos + objectListSpacing
        yPos = yPos + objectListSpacing
      else
        Development:add2DText(textID, objectpicker.GetObject(objectIndex), vec.vector(objectListX, yPos, 0, 0), objectListColor, 0.6, -1)
        textID = textID + 1
      end
      yPos = yPos + objectListSpacing
    end
  end
  textID = textID - 1
  if textID < prevTextID then
    for eraseID = textID, prevTextID do
      Development:eraseText(eraseID)
    end
  end
  prevTextID = textID
  if pickerPrintOutput == true then
    pickerPrintOutput = false
  end
end
local function drawPicker()
  pulsePicker(pickerRadiusVec)
  Development:addGraphics(pickerId, "sphere", pickerColor, pickerPosition, cameraHeading, pickerRadiusVec, -1)
end
local function clearDevGraphics()
  Development:removeGraphics(pickerId)
  for eraseID = textStartID, prevTextID do
    Development:eraseText(eraseID)
  end
end
local function processPickerInputs()
  local pad1 = controller.getPad("GAMEPAD1")
  local nextObjectButton = pad1:status("Menu_Down")
  local prevObjectButton = pad1:status("Menu_Up")
  local smallerPickerButton = pad1:status("Menu_ExtraFirst")
  local biggerPickerButton = pad1:status("Menu_ExtraSecond")
  local nearPickerButton = pad1:status("Vehicle_Accelerate")
  local farPickerButton = pad1:status("Vehicle_Reverse")
  local printInfoButton = pad1:status("Menu_Select")
  if nextObjectButton == "JustPressed" then
    if currentPickedObject < numPickedObjects then
      currentPickedObject = currentPickedObject + 1
    end
    pickerPrintOutput = true
  elseif prevObjectButton == "JustPressed" then
    if currentPickedObject > 0 then
      currentPickedObject = currentPickedObject - 1
    end
    pickerPrintOutput = true
  end
  if biggerPickerButton == "JustPressed" then
    pickerRadius = pickerRadius * 1.25
    objectpicker.pickerradius = pickerRadius
    pickerRadiusVec = vec.vector(pickerRadius * 2, pickerRadius * 2, pickerRadius * 2, 1)
  elseif smallerPickerButton == "JustPressed" then
    pickerRadius = pickerRadius * 0.75
    objectpicker.pickerradius = pickerRadius
    pickerRadiusVec = vec.vector(pickerRadius * 2, pickerRadius * 2, pickerRadius * 2, 1)
  end
  if nearPickerButton == "JustPressed" then
    pickerDist = pickerDist * 1.25
    pickerDistVec = vec.vector(pickerDist, pickerDist, pickerDist, 1)
  elseif farPickerButton == "JustPressed" then
    pickerDist = pickerDist * 0.75
    pickerDistVec = vec.vector(pickerDist, pickerDist, pickerDist, 1)
  end
  if printInfoButton == "JustPressed" then
    objectpicker.PrintObjectInfo = true
  end
  cameraHeading = pickerCamera.matrix[2]
  cameraHeading:normalise()
  pickerCamOffset = cameraHeading * pickerDistVec
  pickerPosition = pickerCamera.matrix[3] - pickerCamOffset
  pickerPosition.w = 1
end
function objectPickerUpdate()
  numPickedObjects = objectpicker.GetNumObjects()
  if numPickedObjects > 0 and numPickedObjects <= currentPickedObject then
    currentPickedObject = numPickedObjects - 1
  end
  displayObjectList()
  drawPicker()
  processPickerInputs()
  objectpicker.pickercentre = pickerPosition
  objectpicker.pickedobject = currentPickedObject
end
function objectPickerInit()
  objectpicker.CreateObjectPicker()
  if objectpicker.enabled == nil then
    print("-=Object Picker Debug Tool: Initialisation FAILED!=-")
    print("\t\t-> Check this config of the game has the object picker enabled (ENABLE_OBJECTPICKER)")
  else
    print("-=Object Picker Debug Tool: Initialised=-")
    controlHandler:setState("objectpickercontrols")
    addUserUpdateFunction("ObjectPicker", objectPickerUpdate, 1)
    allowFreeCam(true)
    pickerCamera = CameraSystem.CreateCamera()
    pickerCamera.viewport = 0
    pickerCamera.matrix = game_camera.matrix
    CameraSystemRegisterUpdate("PickerCam", pickerCamera, "real", Camera_Function_Free_Cam)
    print(pickerCamera.matrix)
    objectpicker.enabled = true
    objectpicker.pickercentre = pickerCamera.matrix[3]
    objectpicker.pickerradius = pickerRadius
    objectpicker.identifyobjects = true
    objectpicker.drawbounds = false
    drawPicker()
  end
end
function objectPickerClose()
  if objectpicker.enabled == nil then
    print("-=Object Picker Debug Tool: Close FAILED!=-")
    print("\t\t-> Check you have ENABLE_OBJECTPICKER for this config.")
  else
    objectpicker.enabled = false
    objectpicker.DestroyObjectPicker()
    clearDevGraphics()
    removeUserUpdateFunction("ObjectPicker")
    allowFreeCam(false)
    pickerCamera:delete()
    CameraSystemRegisterUpdate("PickerCam", pickerCamera, "real", nil)
    controlHandler:resetState("objectpickercontrols")
    print("-=Object Picker Debug Tool: Closed=-")
  end
end
