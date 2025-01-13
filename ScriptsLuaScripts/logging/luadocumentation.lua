function LuaDocumentation_Initialise()
  print("$luadoc$:init")
end
function LuaDocumentation_Shutdown()
  print("$luadoc$:shutdown")
end
function LuaDocumentation_AddLuaLibrary(libraryName)
  print("$luadoc$:addlualibrary:" .. libraryName)
end
function LuaDocumentation_AddLuaFunctionDocumentation(libraryName, functionName, functionDocs)
  print("$luadoc$:addluafunctiondocs:" .. libraryName .. ":" .. functionName .. ":" .. functionDocs)
end
function LuaDocumentation_AddLuaPropertyDocumentation(libraryName, propertyName, propertyDocs)
  print("$luadoc$:addluapropertydocs:" .. libraryName .. ":" .. propertyName .. ":" .. propertyDocs)
end
function LuaDocumentation_RemoveLuaLibrary(libraryName)
  print("$luadoc$:removelualibrary:" .. libraryName)
end
function LuaDocumentation_BeginUpdate()
  print("$luadoc$:beginupdate")
end
function LuaDocumentation_EndUpdate()
  print("$luadoc$:endupdate")
end
function ParseTableForDocumentation(alreadyDone, namespaceString, theTable)
  if not alreadyDone[theTable] then
    alreadyDone[theTable] = true
    for k, v in next, theTable, nil do
      if type(v) == "table" then
        newNamespaceString = namespaceString
        if string.len(newNamespaceString) > 0 then
          newNamespaceString = newNamespaceString .. "."
        end
        newNamespaceString = newNamespaceString .. k
        ParseTableForDocumentation(alreadyDone, newNamespaceString, v)
      end
      if type(v) == "function" then
        LuaDocumentation_AddLuaFunctionDocumentation(namespaceString, k, "Some Docs?")
      end
    end
  end
end
function GenerateLuaDocumentation()
  print("Generating Lua Documentation")
  LuaDocumentation_BeginUpdate()
  local alreadyDone = {}
  ParseTableForDocumentation(alreadyDone, "", _G)
  LuaDocumentation_EndUpdate()
  print("Complete!")
end
