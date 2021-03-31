-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_robnpc")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("vrp_robnpc",cnVRP)
vCLIENT = Tunnel.getInterface("vrp_robnpc")

function cnVRP.triedRobDead()
    TriggerClientEvent("Notify",source,"negado","<b>Você não pode roubar um cidão morto</b>",8000)
end

function cnVRP.robPed()
    local user_id = vRP.getUserId(source)
	local money = math.random(10,200)
    vRP.giveInventoryItem(user_id,"dollars",parseInt(money))
    TriggerClientEvent("Notify",source,"sucesso","<b> Você roubou: "..money.." dólares</b>",8000)
end


RegisterServerEvent('vrp_robnpc:giveMoney')
AddEventHandler('vrp_robnpc:giveMoney', function()
    local user_id = vRP.getUserId({source})
	local money = math.random(10,200)
    vRP.tryGetInventoryItem(user_id,"dollars",parseInt(money))
end)