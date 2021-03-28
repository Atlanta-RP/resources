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
Tunnel.bindInterface("vrp_bichos",cnVRP)
vCLIENT = Tunnel.getInterface("vrp_bichos")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local bichoSelect = "1"
local registerGames = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BICHOS
-----------------------------------------------------------------------------------------------------------------------------------------
local bichoGames = {
	[1] = "1 - Avestruz",
	[2] = "2 - Águia",
	[3] = "Burro",
	[4] = "Borboleta",
	[5] = "Cachorro",
	[6] = "Cabra",
	[7] = "Carneiro",
	[8] = "Camelo",
	[9] = "Cobra",
	[10] = "Coelho",
	[11] = "Cavalo",
	[12] = "Elefante",
	[13] = "Galo",
	[14] = "Gato",
	[15] = "Jacaré",
	[16] = "Leão",
	[17] = "Macaco",
	[18] = "Porco",
	[19] = "Pavão",
	[20] = "Peru",
	[21] = "Touro",
	[22] = "Tigre",
	[23] = "Urso",
	[24] = "Veado",
	[25] = "Vaca"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
local drawTimers = {
	["10:00:00"] = true,
	["12:00:00"] = true,
	["14:00:00"] = true,
	["16:00:00"] = true,
	["18:00:00"] = true,
	["20:00:00"] = true,
	["22:00:00"] = true,
	["00:00:00"] = true,
	["02:00:00"] = true,
	["04:00:00"] = true,
	["06:00:00"] = true,
	["08:00:00"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMANDS LISTAR OU COMPRAR BICHO VALOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("bichos",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if args[1] == "comprar" then
			if bichoGames[parseInt(args[2])] and parseInt(args[3]) > 0 then
				if registerGames[args[2]] == nil then
					registerGames[args[2]] = {}
				end
				if registerGames[args[2]][tostring(user_id)] == nil then
					if vRP.paymentBank(user_id,parseInt(args[2])) then
						registerGames[args[2]][tostring(user_id)] = parseInt(args[3])
						TriggerClientEvent("Notify",source,"sucesso","Aposta de $<b>"..vRP.format(args[3]).."</b> no <b>"..bichoGames[parseInt(args[2])].."</b>.",4000)
					end
				else
					TriggerClientEvent("Notify",source,"sucesso","Ja existe uma aposta no <b>"..bichoGames[parseInt(args[2])].."</b>.",7000)
				end
			end
		elseif args[1] == "listar" then
			for k, v in pairs(bichoGames) do
				TriggerClientEvent("Notify",source,"aviso",v,10000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread( function()
	while true do
		if drawTimers[os.date("%H:%M:%S")] then
			local winners = 0
			bichoSelect = tostring(math.random(#bichoGames))

			if registerGames[bichoSelect] then
				for k,v in pairs(registerGames[bichoSelect]) do
					winners = winners + 1

					if vRP.getPremium(parseInt(k)) then
						vRP.addBank(parseInt(k), parseInt(v * 2.5))
						TriggerClientEvent("Notify",k,"sucesso","Recebou $<b>"..vRP.format(parseInt(v * 2.5)).."</b> do jogo do <b>Bicho</b>.",7000)
					else
						vRP.addBank(parseInt(k), parseInt(v * 2))
						TriggerClientEvent("Notify",k,"sucesso","Recebou $<b>"..vRP.format(parseInt(v * 2)).."</b> do jogo do <b>Bicho</b>.",7000)
					end
				end
			end
			
			if winners >= 2 then
				TriggerClientEvent("Notify",-1,"sucesso","O resultado do <b>Jogo do Bicho</b> foi <b>"..bichoGames[parseInt(bichoSelect)].."</b>, Os pagamentos foram efetuados aos <b>"..winners.."</b> ganhadores do jogo do <b>bicho</b>.",11000)
			else
				TriggerClientEvent("Notify",-1,"sucesso","O resultado do <b>Jogo do Bicho</b> foi <b>"..bichoGames[parseInt(bichoSelect)].."</b>, Os pagamentos foram efetuados ao <b>1</b> ganhador do jogo do <b>bicho</b>.",11000)
			end

			for i = 1, parseInt(#bichoGames) do
				registerGames[tostring(i)] = {}
			end
		end
		Citizen.Wait(1000)
	end
end)