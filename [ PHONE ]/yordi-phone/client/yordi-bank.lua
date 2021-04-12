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
vBANK = Tunnel.getInterface("vrp_bank")

local bank = 0

function setBank (value)
    bank = value
    SendNUIMessage({event = 'updateBankbalance', banking = bank})
end

RegisterNetEvent('vrp_bank:updates12ds')
AddEventHandler('vrp_bank:updates12ds', function(playerData)
   local bankmoney = vBANK.requestBank()
   if bankmoney then
      setBank(bankmoney)
   end
end)

function cnVRP.requestBankClient()
   local bankmoney = vBANK.requestBank()
   if bankmoney then
      return setBank(bankmoney)
   end
end



RegisterNUICallback('bankTransfer', function(data)
      TriggerServerEvent('yordi-phone:bankTransfer', data.to, data.amount)
      cnVRP.requestBankClient()
end)

RegisterNetEvent("yordi-phone:fatura_getBilling")
AddEventHandler("yordi-phone:fatura_getBilling", function(getFatura)
      SendNUIMessage({event = 'getFatura', getFatura = getFatura})
      cnVRP.requestBankClient()
end)

RegisterNUICallback('getFaturaBilling', function(data, cb)
      cnVRP.requestBankClient()
end)

RegisterNUICallback('payFatura', function(data, cb)
      payFatura(data.id, data.sender, data.amount, data.target)
      cnVRP.requestBankClient()
      cb()
end)

function payFatura(id, sender, amount, target)
      TriggerServerEvent('yordi-phone:payFatura', id, sender, amount, target)
      cnVRP.requestBankClient()
end