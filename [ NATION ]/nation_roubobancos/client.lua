local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
func = Tunnel.getInterface("nation_roubobancos")

local banco
local dadosbanco = {}
local roubo = false
local roubando = false
local timer = -1
local hacked = false
local hacking = false
local marcado = false
local dinheiro
local dinheirobonito
local blips = {}


local position 
local hackear
local posdinheiro 
local roubar 
local reward
local nameofbank 
local lastrobbed 
local porta 

function notifyBanco(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function bank_drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function ShowAdvancedNotification(icon, sender, title, text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    SetNotificationMessage(icon, icon, true, 4, sender, title, text)
    DrawNotification(false, true)
end

function DrawText3D(x, y, z, text, scale)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
 
	SetTextFont(4)
	SetTextScale(0.65,0.65)
	SetTextColour(255,255,255,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/270
	DrawRect(_x,_y+0.0220,0.02+factor,0.04,0,0,0,80)
end

function addBlip(x,y,z,idtype,idcolor,text,scale)
	local blip = AddBlipForCoord(x+0.001,y+0.001,z+0.001)
	SetBlipSprite(blip,idtype)
	SetBlipAsShortRange(blip,true)
	SetBlipColour(blip,idcolor)
	SetBlipScale(blip,scale)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)
	return blip
end

RegisterNetEvent("roubobancos:blipcoxa")
AddEventHandler("roubobancos:blipcoxa",function(x,y,z)
    blips[PlayerId()] = addBlip(x,y,z,431,6,"Roubo",1.0)
end)

RegisterNetEvent("roubobancos:rblipcoxa")
AddEventHandler("roubobancos:rblipcoxa",function()
    if blips[PlayerId()] then
        RemoveBlip(blips[PlayerId()])
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if roubo == false then
            for k,v in pairs(cfg.bancos) do
                local x,y,z = v.position.x,v.position.y,v.position.z
                local pcoords = vector3(x,y,z)
                local playercoords = GetEntityCoords(PlayerPedId(),false)
                local distancia = #(playercoords - pcoords)
                if distancia < 10 then
                    DrawMarker(29, x,y,z ,0,0,0,0,0,0,1.0,0.7,1.0,50,150,50,200,1,0,0,1)
                    if distancia < 1 then
                        notifyBanco("Pressione ~INPUT_CONTEXT~ para iniciar um assalto ao ~b~"..v.nameofbank..".")
                        if IsControlJustPressed(0,51) then
                            TriggerServerEvent("roubobancos:stats", k, pcoords, v.nameofbank, v)
                        end
                    end
                end
            end
        elseif roubo == true and hacked == false and hacking == false then
            local playercoords = GetEntityCoords(PlayerPedId(),false)
            local x,y,z,h = dadosbanco.hackear.x,dadosbanco.hackear.y,dadosbanco.hackear.z,dadosbanco.hackear.h
            local hcoords = hackear
            local distancia
            if dadosbanco.hackearmarker then
                local hx,hy,hz = dadosbanco.hackearmarker.x,dadosbanco.hackearmarker.y,dadosbanco.hackearmarker.z
                hcoords = vector3(hx,hy,hz)
            end
            distancia = #(playercoords - hcoords) 
            if distancia < 5 then
                if dadosbanco.hackearmarker then
                    DrawMarker(30, hcoords , 0,0,0,0,0,0,0.5,0.2,0.5,50,150,50,200,1,0,0,1)
                else
                    DrawMarker(30, x, y, z , 0,0,0,0,0,0,0.5,0.2,0.5,50,150,50,200,1,0,0,1)
                end
                if distancia < 1 then
                    notifyBanco("Pressione ~INPUT_CONTEXT~ para ~g~hackear ~w~a porta.")
                    if IsControlJustPressed(0,51) then
                        if func.checkPermission() then
                            hackearporta(x,y,z,h)
                        else
                            TriggerEvent("Notify","aviso","Você não possui um pendrive.")
                        end
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if roubando == true and timer >= 0 then
            bank_drawTxt(0.70, 1.44, 1.0,1.0,0.3, "Roubo a Banco em Andamento: falta ~r~" .. timer .. "~w~ segundo(s) restantes para concluir o Assalto", 255, 255, 255, 255)
            if hacked == true then
                local playercoords = GetEntityCoords(PlayerPedId(),false)
                local distancia = #(playercoords - posdinheiro)
                if distancia < 2 then
                    if dinheiro and dinheirobonito then
                        local x,y,z = table.unpack(posdinheiro)
                        DrawText3D(x, y, z + 0.5 , '~g~$~w~'..dinheirobonito, 0.8)
                    end
                end
            end
        end
    end
end)


local pegandodinheiro = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if dinheiro and roubando == true then
            local playercoords = GetEntityCoords(PlayerPedId(),false)
            local distancia = #(playercoords - posdinheiro)
            if dinheiro > 0 then
                if distancia < 1 then
                    if pegandodinheiro == false then
                        notifyBanco("~g~Pressione ~INPUT_PICKUP~ para começar a roubar.")
                        if IsControlJustPressed(0,38) then
                            pegandodinheiro = true
                            TriggerEvent("roubobancos:startanim")
                        end
                    else
                        if IsControlPressed(0,22) then
                            func.pegarDinheiro()
                        end
                        if (IsControlJustPressed(1,167) or IsControlJustPressed(1,168)) then
                            pegandodinheiro = false
                            DeleteEntity(bagProp)
                            SetPedComponentVariation(PlayerPedId(), 5, 45, 0, 0)
                        end
                    end
                else
                    pegandodinheiro = false
                    if bagProp then
                        if IsEntityAttached(bagProp) then
                            DeleteEntity(bagProp)
                        end
                    end
                end
            else
                pegandodinheiro = false
                if distancia < 1 then
                    if IsEntityPlayingAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 3) then
                        TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "exit", 8.0, -8.0, -1, 1, 0, false, false, false)
                        Wait(2000)
                        ClearPedTasks(PlayerPedId())
                        DeleteEntity(bagProp)
                        SetPedComponentVariation(PlayerPedId(), 5, 45, 0, 0)
                    end
                else
                    if bagProp then
                        if IsEntityAttached(bagProp) then
                            DeleteEntity(bagProp)
                        end
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if pegandodinheiro == true then
            notifyBanco("~g~Segure ~INPUT_JUMP~ para pegar o dinheiro.")
        end
    end
