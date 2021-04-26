local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

API = {}
Tunnel.bindInterface("nation_bennys",API)

local using_bennys = {}

function API.checkPermission()
    local source = source
    --print("porra")
    return vRP.hasPermission(vRP.getUserId(source), "Mechanic")

end

function API.getSavedMods(vehicle_name, vehicle_plate)
    local vehicle_owner_id = vRP.getUserByRegistration(vehicle_plate)
    return json.decode(vRP.getSData("custom:u" .. vehicle_owner_id .. "veh_" .. tostring(vehicle_name)) or {}) or {}
end

function API.checkPayment(amount)
    if not tonumber(amount) then
        return false
    end

    local source = source
    local user_id = vRP.getUserId(source)
    if not vRP.paymentBank(user_id, tonumber(amount)) then
        TriggerClientEvent("Notify",source,"negado","Você não possui dinheiro suficiente.",7000)
        return false
    end
    TriggerClientEvent("Notify",source,"sucesso","Modificações aplicadas com <b>sucesso</b><br>Você pagou <b>$"..tonumber(amount).." dólares<b>.",7000)
    return true
end

function API.repairVehicle(vehicle, damage)

    TriggerEvent("tryreparar", vehicle)
    return true
end

function API.removeVehicle(vehicle)
    using_bennys[vehicle] = nil
    return true
end

function API.checkVehicle(vehicle)
    if using_bennys[vehicle] then
        return false
    end
    using_bennys[vehicle] = true
    return true
end
function API.saveVehicle(vehicle_name, vehicle_plate, vehicle_mods)
    --print(json.encode(vehicle_mods))
    local mods = vehicle_mods
    local custom = {}
    --print(mods["mods"]["mods"][0].mod)
    custom.spoiler = mods["mods"][0].mod
    custom.fbumper = mods["mods"][1].mod
    custom.rbumper = mods["mods"][2].mod
    custom.skirts = mods["mods"][3].mod
    custom.exhaust = mods["mods"][4].mod
    custom.rollcage = mods["mods"][5].mod
    custom.grille = mods["mods"][6].mod
    custom.hood = mods["mods"][7].mod
    custom.fenders = mods["mods"][8].mod
    custom.roof = mods["mods"][10].mod
    custom.engine = mods["mods"][11].mod
    custom.brakes = mods["mods"][12].mod
    custom.transmission = mods["mods"][13].mod
    custom.horn = mods["mods"][14].mod
    custom.suspension = mods["mods"][15].mod
    custom.armor = mods["mods"][16].mod
    custom.tires = mods["mods"][23].mod
    custom.tiresvariation = mods["mods"][23].variation

    custom.btires = mods["mods"][24].mod
    custom.btiresvariation = mods["mods"][24].variation

    custom.plateholder = mods["mods"][25].mod
    custom.vanityplates = mods["mods"][26].mod
    custom.trimdesign = mods["mods"][27].mod
    custom.ornaments = mods["mods"][28].mod
    custom.dashboard = mods["mods"][29].mod
    custom.dialdesign = mods["mods"][30].mod
    custom.doors = mods["mods"][31].mod

    custom.seats = mods["mods"][32].mod
    custom.steeringwheels = mods["mods"][33].mod
    custom.shiftleavers = mods["mods"][34].mod
    custom.plaques = mods["mods"][35].mod
    custom.speakers = mods["mods"][36].mod
    custom.trunk = mods["mods"][37].mod
    custom.hydraulics = mods["mods"][38].mod
    custom.engineblock = mods["mods"][39].mod
    custom.camcover = mods["mods"][40].mod
    custom.strutbrace = mods["mods"][41].mod
    custom.archcover = mods["mods"][42].mod
    custom.aerials = mods["mods"][43].mod
    custom.roofscoops = mods["mods"][44].mod
    custom.tank = mods["mods"][45].mod
    custom.doors2 = mods["mods"][46].mod
    custom.liveries = mods["mods"][48].mod

    custom.tyresmoke = mods["mods"][20].mod
    custom.headlights = mods["mods"][22].mod
    custom.turbo = mods["mods"][18].mod
    --
    custom.color = { ["1"] = mods.color[1], ["2"] = mods.color[2] }
    custom.extracolor = { ["1"] = mods.extracolor[1], ["2"] = mods.extracolor[2] }
    custom.neon = parseInt(mods.neon)
    custom.neoncolor = { ["1"] = mods.neoncolor[1], ["2"] = mods.neoncolor[2], ["3"] = mods.neoncolor[3] }
    custom.xenoncolor = mods.xenoncolor
    custom.smokecolor = { ["1"] = mods.smokecolor[1], ["2"] = mods.smokecolor[2], ["3"] = mods.smokecolor[3] }
    custom.plateindex = mods.plateindex
    custom.windowtint = mods.windowtint
    custom.wheeltype = mods.wheeltype
    --print(json.encode(custom))
    local plateUserId = vRP.getVehiclePlate(vehicle_plate)
    --vRP.setSData("custom:u" .. vehicle_owner_id .. "veh_" .. tostring(vehicle_name),json.encode(vehicle_mods))
    vRP.setSData("custom:"..parseInt(plateUserId)..":"..tostring(vehicle_name),json.encode(custom))
    return true
end


RegisterServerEvent("nation:syncApplyMods")
AddEventHandler("nation:syncApplyMods",function(vehicle_tuning,vehicle)
    TriggerClientEvent("nation:applymods_sync",-1,vehicle_tuning,vehicle)
end)

-- [[!-!]] vcux3MfIy8qDzcrMz8rKycbPzsvKzcnIyM7M [[!-!]] --