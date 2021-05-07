-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("atlanta_idh",cnVRP)
vSERVER = Tunnel.getInterface("atlanta_idh")

RegisterNetEvent("atlanta_idh:setDesenvolvimentoClient")
AddEventHandler("atlanta_idh:setDesenvolvimentoClient",function(desenvolvimento)
    vSERVER.setDesenvolvimento(desenvolvimento)
end)

RegisterNetEvent("atlanta_idh:setPoluicaoClient")
AddEventHandler("atlanta_idh:setPoluicaoClient",function(poluicao)
    vSERVER.setPoluicao(poluicao)
end)