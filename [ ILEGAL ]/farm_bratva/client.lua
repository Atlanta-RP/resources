local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("farm_bratva")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local CoordenadaX, CoordenadaY, CoordenadaZ  = 1391.91, 1159.14, 114.34
local processo = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = -2217.7, ['y'] = 197.39, ['z'] = 174.61 },
	[2] = { ['x'] = 1020.99, ['y'] = -2434.87, ['z'] = 29.66 },
	[3] = { ['x'] = -870.03, ['y'] = 770.4, ['z'] = 191.73 },
	[4] = { ['x'] = 1160.71, ['y'] = -311.69, ['z'] = 69.28 },
	[5] = { ['x'] = -1098.33, ['y'] = -1678.52, ['z'] = 4.36 },
	[6] = { ['x'] = 1271.05, ['y'] = -683.52, ['z'] = 66.04 },
	[7] = { ['x'] = -1791.46, ['y'] = -683.35, ['z'] = 10.65 },
	[8] = { ['x'] = 1010.27, ['y'] = -2289.5, ['z'] = 30.51 },
	[9] = { ['x'] = 325.39, ['y'] = 537.48, ['z'] = 153.88 },
	[10] = { ['x'] = -1132.06, ['y'] = -1971.97, ['z'] = 13.17 },
	[11] = { ['x'] = -667.68, ['y'] = 84.44, ['z'] = 51.93 },
	[12] = { ['x'] = 259.97, ['y'] = -1741.2, ['z'] = 29.46 }
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
					uru = 2
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
					drawTxt("PRESSIONE  ~r~E~w~  PARA COLETAR AS PEÇAS DE ARMAS",4,0.5,0.93,0.50,255,255,255,180)
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