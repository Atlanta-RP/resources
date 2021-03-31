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
Tunnel.bindInterface("vrp_robnpc",cnVRP)
vSERVER = Tunnel.getInterface("vrp_robnpc")

local robbed = false
local timeToWait = math.random(60000,1800000)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsControlJustPressed(0, 38) then
			local aiming, targetPed = GetEntityPlayerIsFreeAimingAt(PlayerId(-1))
			if aiming then
				
				local pP = GetPlayerPed(-1)
				local pCoords = GetEntityCoords(pP, true)
				local tCoords = GetEntityCoords(targetPed, true)
				
				local dict = "random@mugging3"
				RequestAnimDict(dict)
				while not HasAnimDictLoaded(dict) do
					Citizen.Wait(100)
				end
				
				if DoesEntityExist(targetPed) and IsEntityAPed(targetPed) then
					--KnockPedOffVehicle(targetPed)
					
					--KnockFromVehicle(targetPed, GetVehiclePedIsIn(ped), force, wasFall)
					if IsPedDeadOrDying(targetPed, true) then
						vSERVER.triedRobDead()
					else if GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, tCoords.x, tCoords.y, tCoords.z, true) < 3 then
						TaskPlayAnim(targetPed, "random@mugging3", "handsup_standing_base", 8.0, -8, .01, 49, 0, 1, 1, 1)
						--TaskStandStill(targetPed,3000)
						FreezeEntityPosition(targetPed, true)
						robbed = true
						Wait(3000)
						FreezeEntityPosition(targetPed, false)
						SetPedConfigFlag(targetPed,116,true)						
						vSERVER.robPed()
						Citizen.Wait(timeToWait)
						robbed = false
						end
					end
				end
			end
		end
	end
end)


function notify(m_text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(m_text)
	DrawNotification(true, false)
end