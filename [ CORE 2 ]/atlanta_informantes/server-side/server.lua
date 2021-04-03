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
Tunnel.bindInterface("atlanta_informantes",cnVRP)
vCLIENT = Tunnel.getInterface("atlanta_informantes")


function cnVRP.pergunta(introducao,valor,resposta)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.request(source,introducao,30) then
			if vRP.tryGetInventoryItem(user_id,"dollars2",10) then
				TriggerClientEvent("Notify",source,"importante",resposta,5000)
				return true
			else
				TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente na sua mochila.",5000)
			end
		end
		return false
	end
end