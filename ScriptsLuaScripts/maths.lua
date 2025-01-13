local _getMatrixValueByIndex = function()
  local tempVector = vec.vector()
  return function(matrix, column, row)
    matrix:getColumn(column, tempVector)
    return tempVector[row]
  end
end
getMatrixValueByIndex = _getMatrixValueByIndex()
local _setMatrixValueByIndex = function()
  local tempVector = vec.vector()
  return function(matrix, column, row, value)
    matrix:getColumn(column, tempVector)
    tempVector[row] = value
    matrix[column] = tempVector
  end
end
setMatrixValueByIndex = _setMatrixValueByIndex()
function cloneVectorIntoVector(from, to)
  to.x = from.x
  to.y = from.y
  to.z = from.z
  to.w = from.w
  return to
end
function lerp_value(A, B, t)
  return (1 - t) * A + t * B
end
function lerp(vecA, vecB, t)
  local oneMinusT = 1 - t
  return vec.vector(oneMinusT * vecA[0] + t * vecB[0], oneMinusT * vecA[1] + t * vecB[1], oneMinusT * vecA[2] + t * vecB[2], oneMinusT * vecA[3] + t * vecB[3])
end
function lowMemLerp(vecA, vecB, vecOut, t)
  local oneMinusT = 1 - t
  vecOut[0] = oneMinusT * vecA[0] + t * vecB[0]
  vecOut[1] = oneMinusT * vecA[1] + t * vecB[1]
  vecOut[2] = oneMinusT * vecA[2] + t * vecB[2]
  vecOut[3] = oneMinusT * vecA[3] + t * vecB[3]
  return vecOut
end
local _LinearInterpolate = function()
  local tempVector1 = vec.vector()
  local tempVector2 = vec.vector()
  local tempVector3 = vec.vector()
  local primaryAxisFrom = vec.vector()
  local primaryAxisTo = vec.vector()
  local secondaryAxisFrom = vec.vector()
  local secondaryAxisTo = vec.vector()
  local primary_axis = 1
  local secondary_axis = 2
  return function(matfrom, matto, t)
    local matrix = vec.matrix()
    matfrom:getColumn(primary_axis, primaryAxisFrom)
    matfrom:getColumn(secondary_axis, secondaryAxisFrom)
    matto:getColumn(primary_axis, primaryAxisTo)
    matto:getColumn(secondary_axis, secondaryAxisTo)
    matrix[primary_axis] = tempVector1:lerp(primaryAxisFrom, primaryAxisTo, t)
    matrix[secondary_axis] = tempVector2:lerp(secondaryAxisFrom, secondaryAxisTo, t)
    matrix[3] = tempVector3:lerp(matfrom[3], matto[3], t)
    return Reorthonormalise(matrix, primary_axis, secondary_axis)
  end
end
LinearInterpolate = _LinearInterpolate()
local _LowMemLinearInterpolate = function()
  local tempVector1 = vec.vector()
  local tempVector2 = vec.vector()
  local tempVector3 = vec.vector()
  local primaryAxisFrom = vec.vector()
  local primaryAxisTo = vec.vector()
  local secondaryAxisFrom = vec.vector()
  local secondaryAxisTo = vec.vector()
  local primary_axis = 1
  local secondary_axis = 2
  return function(matfrom, matto, matOut, t)
    matfrom:getColumn(primary_axis, primaryAxisFrom)
    matfrom:getColumn(secondary_axis, secondaryAxisFrom)
    matto:getColumn(primary_axis, primaryAxisTo)
    matto:getColumn(secondary_axis, secondaryAxisTo)
    matOut[primary_axis] = tempVector1:lerp(primaryAxisFrom, primaryAxisTo, t)
    matOut[secondary_axis] = tempVector2:lerp(secondaryAxisFrom, secondaryAxisTo, t)
    matfrom:getColumn(3, tempVector1)
    matto:getColumn(3, tempVector2)
    matOut[3] = tempVector3:lerp(tempVector1, tempVector2, t)
    return Reorthonormalise(matOut, primary_axis, secondary_axis)
  end
end
LowMemLinearInterpolate = _LowMemLinearInterpolate()
function scalarDamping(currentScalar, targetScalar, dampingFactor)
  return currentScalar - (currentScalar - targetScalar) * dampingFactor
end
function vectorDamping(currentVector, targetVector, dampingFactor)
  currentVector.x = currentVector.x - (currentVector.x - targetVector.x) * dampingFactor
  currentVector.y = currentVector.y - (currentVector.y - targetVector.y) * dampingFactor
  currentVector.z = currentVector.z - (currentVector.z - targetVector.z) * dampingFactor
  return currentVector
