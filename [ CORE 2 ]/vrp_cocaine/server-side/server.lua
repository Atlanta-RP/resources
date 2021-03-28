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
Tunnel.bindInterface("vrp_cocaine",cnVRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local gallons = {
	{ 1950.97,5180.84,47.99,40,0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(gallons) do
			if v[5] > 0 and v[5] < 100 then
				v[5] = v[5] + 1
			end
		end
		TriggerClientEvent("vrp_cocaine:labUpdate",-1,gallons)
		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSTATUS
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.checkStatus(processId)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Ballas") then
			if parseInt(gallons[processId][5]) <= 0 then
				if vRP.tryGetInventoryItem(user_id,"folhadecoca",parseInt(gallons[processId][4])) then
					gallons[processId][5] = 1
					TriggerClientEvent("vrp_cocaine:labUpdate",-1,gallons)
				else
					TriggerClientEvent("Notify",source,"aviso","Você precisa de <b>"..vRP.format(parseInt(gallons[processId][4])).."x "..vRP.itemNameList("folhadecoca").."</b>.",5000)
				end
			elseif parseInt(gallons[processId][5]) >= 100 then
				if vRP.computeInvWeight(user_id) + vRP.itemWeightList("pastadecoca") * parseInt(gallons[processId][4]) <= vRP.getBackpack(user_id) then
					gallons[processId][5] = 0
					TriggerClientEvent("vrp_cocaine:labUpdate",-1,gallons)
					vRP.giveInventoryItem(user_id,"pastadecoca",parseInt(gallons[processId][4]),true)
					print(vRP.giveInventoryItem(user_id,"pastadecoca",parseInt(gallons[processId][4]),true))
				else
					TriggerClientEvent("Notify",source,"negado","Mochila cheia.",5000)
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPRODUCTION
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.checkProduction()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Ballas") then
			if vRP.tryGetInventoryItem(user_id,"pastadecoca",10) then
				TriggerClientEvent("Progress",source,5000,"Checando...")
				TriggerClientEvent("cancelando",source,true)
				Citizen.Wait(5000)
				vRP.giveInventoryItem(user_id,"cocaine",10,true)
				TriggerClientEvent("cancelando",source,false)
			else
				TriggerClientEvent("Notify",source,"aviso","Você precisa de <b>10x "..vRP.itemNameList("pastadecoca").."</b>.",5000)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	TriggerClientEvent("vrp_cocaine:labUpdate",source,gallons)
end)