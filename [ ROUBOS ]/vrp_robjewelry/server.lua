local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
local idgens = Tools.newIDGenerator()
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
func2 = Tunnel.getInterface("vrp_robjewelry")
func = {}
Tunnel.bindInterface("vrp_robjewelry",func)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
local timers = 0
local andamento = false
local roubando = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKJEWELRY
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkJewelry(x,y,z,h,sec,tipo)
	local source = source
	local user_id = vRP.getUserId(source)
	local policia = vRP.getUsersByPermission("policia.permissao")
	if user_id then
		if #policia <= 4then
			TriggerClientEvent("Notify",source,"aviso","Número insuficiente de <b>Policiais no momento</b>.")
		elseif (os.time()-timers) <= 3600 then
			TriggerClientEvent("Notify",source,"aviso","A <b>Joalheria</b> não se recuperou do ultimo <b>roubo</b>, aguarde <b>"..vRP.format(parseInt((3600-(os.time()-timers)))).." segundos</b> até que o sistema seja <b>restaurado</b>.")
		else
			if vRP.getInventoryItemAmount(user_id,"pendrive") >= 1 and not roubando then
				vRPclient._playAnim(source,false,{{"anim@heists@prison_heistig1_p1_guard_checks_bus","loop"}},true)
				TriggerClientEvent('iniciandojewelry',source,x,y,z,h,sec,tipo,true)
				roubando = true
				SetTimeout(sec*1000,function()
					segundos = 600
					TriggerClientEvent('iniciandojewelrystart',source)
				end)
			else
				TriggerClientEvent("Notify",source,"importante","Precisa de um <b>Pendrive</b> para hackear as <b>câmeras</b> de <b>segurança</b>.")
			end
		end
	end
end

RegisterNetEvent("jewelrystart")
AddEventHandler("jewelrystart",function()
	timers = os.time()
	andamento = true
	TriggerClientEvent('iniciandojewelry',source,x,y,z,h,sec,tipo,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function func.callPolice(x,y,z)
	local source = source
	local user_id = vRP.getUserId(source)
	TriggerClientEvent("vrp_sound:fixed",-1,source,x,y,z,100,'alarm',0.1)
	TriggerClientEvent("jewelry:bankNews",-1, 15)
	local policia = vRP.getUsersByPermission("policia.permissao")
	for l,w in pairs(policia) do
		local player = vRP.getUserSource(parseInt(w))
		if player then
			async(function()
				local ids = idgens:gen()
				vRPclient.playSound(player,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
				blips[ids] = vRPclient.addBlip(player,x,y,z,1,59,"Roubo a Joalheria",0.5,true)
				TriggerClientEvent('chatMessage',player,"911",{65,130,255},"O roubo começou na ^1Joalheria^0, dirija-se até o local e intercepte os Assaltantes.")
				SetTimeout(60000,function() vRPclient.removeBlip(player,blips[ids]) idgens:free(ids) end)
			end)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RETURNJEWELRY
-----------------------------------------------------------------------------------------------------------------------------------------
function func.returnJewelry()
	return andamento
end

function func.returnJewelry2()
	return roubando
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMEROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
local timers = {}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(timers) do
			if v > 0 then
				timers[k] = v - 1
			end
		end
		if andamento then
			segundos = segundos - 1
			if segundos <= 0 then
				timers = {}
				andamento = false
				roubando = false
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("jewelrysetmodel")
AddEventHandler("jewelrysetmodel",function(x,y,z,prop1,prop2)
	TriggerClientEvent("jewelrysetmodel",-1,x,y,z,prop1,prop2)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKJEWELS
-----------------------------------------------------------------------------------------------------------------------------------------
local jewels = {
	[1] = { item = "relogioroubado", nome = "Relogio(s) Roubado(s)" },
	[2] = { item = "pulseiraroubada", nome = "Pulseira(s) Roubada(s)" },
	[3] = { item = "anelroubado", nome = "Anel(s) Roubado(s)" },
	[4] = { item = "colarroubado", nome = "Colar(s) Roubado(s)" },
	[5] = { item = "brincoroubado", nome = "Brinco(s) Roubado(s)" }
}

function func.checkJewels(id,x,y,z,xplayer,yplayer,zplayer,heading,prop1,prop2,tipo)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if timers[id] == 0 or not timers[id] then
			timers[id] = 600
			TriggerClientEvent('jewelryroubo',source,6,tipo,true,x,y,z,prop1,prop2,id)
			func2.setCoord(source,xplayer,yplayer,zplayer,heading)
			local quantidade = math.random(10,14)
			local joia = jewels[math.random(5)]
			if id == 4 or id == 13 or id == 14 or id == 17 then
			    SetTimeout(2000,function()
				    vRPclient.setStandBY(source,parseInt(60))
				    vRP.giveInventoryItem(user_id,joia.item,quantidade)
				    TriggerClientEvent("Notify",source,"sucesso","Roubou <b>"..quantidade.."x "..joia.nome.."</b>")
			    end)
			else
				SetTimeout(3100,function()
				    vRPclient.setStandBY(source,parseInt(60))
				    vRP.giveInventoryItem(user_id,joia.item,quantidade)
				    TriggerClientEvent("Notify",source,"sucesso","Roubou <b>"..quantidade.."x "..joia.nome.."</b>")
			    end)
			end
		else
			TriggerClientEvent("Notify",source,"aviso","O balcão está vazio, aguarde <b>"..vRP.format(parseInt(timers[id])).." segundos</b> até que a loja se recupera do ultimo <b>roubo</b>.")
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETOLDMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
function func.returnJewels(id,x,y,z,prop1,prop2)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if timers[id] == 0 or not timers[id] and contagem == 0 then
			func2.setModel(-1,x,y,z,prop1,prop2)
			contagem = 600
	    end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMECONTAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
local contagem = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if contagem >= 1 then
			contagem = contagem - 1
			if contagem <= 0 then
				contagem = false
			end
		end
	end
end)
