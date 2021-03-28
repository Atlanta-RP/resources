Citizen.CreateThread(function()
    while true do
        SetWeatherTypePersist("CLEAR")
            SetWeatherTypeNowPersist("CLEAR")
            SetWeatherTypeNow("CLEAR")
           SetOverrideWeather("CLEAR")
        Citizen.Wait(7)
    end
end)