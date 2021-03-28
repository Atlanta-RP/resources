local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
func = Tunnel.getInterface("jw_carteiro_coletar")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local processo = false
local segundos = 0
local CoordenadaX = -424.08
local CoordenadaY = -2789.52
local CoordenadaZ = 6.39
-----------------------------------------------------------------------------------------------------------------------------------------
-- PROCESSO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local uru = 1000
		if not processo then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX,CoordenadaY,CoordenadaZ)
			local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,cdz,x,y,z,true)
			if distance <= 3 then
				uru = 4
				DrawMarker(21,-424.08,-2789.52,6.39-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
				if distance <= 1.2 then
					uru = 4
					drawTxt("PRESSIONE  ~r~E~w~  PARA EMPACOTAR ENCOMENDA",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and func.checkPayment() then
						TriggerEvent('cancelando',true)
						vRP._CarregarObjeto("anim@heists@box_carry@","idle","hei_prop_heist_box",15,28422)
						processo = true
						segundos = 8
						SetTimeout(7500,function()
							vRP._DeletarObjeto()
							vRP._stopAnim(false)
							--TriggerServerEvent("trydeleteobj",ObjToNet("hei_prop_heist_box"))
							func.checkPayment()
						end)
					end
				end
			end
		end
		if processo then
			uru = 4
			drawTxt("AGUARDE ~g~"..segundos.."~w~ SEGUNDOS ATÉ FINALIZAR O EMPACOTAMENTO",4,0.5,0.93,0.50,255,255,255,180)
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