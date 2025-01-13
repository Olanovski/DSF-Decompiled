module("cardSystem", package.seeall)
cameraShots = {
  [1] = {
    [1] = {
      lookFromOffset = vec.vector(-1.214496, 1.105459, 3.470696, 0),
      lookAtOffset = vec.vector(3.529056, -1.635167, -4.895139, 0),
      fov = 1.308
    },
    [2] = {
      lookFromOffset = vec.vector(1.835906, 0.2368406, 2.301785, 0),
      lookAtOffset = vec.vector(-4.366685, 1.395298, -5.456136, 0),
      fov = 1.074667
    },
    [3] = {
      lookFromOffset = vec.vector(-1.185527, 1.332915, -3.352656, 0),
      lookAtOffset = vec.vector(2.845106, -1.490603, 5.352556, 0),
      fov = 1.074667
    },
    [4] = {
      lookFromOffset = vec.vector(1.691298, 0.39925, 4.191831, 0),
      lookAtOffset = vec.vector(-4.568212, 2.277619, -3.377165, 0),
      fov = 1.241333
    }
  },
  [2] = {
    [1] = {
      lookFromOffset = vec.vector(3.339527, 3.730958, -6.056915, 0),
      lookAtOffset = vec.vector(-2.430604, -0.7811971, 0.7508619, 0),
      fov = 1.224667
    },
    [2] = {
      lookFromOffset = vec.vector(3.758704, 6.774106, 5.867304, 0),
      lookAtOffset = vec.vector(-0.2407507, 0.05121639, -0.3622297, 0),
      fov = 1.108
    },
    [3] = {
      lookFromOffset = vec.vector(1.601469, 0.4306812, -6.366096, 0),
      lookAtOffset = vec.vector(-3.413737, 2.223093, 2.097652, 0),
      fov = 1.258
    },
    [4] = {
      lookFromOffset = vec.vector(3.487721, 3.808689, 4.817264, 0),
      lookAtOffset = vec.vector(-3.626585, -1.104903, -0.207033, 0),
      fov = 1.458
    }
  },
  [3] = {
    [1] = {
      lookFromOffset = vec.vector(2.382439, 0.7833735, 5.669781, 0),
      lookAtOffset = vec.vector(-3.108973, 1.71356, -2.635606, 0),
      fov = 1.174667
    },
    [2] = {
      lookFromOffset = vec.vector(2.226196, 0.3360639, -4.479703, 0),
      lookAtOffset = vec.vector(-2.497276, 2.790472, 3.985798, 0),
      fov = 1.008
    },
    [3] = {
      lookFromOffset = vec.vector(5.538941, 10.86892, -10.9132, 0),
      lookAtOffset = vec.vector(1.048263, 4.342323, -4.810957, 0),
      fov = 0.7246672
    },
    [4] = {
      lookFromOffset = vec.vector(3.911219, 3.739027, 5.745532, 0),
      lookAtOffset = vec.vector(-2.695842, -0.2928139, -0.5861801, 0),
      fov = 1.141333
    }
  }
}
