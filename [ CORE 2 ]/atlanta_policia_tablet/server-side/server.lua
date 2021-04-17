-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("atlanta_policia_tablet",cRP)
vCLIENT = Tunnel.getInterface("atlanta_policia_tablet")
-----------------------------------------------------------------------------------------------------------------------------------------
------------on/off
-----------------------------------------------------------------------------------------------------------------------------------------
-- Citizen.CreateThread(function()
--     PerformHttpRequest("https://discord.com/api/webhooks/810391336544501780/GZPF2oJAxYH2KnORPJe3TJsLmn-gJOxaE7B3cR0iybrlquPDw3rTW_sZMs1c-lZC_r0A", function(err, text, headers) end, 'POST', json.encode({
--         content = '@everyone',
--         embeds = {
--             {
--                 description = '**SERVIDOR ONLINE:**\n\n**Aperte F8 e conecte: connect cfx.re/join/mpkkxq**',
--                 color = 2723266 --Se quiser mudar a cor é aqui
--             }
--         }
--     }), { ['Content-Type'] = 'application/json' })
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTWANTED
-----------------------------------------------------------------------------------------------------------------------------------------
-- function cRP.requestWanted()
-- 	local source = source
-- 	local user_id = vRP.getUserId(source)
-- 	if user_id then
-- 		if not vRP.wantedReturn(user_id) then
-- 			return true
-- 		end
-- 		return false
-- 	end
-- end
-----------------------------------------------------------------------------------------------------------------------------------------
-- requestUserName
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestUserName()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return vRP.getUserName(user_id)
	end
end

function cRP.getUserName(id)
	local existe = vRP.getUserIdentity(id)
	if existe == nil then
		return "Cidadão Inexistente"
	end
	return vRP.getUserName(id)
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- requestHistoricoCriminal
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestHistoricoCriminal(idPessoaBuscada)
	if idPessoaBuscada then
		local transf = {}
		local tabela = vRP.query("vRP/historico_criminal",{id_preso = parseInt(idPessoaBuscada) })
		for k,v in pairs(tabela) do
			-- print(v.valor)
			local nomePolicial = vRP.getUserName(v.id_policial)
			table.insert(transf,{ data = v.data, motivo = v.motivo ,servicos = v.servicos, policial = nomePolicial })
		end
		return transf
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- requestHistoricoMultas
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestHistoricoMultas(idPessoaBuscada)
	if idPessoaBuscada then
		local transf = {}
		local tabela = vRP.query("vRP/get_multas_historico",{user_id = parseInt(idPessoaBuscada) })
		for k,v in pairs(tabela) do
			-- print(v.valor)
			local nomeAplicador = vRP.getUserName(v.aplicador)
			if v.status == 1 then
				v.status = "PAGA"
			else
				v.status = "NÃO PAGA"
			end
			table.insert(transf,{ data = v.data, status = v.status, motivo = v.motivo, valor = v.valor, aplicador = nomeAplicador })
		end
		return transf
	end
end


RegisterCommand("tablet",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Police") then
			TriggerClientEvent("atlanta_policia_tablet:abrirTablet",source)
		end
	end
end)