end)

RegisterNetEvent("roubobancos:updateobject")
AddEventHandler("roubobancos:updateobject", function(half)
    if object then 
        if half == true then
            DeleteEntity(object)
            object = CreateObject(GetHashKey("hei_prop_cash_crate_half_full"), posdinheiro, true, false)
            FreezeEntityPosition(object, true)
        else
            DeleteEntity(object)
            object = nil
            newobject = CreateObject(GetHashKey("hei_prop_cash_crate_empty"), posdinheiro, true, false)
            FreezeEntityPosition(newobject, true)
        end
    end
end)

RegisterNetEvent("roubobancos:startanim")
AddEventHandler("roubobancos:startanim", function()
    local bagProps = {
        [40] = 'p_ld_heist_bag_s_pro_o', 
        [41] = 'p_ld_heist_bag_s_pro_o',
        [44] = 'prop_cs_heist_bag_01',
        [45] = 'prop_cs_heist_bag_01'
    }
    local coords = GetEntityCoords(PlayerPedId())
    local cash_hash = GetHashKey("hei_prop_heist_cash_pile")
    RequestModel(cash_hash)
    while not HasModelLoaded(cash_hash) do
        Wait(0)
    end

    RequestAnimDict('anim@heists@ornate_bank@grab_cash_heels')
    while not HasAnimDictLoaded('anim@heists@ornate_bank@grab_cash_heels') do
        Wait(10)
    end

    makeEntityFaceEntity(PlayerPedId(), object)

    TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "intro", 8.0, -8.0, -1, 1, 0, false, false, false)
    Wait(1000)

    local bagHash = GetHashKey(bagProps[44])
    RequestModel(bagHash)
    while not HasModelLoaded(bagHash) do
        Wait(0)
    end
    SetPedComponentVariation(PlayerPedId(), 5,0,0,2)
    bagProp = CreateObject(bagHash, coords, true, false)
    SetEntityAsMissionEntity(bagProp, true, true)
    local bagIndex = GetPedBoneIndex(PlayerPedId(), 57005)
    if bagProps[44] == 'p_ld_heist_bag_s_pro_o' then
        AttachEntityToEntity(bagProp, PlayerPedId(), bagIndex, 0.3, -0.25, -0.3, 300.0, 200.0, 300.0, true, true, false, true, 1, true)
    else
        AttachEntityToEntity(bagProp, PlayerPedId(), bagIndex, -0.1, -0.05, -0.42, 300.0, 200.0, 300.0, true, true, false, true, 1, true)
    end

    cashPile = CreateObject(cash_hash, 0, 0, 0, true, false)
    SetEntityAsMissionEntity(cashPile, true, true)
    local boneIndex = GetPedBoneIndex(PlayerPedId(), 18905)

    TaskPlayAnim(PlayerPedId(), "anim@heists@ornate_bank@grab_cash_heels", "grab", 8.0, -8.0, -1, 1, 0, false, false, false)
    Wait(350)
    AttachEntityToEntity(cashPile, PlayerPedId(), boneIndex, 0.125, 0.0, 0.05, 5.0, 150.0, 300.0, true, true, false, true, 1, true)
    Wait(500)
    takingMoney()
