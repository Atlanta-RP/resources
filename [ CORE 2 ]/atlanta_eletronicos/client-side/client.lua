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
Tunnel.bindInterface("atlanta_eletronicos",cnVRP)
vSERVER = Tunnel.getInterface("atlanta_eletronicos")
vRPclient = Tunnel.getInterface("vRP")

local locais = {
	--{coordX,coordY,coordZ,ItemPremio,Quantidade,ativo,timeout}
	{751.06,1273.93,360.3,"fios",math.random(2,4),true,60000},
	{740.78,1276.11,360.3,"fios",1,true,30000},
	{765.97,1273.5,360.3,"fios",math.random(2,4),true,60000},
}



Citizen.CreateThread(function()
	local selecao = locais[1]
	while selecao[6] do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(selecao[1],selecao[2],selecao[3]))
			if distance <= 8 then
				timeDistance = 4
				DrawText3D(selecao[1],selecao[2],selecao[3],"~g~E~w~   COLETAR COMPONENTES")
				--DrawMarker(36,v[1],v[2],v[3]+0.3,0,0,0,1.0,0,90.0,1.04,1.04,1.04,100,0,100,100,true,false,false,false)
				DrawMarker(2,selecao[1],selecao[2],selecao[3]+0.30,0,0,0,0,0.0,170.0,0.6,0.8,0.50,100, 1, 200,100,0,0,0,1)
				if distance <= 1.5 and IsControlJustPressed(1,38) then
					if vSERVER.farmFios(selecao[4],selecao[5]) then
						selecao[6] = false
						Citizen.Wait(selecao[7])
						selecao[6] = true
					end
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)

Citizen.CreateThread(function()
	local selecao = locais[2]
	while selecao[6] do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(selecao[1],selecao[2],selecao[3]))
			if distance <= 8 then
				timeDistance = 4
				DrawText3D(selecao[1],selecao[2],selecao[3],"~g~E~w~   COLETAR COMPONENTES")
				--DrawMarker(36,v[1],v[2],v[3]+0.3,0,0,0,1.0,0,90.0,1.04,1.04,1.04,100,0,100,100,true,false,false,false)
				DrawMarker(2,selecao[1],selecao[2],selecao[3]+0.30,0,0,0,0,0.0,170.0,0.6,0.8,0.50,100, 1, 200,100,0,0,0,1)
				if distance <= 1.5 and IsControlJustPressed(1,38) then
					if vSERVER.farmFios(selecao[4],selecao[5]) then
						selecao[6] = false
						Citizen.Wait(selecao[7])
						selecao[6] = true
					end
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)


Citizen.CreateThread(function()
	local selecao = locais[3]
	while selecao[6] do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(selecao[1],selecao[2],selecao[3]))
			if distance <= 8 then
				timeDistance = 4
				DrawText3D(selecao[1],selecao[2],selecao[3],"~g~E~w~   COLETAR COMPONENTES")
				--DrawMarker(36,v[1],v[2],v[3]+0.3,0,0,0,1.0,0,90.0,1.04,1.04,1.04,100,0,100,100,true,false,false,false)
				DrawMarker(2,selecao[1],selecao[2],selecao[3]+0.30,0,0,0,0,0.0,170.0,0.6,0.8,0.50,100, 1, 200,100,0,0,0,1)
				if distance <= 1.5 and IsControlJustPressed(1,38) then
					if vSERVER.farmFios(selecao[4],selecao[5]) then
						selecao[6] = false
						Citizen.Wait(selecao[7])
						selecao[6] = true
					end
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
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

