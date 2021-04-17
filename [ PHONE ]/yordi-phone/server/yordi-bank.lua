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
Tunnel.bindInterface("atlanta_bank",cnVRP)
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
	TriggerClientEvent("atlanta_bank:updates12ds",source)
end)

RegisterServerEvent('yordi-phone:bankTransfer')
AddEventHandler('yordi-phone:bankTransfer', function(to, amount)
  --print(source)
  local _source = source
  local xPlayer = vRP.getUserId(_source)
  local zPlayer = to
  local balance = 0
  --print(zPlayer)

    if zPlayer ~= nil then
      if vRP.paymentBank(xPlayer,parseInt(amount)) then
				vRP.addBank(zPlayer,parseInt(amount))
        TriggerClientEvent('notify:client', _source,"aviso","Voce enviou dinheiro pelo app do banco")
          vRP.execute("vRP/registrar_transferencia",{ remetente = xPlayer, destinatario = zPlayer,valor = amount,data = os.date("%d/%m/%Y %X") })
        TriggerClientEvent('notify:client', zPlayer,"aviso","Voce recebeu dinheiro")
      end
    end

end)