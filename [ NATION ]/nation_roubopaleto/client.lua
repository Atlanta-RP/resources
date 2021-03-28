local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")

func = Tunnel.getInterface("nation_roubopaleto")

local portax = -104.6049
local portay = 6473.443
local portaz = 31.79532
local hash = 3109761617
local hdefault = 45.0
local h = 160.0
local porta = false
local roubando = false
local roubo = false
local timer = -1
local objectcoord = vector3(-104.41,6477.23,31.50)
local dinheiro
local dinheirobonito
local pegandodinheiro = false
local roubarcoord = vector3(-104.91,6476.57,30.62)
local roubarh = 314.91
local coordexplosao = vector3(-104.88,6472.66,31.82)
local explodir = false
local timerbomba = -1
local blips = {}
local blip = vector3(-103.31,6470.44,31.62)


function checarPorta()
    local door = GetClosestObjectOfType(portax,portay,portaz,1.0,hash,false) 
    if DoesEntityExist(door) then
        if porta == true and roubo == true then
        	SetEntityCanBeDamaged(door,false)
        	NetworkRequestControlOfEntity(door)
        	FreezeEntityPosition(door,true)
        	SetEntityHeading(door,h)
        else
            SetEntityCanBeDamaged(door,false)
        	NetworkRequestControlOfEntity(door)
        	FreezeEntityPosition(door,true)
        	SetEntityHeading(door,hdefault)
        end
    end
end

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


-----------------Abrir Porta----------------------

RegisterNetEvent("roubopaleto:abrirporta")
AddEventHandler("roubopaleto:abrirporta", function(aberta)
    porta = aberta
end)

-----------------------------------------------------


-----------------Iniciar Roubo----------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local distancia = #(GetEntityCoords(PlayerPedId()) - vector3(portax,portay,portaz))
        if distancia < 30 then
            checarPorta()
        end
        if roubando == true and vRP.isInComa() then
            roubando = false
            TriggerServerEvent("roubopaleto:cancelando",2,portax,portay,portaz) 
            TriggerEvent("Notify","negado","Você morreu e o roubo foi cancelado.")
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local distancia = #(GetEntityCoords(PlayerPedId()) - vector3(portax,portay,portaz))
        local distancia2 = #(GetEntityCoords(PlayerPedId()) - coordexplosao)
        if distancia < 30 and roubando == false and roubo == false then
            local x1,y1,z1 = table.unpack(blip)
            local distancia1 = #(GetEntityCoords(PlayerPedId()) - blip)
            DrawMarker(29, x1,y1,z1 ,0,0,0,0,0,0,1.0,0.7,1.0,50,150,50,200,1,0,0,1)
            if distancia1 < 2 then
                notifyBanco("Pressione ~INPUT_CONTEXT~ para iniciar um assalto ao ~b~Banco do Brasil (Paleto).")
                if IsControlJustPressed(1,51) then
                    local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
                    TriggerServerEvent("roubopaleto:iniciar", x,y,z)
                end
            end
        elseif distancia > 30 and roubando == true then
            roubando = false
            TriggerServerEvent("roubopaleto:cancelando",1,portax,portay,portaz)     
            TriggerEvent("Notify","negado","Você se afastou muito do banco e o roubo foi cancelado.")
        end
        
        if distancia < 2 and roubando == true and roubo == true and explodir == true then
            DrawMarker(42, x1,y1,z1 ,0,0,0,0,0,0,1.0,0.7,1.0,50,150,50,200,1,0,0,1)
            notifyBanco("~r~Pressione ~INPUT_CONTEXT~ para plantar a bomba.")
            if IsControlJustPressed(1,51) then
                func.checkBomba()
            end
        end
        if roubando == true and porta == true then
            if pegandodinheiro == true then
                if IsControlPressed(1,51) then
                    func.pegarDinheiro()
                end
            end
        end
    end
end)

-----------------------------------------------------

-------------------Eventos---------------------------


RegisterNetEvent("roubopaleto:iniciando")
AddEventHandler("roubopaleto:iniciando", function(stats)
    local playercoords = GetEntityCoords(PlayerPedId())
    local distancia = #(playercoords - vector3(portax,portay,portaz))
    if distancia < 30 and roubando == false then
        roubando = stats
        if roubando == true then
            notifyBanco("~y~Segure o roubo por ~g~10 minutos~y~.")
            Wait(3000)
            notifyBanco("~y~Se você se afastar do banco antes do tempo acabar, perderá seu ~b~dinheiro sujo~y~.")
            Wait(5000)
            notifyBanco("~y~Exploda a porta com ~r~2x C4~y~.")
        end
    end
end)