end
local _SlerpMatrix = function()
  local tempVector = vec.vector()
  return function(matA, matB, blend)
    local quatA = create_quaternion_from_matrix(matA)
    local quatB = create_quaternion_from_matrix(matB)
    local quatR = quaternion_slerp(quatA, quatB, blend)
    local posR = tempVector:lerp(matA[3], matB[3], blend)
    local matR = create_matrix_from_quaternion(quatR, posR)
    return matR
  end
end
SlerpMatrix = _SlerpMatrix()
local reorth_temp = vec.vector()
local reorth_temp2 = vec.vector()
local reorth_temp3 = vec.vector()
function Reorthonormalise(mat, nPrimaryAxis, nSecondaryAxis)
  local nTertiaryAxis = 3 - nPrimaryAxis - nSecondaryAxis
  mat:getColumn(nPrimaryAxis, reorth_temp)
  mat[nPrimaryAxis] = makeNormal(reorth_temp)
  mat:getColumn((nTertiaryAxis + 1) % 3, reorth_temp)
  mat:getColumn((nTertiaryAxis + 2) % 3, reorth_temp2)
  reorth_temp:cross(reorth_temp2, reorth_temp3)
  mat[nTertiaryAxis] = makeNormal(reorth_temp3)
  mat:getColumn((nSecondaryAxis + 1) % 3, reorth_temp)
  mat:getColumn((nSecondaryAxis + 2) % 3, reorth_temp2)
  reorth_temp:cross(reorth_temp2, reorth_temp3)
  mat[nSecondaryAxis] = makeNormal(reorth_temp3)
  return mat
end
function getNormal(rhs)
  local mag = rhs:dot(rhs)
  mag = math.sqrt(mag)
  return rhs * (1 / mag)
end
function makeNormal(rhs)
  local scale = 1 / rhs:length()
  rhs.x = rhs.x * scale
  rhs.y = rhs.y * scale
  rhs.z = rhs.z * scale
  rhs.w = rhs.w * scale
  return rhs
end
local _cross = function()
  local vector = vec.vector
  return function(lhs, rhs)
    return vector(lhs.y * rhs.z - rhs.y * lhs.z, lhs.z * rhs.x - rhs.z * lhs.x, lhs.x * rhs.y - rhs.x * lhs.y, 0)
  end
end
cross = _cross()
local _CreateLookAtMatrix = function()
  local normal = vec.vector(0, 1, 0, 0)
  local workingVector = vec.vector()
  return function(from, to)
    local matrix = vec.matrix()
    local column2 = workingVector:sub(from, to):normalise()
    local column0 = normal:cross(column2):normalise()
    matrix[0] = column0
    matrix[1] = column2:cross(column0):normalise()
    matrix[2] = column2
    matrix[3] = from
    return matrix
  end
end
CreateLookAtMatrix = _CreateLookAtMatrix()
local _makeLookAtMatrix = function()
  local normal = vec.vector(0, 1, 0, 0)
  return function(from, to, result)
    result[2] = makeNormal(from - to)
    result[0] = makeNormal(cross(normal, result[2]))
    result[1] = makeNormal(cross(result[2], result[0]))
    result[3] = from
    return result
  end
end
makeLookAtMatrix = _makeLookAtMatrix()
local catmull_matrix = vec.matrix(0, 1, 0, 0, -0.5, 0, 0.5, 0, 1, -2.5, 2, -0.5, -0.5, 1.5, -1.5, 0.5)
function catmullRomSpline(t, vecA, vecB, vecC, vecD)
  local temp1 = catmull_matrix[1][0] * vecB
  local temp2 = catmull_matrix[0][1] * vecA + catmull_matrix[2][1] * vecC
  local temp3 = catmull_matrix[0][2] * vecA + catmull_matrix[1][2] * vecB + catmull_matrix[2][2] * vecC + catmull_matrix[3][2] * vecD
  local temp4 = catmull_matrix[0][3] * vecA + catmull_matrix[1][3] * vecB + catmull_matrix[2][3] * vecC + catmull_matrix[3][3] * vecD
  return ((temp4 * t + temp3) * t + temp2) * t + temp1
