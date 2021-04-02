-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","atlanta_roubonpc")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("atlanta_roubonpc",cnVRP)
vCLIENT = Tunnel.getInterface("atlanta_roubonpc")

local timeout = 0;

function cnVRP.triedRobDead()
    TriggerClientEvent("Notify",source,"negado","<b>Você não pode roubar um cidadão morto</b>",8000)
end

function cnVRP.robPed()
    local user_id = vRP.getUserId(source)
	local money = math.random(10,200)
    vRP.giveInventoryItem(user_id,"dollars",parseInt(money))
    TriggerClientEvent("Notify",source,"sucesso","<b> Você roubou: "..money.." dólares</b>",8000)
end

function cnVRP.robPedTimeout(timeout)
    timeout = timeout;
    Citizen.Wait(timeout)
    TriggerClientEvent("Notify",source,"negado","<b>Você não pode roubar um cidadão morto</b>",8000)
end
