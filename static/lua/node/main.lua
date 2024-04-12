if not lvn.config.get("node.password") then
  print("You do not have a password set.")
  io.write("Please enter a password: ")
  local password = io.read("*l")

  lvn.config.set("node.password", password)
end

-- Register node specific packet handlers
sharedWs.registerPacketHandler("toggle", function(data)
  redstone.setOutput(data, not redstone.getOutput(data))
end)

sharedWs.registerPacketHandler("turnOn", function(data)
  redstone.setOutput(data, true)
end)

sharedWs.registerPacketHandler("turnOff", function(data)
  redstone.setOutput(data, false)
end)

-- Load shared websocket loop
local wsId = multishell.launch({}, "/run/wsLoop.lua")
multishell.setTitle(wsId, "Websocket Runner")

-- Load turtle module
if turtle then
  print("Running turtle main")
  local id = multishell.launch(getfenv(), "/run/turtle/main.lua")
  multishell.setTitle(id, "Turtle")
  multishell.setFocus(id)
end

if lvn.config.get("sorter") then
  print("Item sorter detected")
  local id = multishell.launch({}, "/run/sorter/main.lua")
  multishell.setTitle(id, "Item Sorter")
  multishell.setFocus(id)
end

if not turtle and not lvn.config.get("sorter") then
  multishell.setFocus(wsId)
end