end)

function takingMoney()
    while pegandodinheiro == true do
        Wait(500)
        if IsEntityVisible(cashPile) then
            SetEntityVisible(cashPile,false,0)
        else
            SetEntityVisible(cashPile,true,0)  
        end
    end
    DeleteEntity(cashPile)
end


RegisterNetEvent("roubobancos:iniciar")
AddEventHandler("roubobancos:iniciar", function(sroubo, sroubando, bancocoords, nomebanco, cbanco, dados)
    local playercoords = GetEntityCoords(PlayerPedId(),false)
    local distancia = #(playercoords - bancocoords)
    if distancia < 10 then
        roubando = sroubando
    end
    roubo = sroubo
    banco = cbanco
    dadosbanco = dados
    position = vector3(dadosbanco.position.x,dadosbanco.position.y,dadosbanco.position.z)
    hackear = vector3(dadosbanco.hackear.x,dadosbanco.hackear.y,dadosbanco.hackear.z)
    posdinheiro = vector3(dadosbanco.dinheiro.x,dadosbanco.dinheiro.y,dadosbanco.dinheiro.z)
    roubar = vector3(dadosbanco.roubar.x,dadosbanco.roubar.y,dadosbanco.roubar.z)
    porta = vector3(dadosbanco.porta.portax,dadosbanco.porta.portay,dadosbanco.porta.portaz)
    ShowAdvancedNotification("CHAR_DETONATEBOMB", "~b~"..nomebanco, "~r~Roubo em andamento", "~y~O "..nomebanco.." está sendo roubado nesse momento.")
    if roubando == true then
        notifyBanco("~y~Segure o roubo por ~g~10 minutos~y~.")
        Wait(3000)
        notifyBanco("~y~Se você se afastar do banco antes do tempo acabar, perderá seu ~b~dinheiro sujo~y~.")
        Wait(5000)
        notifyBanco("~y~Hackeie a porta com com suas habilidades de ~r~hacker~y~.")
    end
end)

RegisterNetEvent("roubobancos:finalizar")
AddEventHandler("roubobancos:finalizar", function(nomebanco, type)
    local playercoords = GetEntityCoords(PlayerPedId(),false)
    local distancia = #(playercoords - position)
    local x,y,z = table.unpack(porta)
    if type then
        if roubando == true then
            if type == 1 then
                TriggerEvent("Notify","negado","Alguém do grupo se afastou muito do banco e o roubo foi cancelado.")
                func.removeDinheiro()
            elseif type == 2 then
                TriggerEvent("Notify","negado","Alguém do grupo morreu e o roubo foi cancelado.")
                func.removeDinheiro()
            end
        elseif marcado == true then
            func.removeDinheiro()
        end
        ShowAdvancedNotification("CHAR_DETONATEBOMB", "~b~"..nomebanco, "~r~Roubo Cancelado", "~y~O assalto ao "..nomebanco.." foi cancelado.")
    else
        ShowAdvancedNotification("CHAR_DETONATEBOMB", "~b~"..nomebanco, "~r~Roubo Terminado", "~y~O assalto ao "..nomebanco.." foi finalizado.")
    end
    DeleteEntity(newobject)
    DeleteEntity(object)
    newobject = nil
    object = nil
    roubando = false
    roubo = false
    banco = nil
    dadosbanco = nil
    position = nil
    hackear = nil
    posdinheiro = nil
    roubar = nil
    porta = nil
    dinheiro = nil
    dinheirobonito = nil
    timer = -1
    hacked = false
    hacking = false
    marcado = false
    TriggerEvent("syncarea",x,y,z)
end)

RegisterNetEvent("roubobancos:dinheiro")
AddEventHandler("roubobancos:dinheiro", function(money,bmoney)
    dinheiro = money
    dinheirobonito = bmoney
end)

