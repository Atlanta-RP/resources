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
Tunnel.bindInterface("vrp_methlabs",cnVRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local gallons = {
	{ -328.95,-2444.05,7.36,40,0 },
	{ -330.59,-2446.04,7.36,20,0 },
	{ -332.32,-2448.09,7.36,60,0 },
	{ -330.43,-2449.6,7.36,20,0 },
	{ -328.25,-2446.97,7.36,40,0 },
	{ -328.02,-2439.26,7.36,20,0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(gallons) do
			if v[5] > 0 and v[5] < 100 then
				v[5] = v[5] + 2
			end
		end
		TriggerClientEvent("vrp_methlabs:labUpdate",-1,gallons)
		Citizen.Wait(36000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSTATUS
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.checkStatus(processId)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Vagos") then
			if parseInt(gallons[processId][5]) <= 0 then
				if vRP.tryGetInventoryItem(user_id,"analgesic",parseInt(gallons[processId][4])) then
					gallons[processId][5] = 1
					TriggerClientEvent("vrp_methlabs:labUpdate",-1,gallons)
				else
					TriggerClientEvent("Notify",source,"aviso","Você precisa de <b>"..vRP.format(parseInt(gallons[processId][4])).."x "..vRP.itemNameList("analgesic").."</b>.",5000)
				end
			elseif parseInt(gallons[processId][5]) >= 100 then
				if vRP.computeInvWeight(user_id) + vRP.itemWeightList("methliquid") * parseInt(gallons[processId][4]) <= vRP.getBackpack(user_id) then
					gallons[processId][5] = 0
					TriggerClientEvent("vrp_methlabs:labUpdate",-1,gallons)
					vRP.giveInventoryItem(user_id,"methliquid",parseInt(gallons[processId][4]),true)
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
		if vRP.hasPermission(user_id,"Vagos") then
			if vRP.tryGetInventoryItem(user_id,"methliquid",10) then
				TriggerClientEvent("Progress",source,5000,"Checando...")
				TriggerClientEvent("cancelando",source,true)
				Citizen.Wait(5000)
				vRP.giveInventoryItem(user_id,"meth",10,true)
				TriggerClientEvent("cancelando",source,false)
			else
				TriggerClientEvent("Notify",source,"aviso","Você precisa de <b>10x "..vRP.itemNameList("methliquid").."</b>.",5000)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	TriggerClientEvent("vrp_methlabs:labUpdate",source,gallons)
end)