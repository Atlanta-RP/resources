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
Tunnel.bindInterface("vrp_lean",cnVRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local gallons = {
	{ 893.11,-960.8,39.28,1,3,1,0 },
	{890.98,-960.69,39.28,2,6,2,0 },
	{888.65,-960.67,39.28,3,9,3,0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(gallons) do
			if v[7] > 0 and v[7] < 100 then
				v[7] = v[7] + 1
			end
		end
		TriggerClientEvent("vrp_lean:labUpdate",-1,gallons)
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
		if vRP.hasPermission(user_id,"Groove") then
			if parseInt(gallons[processId][7]) <= 0 then
				if vRP.tryGetInventoryItem(user_id,"codeina",parseInt(gallons[processId][4])) and 
				vRP.tryGetInventoryItem(user_id,"chiclete",parseInt(gallons[processId][5])) and
				vRP.tryGetInventoryItem(user_id,"soda",parseInt(gallons[processId][6]))
				then
					gallons[processId][7] = 1
					TriggerClientEvent("vrp_lean:labUpdate",-1,gallons)
				else
					TriggerClientEvent("Notify",source,"aviso","Você precisa de: <br>"..vRP.format(parseInt(gallons[processId][4])).."x "..vRP.itemNameList("codeina").." <br>"
					..vRP.format(parseInt(gallons[processId][5])).."x "..vRP.itemNameList("chiclete").."<br>"
					..vRP.format(parseInt(gallons[processId][6])).."x "..vRP.itemNameList("soda")..".",5000)
				end
			elseif parseInt(gallons[processId][7]) >= 100 then
				if vRP.computeInvWeight(user_id) + vRP.itemWeightList("lean") * parseInt(gallons[processId][4]) <= vRP.getBackpack(user_id) then
					gallons[processId][7] = 0
					TriggerClientEvent("vrp_lean:labUpdate",-1,gallons)
					vRP.giveInventoryItem(user_id,"lean",parseInt(gallons[processId][4]),true)
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
	TriggerClientEvent("vrp_lean:labUpdate",source,gallons)
end)