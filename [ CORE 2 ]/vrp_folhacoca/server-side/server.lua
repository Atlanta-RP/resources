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
Tunnel.bindInterface("vrp_folhacoca",cnVRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local gallons = {
	{ 1495.97,1708.57,110.28,0,0,0,0 },
	{ 1488.22,1713.8,109.49,0,0,0,0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(gallons) do
			if v[7] > 0 and v[7] < 100 then
				v[7] = v[7] + 10
			end
		end
		TriggerClientEvent("vrp_folhacoca:labUpdate",-1,gallons)
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
			if parseInt(gallons[processId][7]) <= 0 then				
				--Citizen.Wait(1000)
				gallons[processId][7] = 1
				TriggerClientEvent("vrp_folhacoca:labUpdate",-1,gallons)
			elseif parseInt(gallons[processId][7]) >= 100 then
				local quantidade =parseInt(math.random(6))
				--print (quantidade)
				if vRP.computeInvWeight(user_id) + vRP.itemWeightList("folhadecoca") * quantidade  <= vRP.getBackpack(user_id) then
					gallons[processId][7] = 0
					TriggerClientEvent("Notify",source,"aviso","Você coletou "..quantidade.."x "..vRP.itemNameList("folhadecoca"),5000)
					TriggerClientEvent("vrp_folhacoca:labUpdate",-1,gallons)
					vRP.giveInventoryItem(user_id,"folhadecoca",quantidade,true)
				else
					TriggerClientEvent("Notify",source,"negado","Mochila cheia.",5000)
				end
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	TriggerClientEvent("vrp_folhacoca:labUpdate",source,gallons)
end)