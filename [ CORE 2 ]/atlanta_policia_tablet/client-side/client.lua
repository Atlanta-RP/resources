-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("atlanta_policia_tablet",cRP)
vSERVER = Tunnel.getInterface("atlanta_policia_tablet")
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALIDADES
-----------------------------------------------------------------------------------------------------------------------------------------
local localidades = {
	{ 359.82,-1599.2,29.3 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)

	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for k,v in pairs(localidades) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 2 then
					timeDistance = 4
					DrawText3D(v[1],v[2],v[3],"~g~E~w~   ABRIR SISTEMA")
					if IsControlJustPressed(1,38) --[[ and vSERVER.requestWanted()]] then				
						SetNuiFocus(true,true)
						SendNUIMessage({ action = "showMenu" })
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)



-----------------------------------------------------------------------------------------------------------------------------------------
-- BANKCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("bankClose",function(data)
	-- vRP._stopAnim(true)
	TriggerServerEvent("vrp_inventory:Cancel")
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- requestUserName
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestUserName",function(data,cb)
	local resultado = vSERVER.requestUserName()
	while identity do
		Citizen.Wait(10)
	end
	if resultado then
		cb({ resultado = resultado })
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- requestHistoricoCriminal
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestHistoricoCriminal",function(data,cb)	
	local nomeIndividuo = vSERVER.getUserName(data.idPessoaBuscada)
	
	local resultado = vSERVER.requestHistoricoCriminal(data.idPessoaBuscada)
	while not resultado do
		resultado = vSERVER.requestHistoricoCriminal(data.idPessoaBuscada)
		Citizen.Wait(10)
	end

	if resultado then
		cb({ resultado = resultado, nomeIndividuo = nomeIndividuo })
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- requestHistoricoMultas
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestHistoricoMultas",function(data,cb)	
	local nomeIndividuo = vSERVER.getUserName(data.idPessoaBuscada)
	
	local resultado = vSERVER.requestHistoricoMultas(data.idPessoaBuscada)
	while not resultado do
		resultado = vSERVER.requestHistoricoMultas(data.idPessoaBuscada)
		Citizen.Wait(10)
	end

	if resultado then
		cb({ resultado = resultado, nomeIndividuo = nomeIndividuo })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP_PANK:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("atlanta_policia_tablet:Updates12ds")
AddEventHandler("atlanta_policia_tablet:Updates12ds",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,100)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 400
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,100)
end

RegisterNetEvent('atlanta_policia_tablet:abrirTablet')
AddEventHandler('atlanta_policia_tablet:abrirTablet',function()
	vRP.createObjects("amb@code_human_in_bus_passenger_idles@female@tablet@base","base","prop_cs_tablet",50,28422)
	SetNuiFocus(true,true)
	SendNUIMessage({ action = "showMenu" })
end)

