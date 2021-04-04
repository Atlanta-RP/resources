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
		["itemTroca"] = "dollars2",
		["resposta"] = "Ta ai docinho, só chegar lá e procurar pelo Fred, é o nerd da gravadora",
		["respostaNegativa"] = "Ta doido filho ? Só volte aqui quando tiver o que eu quero!",
	},
	{
		["x"] = 2558.91, ["y"] = 288.85, ["z"] = 108.61, ["h"] = 87.01,
		["hash"] = 0x039677BD,
		["hash2"] = "cs_jimmyboston",
		["introducao"] = "Fala guerreiro, conheço um cara que pode te vender umas armas no precinho...<br>Ta interessado ? 10 rolinhos apenas.",
		["marcadorX"] = 1787.7, ["marcadorY"] = 3896.81, ["marcadorZ"] = 34.39,
		["valor"] = 10,
		["itemTroca"] = "dollars2",
		["resposta"] = "Ta na mão, só falar com o Clark, ele é meio esquesito, toma cuidado!",
		["respostaNegativa"] = "Ta querendo me pssar a perna ? rala!",
		
	},
	{
		["x"] = 1008.95, ["y"] = -2531.2, ["z"] = 28.31, ["h"] = 355.99,
		["hash"] = 0x062547E7,
		["hash2"] = "cs_floyd",
		["introducao"] = "Fala irmão, conheço um maluco que mora em uma ilha, ele vende umas paradas estranhas...<br>Ta interessado ? 12 rolinhos apenas.",
		["marcadorX"] = -2168.43, ["marcadorY"] = 5198.36, ["marcadorZ"] = 17.03,
		["valor"] = 12,
		["itemTroca"] = "dollars2",
		["resposta"] = "Ta na mão, cuidado, eu ouvi dizer que ele é um canibal, leve <b>CAMARÕES</b>!! Ele só aceita isso",
		["respostaNegativa"] = "Rala daqui!",
		
	},
	{
		["x"] = -1568.72, ["y"] = -3224.38, ["z"] = 26.34, ["h"] = 149.18,
		["hash"] = 0x65793043,
		["hash2"] = "s_m_y_marine_01",
		["introducao"] = "Fala irmão, conheço um policial que vende umas coisas dos porcos na calada...<br>Ta interessado ? 20 rolinhos apenas.",
		["marcadorX"] = 485.92, ["marcadorY"] = -1529.44, ["marcadorZ"] = 29.29,
		["valor"] = 20,
		["itemTroca"] = "dollars2",
		["resposta"] = "Ta na mão, toma cuidado, é perto da delegacia!",
		["respostaNegativa"] = "Rala daqui!",
		
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
					if vSERVER.pergunta(v.introducao,v.valor,v.resposta,v.itemTroca,v.respostaNegativa) then
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