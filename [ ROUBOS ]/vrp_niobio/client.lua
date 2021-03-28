local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
func = {}
Tunnel.bindInterface("vrp_niobio",func)
vSERVER = Tunnel.getInterface("vrp_niobio")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local hackeando = false
local roubando = false
local cdsx = 3611.11
local cdsy = 3728.08
local cdsz = 29.69
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO LOCAL DO ROUBO 
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
	{ ['id'] = 1, ['x'] = 3600.79, ['y'] = 3718.35, ['z'] = 29.69 },
	{ ['id'] = 2, ['x'] = 3585.58, ['y'] = 3700.7, ['z'] = 28.83 }
}
local lochacker = {
	{ ['id'] = 1, ['x'] = 3556.4, ['y'] = 3665.64, ['z'] = 28.13 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
        local uru = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local bowz,cdz = GetGroundZFor_3dCoord(cdsx,cdsy,cdsz)
		local distance = GetDistanceBetweenCoords(cdsx,cdsy,cdsz,x,y,z,true)
		if distance <= 5.0 and not roubando then
            uru = 4
            Opacidade = math.floor(255 - (distance * 10))
            TextoMarker(cdsx,cdsy,cdsz+0.4, "APERTE ~o~[ E ]~w~ PARA ~o~INICIAR O ROUBO~w~", Opacidade, 0.54, 0.54)
            DrawMarker(27,cdsx,cdsy,cdsz-0.5, 0, 0, 0, 0, 0, 0, 1.501,1.5001,0.5001,255,165,0,155, 0, 0, 0, 1)
            TextoMarker(cdsx,cdsy,cdsz+0.7, '~o~~h~AÇÃO: LABORATÓRIO HUMANE - NIÓBIO', Opacidade, 0.54, 0.54)
			if IsControlJustPressed(0,38) and vSERVER.checkAuth() and not IsPedInAnyVehicle(ped) then
				if vSERVER.checkPolice(cdsx,cdsy,cdsz) then                    
    				vSERVER.startNiobio()
                    vSERVER.sendMessageAll("Invasão a Humane sendo iniciada.")
                    roubando = true
                    TriggerServerEvent('InteractSound_SV:PlayOnAll', 'sirene', 0.6)
                    Citizen.Wait(34900)
                    TriggerServerEvent('InteractSound_SV:PlayOnAll', 'sirene', 0.6)
                    Citizen.Wait(34900)      
                    TriggerServerEvent('InteractSound_SV:PlayOnAll', 'sirene', 0.5)
                    Citizen.Wait(34900) 
                    TriggerServerEvent('InteractSound_SV:PlayOnAll', 'sirene', 0.5)
				end
			end
		end	
        Citizen.Wait(uru)	
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HACKER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local uru = 1000
		local ped = PlayerPedId()
		local x,y,z = GetEntityCoords(ped)
		if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_UNARMED") and not IsPedInAnyVehicle(ped) then
			for k,v in pairs(lochacker) do
				if Vdist(v.x,v.y,v.z,x,y,z) <= 1 and roubando then
                    uru = 4
					drawTxt("PRESSIONE  ~o~G~w~  PARA ~o~HACKEAR A PORTA~w~",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,47) and vSERVER.checkPermission() and vSERVER.checkHacker() then	
                        vSERVER.sendMessageAll("ATENÇÃO: Os assaltantes estão invadindo a Humane.")
                        TriggerEvent("status:hacker_digital",true)
						TriggerEvent('cancelando',true)
						
						prop = GetHashKey("prop_cs_hand_radio")
						object = CreateObject(GetHashKey("prop_police_radio_main"), GetEntityCoords(PlayerPedId()), true)	
						AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), -0.03, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
 
						RequestAnimDict('weapons@projectile@sticky_bomb')
						while not HasAnimDictLoaded('weapons@projectile@sticky_bomb') do
						Citizen.Wait(100)
						end 

						TaskPlayAnim(ped, 'weapons@projectile@sticky_bomb', 'plant_vertical', 8.0, -8, -1, 49, 0, 0, 0, 0)		
						TriggerEvent("progress", 1900, "CONECTANDO AO DISPOSITIVO...")
						Citizen.Wait(1000)
						DeleteEntity(object)
						Citizen.Wait(700)
						ClearPedTasksImmediately(GetPlayerPed(-1))
						Citizen.Wait(200)
						TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_MOBILE", 0, true)						
						TriggerEvent("progress", 5000, "ACESSANDO O SISTEMA...")
						Citizen.Wait(7100)
						TriggerEvent("mhacking:show")
						TriggerEvent("mhacking:start",3,20,mycallback)																					
					end
				end
			end			
		end
        Citizen.Wait(uru)
	end
end)
local chance = 1
local bomba = GetHashKey("prop_bomb_01_s") 
-----------------------------------------------------------------------------------------------------------------------------------------
-- HACKEAR
-----------------------------------------------------------------------------------------------------------------------------------------
function mycallback(success,time)
	if success then	
		TriggerEvent("mhacking:hide")
		TriggerEvent("utk_fingerprint:Start", 4, 6, 2, function(outcome, reason)        
    		if outcome == true then -- reason will be nil if outcome is true
       			hackeando = true
                TriggerServerEvent("test:forcedelete3")
    		elseif outcome == false then
       			chance = chance + 1
    		end
		end)
        vSERVER.sendMessageAll("ATUALIZAÇÃO: Os assaltantes acabaram de invadir o sistema.")
		DeleteObject(laptop)
		vRP._stopAnim(false)
		TriggerEvent('cancelando',false)
	else
		chance = chance + 1
		TriggerEvent("mhacking:hide")
		DeleteObject(laptop)
		vRP._stopAnim(false)
		TriggerEvent('cancelando',false)
	end
