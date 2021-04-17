local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
srv = {}
Tunnel.bindInterface("atlanta_tablet",srv)



function srv.versao()
    local versao = vRP.query("vRP/get_version",{id = 1})
    return versao[1].versao 
end
