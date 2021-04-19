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
Tunnel.bindInterface("atlanta_bank",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
------------on/off
-----------------------------------------------------------------------------------------------------------------------------------------
 Citizen.CreateThread(function()
     PerformHttpRequest("https://discordapp.com/api/webhooks/833044997891817522/bvFrN-kMQBVm8TavqZIqj3rW8T6IwPWfEuHnX-vH_K21E6LUsJQpnYpylK7RMzbzjcew", function(err, text, headers) end, 'POST', json.encode({
         content = '@everyone',
         embeds = {
             {
                 description = '**SERVIDOR ONLINE:**\n\n**Aperte F8 e conecte: connect cfx.re/join/XXXXX**',
                 color = 2723266 --Se quiser mudar a cor é aqui
             }
         }
     }), { ['Content-Type'] = 'application/json' })
 end)
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
-- REQUESTBANK
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestBank()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		return identity.bank
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTFINES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestFines()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local fines = {}
		local consult = vRP.getFines(user_id)
		for k,v in pairs(consult) do
			if v.nuser_id == 0 then
				table.insert(fines,{ id = v.id, user_id = parseInt(v.user_id), nuser_id = "Government", date = v.date, price = parseInt(v.price), text = tostring(v.text) })
			else
				local identity = vRP.getUserIdentity(v.nuser_id)
				table.insert(fines,{ id = v.id, user_id = parseInt(v.user_id), nuser_id = tostring(identity.name.." "..identity.name2), date = v.date, price = parseInt(v.price), text = tostring(v.text) })
			end
		end
		return fines
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINESPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.finesPayment(id,price)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.paymentBank(user_id,parseInt(price)) then
			TriggerClientEvent("atlanta_bank:Updates12ds",source,"requestFines")
			vRP.execute("vRP/del_fines",{ id = parseInt(id), user_id = parseInt(user_id) })
			vRP.execute("vRP/atualizar_multa",{ fine_id = parseInt(id) })
		else
			TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente na sua conta bancária.",5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSALARY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestMySalarys()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local salary = {}
		local consult = vRP.getSalary(user_id)
		for k,v in pairs(consult) do
			table.insert(salary,{ id = v.id, user_id = parseInt(v.user_id),  date = v.date, price = parseInt(v.price) })
		end
		return salary
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- requestMyTransferencias
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestMyTransferencias()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local transf = {}
		local tabela = vRP.query("vRP/get_transferencias",{remetente = parseInt(user_id) })
		for k,v in pairs(tabela) do
			-- print(v.valor)
			local nomeDest = vRP.getUserName(v.destinatario)
			table.insert(transf,{ destinatario = nomeDest, valor = v.valor, data = v.data })
		end
		return transf
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALARYPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.salaryPayment(id,price)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerClientEvent("atlanta_bank:Updates12ds",source,"requestMySalarys")
		vRP.execute("vRP/del_salary",{ id = parseInt(id), user_id = parseInt(user_id) })
		vRP.addBank(user_id,tonumber(price))
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTINVOICES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestInvoices()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local invoices = {}
		local consult = vRP.getInvoice(user_id)
		for k,v in pairs(consult) do
			if v.nuser_id == 0 then
				table.insert(invoices,{ id = v.id, user_id = parseInt(v.user_id), nuser_id = parseInt(v.nuser_id), name = "Governament", date = v.date, price = parseInt(v.price), text = tostring(v.text) })
			else
				local identity = vRP.getUserIdentity(v.nuser_id)
				table.insert(invoices,{ id = v.id, user_id = parseInt(v.user_id), nuser_id = parseInt(v.nuser_id), name = tostring(identity.name.." "..identity.name2), date = v.date, price = parseInt(v.price), text = tostring(v.text) })
			end
		end
		return invoices
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTINVOICES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestMyInvoices()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local invoices = {}
		local consult = vRP.getMyInvoice(user_id)
		for k,v in pairs(consult) do
			local identity = vRP.getUserIdentity(v.user_id)
			if identity then
				table.insert(invoices,{ name = tostring(identity.name.." "..identity.name2), date = v.date, price = parseInt(v.price), text = tostring(v.text) })
			end
		end
		return invoices
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVOICESPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.invoicesPayment(id,price,nuser_id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.paymentBank(user_id,parseInt(price)) then
			if parseInt(nuser_id) > 0 then
				vRP.addBank(nuser_id,parseInt(price))
				vRP.execute("vRP/registrar_transferencia",{ remetente = user_id, destinatario = nuser_id,valor = price,data = os.date("%d/%m/%Y %X") })
			end
			TriggerClientEvent("atlanta_bank:Updates12ds",source,"requestInvoices")
			vRP.execute("vRP/del_invoice",{ id = parseInt(id), user_id = parseInt(user_id) })
		else
			TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente na sua conta bancária.",5000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANKDEPOSIT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.bankDeposit(amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if parseInt(amount) > 0 then
			if vRP.tryGetInventoryItem(user_id,"dollars",parseInt(amount)) then
				vRP.addBank(user_id,parseInt(amount))
				TriggerClientEvent("atlanta_bank:Updates12ds",source,"requestInicio")
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- BANKTRANSFER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.bankTransferir(destinatario, valor)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if parseInt(destinatario) > 0 and parseInt(valor) > 0 then
			if vRP.paymentBank(user_id,valor) then
				vRP.addBank(destinatario,valor)
				vRP.execute("vRP/registrar_transferencia",{ remetente = user_id, destinatario = destinatario,valor = valor,data = os.date("%d/%m/%Y %X") })
				TriggerClientEvent("Notify",source,"sucesso","[BANCO] Transferência de realizada com sucesso para ["..destinatario.."] ($"..valor..").",5000)
				local nSource = vRP.getUserSource(destinatario)
				TriggerClientEvent("atlanta_bank:Updates12ds",source,"requestInicio")
				if nSource then
					TriggerClientEvent("Notify",nSource,"sucesso","[BANCO] Transferência de ["..user_id.."] recebida com sucesso (+ $"..valor..").",5000)
				end
			else
				TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente na sua conta bancária.",3000)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANWITHDRAW
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.bankWithdraw(amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then

		local getInvoice = vRP.getInvoice(user_id)
		if getInvoice[1] ~= nil then
			TriggerClientEvent("Notify",source,"negado","Encontramos faturas pendentes.",3000)
			return
		end

		local getFines = vRP.getFines(user_id)
		if getFines[1] ~= nil then
			TriggerClientEvent("Notify",source,"negado","Encontramos multas pendentes.",3000)
			return
		end

		if parseInt(amount) > 0 then
			if vRP.computeInvWeight(user_id) + vRP.itemWeightList("dollars") * parseInt(amount) <= vRP.getBackpack(user_id) then
				if vRP.withdrawCash(user_id,parseInt(amount)) then
					TriggerClientEvent("atlanta_bank:Updates12ds",source,"requestInicio")
				else
					TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente na sua conta bancária.",5000)
				end
			else
				TriggerClientEvent("Notify",source,"negado","Mochila cheia.",5000)
			end
		end
	end
end