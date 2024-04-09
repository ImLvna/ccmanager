print('Downloading core files...')

if fs.exists('/lvn/core') then
  fs.delete('/lvn/core')
end

print('Downloading core files...')
print('Downloading boot.lua...')
lvn.net.downloadFile('/lua/boot.lua', '/startup/boot.lua')

print('Downloading config.lua...')
lvn.net.downloadFile('/lua/core/config.lua', '/lvn/core/config.lua')

print('Downloading net.lua...')
lvn.net.downloadFile('/lua/core/net.lua', '/lvn/core/net.lua')

print('Downloading urls.lua...')
lvn.net.downloadFile('/lua/core/urls.lua', '/lvn/core/urls.lua')

print('Downloading lvn.lua...')
lvn.net.downloadFile('/lua/core/lvn.lua', '/lvn/core/lvn.lua')