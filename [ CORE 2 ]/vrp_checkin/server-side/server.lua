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
Tunnel.bindInterface("vrp_checkin",cnVRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSERVICES
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.checkServices()
	local amountMedics = vRP.numPermission("Paramedic")
	if parseInt(#amountMedics) > 2 then
		TriggerClientEvent("Notify",source,"aviso","Existem paramédicos em serviço.",5000)
		return false
	end
	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTCHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.paymentCheckin()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Police") then
			return true
		end

		local value = 400
		if GetEntityHealth(GetPlayerPed(source)) <= 101 then
			value = value + 500
		end

		if vRP.paymentBank(user_id,parseInt(value)) then
			TriggerClientEvent("Notify",source,"sucesso","Pagamento de "..value.." dólares realizado.",5000)
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente no banco.",5000)
		end

	end
	return false
end