RegisterNetEvent("roubopaleto:removerdinheiro")
AddEventHandler("roubopaleto:removerdinheiro", function()
    local playercoords = GetEntityCoords(PlayerPedId())
    local distancia = #(playercoords - vector3(portax,portay,portaz))
    if distancia < 35 then
        func.removeDinheiro()
    end
end)

RegisterNetEvent("roubopaleto:terminando")
AddEventHandler("roubopaleto:terminando", function(stats)
    roubando = stats
    roubo = stats
    ShowAdvancedNotification("CHAR_DETONATEBOMB", "~b~Banco do Brasil", "~r~Roubo Terminado", "~b~O roubo no Banco do Brasil (Paleto) foi terminado.")
end)


RegisterNetEvent("roubopaleto:iniciado")
AddEventHandler("roubopaleto:iniciado", function(status1)
    roubo = status1
    ShowAdvancedNotification("CHAR_DETONATEBOMB", "~b~Banco do Brasil", "~r~Roubo em andamento", "~y~O Banco do Brasil (Paleto) está sendo roubado nesse momento.")
end)

RegisterNetEvent("roubopaleto:cancelou")
AddEventHandler("roubopaleto:cancelou", function(tipo)
    local playercoords = GetEntityCoords(PlayerPedId())
    local distancia = #(playercoords - vector3(portax,portay,portaz))
    if distancia < 30 and roubando == true then
        if tipo == 1 then
            TriggerEvent("Notify","aviso","Alguém do grupo se afastou muito do banco e o roubo foi cancelado.")
        elseif tipo == 2 then
            TriggerEvent("Notify","aviso","Alguém do grupo morreu e o roubo foi cancelado.")
        end
    end
    roubando = false
    roubo = false
end)



RegisterNetEvent("roubopaleto:explosao")
AddEventHandler("roubopaleto:explosao",function()
    local playercoords = GetEntityCoords(PlayerPedId())
    local distancia = #(playercoords - vector3(portax,portay,portaz))
    if distancia < 30 then
        AddExplosion(-104.88,6472.66,31.82, 5, 100.0, true, false, 5.0)
    end
end)

RegisterNetEvent("roubopaleto:cpodeexplodir")
AddEventHandler("roubopaleto:cpodeexplodir",function(podeounpode)
    explodir = podeounpode
end)

-----------------------------------------------------




-----------------Timers----------------------

RegisterNetEvent("roubopaleto:timer")
AddEventHandler("roubopaleto:timer", function(tempo)
    timer = tempo
end)

RegisterNetEvent("roubopaleto:timerbomba")
AddEventHandler("roubopaleto:timerbomba", function(tempos)
    timerbomba = tempos
end)

-----------------------------------------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if timer >= 0 and roubando == true then
            bank_drawTxt(0.70, 1.44, 1.0,1.0,0.4, "Roubo a Banco em Andamento: falta ~r~" .. timer .. "~w~ segundo(s) restantes para concluir o Assalto", 255, 255, 255, 255)
        end
        if timer == 0 then
            timer = -1
        end
        if timerbomba >= 0 and roubando == true then
            notifyBanco("~y~A bomba explodirá em ~r~"..timerbomba.." ~y~segundo(s).")
        end
        if timerbomba == 0 and roubando == true then
            notifyBanco("~r~BOOM!")
            timerbomba = -1
        end
    end
end)

-----------------------------------------------------

-----------------------BLIPS DOS COXA----------------------------

RegisterNetEvent("roubopaleto:blipcoxa")
AddEventHandler("roubopaleto:blipcoxa",function(x,y,z)
    blips[PlayerId()] = vRP.addBlip(x,y,z,431,6,"Roubo",1.4,true)
end)

RegisterNetEvent("roubopaleto:rblipcoxa")
AddEventHandler("roubopaleto:rblipcoxa",function(x,y,z)
    if blips[PlayerId()] then
        vRP.removeBlip(blips[PlayerId()])
    end
end)

-----------------------------------------------------------------


-----------------Criar Objeto----------------------

