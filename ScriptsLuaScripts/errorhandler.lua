function LuaErrorHandler(message)
  errorhandler.reporterror(message)
end
function ErrorReportingTest_BrokenLua()
  print("Testing: About to call a non-existant function!")
  invalid_library.invalid_function()
end
