-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
vRP.user_tables = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("vrp_admin",cnVRP)
vCLIENT = Tunnel.getInterface("vrp_admin")
vHOMES = Tunnel.getInterface("vrp_homes")

local screenshotOptions = {
	encoding = 'png',
	quality = 1
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookadmin = " "
local webhookkick = "SEU HEBHOOK DE KICK"
local webhookfac = " "
local webhookkeys = " "
local webhookcds = " "
local webhookblacklist = "SEU HEBHOOK DE BLACKLIST"
local webhookgive = "SEU HEBHOOK DE GIVE ITEM"
local webhookban = "SEU HEBHOOK DE BANIMENTO"
local webhookadminwl = "SEU HEBHOOK DE TIRAR WL"
local webhookunwl = "SEU HEBHOOK DE WL"
local webhookadmingod = " "
local webhookinfernao = " "
local webhooktroxao = " "
local webhookaddcar = " "

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- KICKALL
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- RegisterCommand("kickall",function(source,args,rawCommand)
-- 	if source == 0 then
-- 		local users = vRP.getUsers()
-- 	    for k,v in pairs(users) do
-- 		   local user_idk = vRP.getUserId(v)
-- 		   TriggerClientEvent("vrp_admin:KickAll",users)
		  
-- 		   vRP.kick(parseInt(user_idk),"Terremoto!")
-- 		end
-- 	end
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("say",function(source,args,rawCommand)
	if source == 0 then
		TriggerClientEvent("Notify",-1,"importante",rawCommand:sub(4).."<br><b>Mensagem enviada por:</b> Governador",15000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	local identity = vRP.getUserIdentity(user_id)
	if identity then
		vCLIENT.setDiscord(source,"#"..user_id.." "..identity.name.." "..identity.name2)
		TriggerClientEvent(source,'active:checkcam',true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('skin',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"Owner") then
		TriggerClientEvent("skinmenu",args[1],args[2])
		TriggerClientEvent("Notify",source,"negado","Voce setou a skin <b>"..args[2].."</b> no passaporte <b>"..parseInt(args[1]).."</b>.",5000)
    end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("item",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") then
			if args[1] and args[2] and vRP.itemNameList(args[1]) ~= nil then
				print(vRP.itemNameList(args[1]))
				vRP.giveInventoryItem(user_id,args[1],parseInt(args[2]),true)
				SendWebhookMessage(webhookgive,"```prolog\n[ID]: "..user_id.."\n[PEGOU]: "..args[1].." \n[QUANTIDADE]: "..parseInt(args[2]).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("debug",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") then
			TriggerClientEvent("ToggleDebug",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("plate",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") or vRP.hasPermission(user_id,"Moderador") and args[1] and args[2] and args[3] then
			vRP.execute("vRP/update_plate_vehicle",{ user_id = parseInt(args[1]), vehicle = args[2], plate = args[3] })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDCAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("addcar",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") and args[1] and args[2] then
			vRP.execute("vRP/add_vehicle",{ user_id = parseInt(args[1]), vehicle = args[2], plate = vRP.generatePlateNumber(), phone = vRP.getPhone(args[1]), work = tostring(false) })
			TriggerClientEvent("Notify",args[1],"importante","Voce recebeu <b>"..args[2].."</b> em sua garagem.",5000)
			TriggerClientEvent("Notify",source,"importante","Adicionou o veiculo: <b>"..args[2].."</b> no ID:<b>"..args[1].."</b.")
		end
	end
end)

RegisterCommand("capuzz",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") and args[1] then
			TriggerClientEvent("vrp_hud:toggleHood",source,args[1])
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NC
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.enablaNoclip()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") or vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Moderador") or vRP.hasPermission(user_id,"Suporte") then
			vRPclient.noClip(source)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kick",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") or vRP.hasPermission(user_id,"Moderador") or vRP.hasPermission(user_id,"Suporte") and parseInt(args[1]) > 0 then
			vRP.kick(parseInt(args[1]),"Você foi expulso da cidade.")
			SendWebhookMessage(webhookkick,"```prolog\n[ID]: "..user_id.."\n[KICKOU]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ban",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") and parseInt(args[1]) > 0 then
			local identity = vRP.getUserIdentity(parseInt(args[1]))
			if identity then
				vRP.execute("vRP/set_banned",{ steam = tostring(identity.steam), banned = 1 })
				SendWebhookMessage(webhookban,"```prolog\n[ID]: "..user_id.." \n[BANIU]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end)

local webhooksuspeito= "https://discord.com/api/webhooks/814295770093715457/p_DlJ9wnNmVjmhJqzOTGZR9LF0BtQht2sdH4nxWhB5MXmZ6dcnuluFJkx01V8E9Gots5"
RegisterServerEvent('LOG:ARMASxis4')
AddEventHandler('LOG:ARMASxis4', function(weapons)
    local user_id = vRP.getUserId(source)
    if user_id~=nil then
		local msg = "**[SUSPEITO SPAWN DE ARMAS] USER_ID [ "..user_id.." ]**"
		local lstweapons = "```Ammo     Weapon\n"
		for _,weapon in pairs(weapons)do
			if(weapon~=nil)then
				local strammo = "[ "..weapon.ammo.." ] "
				lstweapons=lstweapons..strammo..string.rep(" ", 10-string.len(strammo))..string.gsub(weapon.name, "WEAPON_", "").."\n"
			end
		end
		lstweapons = lstweapons.."```"
		msg = msg.."\n"..lstweapons
		PerformHttpRequest(webhooksuspeito, function(err, text, headers) end, 'POST', json.encode({content = msg}), { ['Content-Type'] = 'application/json' })
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("wl",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") or vRP.hasPermission(user_id,"Moderador") or vRP.hasPermission(user_id,"Suporte") then
			vRP.execute("vRP/set_whitelist",{ steam = tostring(args[1]), whitelist = 1 })
			SendWebhookMessage(webhookadminwl,"```prolog\n[ID]: "..user_id.."\n[APROVOU WL]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNWL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("unwl",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") or vRP.hasPermission(user_id,"Moderador") or vRP.hasPermission(user_id,"Suporte") and parseInt(args[1]) > 0 then
			local identity = vRP.getUserIdentity(parseInt(args[1]))
			if identity then
				vRP.execute("vRP/set_whitelist",{ steam = tostring(identity.steam), whitelist = 0 })
				SendWebhookMessage(webhookunwl,"```prolog\n[ID]: "..user_id.."\n[RETIROU WL]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GEMS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("coins",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") and parseInt(args[1]) > 0 and parseInt(args[2]) > 0 then
			local identity = vRP.getUserIdentity(parseInt(args[1]))
			if identity then
				vRP.addGmsId(args[1],args[2])
				TriggerClientEvent("Notify",source,"importante","Coins entregues para "..identity.name.." #"..args[1]..".",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNBAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("unban",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") and parseInt(args[1]) > 0 then
			local identity = vRP.getUserIdentity(parseInt(args[1]))
			if identity then
				vRP.execute("vRP/set_banned",{ steam = tostring(identity.steam), banned = 0 })
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPCDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpcds",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") then
			local fcoords = vRP.prompt(source,"Coordinates:","")
			if fcoords == "" then
				return
			end

			local coords = {}
			for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
				table.insert(coords,parseInt(coord))
			end
			vRPclient.teleport(source,coords[1] or 0,coords[2] or 0,coords[3] or 0)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cds",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") then
			local x,y,z,h = vRPclient.getPositions(source)
			vRP.prompt(source,"Coordinates:",x..","..y..","..z..","..h)
		end
	end
end)

RegisterCommand("cds2",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") then
			local x,y,z,h = vRPclient.getPositions(source)
			vRP.prompt(source,"Cordenadas:","[\"x\"] = "..x..", [\"y\"] = "..y..", [\"z\"] = "..z..", [\"h\"] = "..h.."")
		end
	end
end)

RegisterCommand("cds3",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") then
			local x,y,z,h = vRPclient.getPositions(source)
			vRP.prompt(source,"Cordenadas:","[\"marcadorX\"] = "..x..", [\"marcadorY\"] = "..y..", [\"marcadorZ\"] = "..z)
		end
	end
end)

RegisterCommand("cds4",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") then
			local x,y,z,h = vRPclient.getPositions(source)
			vRP.prompt(source,"Cordenadas:","[\"x\"] = "..x..", [\"y\"] = "..y..", [\"z\"] = "..z..",")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("group",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") then
			local grupo = vRP.query("vRP/get_perms",{ group_name = tostring(args[2]) })
			for k,v in pairs(grupo) do
				TriggerClientEvent("Notify",source,"sucesso","<b>Usuário adicionado ao grupo:</b> "..v.group_name,5000)
				if not vRP.hasPermission(parseInt(args[1]),tostring(args[2])) then
					vRP.insertPermission(parseInt(args[1]),tostring(args[2]))
					vRP.execute("vRP/add_group",{ user_id = parseInt(args[1]), permiss = tostring(args[2]) })
					
				end
			end
			if json.encode(grupo) == '[]' then
				TriggerClientEvent("Notify",source,"negado","<b>Grupo: "..tostring(args[2]).." não existe</b>",5000)
			end			
		end
	else
		TriggerClientEvent("Notify",source,"negado","<b>Usuário não encontrado ou não está online no momento</b>",5000)
	end
	
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ungroup",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") then
			if vRP.hasPermission(parseInt(args[1]),tostring(args[2])) then
				vRP.removePermission(parseInt(args[1]),tostring(args[2]))
				vRP.execute("vRP/del_group",{ user_id = parseInt(args[1]), permiss = tostring(args[2]) })
				TriggerClientEvent("Notify",source,"sucesso","<b>Usuário removido do grupo "..tostring(args[2]).."</b>",5000)
			else
				TriggerClientEvent("Notify",source,"negado","<b>Usuário não tem o grupo "..tostring(args[2]).."</b>",5000)
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("groups",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if args[1] == nil then
			args[1] = user_id
		end
		if vRP.hasPermission(user_id,"Admin") then
			local grupos = vRP.query("vRP/get_perm",{ user_id = parseInt(args[1])})
			local texto = "("..args[1]..") Grupos:<br>"
			for k,v in pairs(grupos) do
				texto = texto..v.permiss.."<br>"
				
			end
			TriggerClientEvent("Notify",source,"aviso","<b>"..texto.."</b>",8000)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tptome",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") or vRP.hasPermission(user_id,"Moderador") and parseInt(args[1]) > 0 then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient.teleport(nplayer,vRPclient.getPositions(source))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpto",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") or vRP.hasPermission(user_id,"Moderador") and parseInt(args[1]) > 0 then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient.teleport(source,vRPclient.getPositions(nplayer))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpway",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") or vRP.hasPermission(user_id,"Moderador") then
			vCLIENT.teleportWay(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMBO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limbo",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRPclient.getHealth(source) <= 101 then
			vCLIENT.teleportLimbo(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hash",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") then
			local vehicle = vRPclient.getNearVehicle(source,7)
			if vehicle then
				vCLIENT.vehicleHash(source,vehicle)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELNPCS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("delnpcs",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") or vRP.hasPermission(user_id,"Moderador")  then
			vCLIENT.deleteNpcs(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tuning",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") then
			TriggerClientEvent("vrp_admin:vehicleTuning",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fix",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") then
			local vehicle,vehNet = vRPclient.vehList(source,11)
			if vehicle then
				TriggerClientEvent("vrp_inventory:repairVehicle",-1,vehNet,true)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limparea",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") then
			local x,y,z = vRPclient.getPositions(source)
			TriggerClientEvent("syncarea",-1,x,y,z,100)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("players",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") or vRP.hasPermission(user_id,"Moderador") or vRP.hasPermission(user_id,"Suporte") then
			local quantidade = 0
			local users = vRP.getUsers()
			for k,v in pairs(users) do
				quantidade = parseInt(quantidade) + 1
			end
			TriggerClientEvent("Notify",source,"importante","<b>Players Conectados:</b> "..quantidade,5000)
		end
	end
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- EMS
--  ----------------------------------------------------------------------------------------------------------------------------------------
 RegisterCommand("ems", function(source,args,rawCommand)
	service = vRP.numPermission("Paramedic")
	local contador = 0
	for k,v in pairs(service) do
		contador = contador + 1
	end
	TriggerClientEvent("Notify",source,"importante","Existem "..contador.." paramedicos na cidade",2000)
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- MECS
-- ----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("mecs", function(source,args,rawCommand)
	service = vRP.numPermission("Mechanic")
	local contador = 0
	for k,v in pairs(service) do
		contador = contador + 1
	end
	TriggerClientEvent("Notify",source,"importante","Existem "..contador.." mecänicos na cidade",2000)
end)
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- PTR
-- ----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ptr", function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.request(source,"Deseja pagar $300 para ver a quantidade de policiais em serviço?",30) then
		if vRP.tryGetInventoryItem(user_id,"dollars",300) then
			service = vRP.numPermission("Police")
			local contador = 0
			for k,v in pairs(service) do
				contador = contador + 1
			end
			TriggerClientEvent("Notify",source,"importante","Existem "..contador.." policias em serviço na cidade",2000)
		else
			TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente na sua mochila.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand("cplayers",function(source,args,rawCommand)
	if source == 0 then
		local quantidade = 0
		local users = vRP.getUsers()
		for k,v in pairs(users) do
			quantidade = parseInt(quantidade) + 1
		end
		print("Players Conectados: "..quantidade)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pon',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"Admin") or vRP.hasPermission(user_id,"Moderador") or vRP.hasPermission(user_id,"Suporte") then
		local users = vRP.getUsers()
		local players = ""
		local quantidade = 0
		for k,v in pairs(users) do
			if k ~= #users then
				players = players..", "
			end
			players = players..k
			quantidade = quantidade + 1
		end
		TriggerClientEvent('chatMessage',source,"TOTAL ONLINE",{1, 136, 0},quantidade)
		TriggerClientEvent('chatMessage',source,"ID's ONLINE",{1, 136, 0},players)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.buttonTxt()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") then
			local x,y,z,h = vRPclient.getPositions(source)
			vRP.updateTxt(user_id..".txt",x..","..y..","..z..","..h)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANNOUNCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("announce",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Admin") then
			local message = vRP.prompt(source,"Message:","")
			if message == "" then
				return
			end

			TriggerClientEvent("Notify",-1,"negado",message.."<br><b>Mensagem enviada por:</b> Governador",15000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("itemall",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") then
			local users = vRP.getUsers()
			for k,v in pairs(users) do
				vRP.giveInventoryItem(parseInt(k),tostring(args[1]),parseInt(args[2]),true)
			end
		end
	end
end)