RegisterNetEvent("roubobancos:updatetimer")
AddEventHandler("roubobancos:updatetimer", function(tempo)
    timer = tempo
end)

RegisterNetEvent("roubobancos:updatehacking")
AddEventHandler("roubobancos:updatehacking", function(shacking)
    hacking = shacking
end)

RegisterNetEvent("roubobancos:updatehacked")
AddEventHandler("roubobancos:updatehacked", function(shacked,smoney,sbmoney)
    hacked = shacked
    if hacked == true then
        local playercoords = GetEntityCoords(PlayerPedId(),false)
        local distancia = #(playercoords - porta)
        if distancia < 10 then
            RequestAmbientAudioBank("SAFE_CRACK", 0, 0) 
            RequestAmbientAudioBank("DLC_Biker_Cracked_Sounds", 0, 0) 
            PlaySoundFrontend( -1, "TUMBLER_PIN_FALL", "SAFE_CRACK_SOUNDSET", 1)
        end
        TriggerEvent("roubobancos:criarobjeto")
        dinheiro = smoney
        dinheirobonito = sbmoney
    end
end)

RegisterNetEvent("roubobancos:criarobjeto")
AddEventHandler("roubobancos:criarobjeto", function()
    local playercoords = GetEntityCoords(PlayerPedId())
    local distancia = #(playercoords - posdinheiro)
    if distancia < 10 and roubando == true and roubo == true then
        local model = GetHashKey('prop_cash_crate_01')
        RequestModel(model)
        while not HasModelLoaded(model) do
        	Wait(0)
     	end
     	if object == nil then 
     		object = CreateObject(model, posdinheiro, false, false)
        	FreezeEntityPosition(object, true)
        	SetEntityHeading(object,135.0)
        end
    end
end)

function hackearporta(x,y,z,h)
    SetEntityCoords(PlayerPedId(),x,y,z-1,false,false,false,false)
    SetEntityHeading(PlayerPedId(),h)
    TriggerEvent("roubobancos:hackeando",x,y,z,h)
end

local rotation
function checkPorta(x,y,z,hash,h,hdefault,stats)
    local door = GetClosestObjectOfType(x,y,z,1.0,hash,false) 
    if DoesEntityExist(door) then
        if stats == true then
        	SetEntityCanBeDamaged(door,false)
        	NetworkRequestControlOfEntity(door)
            FreezeEntityPosition(door,true)
            rotation = GetEntityHeading(door)
            while math.ceil(rotation) ~= math.ceil(h) do
                rotation = rotation - 0.5
                SetEntityRotation(door, 0.0, 0.0, rotation, 1, true)
                Wait(1)
            end
        else
            SetEntityCanBeDamaged(door,false)
        	NetworkRequestControlOfEntity(door)
        	FreezeEntityPosition(door,true)
        	SetEntityHeading(door,hdefault)
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if roubo == true then
            local x,y,z,h,hdefault,hash = dadosbanco.porta.portax,dadosbanco.porta.portay,dadosbanco.porta.portaz, dadosbanco.porta.rotacao, dadosbanco.porta.hdefault, dadosbanco.porta.hash
            local portacoords = vector3(x,y,z)
            local playercoords = GetEntityCoords(PlayerPedId(),false)
            local distancia = #(playercoords - portacoords) 
            if distancia < 5 then
                if hacked == true then
                    checkPorta(x,y,z,hash,h,hdefault,true)
                else
                    checkPorta(x,y,z,hash,h,hdefault,false)
                end
            end
            if distancia > 10 and roubando == true then
                roubando = false
                marcado = true
                TriggerEvent("Notify","negado","Você se afastou muito do banco e o roubo foi cancelado.")
                TriggerServerEvent("roubobancos:cancel", dadosbanco.nameofbank,1)
                func.cancelTimer()
            end
            if roubando == true and vRP.isInComa() then
                roubando = false
                marcado = true
                TriggerEvent("Notify","negado","Você morreu e o roubo foi cancelado.")
                TriggerServerEvent("roubobancos:cancel", dadosbanco.nameofbank,2)
                func.cancelTimer()
            end
        end
    end
end)
    
