local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "nation_roubobancos")
func = {}
Tunnel.bindInterface("nation_roubobancos", func)

local roubo = false
local roubando = false
local cooldown = -1
local timer = -1
local banco = {}
local dinheiro
local half = false

local perm = cfg.permissao

local log_webhook = "none"
function SendWebhookMessage(webhook,message)
	if webhook ~= "none" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

function func.checkPermission()
    local user_id = vRP.getUserId(source)
    if vRP.getInventoryItemAmount(user_id,"pendrive") > 0 then
        return true
    end
    return false
end


function func.timer()
    timer = cfg.segundos
    while timer >= 0 do
        timer = timer - 1
        TriggerClientEvent("roubobancos:updatetimer", -1, timer)
        Wait(1000)        
    end
    if timer == -2 then
        TriggerClientEvent("roubobancos:updatetimer", -1, -1)
    end
end

function func.cooldown()
    cooldown = cfg.cooldown
    while cooldown >= 0 do
        cooldown = cooldown - 1
        Wait(1000)        
    end
end

function func.pegarDinheiro()
    local user_id = vRP.getUserId(source)
    if user_id then
        if dinheiro > 0 then
            local randommoney = math.random(5000,10000)
            dinheiro = dinheiro - randommoney
            if dinheiro >= 0 then
                vRP.giveInventoryItem(user_id,"dinheirosujo",randommoney,true)
                TriggerClientEvent("roubobancos:dinheiro",-1,dinheiro,vRP.format(dinheiro))
                if dinheiro <= (banco.reward / 2) and half == false then
                    half = true
                    TriggerClientEvent("roubobancos:updateobject", -1, true)
                end
            else
                vRP.giveInventoryItem(user_id,"dinheirosujo",randommoney+dinheiro,true)
                TriggerClientEvent("roubobancos:dinheiro",-1,0,vRP.format(0))
                TriggerClientEvent("roubobancos:updateobject", -1, false)
            end
            Wait(1000)
        end                
    end
end

RegisterServerEvent("roubobancos:hackingstats")
AddEventHandler("roubobancos:hackingstats", function(stats)
    TriggerClientEvent("roubobancos:updatehacking", -1, stats)
end)

RegisterServerEvent("roubobancos:hackedstats")
AddEventHandler("roubobancos:hackedstats", function(stats)
    if dinheiro then
        if stats == true then
            TriggerClientEvent("roubobancos:updatehacked", -1, stats, dinheiro,vRP.format(dinheiro))
        else
            TriggerClientEvent("roubobancos:updatehacked", -1, stats, nil,nil)
        end
    end
end)

RegisterServerEvent("roubobancos:stats")
AddEventHandler("roubobancos:stats", function(bancok, coords, nomebanco, dadosbanco)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, cfg.permissao) then
        TriggerClientEvent("Notify", source, "aviso", "Você é um <b>policial</b>, não pode fazer isso.")
    elseif #(vRP.getUsersByPermission(cfg.permissao)) < cfg.minpolicia then
        TriggerClientEvent("Notify", source, "negado", "Número insuficiente de policiais em patrulha.")
    elseif cooldown > 0 then
        TriggerClientEvent("Notify", source, "negado", "Você deve esperar <b> "..cooldown.." </b>segundos para poder roubar o banco.")
    else
        SendWebhookMessage(log_webhook,"```O ID ["..user_id.."] iniciou um roubo no "..nomebanco..".```")
        for k,v in pairs(vRP.getUsersByPermission(cfg.permissao)) do
            TriggerClientEvent("roubobancos:blipcoxa",vRP.getUserSource(v),dadosbanco.position.x,dadosbanco.position.y,dadosbanco.position.z)
        end
        roubo = true
        roubando = true
        banco = dadosbanco
        dinheiro = dadosbanco.reward
        TriggerClientEvent("roubobancos:iniciar", -1, roubo, roubando, coords, nomebanco, bancok, dadosbanco)
        func.timer()
        if timer ~= -2 then
            TriggerEvent("roubobancos:finished", nomebanco, nil)
            SendWebhookMessage(log_webhook,"```O roubo começado pelo ID ["..user_id.."] no "..nomebanco.." terminou com sucesso.```")
            for k,v in pairs(vRP.getUsersByPermission(cfg.permissao)) do
                TriggerClientEvent("roubobancos:rblipcoxa",vRP.getUserSource(v))
            end
        end
    end
end)


function func.cancelTimer()
    timer = -2
end

function func.removeDinheiro()
    local source = source
    if source then
        local user_id = vRP.getUserId(source)
        local amount = vRP.getInventoryItemAmount(user_id,"dinheirosujo")
        if amount > 0 then
            vRP.tryGetInventoryItem(user_id,"dinheirosujo",amount)
            TriggerClientEvent("Notify",source,"aviso","Foram removidos $ "..vRP.format(amount).." sujos de seu inventário.")
        end   
    end
end

RegisterServerEvent("roubobancos:finished")
AddEventHandler("roubobancos:finished", function(nomebanco)
    roubo = false
    roubando = false
    banco = nil
    dinheiro = nil
    half = false
    TriggerClientEvent("roubobancos:finalizar", -1, nomebanco)
    func.cooldown()
end)

RegisterServerEvent("roubobancos:cancel")
AddEventHandler("roubobancos:cancel", function(nomebanco,type)
    local source = source
    if type == 1 then
        SendWebhookMessage(log_webhook,"```O ID ["..vRP.getUserId(source).."] saiu do "..nomebanco.." antes do roubo ser finalizado.```")
    else
        SendWebhookMessage(log_webhook,"```O ID ["..vRP.getUserId(source).."] morreu enquanto roubava o "..nomebanco..".```")
    end
    for k,v in pairs(vRP.getUsersByPermission(cfg.permissao)) do
        TriggerClientEvent("roubobancos:rblipcoxa",vRP.getUserSource(v))
    end
    roubo = false
    roubando = false
    banco = nil
    dinheiro = nil
    half = false
    TriggerClientEvent("roubobancos:finalizar", -1, nomebanco,type)
    func.cooldown()
end)