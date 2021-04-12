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
Tunnel.bindInterface("atlanta_uvas",cnVRP)
vSERVER = Tunnel.getInterface("atlanta_uvas")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local gallons = {}
local frozen = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for k,v in pairs(gallons) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 5.5 then
					DrawMarker(21,v[1],v[2],v[3]+0.3,0,0,0,180.0,0,145.0,1.04,1.04,1.04,100,0,100,100,0,0,0,0)
					timeDistance = 4
					if v[7] >= 100 then
						DrawText3D(v[1],v[2],v[3]+0.5,"~g~E~w~   PRONTO PARA RECOLHER")
					elseif v[7] > 90 and v[7] < 100 then
						toggleFreeze(false)
						vSERVER.cancelarAnim()
					elseif v[7] > 0 then
						DrawText3D(v[1],v[2],v[3]+0.5,"~y~"..v[7].."%~w~  REUNINDO AS UVAS")
						toggleFreeze(true)
					else
						-- print(v[4])
						DrawText3D(v[1],v[2],v[3]+0.5,"~g~E~w~   COLETAR UVAS")
					end

					if IsControlJustPressed(1,38) and distance <= 0.8 then
						vSERVER.checkStatus(k)
					end
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEEXISTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("atlanta_uvas:labUpdate")
AddEventHandler("atlanta_uvas:labUpdate",function(status)
	gallons = status
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



-- Freeze (stops player from moving)
function toggleFreeze(status)
   FreezeEntityPosition(GetPlayerPed(-1), status)
end