RegisterNetEvent("roubopaleto:criarobjeto")
AddEventHandler("roubopaleto:criarobjeto", function()
    local playercoords = GetEntityCoords(PlayerPedId())
    local distancia = #(playercoords - vector3(portax,portay,portaz))
    if distancia < 30 and roubando == true and roubo == true then
        local model = GetHashKey('prop_cash_crate_01')
        RequestModel(model)
        while not HasModelLoaded(model) do
        	Wait(0)
     	end
     	if object == nil then 
     		object = CreateObject(model, objectcoord, false, false)
        	FreezeEntityPosition(object, true)
        	SetEntityHeading(object,135.0)
        end
    end
end)

RegisterNetEvent("roubopaleto:criarbomba")
AddEventHandler("roubopaleto:criarbomba", function()
    local playercoords = GetEntityCoords(PlayerPedId())
    local distancia = #(playercoords - coordexplosao)
    if distancia < 2 and roubando == true and roubo == true then
        while (not HasAnimDictLoaded("mp_car_bomb")) do 
            RequestAnimDict("mp_car_bomb")
            Citizen.Wait(0)
        end
     	if bomba == nil then 
     	    local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
     	    TriggerServerEvent("roubopaleto:plantou")
     	    SetEntityCoords(PlayerPedId(),-104.69,6472.42,30.62,false,false,false,false)
     	    SetEntityHeading(PlayerPedId(),45.61)
     	    FreezeEntityPosition(PlayerPedId(-1),true)
     		bomba = CreateObject(GetHashKey("prop_bomb_01_s"), x, y, z+0.2, true, true, true)
     		AttachEntityToEntity(bomba, PlayerPedId(-1), GetPedBoneIndex(PlayerPedId(-1), 28422), 0.0, 0.0, 0.0, 80.0, 160.0, 0, true, true, false, true, 1, true)
     		TaskPlayAnim(PlayerPedId(-1), "mp_car_bomb", "car_bomb_mechanic", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
     		Citizen.Wait(2000)
     		FreezeEntityPosition(PlayerPedId(-1),false)
     		FreezeEntityPosition(bomba,true)
     		DetachEntity(bomba, 1, 1)
     		ClearPedTasksImmediately(PlayerPedId(-1))
     		Wait(10000)
     		DeleteObject(bomba)
     		bomba = nil
        end
    end
end)

-----------------------------------------------------




-----------------Dinheiro----------------------

RegisterNetEvent("roubopaleto:dinheiro")
AddEventHandler("roubopaleto:dinheiro", function(money,bmoney)
    dinheiro = money
    dinheirobonito = bmoney
end)

-----------------------------------------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if roubando == true and porta == true then
            local playercoords = GetEntityCoords(PlayerPedId())
            local distancia = #(playercoords - objectcoord)
            if dinheiro then
                if dinheirobonito and distancia < 2 then
                    local x1,y1,z1 = table.unpack(objectcoord)
                    DrawText3D(x1, y1, z1 + 0.5 , '~g~$~w~'..dinheirobonito, 0.8)
                end
                if dinheiro > 0 and distancia < 2 then
                    if pegandodinheiro == false then
                        notifyBanco("~g~Pressione ~INPUT_DETONATE~ para começar a roubar.")
                    elseif pegandodinheiro == true then
                        notifyBanco("~r~Segure ~INPUT_CONTEXT~ para pegar o dinheiro.")
                    end
                    if IsControlJustPressed(1,47) and pegandodinheiro == false then
                        SetEntityCoords(PlayerPedId(),roubarcoord,false,false,false,false )
    					SetEntityHeading(PlayerPedId(),roubarh)
    					SetPedComponentVariation(PlayerPedId(),5,45,0,2)
    					SetCurrentPedWeapon(PlayerPedId(),GetHashKey("WEAPON_UNARMED"),true)
    					vRP._playAnim(false,{{"anim@heists@ornate_bank@grab_cash_heels","grab"}},true)
                        pegandodinheiro = true
                    end
                    if (IsControlJustPressed(1,167) or IsControlJustPressed(1,168)) then
                        pegandodinheiro = false
                    end
                else 
                    pegandodinheiro = false
                end
                if dinheiro == 0 and distancia < 2 then        
                    vRP._stopAnim(false)
                end
            end
        end
    end
end)

-------------------------------------------------------------------
