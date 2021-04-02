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
Tunnel.bindInterface("atlanta_hospital_clandestino",cnVRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTCHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.paymentCheckin()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local value = 4000
		local valueSujo = 40
		
		if vRP.tryGetInventoryItem(user_id,"dollars",parseInt(value)) then
			return true
		elseif vRP.tryGetInventoryItem(user_id,"dollars2",parseInt(valueSujo)) then
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Foi mal fera, só aceito dinheiro na mão <br>Você pode me pagar com: <br>Dinheiro Limpo: $"..value.." <br>Dinheiro Sujo: $"..valueSujo,7000)
			return false
		end
	end
	return false
end