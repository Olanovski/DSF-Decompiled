local wrongWayOn = false
local rightArrowOn = false
local rightDiagonalArrowOn = false
local leftArrowOn = false
local leftDiagonalArrowOn = false
local setToOff = false
local showArrows = false
local distanceToTarget, headingDot, headingToTarget
local arrowHeading = vec.vector()
local workingVector = vec.vector()
local heading = vec.vector()
local playerPosition = vec.vector()
local targetPosition = vec.vector()
local arrowOffset = vec.vector(0, 1.75, 0, 0)
local arrowPosition = vec.vector()
local heading = vec.vector()
local binormal = vec.vector()
local playerX = vec.vector()
local playerMatrix = vec.matrix()
local checkDistance = 45
function addDirectionArrows(playerVehicle, target)
  setToOff = false
  addUserUpdateFunction("updateArrow", function()
    if not setToOff then
      playerPosition = GameVehicleResource.position(playerVehicle, playerPosition)
      if type(target) == "table" then
        targetPosition = target.position
      else
        targetPosition = GameVehicleResource.position(target, targetPosition)
      end
      arrowHeading = arrowHeading:sub(targetPosition, playerPosition)
      distanceToTarget = arrowHeading:length()
      arrowHeading = arrowHeading:normalise()
      headingToTarget = arrowHeading:dot(heading)
      arrowPosition = arrowPosition:add(playerPosition, arrowOffset)
      playerMatrix = GameVehicleResource.transform(playerVehicle, playerMatrix)
      playerMatrix:getColumn(2, heading)
      playerMatrix:getColumn(0, binormal)
      local player = localPlayer.currentVehicle
      if player then
        local roadIndex = player:get_closestRoadIndex()
        local playerDistanceAlong = player:get_closestDistanceAlongRoad()
        if playerDistanceAlong <= checkDistance then
          local roadEnd = findEndVehicleHeadingTo(player)
          if roadEnd == "Start" then
            if playerDistanceAlong > 45 then
              showArrows = true
            else
              showArrows = false
            end
          end
        elseif playerDistanceAlong >= road.length - checkDistance then
          local roadEnd = findEndVehicleHeadingTo(player)
          if roadEnd == "End" then
            local flooredRoadLength = math.floor(Atlas.RoadLength(roadIndex)) - 5
            if playerDistanceAlong < flooredRoadLength then
              showArrows = true
            else
              showArrows = false
            end
          end
        end
      end
      if distanceToTarget > 200 and showArrows then
        headingDot = binormal:dot(arrowHeading)
        if headingToTarget >= -0.5 then
          if not forwardArrowOn and not rightArrowOn and not rightDiagonalArrowOn and not leftArrowOn and not leftDiagonalArrowOn then
            if math.abs(headingDot) < 0.35 then
              if not forwardArrowOn then
                forwardArrowOn = true
              end
              if rightArrowOn then
                rightArrowOn = false
              end
              if rightDiagonalArrowOn then
                rightDiagonalArrowOn = false
              end
              if leftArrowOn then
                leftArrowOn = false
              end
              if leftDiagonalArrowOn then
                leftDiagonalArrowOn = false
              end
            elseif headingDot >= 0.35 and headingDot < 0.85 then
              if not leftDiagonalArrowOn then
                leftDiagonalArrowOn = true
              end
              if leftArrowOn then
                leftArrowOn = false
              end
              if rightArrowOn then
                rightArrowOn = false
              end
              if rightDiagonalArrowOn then
                rightDiagonalArrowOn = false
              end
              if forwardArrowOn then
                forwardArrowOn = false
              end
            elseif headingDot >= 0.85 then
              if not leftArrowOn then
                leftArrowOn = true
              end
              if leftDiagonalArrowOn then
                leftDiagonalArrowOn = false
              end
              if rightArrowOn then
                rightArrowOn = false
              end
              if rightDiagonalArrowOn then
                rightDiagonalArrowOn = false
              end
              if forwardArrowOn then
                forwardArrowOn = false
              end
            elseif headingDot <= -0.35 and headingDot > -0.85 then
              if not rightDiagonalArrowOn then
                rightDiagonalArrowOn = true
              end
              if rightArrowOn then
                rightArrowOn = false
              end
              if leftArrowOn then
                leftArrowOn = false
              end
              if leftDiagonalArrowOn then
                leftDiagonalArrowOn = false
              end
              if forwardArrowOn then
                forwardArrowOn = false
              end
            elseif headingDot <= -0.85 then
              if not rightArrowOn then
                rightArrowOn = true
              end
              if rightDiagonalArrowOn then
                rightDiagonalArrowOn = false
              end
              if leftArrowOn then
                leftArrowOn = false
              end
              if leftDiagonalArrowOn then
                leftDiagonalArrowOn = false
              end
              if forwardArrowOn then
                forwardArrowOn = false
              end
            end
          end
        else
          if forwardArrowOn then
            forwardArrowOn = false
          end
          if rightArrowOn then
            rightArrowOn = false
          end
          if rightDiagonalArrowOn then
            rightDiagonalArrowOn = false
          end
          if leftArrowOn then
            leftArrowOn = false
          end
          if leftDiagonalArrowOn then
            leftDiagonalArrowOn = false
          end
        end
      end
      if showArrows == false then
        if rightArrowOn then
          rightArrowOn = false
        elseif rightDiagonalArrowOn then
          rightDiagonalArrowOn = false
        elseif leftArrowOn then
          leftArrowOn = false
        elseif leftDiagonalArrowOn then
          leftDiagonalArrowOn = false
        elseif forwardArrowOn then
          forwardArrowOn = false
        end
      end
    end
  end, 2)
end
function removeDirectionArrows()
  setToOff = true
  removeUserUpdateFunction("updateArrow")
  if rightArrowOn then
    rightArrowOn = false
  end
  if rightDiagonalArrowOn then
    rightDiagonalArrowOn = false
  end
  if leftArrowOn then
    leftArrowOn = false
  end
  if leftDiagonalArrowOn then
    leftDiagonalArrowOn = false
  end
  if forwardArrowOn then
    leftArrowOn = false
  end
end
