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
Tunnel.bindInterface("vrp_aluminio",cnVRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local gallons = {
	{ 1110.0,-2008.11,31.06,0,0,0,0 },
	{ 1088.18,-2001.55,30.88,0,0,0,0 }
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
		TriggerClientEvent("vrp_aluminio:labUpdate",-1,gallons)
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
		if vRP.hasPermission(user_id,"Mafia") then
			if parseInt(gallons[processId][7]) <= 0 then
				gallons[processId][7] = 1
				TriggerClientEvent("vrp_aluminio:labUpdate",-1,gallons)
			elseif parseInt(gallons[processId][7]) >= 100 then
				local quantidade =parseInt(math.random(4,10))
				--print (quantidade)
				if vRP.computeInvWeight(user_id) + vRP.itemWeightList("aluminum") * quantidade  <= vRP.getBackpack(user_id) then
					gallons[processId][7] = 0
					TriggerClientEvent("Notify",source,"aviso","Você coletou "..quantidade.."x "..vRP.itemNameList("aluminum"),5000)
					TriggerClientEvent("vrp_aluminio:labUpdate",-1,gallons)
					vRP.giveInventoryItem(user_id,"aluminum",quantidade,true)
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
	TriggerClientEvent("vrp_aluminio:labUpdate",source,gallons)
end)