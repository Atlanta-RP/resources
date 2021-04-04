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


function cnVRP.pergunta(introducao,valor,resposta,itemTroca,respostaNegativa)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.request(source,introducao,30) then
			if vRP.tryGetInventoryItem(user_id,itemTroca,10) then
				TriggerClientEvent("Notify",source,"importante",resposta,7000)
				return true
			else
				TriggerClientEvent("Notify",source,"negado",respostaNegativa,6000)
			end
		end
		return false
	end
end