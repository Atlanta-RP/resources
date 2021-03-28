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
Tunnel.bindInterface("vrp_bank",cnVRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.requestBank()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return vRP.getBank(user_id)
	end
end


AddEventHandler("vRP:playerSpawn",function(user_id,source)
	TriggerClientEvent("vrp_bank:updates12ds",source)
end)

RegisterServerEvent('yordi-phone:bankTransfer')
AddEventHandler('yordi-phone:bankTransfer', function(to, amount)
  local _source = source
  local xPlayer = vRP.getUserId(_source)
  local zPlayer = vRP.getUserId(to)
  local balance = 0


    if zPlayer ~= nil then
      if vRP.paymentBank(xPlayer,parseInt(amount)) then
				vRP.addBank(zPlayer,parseInt(amount))
        TriggerClientEvent('notify:client', _source,"aviso","Voce enviou dinheiro pelo app do banco")
          TriggerClientEvent('notify:client', zPlayer,"aviso","Voce recebeu dinheiro")
      end
    end

end)