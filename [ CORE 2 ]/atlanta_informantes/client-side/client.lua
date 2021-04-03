-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("atlanta_informantes",cnVRP)
vSERVER = Tunnel.getInterface("atlanta_informantes")

-----------------------------------------------------------------------------------------------------------------------------------------
-- NPC no Blip Crafting Ilegal
-----------------------------------------------------------------------------------------------------------------------------------------
local pedList = {
	{
		["x"] = 367.93, ["y"] = 272.9, ["z"] = 94.2, ["h"] = 116.38,
		["hash"] = 0x5AA42C21,
		["hash2"] = "g_f_y_vagos_01",
		["introducao"] = "Eae meu bem, tenho um contato que pode te passar uns lockpicks...<br>Ta interessado ? 10 rolinhos apenas.",
		["marcadorX"] = 736.34, ["marcadorY"] = 2585.57, ["marcadorZ"] = 75.53,
		["valor"] = 10,
		["resposta"] = "Ta ai docinho, só chegar lá e procurar pelo Fred, é o nerd da gravadora",
	}
	
}



Citizen.CreateThread( function()
	while true do
		local timeDistance = 500
		local pedUsuario = PlayerPedId()
		for k, v in pairs(pedList) do
			local coords = GetEntityCoords(pedUsuario)
			local distance = #(coords - vector3(v.x, v.y, v.z))
			if distance <= 3 then
				timeDistance = 4
				DrawText3D(v.x, v.y, v.z,"~g~E~w~   INFORMANTE")
				if distance <= 1.5 and IsControlJustPressed(1,38) then
					if vSERVER.pergunta(v.introducao,v.valor,v.resposta) then
					marcarNoMapa(v.marcadorX,v.marcadorY,v.marcadorZ)
					end
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)

function marcarNoMapa(x,y,z)
	SetNewWaypoint(x,y)
end

Citizen.CreateThread( function()
	for k, v in pairs(pedList) do
		RequestModel(GetHashKey(v.hash2))

		while not HasModelLoaded(GetHashKey(v.hash2)) do
			Citizen.Wait(100)
		end

		local ped = CreatePed(4, v.hash, v.x, v.y, v.z -1, v.h, false, true)		
		FreezeEntityPosition(ped, true)
		SetEntityInvincible(ped, true)
		SetBlockingOfNonTemporaryEvents(ped, true)
	end
end)




function teste(teste)
	print(teste)
end
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
	local factor = (string.len(text))/350
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,100)
	--print("teste")
end