RegisterNetEvent("roubobancos:hackeando")
AddEventHandler("roubobancos:hackeando", function(x,y,z,h)
    local animDict = "anim@heists@ornate_bank@hack"

    RequestAnimDict(animDict)
    RequestModel("hei_prop_hst_laptop")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestModel("hei_prop_heist_card_hack_02")

    while not HasAnimDictLoaded(animDict)
        or not HasModelLoaded("hei_prop_hst_laptop")
        or not HasModelLoaded("hei_p_m_bag_var22_arm_s")
        or not HasModelLoaded("hei_prop_heist_card_hack_02") do
        Citizen.Wait(100)
    end
    local ped = PlayerPedId()
    local targetPosition, targetRotation = (vec3(GetEntityCoords(ped))), vec3(GetEntityRotation(ped))
    local animPos = GetAnimInitialOffsetPosition(animDict, "hack_enter", x,y,z-0.1,x,y,z-0.1, 0, 2) 
    local animPos2 = GetAnimInitialOffsetPosition(animDict, "hack_loop", x,y,z-0.1,x,y,z-0.1, 0, 2)
    local animPos3 = GetAnimInitialOffsetPosition(animDict, "hack_exit", x,y,z-0.1,x,y,z-0.1, 0, 2)
    FreezeEntityPosition(ped, true)
    local netScene = NetworkCreateSynchronisedScene(animPos, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "hack_enter", 1.5, -4.0, 1, 16, 1148846080, 0)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), targetPosition, 1, 1, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, "hack_enter_bag", 4.0, -8.0, 1)
    local laptop = CreateObject(GetHashKey("hei_prop_hst_laptop"), targetPosition, 1, 1, 0)
    NetworkAddEntityToSynchronisedScene(laptop, netScene, animDict, "hack_enter_laptop", 4.0, -8.0, 1)
    local card = CreateObject(GetHashKey("hei_prop_heist_card_hack_02"), targetPosition, 1, 1, 0)
    NetworkAddEntityToSynchronisedScene(card, netScene, animDict, "hack_enter_card", 4.0, -8.0, 1)
    local netScene2 = NetworkCreateSynchronisedScene(animPos2, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, "hack_loop", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene2, animDict, "hack_loop_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene2, animDict, "hack_loop_laptop", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(card, netScene2, animDict, "hack_loop_card", 4.0, -8.0, 1)
    local netScene3 = NetworkCreateSynchronisedScene(animPos3, targetRotation, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, "hack_exit", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene3, animDict, "hack_exit_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene3, animDict, "hack_exit_laptop", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(card, netScene3, animDict, "hack_exit_card", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0) 

    local hackeando = true
    TriggerServerEvent("roubobancos:hackingstats", true)

    SetFollowPedCamViewMode(4)
    NetworkStartSynchronisedScene(netScene)
    Citizen.Wait(4500)
    NetworkStopSynchronisedScene(netScene)
    NetworkStartSynchronisedScene(netScene2)
    Citizen.Wait(2500)
    ExecuteCommand("animar off")
    TriggerEvent("utk_fingerprint:Start", 3, 3, 2, function(outcome, reason)
        if outcome == true then 
            TriggerServerEvent("roubobancos:hackingstats", false)
            TriggerServerEvent("roubobancos:hackedstats", true)
            TriggerEvent("Notify","sucesso","Porta <b>hackeada</b> com sucesso.")
            hackeando = false
        elseif outcome == false then
            TriggerServerEvent("roubobancos:hackingstats", false)
            TriggerEvent("Notify","negado","Você falhou em <b>hackear</b> a porta.")
            hackeando = false
        end
    end)

    while hackeando == true do 
        Wait(1)
        if not IsEntityPlayingAnim(PlayerPedId(), animDict, "hack_loop", 3) then
            TaskPlayAnim(PlayerPedId(), animDict, "hack_loop", 8.0, -8.0, -1, 1, 0, false, false, false)
--            vRP._playAnim(false,{{animDict,"hack_loop"}},true)
        end
    end
    
    Citizen.Wait(2500)
    NetworkStopSynchronisedScene(netScene2)
    NetworkStartSynchronisedScene(netScene3)
    Citizen.Wait(4500)
    NetworkStopSynchronisedScene(netScene3)
    DeleteObject(bag)
    DeleteObject(laptop)
    DeleteObject(card)
    FreezeEntityPosition(ped, false)
    SetFollowPedCamViewMode(1)
    SetPedComponentVariation(ped, 5, 45, 0, 0)
    ExecuteCommand("animar on")
end)

function makeEntityFaceEntity( entity1, entity2 )
    local p1 = GetEntityCoords(entity1, true)
    local p2 = GetEntityCoords(entity2, true)

    local dx = p2.x - p1.x
    local dy = p2.y - p1.y

    local heading = GetHeadingFromVector_2d(dx, dy)
    SetEntityHeading( entity1, heading )
end