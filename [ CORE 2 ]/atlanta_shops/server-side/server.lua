-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("atlanta_shops",cnVRP)
vCLIENT = Tunnel.getInterface("atlanta_shops")

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------

local taxaLucro = 0.5 

local shops = {
	["departamentStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["postit"] = 7,
			["energetic"] = 7,
			["emptybottle"] = 3,
			["cigarette"] = 8,
			["skate"] = 200,
			["lighter"] = 20,
			["donut"] = 4,
			["chocolate"] = 5,
			["dewars"] = 23,
			["backpackp"] = 119,
			["roupas"] = 250,
			["chiclete"] = 3,
			["soda"] = 5
		}
	},
	["pharmacyStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Paramedic",
		["list"] = {
			["gauze"] = 40,
			["bandage"] = 30,
			["analgesic"] = 50,
			["warfarin"] = 200,
			["sinkalmy"] = 150,
			["ritmoneury"] = 250,
			["adrenaline"] = 300,
			["codeina"] = 80
		}
	},
	["ammunationStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["GADGET_PARACHUTE"] = 160,
			["WEAPON_KNIFE"] = 15,
			["WEAPON_HATCHET"] = 118,
			["WEAPON_BAT"] = 34,
			["WEAPON_BATTLEAXE"] = 130,
			["WEAPON_BOTTLE"] = 4,
			["WEAPON_CROWBAR"] = 33,
			["WEAPON_DAGGER"] = 30,
			["WEAPON_GOLFCLUB"] = 80,
			["WEAPON_HAMMER"] = 25,
			["WEAPON_MACHETE"] = 45,
			["WEAPON_POOLCUE"] = 32,
			["WEAPON_STONE_HATCHET"] = 67,
			["WEAPON_SWITCHBLADE"] = 40,
			["WEAPON_WRENCH"] = 22,
			["WEAPON_KNUCKLE"] = 33
		}
	},
	["premiumStore"] = {
		["mode"] = "Buy",
		["type"] = "Premium",
		["list"] = {
			["premium01"] = 15,
			["premium02"] = 25,
			["premium03"] = 35,
			["premium04"] = 45,
			["premiumplate"] = 25,
			["premiumname"] = 25,
			["premiumgarage"] = 25
		}
	},
	["fishingSell"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["shrimp"] = 18,
			["octopus"] = 14,
			["carp"] = 10
		}
	},
	["recyclingSell"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["plastic"] = 10,
			["glass"] = 10,
			["rubber"] = 10,
			["aluminum"] = 10,
			["copper"] = 10,
			["eletronics"] = 20,
			["emptybottle"] = 1,
			["lighter"] = 10,
			["bucket"] = 7,
			["teddy"] = 20,
			["fishingrod"] = 100,
			["identity"] = 5,
			["radio"] = 100,
			["cellphone"] = 300,
			["binoculars"] = 20,
			["camera"] = 200,
			["vape"] = 60,
			["pager"] = 100,
			["keyboard"] = 180,
			["mouse"] = 99,
			["ring"] = 120,
			["watch"] = 200,
			["goldbar"] = 600,
			["playstation"] = 300,
			["xbox"] = 300,
			["legos"] = 20,
			["ominitrix"] = 20,
			["bracelet"] = 137,
			["dildo"] = 76,
			["postit"] = 10
		}
	},
	["lavandaStore"] = {
		["mode"] = "Sell",
		["type"] = "Cash",
		["list"] = {
			["dollars2"] = 40
		}
	},
	["fishingStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["bait"] = 10,
			["fishingrod"] = 200
		}
	},
	["registryStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["identity"] = 30
		}
	},
	["digitalDen"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["loja"] = "DigitalDenMaster",
		["list"] = {
			["radio"] = 200,
			["cellphone"] = 1000,
			["binoculars"] = 60,
			["camera"] = 700,
			["vape"] = 180
		}
	},
	["megaMallStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["postit"] = 20,
			["teddy"] = 50,
			["rose"] = 23,
			["plastic"] = 150,
			["glass"] = 150,
			["rubber"] = 150,
			["aluminum"] = 150,
			["copper"] = 150,
			["paperbag"] = 2,
			["firecracker"] = 200,
			["analgesic"] = 150
		}
	},
	["weedz"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["cigarette"] = 9,
			["lighter"] = 22,
			["bucket"] = 12,
			["compost"] = 10,
			["cannabisseed"] = 100,
			["silk"] = 6,
		}
	},
	["comedyBar"] = {
		["mode"] = "Buy",
		["loja"] = "ComedyClubMaster",
		["type"] = "Cash",
		["list"] = {
			["energetic"] = 10,
			["cola"] = 7,
			["soda"] = 7,
			["fries"] = 8,
			["absolut"] = 22,
			["chandon"] = 45,
			["dewars"] = 20,
			["hennessy"] = 30,
		}
	},
	["bar"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["energetic"] = 10,
			["cola"] = 7,
			["soda"] = 7,
			["absolut"] = 22,
			["chandon"] = 45,
			["dewars"] = 20,
			["hennessy"] = 30,
		}
	},
	["vanilla"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["loja"] = "VanillaMaster",
		["list"] = {
			["energetic"] = 10,
			["cola"] = 7,
			["soda"] = 7,
			["absolut"] = 22,
			["chandon"] = 45,
			["dewars"] = 20,
			["hennessy"] = 30,
		}
	},
	["tequila"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["loja"] = "TequilaMaster",
		["list"] = {
			["energetic"] = 10,
			["cola"] = 7,
			["soda"] = 7,
			["absolut"] = 22,
			["chandon"] = 45,
			["dewars"] = 20,
			["hennessy"] = 30,
		}
	},
	["pearls"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["loja"] = "PearlsMaster",
		["list"] = {
			["energetic"] = 10,
			["cola"] = 7,
			["soda"] = 7,
			["absolut"] = 22,
			["chandon"] = 45,
			["dewars"] = 20,
			["hennessy"] = 30,
		}
	},
	["tacosBebidas"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["energetic"] = 50,
			["cola"] = 50,
			["soda"] = 50,
			["absolut"] = 50,
			["chandon"] = 50,
			["dewars"] = 50,
			["hennessy"] = 50,
		}
	},
	["tacosComidas"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["hamburger"] = 50,
			["sandwich"] = 50,
			["fries"] = 50,
		}
	},
	["waterMachine"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["list"] = {
			["water"] = 40
		}
	},
	["policeStore"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["perm"] = "Police",
		["list"] = {
			["vest"] = 500,
			["gsrkit"] = 200,
			["gdtkit"] = 200,
			["WEAPON_SMG"] = 4400,
			["WEAPON_CARBINERIFLE"] = 7000,
			["WEAPON_FIREEXTINGUISHER"] = 120,
			["WEAPON_STUNGUN"] = 200,
			["WEAPON_NIGHTSTICK"] = 200,
			["WEAPON_COMBATPISTOL"] = 2000,
			["WEAPON_SMG_AMMO"] = 8,
			["WEAPON_RIFLE_AMMO"] = 10,
			["WEAPON_PISTOL_AMMO"] = 6
		}
	},
	["coffeshop"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["item"] = "dollars",
		["loja"] = "BeanMachineMaster",
		["list"] = {
			["coffee"] = 12,
			["expresso"] = 15,
			["brash"] = 16,
			["frappe"] = 19,
			["cappuccino"] = 17,

		}
	},
	["coffeshop2"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["item"] = "dollars",
		["loja"] = "BeanMachine2Master",
		["list"] = {
			["coffee"] = 12,
			["expresso"] = 15,
			["bbspecial"] = 16,
			["frappe"] = 19,
			["cappuccino"] = 17,
		}
	},
	["burgershot"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["item"] = "dollars",
		["list"] = {
			["hamburger"] = 20,
			["sandwich"] = 12,
			["energetic"] = 9,
			["cola"] = 6,
			["soda"] = 6,
			["fries"] = 7,
		}
	},
	["vendaCodeina"] = {
		["mode"] = "Buy",
		["perm"] = "Groove",
		["type"] = "Consume",
		["item"] = "dollars",
		["list"] = {
			["codeina"] = 200
		}
	},
	["vendaLock"] = {
		["mode"] = "Buy",
		["type"] = "Consume",
		["item"] = "dollars2",
		["list"] = {
			["lockpick"] = 10
		}
	},
	["vendaAssassino"] = {
		["mode"] = "Buy",
		["type"] = "Consume",
		["item"] = "dollars2",
		["list"] = {
			["WEAPON_KNIFE"] = 1,
			["WEAPON_HATCHET"] = 2,
			["WEAPON_BAT"] = 2,
			["WEAPON_BATTLEAXE"] = 3,
			["WEAPON_BOTTLE"] = 1,
			["WEAPON_CROWBAR"] = 1,
			["WEAPON_DAGGER"] = 1,
			["WEAPON_GOLFCLUB"] = 1,
			["WEAPON_HAMMER"] = 2,
			["WEAPON_MACHETE"] = 2,
			["WEAPON_POOLCUE"] = 1,
			["WEAPON_STONE_HATCHET"] = 1,
			["WEAPON_SWITCHBLADE"] = 2,
			["WEAPON_WRENCH"] = 1,
			["WEAPON_KNUCKLE"] = 1,
		}
	},
	["vendaIsolado"] = {
		["mode"] = "Buy",
		["type"] = "Consume",
		["item"] = "shrimp",
		["list"] = {
			["analgesic"] = 1,
			["radio"] = 4,
			["WEAPON_KNIFE"] = 1,
			["plastic"] = 1,
			["glass"] = 1,
			["rubber"] = 1,
			["aluminum"] = 2,
			["copper"] = 2,
		}
	},
	["vendaPolicialSecreto"] = {
		["mode"] = "Buy",
		["type"] = "Consume",
		["item"] = "dollars2",
		["list"] = {
			["WEAPON_NIGHTSTICK"] = 1,
			["WEAPON_COMBATPISTOL"] = 60,
		}
	},
	["lojaMochilas"] = {
		["mode"] = "Buy",
		["type"] = "Cash",
		["loja"] = "BagShopMaster",
		["item"] = "dollars",
		["list"] = {
			["backpackp"] = 100,
			["backpackm"] = 220,
			["backpackg"] = 330,
			["backpackx"] = 440,
		}
	},

}
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPERM
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.requestPerm(shopType)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.wantedReturn(user_id) then
			return false
		end

		if shops[shopType]["perm"] ~= nil then
			if not vRP.hasPermission(user_id,shops[shopType]["perm"]) then
				return false
			end
		end
		
		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.requestShop(name)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local inventoryShop = {}
		for k,v in pairs(shops[name]["list"]) do
			table.insert(inventoryShop,{ price = parseInt(v), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, weight = vRP.itemWeightList(k) })
		end

		local inventoryUser = {}
		local inv = vRP.getInventory(user_id)
		if inv then
			for k,v in pairs(inv) do
				if string.sub(v.item,1,9) == "toolboxes" then
					local advFile = LoadResourceFile("logsystem","toolboxes.json")
					local advDecode = json.decode(advFile)

					v.durability = advDecode[v.item]
				end

				v.amount = parseInt(v.amount)
				v.name = vRP.itemNameList(v.item)
				v.peso = vRP.itemWeightList(v.item)
				v.index = vRP.itemIndexList(v.item)
				v.key = v.item
				v.slot = k

				inventoryUser[k] = v
			end
		end

		return inventoryShop,inventoryUser,vRP.computeInvWeight(user_id),vRP.getBackpack(user_id),{ identity.name.." "..identity.name2,parseInt(user_id),parseInt(identity.bank),parseInt(vRP.getGmsId(user_id)),identity.phone,identity.registration }
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSHOPTYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.getShopType(name)
    return shops[name].mode
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.functionShops(shopType,shopItem,shopAmount,slot)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if shopAmount == nil then shopAmount = 1 end
		if shopAmount <= 0 then shopAmount = 1 end
		local inv = vRP.getInventory(user_id)
		if inv then
			if shops[shopType]["mode"] == "Buy" then
				if vRP.computeInvWeight(parseInt(user_id)) + vRP.itemWeightList(shopItem) * parseInt(shopAmount) <= vRP.getBackpack(parseInt(user_id)) then
					if shops[shopType]["type"] == "Cash" then
						if shops[shopType]["list"][shopItem] then
							if vRP.paymentBank(parseInt(user_id),parseInt(shops[shopType]["list"][shopItem]*shopAmount)) then

								if inv[tostring(slot)] then
									vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false)
								else
									vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false,slot)
								end
								--print("teste")
								if shops[shopType]["loja"] ~= nil then
									local valor = parseInt(parseInt(shops[shopType]["list"][shopItem]*shopAmount) * taxaLucro)
									local quantidade = vRP.tryChestItemVendaExiste(user_id,"chestLoja:"..tostring(shops[shopType]["loja"]),'dollars2',valor,2)
									if quantidade > 0 then
										if quantidade >= valor then
											if vRP.tryChestItemVenda(user_id,"chestLoja:"..tostring(shops[shopType]["loja"]),'dollars2',valor,2) then
												valor = valor + (valor * 10) -- alterar valor
												print("adicionado 1: "..valor)
											end
										else
											if vRP.tryChestItemVenda(user_id,"chestLoja:"..tostring(shops[shopType]["loja"]),'dollars2',valor,2) then
												valor = valor + (quantidade * 10) -- alterar valor
												print("adicionado 2: "..quantidade)
											end
										end
									end
									vRP.storeChestItemVenda(user_id,"chestLoja:"..tostring(shops[shopType]["loja"]),'dollars',valor,1,1)
									--print(valor)
									--print(tostring(shops[shopType]["loja"]))
									--print(parseInt(shops[shopType]["list"][shopItem]*shopAmount))
								end
								
								
								
							else
								TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",5000)
							end
						end
					elseif shops[shopType]["type"] == "Consume" then
						if vRP.tryGetInventoryItem(parseInt(user_id),shops[shopType]["item"],parseInt(shops[shopType]["list"][shopItem]*shopAmount)) then
							if inv[tostring(slot)] then
								vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false)
							else
								vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false,slot)
							end
						else
							TriggerClientEvent("Notify",source,"negado","Insuficiente "..vRP.itemNameList(shops[shopType]["item"])..".",5000)
						end
					elseif shops[shopType]["type"] == "Premium" then
						local identity = vRP.getUserIdentity(parseInt(user_id))
						local consult = vRP.getInfos(identity.steam)
						if parseInt(consult[1].gems) >= parseInt(shops[shopType]["list"][shopItem]*shopAmount) then
							if inv[tostring(slot)] then
								vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false)
							else
								vRP.giveInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),false,slot)
							end							vRP.remGmsId(user_id,parseInt(shops[shopType]["list"][shopItem]*shopAmount))
							TriggerClientEvent("Notify",source,"sucesso","Você comprou <b>"..vRP.format(parseInt(shopAmount)).."x "..vRP.itemNameList(shopItem).."</b> por <b>"..vRP.format(parseInt(shops[shopType]["list"][shopItem]*shopAmount)).." coins</b>.",5000)
						else
							TriggerClientEvent("Notify",source,"negado","Coins Insuficientes.",5000)
						end
					end
				else
					TriggerClientEvent("Notify",source,"negado","Mochila cheia.",5000)
				end
			elseif shops[shopType]["mode"] == "Sell" then
				if shops[shopType]["list"][shopItem] then
					if shops[shopType]["type"] == "Cash" then
						if vRP.tryGetInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),true,slot) then
							vRP.giveInventoryItem(parseInt(user_id),"dollars",parseInt(shops[shopType]["list"][shopItem]*shopAmount),false)
							TriggerClientEvent("Notify",source,"aviso","Voce recebeu $"..shops[shopType]["list"][shopItem]*shopAmount.." dolares.",5000)
						end
					elseif shops[shopType]["type"] == "Consume" then
						if vRP.tryGetInventoryItem(parseInt(user_id),shopItem,parseInt(shopAmount),true,slot) then

							vRP.giveInventoryItem(parseInt(user_id),shops[shopType]["item"],parseInt(shops[shopType]["list"][shopItem]*shopAmount),false)
						end
					end
				end
			end
		end

		TriggerClientEvent("atlanta_shops:Update",source,"requestShop")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("atlanta_shops:populateSlot")
AddEventHandler("atlanta_shops:populateSlot",function(itemName,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		if vRP.tryGetInventoryItem(user_id,itemName,amount,false,slot) then
			vRP.giveInventoryItem(user_id,itemName,amount,false,target)
			TriggerClientEvent("atlanta_shops:Update",source,"requestShop")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("atlanta_shops:updateSlot")
AddEventHandler("atlanta_shops:updateSlot",function(itemName,slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		local inv = vRP.getInventory(user_id)
		if inv then
			if inv[tostring(slot)] and inv[tostring(target)] and inv[tostring(slot)].item == inv[tostring(target)].item then
				if vRP.tryGetInventoryItem(user_id,itemName,amount,false,slot) then
					vRP.giveInventoryItem(user_id,itemName,amount,false,target)
				end
			else
				vRP.swapSlot(user_id,slot,target)
			end
		end

		TriggerClientEvent("atlanta_shops:Update",source,"requestShop")
	end
end)