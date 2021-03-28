local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
func = {}
Tunnel.bindInterface("jw_carteiro_entregas",func)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------

local quantidade = {}
function func.Quantidade()
	local source = source
	if quantidade[source] == nil then
	   quantidade[source] = math.random(5,8)	
	end
	   TriggerClientEvent("quantidade-encomenda",source,parseInt(quantidade[source]))
end

function func.checkPayment()
	func.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	local consulta = vRP.getUData(12,"vRP:empresa") 
	local resultado = json.decode(consulta) or 0
	if user_id then
		if vRP.tryGetInventoryItem(user_id,"encomenda",quantidade[source]) then
			randmoney = (math.random(90,130)*quantidade[source])
			vRP.giveMoney(user_id,parseInt(randmoney))
			vRP.setUData(12,"vRP:empresa",json.encode(parseInt(resultado+randmoney/4)))
	        TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
	        TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b>.")
			quantidade[source] = nil
			func.Quantidade()
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Você precisa de <b>"..quantidade[source].."x Encomendas</b>.")
		end
	end
end