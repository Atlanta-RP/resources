local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = {}
Tunnel.bindInterface("emp_taxista",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------

function emP.checkPayment()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        randmoney = math.random(100,210)
        vRP.giveInventoryItem(user_id,"dollars",parseInt(randmoney))
        TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..parseInt(randmoney).." dólares</b>.")

        -- EMPRESA
        local consulta = vRP.getUData(11,"vRP:empresa") 
        local resultado = json.decode(consulta) or 0
        vRP.setUData(11,"vRP:empresa",json.encode(parseInt(resultado+randmoney/2)))
    end
end

function emP.empresataxi()
    local source = source
    local user_id = vRP.getUserId(source)
    local consulta = vRP.getUData(11,"vRP:empresa") 
    local resultado = json.decode(consulta) or 0
    local taxa = 1000
    
    if vRP.tryGetInventoryItem(user_id,"dollars",parseInt(taxa),false,slot) then
        return true
    end
end