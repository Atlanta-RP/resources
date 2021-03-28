local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
hel = {}
Tunnel.bindInterface("hel_mecanico",hel)


--------------------------------------------
-- Check Permission
--------------------------------------------
function hel.checkPermission()
    local source = source
    local user_id = vRP.getUserId(source)

    if user_id then
        if vRP.hasPermission(user_id,"mecanico.permissao") then
            return true
        else
            return false
        end
    end
end

----------------------------------------------
-- DA O KIT DE FERRAMENTAS
----------------------------------------------

function giveFerramentas()
    local source = source
    local user_id = vRP.getUserId(source)
    local ferramentas = math.random(1,2)
    if user_id then
        if vRP.getInventoryWeight(user_id) + vRP.getItemWeight("repairkit")*ferramentas <= vRP.getInventoryMaxWeight(user_id) then
            vRP.giveInventoryItem(user_id,"repairkit",parseInt(ferramentas))
            TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>"..ferramentas.." Kit de Ferramentas</b> pelo concerto do carro!")
            return true
        else
            TriggerClientEvent("Notify",source,"negado","Mochila Cheia!")
            return false
        end
    end
end                   


----------------------------------------------
-- PAGAMENTO
----------------------------------------------
function hel.checkPayment()
    local source = source
    local user_id = vRP.getUserId(source)
    local valor = math.random(600,800)

    if user_id then
        if giveFerramentas() then
            vRP.giveMoney(user_id,valor)
            TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
            TriggerClientEvent("Notify",source,"sucesso","Você recebeu <b>$"..valor.."<b> pelo concerto do veículo!")
        else
            TriggerClientEvent("Notify",source,"negado","Você não recebeu pelo serviço!")
        end
    end
end                        