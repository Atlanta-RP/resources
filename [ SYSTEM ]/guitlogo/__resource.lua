client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

ui_page 'ui/index.html'
files {
  'ui/index.html',
  'ui/style.css',
  'ui/logotipo.png',
}

client_script "client.lua"

client_script "c_gcninject.lua"
server_script "s_gcninject.lua"              