end
local deleteDoor2 = false
RegisterNetEvent('deleteDoor:allow2')
AddEventHandler('deleteDoor:allow2', function(status)
    deleteDoor2 = true
end)
DoorsHashes2 = {
    -421709054,
    1282049587 
}
DoorsCoords2 = {
    { 3601.35, 3717.96, 29.69 },
    { 3600.18, 3718.65, 29.69 }
}
local DoorXCoords2 = 3601.35
local DoorYCoords2 = 3717.96
local DoorZCoords2 = 29.69
Citizen.CreateThread(function()
    while true do
        local uru = 1000
        local ped = PlayerPedId()
        local x,y,z = table.unpack(GetEntityCoords(ped))
        if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_UNARMED") and not IsPedInAnyVehicle(ped) then            
            if Vdist(DoorXCoords2,DoorYCoords2,DoorZCoords2,x,y,z) <= 1 and roubando then
                uru = 4
                drawTxt("PRESSIONE  ~o~G~w~  PARA ~o~APLICAR A C4~w~",4,0.5,0.93,0.50,255,255,255,180)
                if IsControlJustPressed(0,47) and Vdist(DoorsCoords2[1][1], DoorsCoords2[1][2], DoorsCoords2[1][3],x,y,z) <= 2 and vSERVER.checkPermission() and vSERVER.checkNiobio() then
                    TriggerServerEvent("test:forcedelete2")
                    local bombax1 = 3600.79
                    local bombay1 = 3718.35
                    local bombaz1 = 29.69
                    vRP._playAnim(false,{{'amb@medic@standing@kneel@idle_a','idle_a'}},false)                    
                    loadModel(bomba)
                    Wait(10)                                               
                    bomba = CreateObject(bomba,bombax1,bombay1,bombaz1, false, true)                    
                    SetTimeout(15000,function()
                        vSERVER.sendMessageAll("ATUALIZAÇÃO: Os assaltantes acabaram de explodir uma parte do laboratório.")
                        AddExplosion(bombax1,bombay1,bombaz1,1,15.0,true,false,true)                            
                        DeleteEntity(bomba)                                                 
                    end)
                end
            end            
        end
        Citizen.Wait(uru)
    end
end)
Citizen.CreateThread(function()
    while true do
        if deleteDoor2 then
            Citizen.Wait(15000)
            local objectId1 = GetClosestObjectOfType(DoorsCoords2[1][1], DoorsCoords2[1][2], DoorsCoords2[1][3], 3.0, DoorsHashes2[1], false, 0, 0)
            local objectId2 = GetClosestObjectOfType(DoorsCoords2[2][1], DoorsCoords2[2][2], DoorsCoords2[2][3], 3.0, DoorsHashes2[2], false, 0, 0)
            SetEntityAsMissionEntity(objectId1, true, true)
            SetEntityAsMissionEntity(objectId2, true, true)
            DeleteEntity(objectId1)
            DeleteEntity(objectId2)
            deleteDoor2 = false
        end
        Citizen.Wait(500)
    end
end)
Citizen.CreateThread(function()
    while true do
        if vSERVER.checkPermission2() then
            Citizen.Wait(1000)
            local objectId1 = GetClosestObjectOfType(DoorsCoords2[1][1], DoorsCoords2[1][2], DoorsCoords2[1][3], 3.0, DoorsHashes2[1], false, 0, 0)
            local objectId2 = GetClosestObjectOfType(DoorsCoords2[2][1], DoorsCoords2[2][2], DoorsCoords2[2][3], 3.0, DoorsHashes2[2], false, 0, 0)
            SetEntityAsMissionEntity(objectId1, true, true)
            SetEntityAsMissionEntity(objectId2, true, true)
            DeleteEntity(objectId1)
            DeleteEntity(objectId2)
            deleteDoor2 = false
        end
        Citizen.Wait(1000)
    end
end)
------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------PORTA2----------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
local deleteDoor = false
RegisterNetEvent('deleteDoor:allow')
AddEventHandler('deleteDoor:allow', function(status)
    deleteDoor = true
end)
DoorsHashes = {
    -421709054,
    1282049587 
}
DoorsCoords = {
    { 3585.066,3701.095,28.82138 },
    { 3585.86, 3700.213, 28.82138 }
}
local DoorXCoords = 3585.066
local DoorYCoords = 3701.095
local DoorZCoords = 28.82138
Citizen.CreateThread(function()
    while true do
        local uru = 4
        local ped = PlayerPedId()
        local x,y,z = table.unpack(GetEntityCoords(ped))
        if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_UNARMED") and not IsPedInAnyVehicle(ped) then            
            if Vdist(DoorXCoords,DoorYCoords,DoorZCoords,x,y,z) <= 1 and roubando then
                uru = 4
                drawTxt("PRESSIONE  ~o~G~w~  PARA ~o~APLICAR A C4~w~",4,0.5,0.93,0.50,255,255,255,180)
                if IsControlJustPressed(0,47) and Vdist(DoorsCoords[1][1], DoorsCoords[1][2], DoorsCoords[1][3],x,y,z) <= 2 and vSERVER.checkPermission() and vSERVER.checkNiobio() then
                    TriggerServerEvent("test:forcedelete")
                    local bombax2 = 3585.58
                    local bombay2 = 3700.7
                    local bombaz2 = 28.83                                                          
                    vRP._playAnim(false,{{'amb@medic@standing@kneel@idle_a','idle_a'}},false)                                    
                    loadModel(bomba)
                    Wait(10)                                               
                    bomba = CreateObject(bomba,bombax2,bombay2,bombaz2, false, true)                    
                    SetTimeout(15000,function()
                        vSERVER.sendMessageAll("ATUALIZAÇÃO: Ouvimos mais uma explosão no Laboratório. Os assaltantes estão com tudo. Será que a Polícia será capaz de impedi-los?")
                        AddExplosion(bombax2,bombay2,bombaz2,1,15.0,true,false,true)                            
                        DeleteEntity(bomba)                                                 
                    end)
                end
            end                
        end
        Citizen.Wait(uru)
    end
end)
Citizen.CreateThread(function()
    while true do
        if vSERVER.checkPermission2() then
            Citizen.Wait(1000)
            local objectId1 = GetClosestObjectOfType(DoorsCoords[1][1], DoorsCoords[1][2], DoorsCoords[1][3], 3.0, DoorsHashes[1], false, 0, 0)
            local objectId2 = GetClosestObjectOfType(DoorsCoords[2][1], DoorsCoords[2][2], DoorsCoords[2][3], 3.0, DoorsHashes[2], false, 0, 0)
            SetEntityAsMissionEntity(objectId1, true, true)
            SetEntityAsMissionEntity(objectId2, true, true)
            DeleteEntity(objectId1)
            DeleteEntity(objectId2)
            deleteDoor = false
        end
        Citizen.Wait(1000)
    end
end)
Citizen.CreateThread(function()
    while true do
        if deleteDoor then
            Citizen.Wait(15000)
            local objectId1 = GetClosestObjectOfType(DoorsCoords[1][1], DoorsCoords[1][2], DoorsCoords[1][3], 3.0, DoorsHashes[1], false, 0, 0)
            local objectId2 = GetClosestObjectOfType(DoorsCoords[2][1], DoorsCoords[2][2], DoorsCoords[2][3], 3.0, DoorsHashes[2], false, 0, 0)
            SetEntityAsMissionEntity(objectId1, true, true)
            SetEntityAsMissionEntity(objectId2, true, true)
            DeleteEntity(objectId1)
            DeleteEntity(objectId2)
            deleteDoor = false
        end
        Citizen.Wait(500)
    end
end)
------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------PORTA3----------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
local deleteDoor3 = false
RegisterNetEvent('deleteDoor:allow3')
AddEventHandler('deleteDoor:allow3', function(status)
    deleteDoor3 = true
end)
DoorsHashes3 = {
    161378502
}
DoorsCoords3 = {
    { 3557.38, 3669.8, 28.13 }
}
local DoorXCoords3 = 3557.38
local DoorYCoords3 = 3669.8
local DoorZCoords3 = 28.13
Citizen.CreateThread(function()
    while true do
        if deleteDoor3 then
            Citizen.Wait(2000)
            local objectId1 = GetClosestObjectOfType(DoorsCoords3[1][1], DoorsCoords3[1][2], DoorsCoords3[1][3], 3.0, DoorsHashes3[1], false, 0, 0)
            SetEntityAsMissionEntity(objectId1, true, true)
            DeleteEntity(objectId1)
            deleteDoor3 = false
        end
        Citizen.Wait(500)
    end
end)
Citizen.CreateThread(function()
    while true do
        if vSERVER.checkPermission2() then
            Citizen.Wait(2000)
            local objectId1 = GetClosestObjectOfType(DoorsCoords3[1][1], DoorsCoords3[1][2], DoorsCoords3[1][3], 3.0, DoorsHashes3[1], false, 0, 0)           
            SetEntityAsMissionEntity(objectId1, true, true)
            DeleteEntity(objectId1)
            deleteDoor3 = false
        end
        Citizen.Wait(1000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERS
-----------------------------------------------------------------------------------------------------------------------------------------
local robbery = false
local timedown = 0
local robbers = {
	[1] = { ['x'] = 3559.88, ['y'] = 3674.68, ['z'] = 28.13 }	
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERSBUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local uru = 1000
		if not robbery then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			for k,v in pairs(robbers) do
                uru = 4
				local distance = Vdist(x,y,z,v.x,v.y,v.z)
				if distance <= 1.1 and GetEntityHealth(ped) > 101 then					
					drawText("PRESSIONE  ~o~E~w~  PARA ~o~INICIAR O ROUBO~w~",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and timedown <= 0 then										
						timedown = 3
                        if chance > 6 then
                        chance = 6
                        end						
						vSERVER.Start(chance,v.x,v.y,v.z)
                        vSERVER.sendMessageAll("ATUALIZAÇÃO: A Segurança dos Cofres foi violada de acordo com a segurança do laboratório. A Polícia está a caminho do local.") 
					end
				end
			end
		else
            uru = 4
			drawText("PARA CANCELAR O ROUBO SAIA DA SALA",4,0.5,0.88,0.36,255,255,255,50)
			drawText("AGUARDE ~o~"..timedown.." SEGUNDOS~w~ ATÉ QUE TERMINE O ROUBO",4,0.5,0.9,0.46,255,255,255,150)
			if GetEntityHealth(PlayerPedId()) <= 101 then
				robbery = false
				vSERVER.pararroubo()
			end
		end
        Citizen.Wait(uru)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function func.inicioroubo(time,x2,y2,z2)
	robbery = true
	timedown = time
	SetPedComponentVariation(PlayerPedId(),5,45,0,2)
	Citizen.CreateThread(function()
		while robbery do
			Citizen.Wait(500)
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local distance = Vdist(x,y,z,x2,y2,z2)
			if distance >= 5.0 then
				robbery = false
				vSERVER.pararroubo()
			end
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMEDOWN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local uru = 1000
		if timedown >= 1 then
			timedown = timedown - 1
			if timedown == 0 then
                uru = 4
				robbery = false
			end
		end
		Citizen.Wait(uru)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextScale(scale,scale)
    SetTextColour(r,g,b,a)
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x,y)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function drawText(text,font,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextScale(scale,scale)
    SetTextColour(r,g,b,a)
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x,y)
end
function loadModel(model)
    Citizen.CreateThread(function()
        while not HasModelLoaded(model) do
            RequestModel(model)
          Citizen.Wait(1)
        end
    end)
end
function TextoMarker(x,y,z, text, Opacidade, s1, s2)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())    
    if onScreen then 
        SetTextScale(s1, s2)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, Opacidade)
        SetTextDropshadow(0, 0, 0, 0, Opacidade)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end