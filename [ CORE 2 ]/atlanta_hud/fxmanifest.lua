---dependency "flux" client_script "@flux/client.lua" --- HUD FEITA POR Rafitz#6666
fx_version "bodacious"
game "gta5"

ui_page "web-side/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server-side/*"
}

files {
	"web-side/*"
}
--- HUD FEITA POR Rafitz#6666