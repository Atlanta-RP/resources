local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_minerador",emP)
levels = Proxy.getInterface("vrp_levels")

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local quantidade = {}
local porcentagem = 0
local itemname = ""


function emP.Quantidade()
    local source = source
	local teste = nil
    local user_id = vRP.getUserId(source)
    if teste == nil then
		teste = math.random(1,2)
		return teste
    end
end 

function emP.checkWeight()
	qntde = emP.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		porcentagem = math.random(100)
		if porcentagem <= 15 then
			itemname = "bronze"
		elseif porcentagem >= 16 and porcentagem <= 30 then
			itemname = "ferro"
		elseif porcentagem >= 31 and porcentagem <= 40 then
			itemname = "ouro"
		elseif porcentagem >= 41 and porcentagem <= 50 then
			itemname = "rubi"
		elseif porcentagem >= 51 and porcentagem <= 60 then
			itemname = "esmeralda"
		elseif porcentagem >= 61 and porcentagem <= 70 then
			itemname = "safira"
		elseif porcentagem >= 71 and porcentagem <= 80 then
			itemname = "diamante"
		elseif porcentagem >= 81 and porcentagem <= 90 then
			itemname = "topazio"
		elseif porcentagem >= 91 then
			itemname = "ametista2"
		end
		 return vRP.computeInvWeight(user_id) + vRP.itemWeightList(itemname) * qntde <= vRP.getBackpack(user_id)
	end
end

function emP.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	print("entrou aqui")
	if user_id then
		print(itemname)
		vRP.giveInventoryItem(user_id,itemname,qntde)
		-- levels.setxP(user_id,'Farming',3)		
		TriggerClientEvent("Notify",source,"sucesso","Encontrou <b>"..qntde.."x "..vRP.itemNameList(itemname).."</b>.",8000)
		quantidade[source] = nil
	end
end