end
function create_quaternion_from_matrix(matrix)
  local result = vec.vector()
  local trace = matrix[0][0] + matrix[1][1] + matrix[2][2]
  if trace >= 0 then
    local s = math.sqrt(trace + 1)
    result[3] = 0.5 * s
    s = 0.5 / s
    result[0] = (matrix[1][2] - matrix[2][1]) * s
    result[1] = (matrix[2][0] - matrix[0][2]) * s
    result[2] = (matrix[0][1] - matrix[1][0]) * s
  else
    local i = 0
    local nxt = {
      1,
      2,
      0
    }
    if matrix[1][1] > matrix[0][0] then
      i = 1
    end
    if matrix[2][2] > matrix[i][i] then
      i = 2
    end
    local j = nxt[i + 1]
    local k = nxt[j + 1]
    local s = math.sqrt(matrix[i][i] - (matrix[j][j] + matrix[k][k]) + 1)
    result[i] = 0.5 * s
    s = 0.5 / s
    result[j] = (matrix[j][i] + matrix[i][j]) * s
    result[k] = (matrix[k][i] + matrix[i][k]) * s
    result[3] = (matrix[j][k] - matrix[k][j]) * s
  end
  return result
end
local _create_matrix_from_quaternion = function()
  local matrix = vec.matrix
  return function(quaternion, vector)
    result = matrix()
    local tmpxx = quaternion[0] + quaternion[0]
    local tmpxy = tmpxx
    local tmpxz = tmpxx
    local tmpyy = quaternion[1] + quaternion[1]
    local tmpyz = tmpyy
    local tmpzz = (quaternion[2] + quaternion[2]) * quaternion[2]
    local tmprx = quaternion[3] + quaternion[3]
    local tmpry = tmprx
    local tmprz = tmprx
    tmpxx = tmpxx * quaternion[0]
    tmpxy = tmpxy * quaternion[1]
    tmpxz = tmpxz * quaternion[2]
    tmpyy = tmpyy * quaternion[1]
    tmpyz = tmpyz * quaternion[2]
    tmprx = tmprx * quaternion[0]
    tmpry = tmpry * quaternion[1]
    tmprz = tmprz * quaternion[2]
    result[0][0] = 1 - tmpyy - tmpzz
    result[1][0] = tmpxy - tmprz
    result[2][0] = tmpxz + tmpry
    result[0][1] = tmpxy + tmprz
    result[1][1] = 1 - tmpxx - tmpzz
    result[2][1] = tmpyz - tmprx
    result[0][2] = tmpxz - tmpry
    result[1][2] = tmpyz + tmprx
    result[2][2] = 1 - tmpxx - tmpyy
    result[3] = vector
    return result
  end
end
create_matrix_from_quaternion = _create_matrix_from_quaternion()
local _quaternion_slerp = function()
  local matrix = vec.matrix
  local tempVector = vec.vector()
  local sin = math.sin
  local acos = math.acos
  return function(A, B, t)
    if t < 0 then
      return A:clone()
    elseif t > 1 then
      return B:clone()
    end
    local result = matrix()
    local to1 = B
    local cosom = B:dot(A)
    if cosom < 0 then
      cosom = -cosom
      to1 = -1 * B
    end
    if 1 - cosom > 0.05 then
      local omega = acos(cosom)
      local sinom = sin(omega)
      local scale0 = sin((1 - t) * omega)
      local scale1 = sin(t * omega)
      result = (scale0 * A + scale1 * to1) * (1 / sinom)
    else
      result = lowMemLerp(A, to1, tempVector, t)
      result = getNormal(result)
    end
    return result
  end
end
quaternion_slerp = _quaternion_slerp()
function quaternionToEulerRoll(quaternion)
  return math.atan2(2 * (quaternion[2] * quaternion[3] + quaternion[0] * quaternion[1]), quaternion[0] * quaternion[0] - quaternion[1] * quaternion[1] - quaternion[2] * quaternion[2] + quaternion[3] * quaternion[3])
end
function quaternionToEulerPitch(quaternion)
  return math.sin(-2 * (quaternion[1] * quaternion[3] + quaternion[0] * quaternion[2]))
end
function quaternionToEulerYaw(quaternion)
  return math.atan2(2 * (quaternion[1] * quaternion[2] + quaternion[0] * quaternion[3]), quaternion[0] * quaternion[0] + quaternion[1] * quaternion[1] - quaternion[2] * quaternion[2] - quaternion[3] * quaternion[3])
end
function intersectSphere(origin, direction, sphere_centre, sphere_radius)
  local a = direction:dot(direction)
  local c = origin - sphere_centre
  local b = 2 * direction:dot(c)
  c = c:dot(c) - sphere_radius * sphere_radius
  local d = b * b - 4 * a * c
  if d < 0 then
    return -1
  else
    local t1 = (-b + math.sqrt(d)) / (2 * a)
    local t2 = (-b - math.sqrt(d)) / (2 * a)
    if t1 > t2 then
      t1, t2 = t2, t1
    end
    if t1 < 0 then
      return t2
    else
      return t1
    end
  end
