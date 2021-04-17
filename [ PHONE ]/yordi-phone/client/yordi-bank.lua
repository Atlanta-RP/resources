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
vBANK = Tunnel.getInterface("atlanta_bank")

local bank = 0

function setBank (value)
    bank = value
    SendNUIMessage({event = 'updateBankbalance', banking = bank})
end

RegisterNetEvent('atlanta_bank:updates12ds')
AddEventHandler('atlanta_bank:updates12ds', function(playerData)
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
      print("teste")
      SendNUIMessage({event = 'getFatura', getFatura = getFatura})
      cnVRP.requestBankClient()
end)

-- vRP.getInvoice

RegisterNUICallback('getFatura', function(data, cb)
      payFatura(data.id, data.sender, data.amount, data.target)
      cnVRP.requestBankClient()
      cb()
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