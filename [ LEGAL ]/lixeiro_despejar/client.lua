local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("lixeiro_despejar")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local processo = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROCESSO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local uru = 1000
		if not processo then
			local ped = PlayerPedId()
			local distancia = GetDistanceBetweenCoords(GetEntityCoords(ped),-329.45,-1566.93,25.23)
			local vehicle = GetPlayersLastVehicle()
			if distancia <= 3 and GetEntityModel(vehicle) == -1255698084 then
				uru = 4
				DrawMarker(22,-329.45,-1566.93,25.23-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,232,67,147,100,1,0,0,1)
				if distancia <= 1.5 then
					uru = 4
					drawTxt("PRESSIONE  ~r~E~w~  PARA DESPEJAR O LIXO",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						if emP.checkPayment() then
							TriggerEvent('cancelando',true)
							vRP._CarregarObjeto("anim@heists@narcotics@trash","throw_ranged_a","prop_cs_rub_binbag_01",50,28422)
							processo = true
							segundos = 3
							SetTimeout(2000,function()
								vRP._DeletarObjeto()
								vRP._stopAnim(false)
								TriggerServerEvent("trydeleteobj",ObjToNet("prop_cs_rub_binbag_01"))
							end)
						end
					end
				end
			end
		end
		if processo then
			uru = 4
			drawTxt("AGUARDE ~g~"..segundos.."~w~ SEGUNDOS ATÉ FINALIZAR O DESPEJO DO LIXO",4,0.5,0.93,0.50,255,255,255,180)
		end
		Citizen.Wait(uru)
	end
end)
Citizen.CreateThread(function()
	while true do
		local uru = 1000
		if processo then
			uru = 4
			if segundos > 0 then
				segundos = segundos - 1
				if segundos == 0 then
					processo = false
					TriggerEvent('cancelando',false)
				end
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