end
local _setXRotation = function()
  local sin = math.sin
  local cos = math.cos
  local workingVector = vec.vector()
  local matrix = vec.matrix
  return function(theta)
    local matRotation = matrix()
    local cosTheta = cos(theta)
    local sinTheta = sin(theta)
    matRotation:getColumn(1, workingVector)
    workingVector.y = cosTheta
    workingVector.z = sinTheta
    matRotation[1] = workingVector
    matRotation:getColumn(2, workingVector)
    workingVector.y = -sinTheta
    workingVector.z = cosTheta
    matRotation[2] = workingVector
    return matRotation
  end
end
setXRotation = _setXRotation()
local _setYRotation = function()
  local sin = math.sin
  local cos = math.cos
  local workingVector = vec.vector()
  local matrix = vec.matrix
  return function(theta)
    local matRotation = matrix()
    local cosTheta = cos(theta)
    local sinTheta = sin(theta)
    matRotation:getColumn(0, workingVector)
    workingVector.x = cosTheta
    workingVector.z = -sinTheta
    matRotation[0] = workingVector
    matRotation:getColumn(2, workingVector)
    workingVector.x = sinTheta
    workingVector.z = cosTheta
    matRotation[2] = workingVector
    return matRotation
  end
end
setYRotation = _setYRotation()
local _setZRotation = function()
  local sin = math.sin
  local cos = math.cos
  local workingVector = vec.vector()
  local matrix = vec.matrix
  return function(theta)
    local matRotation = matrix()
    local cosTheta = cos(theta)
    local sinTheta = sin(theta)
    matRotation:getColumn(0, workingVector)
    workingVector.x = cosTheta
    workingVector.y = sinTheta
    matRotation[0] = workingVector
    matRotation:getColumn(1, workingVector)
    workingVector.x = -sinTheta
    workingVector.y = cosTheta
    matRotation[1] = workingVector
    return matRotation
  end
end
setZRotation = _setZRotation()
function createRotationAroundAxis(axis, angle)
  axis = axis:normalise()
  local cos = math.cos(angle)
  local sin = math.sin(angle)
  local cosComp = 1 - cos
  local matrix = vec.matrix()
  matrix[0].x = axis.x * axis.x + cos * (1 - axis.x * axis.x)
  matrix[0].y = axis.x * axis.y * cosComp + axis.z * sin
  matrix[0].z = axis.x * axis.z * cosComp - axis.y * sin
  matrix[1].x = axis.x * axis.y * cosComp - axis.z * sin
  matrix[1].y = axis.y * axis.y + cos * (1 - axis.y * axis.y)
  matrix[1].z = axis.y * axis.z * cosComp + axis.x * sin
  matrix[2].x = axis.x * axis.z * cosComp + axis.y * sin
  matrix[2].y = axis.y * axis.z * cosComp - axis.x * sin
  matrix[2].z = axis.z * axis.z + cos * (1 - axis.z * axis.z)
  return matrix
end
local _twoDTransform = function()
  local cos = math.cos
  local sin = math.sin
  return function(centerPoint, offset, angle)
    if not centerPoint then
      print("CenterPoint")
      callStack()
    elseif not offset then
      print("Offset")
      callStack()
    elseif not angle then
      print("Angle")
      callStack()
    end
    local transformed = centerPoint:clone()
    transformed.x = centerPoint.x + offset.x * cos(angle) + offset.z * sin(angle)
    transformed.z = centerPoint.z + offset.z * cos(angle) - offset.x * sin(angle)
    return transformed
  end
end
twoDTransform = _twoDTransform()
local _nonReflexAngleBetween = function()
  local pi = math.pi
  local twoPi = pi * 2
  return function(angleA, angleB)
    local angleBetween = angleB - angleA
    if angleBetween > pi then
      angleBetween = angleBetween - twoPi
    elseif angleBetween < -pi then
      angleBetween = twoPi + angleBetween
    end
    return angleBetween
  end
end
nonReflexAngleBetween = _nonReflexAngleBetween()
local _radian_bounds = function()
  local pi = math.pi
  local minusPi = -pi
  return function(angle)
    if angle < minusPi then
      angle = pi + (angle + pi)
    elseif angle > pi then
      angle = minusPi + (angle - pi)
    end
    return angle
  end
