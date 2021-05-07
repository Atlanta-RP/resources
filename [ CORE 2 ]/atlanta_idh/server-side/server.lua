-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("atlanta_idh",cnVRP)
vCLIENT = Tunnel.getInterface("atlanta_idh")

function cnVRP.setDesenvolvimento(desenvolvimento)
    local dados = vRP.query("vRP/getIdh")
    local antigos = dados[1].desenvolvimento
    local novoValor = parseInt(desenvolvimento)+parseInt(antigos)
    vRP.execute("vRP/setDesenvolvimento",{ desenvolvimento = novoValor })
end

function cnVRP.setPoluicao(poluicao)
    local dados = vRP.query("vRP/getIdh")
    local antigos = dados[1].poluicao
    local novoValor = parseInt(poluicao)+parseInt(antigos)
    vRP.execute("vRP/setPoluicao",{ poluicao = novoValor })
end