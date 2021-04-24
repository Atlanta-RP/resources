-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
vTASKBAR = Tunnel.getInterface("vrp_taskbar")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("atlanta_eletronicos",cnVRP)
vCLIENT = Tunnel.getInterface("atlanta_eletronicos")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------

function cnVRP.farmFios(item,quantidade)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"DigitalDen") then
			if vRP.getInventoryItemAmount(user_id,"lockpick") >= 1 then
				vRPclient.stopActived(source)
				--vCLIENT.blockButtons(source,true)
				vRPclient.playAnim(source,false,{"missheistfbi3b_ig7","lift_fibagent_loop"},false)
				local taskResult = vTASKBAR.taskLockpick(source)
				if taskResult then
					quebrarLockPick(user_id)
					vRP.upgradeStress(user_id,4)
					if vRP.computeInvWeight(user_id) + vRP.itemWeightList(item) * quantidade  <= vRP.getBackpack(user_id) then
						TriggerClientEvent("Notify",source,"sucesso","Você coletou "..quantidade.."x "..vRP.itemNameList(item),5000)
						vRP.giveInventoryItem(user_id,item,quantidade,true)
						vRPclient._stopAnim(source,false)
						return true
					else
						TriggerClientEvent("Notify",source,"negado","Mochila cheia.",5000)
						vRPclient._stopAnim(source,false)
						return false
					end
				else
					quebrarLockPick(user_id)
					TriggerClientEvent("Notify",source,"negado","Falha ao coletar os componentes.",5000)
					vRPclient._stopAnim(source,false)
					return false
				end
			else
				TriggerClientEvent("Notify",source,"negado","Você precisa de um lockpick para isso.",1000)
				return false
			end
		end
	end
end

function quebrarLockPick(user_id)
	if parseInt(math.random(1000)) >= 950 then
		vRP.removeInventoryItem(user_id,"lockpick",1,true)
	end
end

function cnVRP.cancelarAnim()
	vRPclient._stopAnim(source,false)
end
