local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("farm_municoescorleone")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0 
local CoordenadaX, CoordenadaY, CoordenadaZ = -1641.45,-3013.61,-78.14
local processo = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = -3068.87, ['y'] = 3328.0, ['z'] = 8.8 }, 
	[2] = { ['x'] = 439.38, ['y'] = 3561.53, ['z'] = 33.24 }, 
	[3] = { ['x'] = 1601.67, ['y'] = 3562.69, ['z'] = 35.37 }, 
	[4] = { ['x'] = 1310.24, ['y'] = 4386.92, ['z'] = 41.23 }, 
	[5] = { ['x'] = 1943.85, ['y'] = 4647.04, ['z'] = 40.63 }, 
	[6] = { ['x'] = 1736.61, ['y'] = 6423.25, ['z'] = 34.39 }, 
	[7] = { ['x'] = -758.16, ['y'] = 5600.44, ['z'] = 33.83 }, 
	[8] = { ['x'] = 264.26, ['y'] = 3096.01, ['z'] = 42.79 }, 
	[9] = { ['x'] = 2867.29, ['y'] = 1506.66, ['z'] = 24.57 }, 
	[10] = { ['x'] = 2544.2, ['y'] = 377.0, ['z'] = 108.62 }, 
	[11] = { ['x'] = 2505.42, ['y'] = -333.5, ['z'] = 93.0 }, 
	[12] = { ['x'] = 1126.87, ['y'] = -1302.52, ['z'] = 34.73 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local uru = 1000
		if not servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX,CoordenadaY,CoordenadaZ)
			local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,cdz,x,y,z,true)
			if distance <= 3 then
				uru = 2
				DrawMarker(21,CoordenadaX,CoordenadaY,CoordenadaZ-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
				if distance <= 1.2 then
					drawTxt("PRESSIONE  ~r~E~w~  PARA INCIAR A COLETA",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and emP.checkPermission() then
						servico = true
						selecionado = math.random(12)
						CriandoBlip(locs,selecionado)
						TriggerEvent("Notify","sucesso","Você entrou em serviço.")
					end
				end
			end
		end
		Wait(uru)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTREGAS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local uru = 1000
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)
			if distance <= 3 then
				uru = 2 
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
				if distance <= 1.2 then
					uru = 2
					drawTxt("PRESSIONE  ~r~E~w~  PARA COLETAR POLVORA",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and emP.checkPermission() and not IsPedInAnyVehicle(ped) then
						if emP.checkPayment() then
							TriggerEvent('cancelando',true)
							FreezeEntityPosition(ped, true)
							RemoveBlip(blips)
							backentrega = selecionado
							processo = true
							segundos = 10
							vRP._playAnim(false,{{"anim@heists@ornate_bank@grab_cash_heels","grab"}},true)
							while true do
								if backentrega == selecionado then
									selecionado = math.random(12)
								else
									break
								end
								Citizen.Wait(1)
							end
							CriandoBlip(locs,selecionado)
						end
					end
				end
			end
		end
		Wait(uru)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local uru = 1000
		if servico then
			if IsControlJustPressed(0,168) then
				uru = 2
				servico = false
				RemoveBlip(blips)
				TriggerEvent("Notify","aviso","Você saiu de serviço.")
				if segundos > 0 and processo then
					local ped = PlayerPedId()
					processo = false
					FreezeEntityPosition(ped, false)
					TriggerEvent('cancelando',false)
					ClearPedTasks(ped)
				end
			end
			if processo then
				uru = 2
				local ped = PlayerPedId()
				if (not IsEntityPlayingAnim(ped, "anim@heists@ornate_bank@grab_cash_heels","grab", 3)) then
					vRP.playAnim(false,{{"anim@heists@ornate_bank@grab_cash_heels","grab"}},true)
				end
			end
		end
		Citizen.Wait(uru)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local uru = 1000
		if segundos > 0 then
			segundos = segundos - 1
			if segundos == 0 then
				uru = 2
				local ped = PlayerPedId()
				processo = false
				FreezeEntityPosition(ped, false)
				TriggerEvent('cancelando',false)
				ClearPedTasks(ped)
			end
		end
		Citizen.Wait(uru)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end
function CriandoBlip(locs,selecionado)
	blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blips,1)
	SetBlipColour(blips,5)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Coletar Peças de Armas")
	EndTextCommandSetBlipName(blips)
end