print("HELLO")
function StartMemoryLogging()
  print("Memory Logging active")
  return 1
end
function MemoryLog(string)
  print("$MEMLOG$:" .. string)
end
