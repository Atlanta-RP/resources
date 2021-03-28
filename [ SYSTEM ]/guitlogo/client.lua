AddEventHandler('onClientMapStart', function()
  Citizen.CreateThread(function()
    local display = true

    TriggerEvent('logo:disp', true)
  end)
end)

RegisterNetEvent('logo:disp')
AddEventHandler('logo:disp', function(valor)
  SendNUIMessage({
    type = "logo",
    display = valor
  })
end)