end
radian_bounds = _radian_bounds()
local _round = function()
  local number = "number"
  local floor = math.floor
  local mult = 1
  return function(x, i)
    if i and type(i) == number then
      if i < 0 then
        i = 0
      end
      mult = 10 ^ i
      return floor(x * mult + 0.5) / mult
    end
  end
end
round = _round()
local _roughlyEqual = function()
  local log10 = math.log10
  local abs = math.abs
  return function(a, b)
    return log10(abs(a - b)) < -2
  end
end
roughlyEqual = _roughlyEqual()
function _nonLinearCameraBlend()
  local resultMatrix = vec.matrix()
  return function(startMatrix, endMatrix, startFOV, endFOV, time)
    local nonLinearTime = -(math.cos(math.pi * time) - 1) / 2
    return LowMemLinearInterpolate(startMatrix, endMatrix, resultMatrix, nonLinearTime), lerp_value(startFOV, endFOV, nonLinearTime)
  end
end
nonLinearCameraBlend = _nonLinearCameraBlend()
function _cubicNonLinearCameraBlend()
  local resultMatrix = vec.matrix()
  local timeOffset = 0.01666667
  return function(startMatrix, endMatrix, startFOV, endFOV, time)
    time = time + timeOffset
    local nonLinearTime = time ^ 4
    return LowMemLinearInterpolate(startMatrix, endMatrix, resultMatrix, nonLinearTime), lerp_value(startFOV, endFOV, nonLinearTime)
  end
end
cubicNonLinearCameraBlend = _cubicNonLinearCameraBlend()
function _squareNonLinearCameraBlend()
  local resultMatrix = vec.matrix()
  return function(startMatrix, endMatrix, startFOV, endFOV, time)
    local nonLinearTime = 0
    if time <= 0.5 then
      nonLinearTime = 0.5 - math.sqrt(1 - 4 * time ^ 2) / 2
    else
      nonLinearTime = math.sqrt(1 - 4 * (time - 1) ^ 2) / 2 + 0.5
    end
    return LowMemLinearInterpolate(startMatrix, endMatrix, resultMatrix, nonLinearTime), lerp_value(startFOV, endFOV, nonLinearTime)
  end
end
squareNonLinearCameraBlend = _squareNonLinearCameraBlend()
function _arcTanNonLinearCameraBlend()
  local resultMatrix = vec.matrix()
  return function(startMatrix, endMatrix, startFOV, endFOV, time)
    local nonLinearTime = 0.5 + math.atan((time - 0.5) * 10) / 2.75
    return LowMemLinearInterpolate(startMatrix, endMatrix, resultMatrix, nonLinearTime), lerp_value(startFOV, endFOV, nonLinearTime)
  end
end
arcTanNonLinearCameraBlend = _arcTanNonLinearCameraBlend()
function _linearPositionNonLinearAngleCameraBlend()
  local resultMatrix = vec.matrix()
  local startPosition = vec.vector()
  local endPosition = vec.vector()
  local blendPosition = vec.vector()
  return function(startMatrix, endMatrix, startFOV, endFOV, time)
    local nonLinearTime = -(math.cos(math.pi * time) - 1) / 2
    startMatrix:getColumn(3, startPosition)
    endMatrix:getColumn(3, endPosition)
    blendPosition = lowMemLerp(startPosition, endPosition, blendPosition, time)
    resultMatrix = LowMemLinearInterpolate(startMatrix, endMatrix, resultMatrix, nonLinearTime)
    resultMatrix[3] = blendPosition
    return resultMatrix, lerp_value(startFOV, endFOV, nonLinearTime)
  end
end
linearPositionNonLinearAngleCameraBlend = _linearPositionNonLinearAngleCameraBlend()
local lineCheckParams = {
  Heading = vec.vector(0, -1, 0, 0),
  Length = 5
}
local defaultNormal = vec.vector(0, 1, 0, 0)
function alignMatrix(position, heading)
  lineCheckParams.Position = position
  local matrix = vec.matrix()
  local flatTangent = vec.vector(math.sin(heading), 0, math.cos(heading), 0)
  local results = physics.LineCheck(lineCheckParams)
  local normal = results.Normal
  if not normal or type(normal) ~= "userdata" then
    normal = defaultNormal
  end
  local biNormal = normal:cross(flatTangent)
  local tangent = biNormal:cross(normal)
  matrix[0] = biNormal
  matrix[1] = normal
  matrix[2] = tangent
  matrix[3] = position
  return matrix
end
