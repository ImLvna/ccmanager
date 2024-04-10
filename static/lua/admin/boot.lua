lvn.net.downloadFile('/lua/admin/toggle.lua', '/run/toggle.lua')
shell.setAlias('toggle', '/run/toggle.lua')
shell.run('/run/toggle.lua completion')

lvn.net.downloadFile('/lua/admin/eval.lua', '/run/eval.lua')
shell.setAlias('eval', '/run/eval.lua')
shell.run('/run/eval.lua completion')

lvn.net.downloadFile('/lua/admin/turtle.lua', '/run/turtle.lua')
shell.setAlias('turtle', '/run/turtle.lua')
shell.run('/run/turtle.lua completion')


lvn.net.downloadFile('/lua/admin/update.lua', '/run/update.lua')
shell.setAlias('update', '/run/update.lua')




lvn.net.downloadFile('/lua/admin/ws.lua', '/run/ws.lua')

lvn.net.downloadFile('/lua/shared/ws.lua', '/run/sharedWs.lua')


if not lvn.config.get("admin.password") then
  print("You do not have a password set.")
  io.write("Please enter a password: ")
  local password = io.read("*l")

  lvn.config.set("admin.password", password)
end