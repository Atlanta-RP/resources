-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local Tools = module("vrp","lib/Tools")

local lideres = {
    {"Police","PolMaster","waitPolice"},
    {"Mechanic","MecMaster","Mechanic"},
    {"Paramedic","ParMaster","waitParamedic"},
    {"Groove","GrooveMaster","Groove"},
    {"Ballas","BallasMaster","Ballas"},
    {"Vagos","VagosMaster","Vagos"},
    {"Mafia","MafiaMaster","Mafia"},
    {"Dk","DkMaster","Dk"},
    {"TheLost","TheLostMaster","TheLost"},
    {"BeanMachine","BeanMachineMaster","BeanMachine"},
    {"BeanMachine2","BeanMachine2Master","BeanMachine2"},
    {"BagShop","BagShopMaster","BagShop"},
    {"Judiciario","Juiz","Judiciario"},
    {"DigitalDen","DigitalDenMaster","DigitalDen"},
    {"Vultur","VulturMaster","Vultur"},

}

-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("add",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if parseInt(args[1]) > 0 then
            for k,v in pairs(lideres) do
                if args[2] == v[1] then
                    if vRP.hasPermission(user_id,v[2]) then
                        if vRP.request(source,"Deseja contratar o cidadão de passaporte: <b>"..parseInt(args[1]).."</b> para <b>"..args[2].."</b>?",30) then
                            --vRP.execute("vRP/cle_group",{ user_id = parseInt(args[1]) })
                            vRP.execute("vRP/add_group",{ user_id = parseInt(args[1]), permiss = tostring(v[3]) })
                            vRP.insertPermission(parseInt(args[1]),tostring(v[3]))
                            TriggerClientEvent("Notify",source,"sucesso","Passaporte <b>"..vRP.format(parseInt(args[1])).."</b> adicionado com sucesso.",5000)
                        end
                    else
                        TriggerClientEvent("Notify",source,"negado","["..args[2].."] Você precisa ser líder para isso.",5000)
                    end
                end
            end
		end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("rem",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if parseInt(args[1]) > 0 then
            for k,v in pairs(lideres) do
                if args[2] == v[1] then
                    if vRP.hasPermission(user_id,v[2]) then
                        vRP.execute("vRP/cle_group",{ user_id = parseInt(args[1]) })
                        TriggerClientEvent("Notify",source,"sucesso","Passaporte <b>"..vRP.format(parseInt(args[1])).."</b> removido com sucesso.",5000)
                    else
                        TriggerClientEvent("Notify",source,"negado","["..args[2].."] Você precisa ser líder para isso.",5000)
                    end
                end
            end
		end
	end
end)