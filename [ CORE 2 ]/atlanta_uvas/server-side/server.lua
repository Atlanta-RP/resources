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
Tunnel.bindInterface("atlanta_uvas",cnVRP)
vCLIENT = Tunnel.getInterface("atlanta_uvas")
--vInvServ = Tunnel.getInterface("vrp_inventory")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local gallons = {
	{ -1850.44,2090.7,139.8,0,0,0,0 },
	{ -1843.42,2095.0,139.07,0,0,0,0 },
	{-1833.93,2100.48,138.02,0,0,0,0 },
	{-1841.58,2106.08,138.33,0,0,0,0 },
	{-1848.22,2102.82,138.6,0,0,0,0 },
	{-1859.49,2097.56,138.82,0,0,0,0 },

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
		TriggerClientEvent("atlanta_uvas:labUpdate",-1,gallons)
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
				TriggerClientEvent("atlanta_uvas:labUpdate",-1,gallons)
				vRPclient._playAnim(source,true,{"anim@move_m@trash","pickup"},true)
			elseif parseInt(gallons[processId][7]) >= 100 then
				local quantidade =parseInt(math.random(6))
				if vRP.computeInvWeight(user_id) + vRP.itemWeightList("uva") * quantidade  <= vRP.getBackpack(user_id) then
					gallons[processId][7] = 0
					TriggerClientEvent("Notify",source,"aviso","Você coletou "..quantidade.."x "..vRP.itemNameList("uva"),5000)
					TriggerClientEvent("atlanta_uvas:labUpdate",-1,gallons)
					vRP.giveInventoryItem(user_id,"uva",quantidade,true)
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
	TriggerClientEvent("atlanta_uvas:labUpdate",source,gallons)
end)

function cnVRP.cancelarAnim()
	vRPclient._stopAnim(source,false)
end
