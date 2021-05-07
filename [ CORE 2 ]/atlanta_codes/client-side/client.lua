-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPATCH
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for i = 1,12 do
		EnableDispatchService(i,false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TYREBURST
-----------------------------------------------------------------------------------------------------------------------------------------
local oldSpeed = 0
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			timeDistance = 4
			SetPedHelmet(ped,false)
			DisableControlAction(0,345,true)
			local veh = GetVehiclePedIsUsing(ped)
			if GetPedInVehicleSeat(veh,-1) == ped then
				local speed = GetEntitySpeed(veh) * 2.236936
				if speed ~= oldSpeed then
					if (oldSpeed - speed) >= 60 then
						TriggerServerEvent("upgradeStress",10)
						if GetVehicleClass(veh) ~= 8 then
							vehicleTyreBurst(veh)
						end
					end
					oldSpeed = speed
				end
			end
		else
			oldSpeed = 0
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLETYREBURST
-----------------------------------------------------------------------------------------------------------------------------------------
function vehicleTyreBurst(vehicle)
	local tyre = math.random(4)
	if tyre == 1 then
		if not IsVehicleTyreBurst(vehicle,0,false) then
			SetVehicleTyreBurst(vehicle,0,true,1000.0)
		end
	elseif tyre == 2 then
		if not IsVehicleTyreBurst(vehicle,1,false) then
			SetVehicleTyreBurst(vehicle,1,true,1000.0)
		end
	elseif tyre == 3 then
		if not IsVehicleTyreBurst(vehicle,4,false) then
			SetVehicleTyreBurst(vehicle,4,true,1000.0)
		end
	elseif tyre == 4 then
		if not IsVehicleTyreBurst(vehicle,5,false) then
			SetVehicleTyreBurst(vehicle,5,true,1000.0)
		end
	end

	if math.random(100) < 30 then
		Citizen.Wait(10)
		vehicleTyreBurst(vehicle)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {
	{ -1137.98,-1990.62,13.17,446,75,"Atlanta Customs",0.6 },
	{ 538.29,-179.33,54.49,446,75,"Auto Exotic",0.6 },
	{ 298.43,-584.54,43.27,80,35,"Hospital",0.6 },
	{ 55.43,-876.19,30.66,357,14,"Garagem",0.6 },
	{ 317.25,2623.14,44.46,357,14,"Garagem",0.6 },
	{ -773.34,5598.15,33.60,357,14,"Garagem",0.6 },
	{ 275.23,-345.54,45.17,357,14,"Garagem",0.6 },
	{ 596.40,90.65,93.12,357,14,"Garagem",0.6 },
	{ -340.76,265.97,85.67,357,14,"Garagem",0.6 },
	{ -2030.01,-465.97,11.60,357,14,"Garagem",0.6 },
	{ -1184.92,-1510.00,4.64,357,14,"Garagem",0.6 },
	{ -73.44,-2004.99,18.27,357,14,"Garagem",0.6 },
	{ 214.02,-808.44,31.01,357,14,"Garagem",0.6 },
	{ -348.88,-874.02,31.31,357,14,"Garagem",0.6 },
	{ 67.74,12.27,69.21,357,14,"Garagem",0.6 },
	{ 361.90,297.81,103.88,357,14,"Garagem",0.6 },
	{ 1035.89,-763.89,57.99,357,14,"Garagem",0.6 },
	{ -796.63,-2022.77,9.16,357,14,"Garagem",0.6 },
	{ 453.27,-1146.76,29.52,357,14,"Garagem",0.6 },
	{ 528.66,-146.3,58.38,357,14,"Garagem",0.6 },
	{ -1159.48,-739.32,19.89,357,14,"Garagem",0.6 },
	{ 29.29,-1770.35,29.61,357,14,"Garagem",0.6 },
	{ 101.22,-1073.68,29.38,357,14,"Garagem",0.6 },

	{ 25.68,-1346.6,29.5,52,36,"Loja de Departamento",0.6 },
	{ 361.08,-1584.91,29.3,60,4,"Departamento Policial",0.6 },
	{ 1851.45,3686.71,34.26,60,4,"Departamento Policial",0.6 },
	{ -448.18,6011.68,31.71,60,4,"Departamento Policial",0.6 },
	{ 2556.47,382.05,108.63,52,36,"Loja de Departamento",0.6 },
	{ 1163.55,-323.02,69.21,52,36,"Loja de Departamento",0.6 },
	{ -707.31,-913.75,19.22,52,36,"Loja de Departamento",0.6 },
	{ -47.72,-1757.23,29.43,52,36,"Loja de Departamento",0.6 },
	{ 373.89,326.86,103.57,52,36,"Loja de Departamento",0.6 },
	{ -3242.95,1001.28,12.84,52,36,"Loja de Departamento",0.6 },
	{ 1729.3,6415.48,35.04,52,36,"Loja de Departamento",0.6 },
	{ 548.0,2670.35,42.16,52,36,"Loja de Departamento",0.6 },
	{ 1960.69,3741.34,32.35,52,36,"Loja de Departamento",0.6 },
	{ 2677.92,3280.85,55.25,52,36,"Loja de Departamento",0.6 },
	{ 1698.5,4924.09,42.07,52,36,"Loja de Departamento",0.6 },
	{ -1820.82,793.21,138.12,52,36,"Loja de Departamento",0.6 },
	{ 1393.21,3605.26,34.99,52,36,"Loja de Departamento",0.6 },
	{ -2967.78,390.92,15.05,52,36,"Loja de Departamento",0.6 },
	{ -3040.14,585.44,7.91,52,36,"Loja de Departamento",0.6 },
	{ 1135.56,-982.24,46.42,52,36,"Loja de Departamento",0.6 },
	{ 1166.0,2709.45,38.16,52,36,"Loja de Departamento",0.6 },
	{ -1487.21,-378.99,40.17,52,36,"Loja de Departamento",0.6 },
	{ -1222.76,-907.21,12.33,52,36,"Loja de Departamento",0.6 },

	{ 1692.62,3759.50,34.70,76,6,"Loja de Armamentos",0.6 },
	{ 252.89,-49.25,69.94,76,6,"Loja de Armamentos",0.6 },
	{ 843.28,-1034.02,28.19,76,6,"Loja de Armamentos",0.6 },
	{ -331.35,6083.45,31.45,76,6,"Loja de Armamentos",0.6 },
	{ -663.15,-934.92,21.82,76,6,"Loja de Armamentos",0.6 },
	{ -1305.18,-393.48,36.69,76,6,"Loja de Armamentos",0.6 },
	{ -1118.80,2698.22,18.55,76,6,"Loja de Armamentos",0.6 },
	{ 2568.83,293.89,108.73,76,6,"Loja de Armamentos",0.6 },
	{ -3172.68,1087.10,20.83,76,6,"Loja de Armamentos",0.6 },
	{ 21.32,-1106.44,29.79,76,6,"Loja de Armamentos",0.6 },
	{ 811.19,-2157.67,29.61,76,6,"Loja de Armamentos",0.6 },

	{ -1213.44,-331.02,37.78,207,46,"Banco",0.6 },
	{ -351.59,-49.68,49.04,207,46,"Banco",0.6 },
	{ 313.47,-278.81,54.17,207,46,"Banco",0.6 },
	{ 149.35,-1040.53,29.37,207,46,"Banco",0.6 },
	{ -2962.60,482.17,15.70,207,46,"Banco",0.6 },
	{ -112.81,6469.91,31.62,207,46,"Banco",0.6 },
	{ 1175.74,2706.80,38.09,207,46,"Banco",0.6 },

	{ -51.82,-1111.38,26.44,225,4,"Deluxe Motors",0.6 },

	{ -815.12,-184.15,37.57,71,4,"Barbearia",0.6 },
	{ 138.13,-1706.46,29.3,71,4,"Barbearia",0.6 },
	{ -1280.92,-1117.07,7.0,71,4,"Barbearia",0.6 },
	{ 1930.54,3732.06,32.85,71,4,"Barbearia",0.6 },
	{ 1214.2,-473.18,66.21,71,4,"Barbearia",0.6 },
	{ -33.61,-154.52,57.08,71,4,"Barbearia",0.6 },
	{ -276.65,6226.76,31.7,71,4,"Barbearia",0.6 },

	{ 75.35,-1392.92,29.38,366,4,"Loja de Roupas",0.6 },
	{ -710.15,-152.36,37.42,366,4,"Loja de Roupas",0.6 },
	{ -163.73,-303.62,39.74,366,4,"Loja de Roupas",0.6 },
	{ -822.38,-1073.52,11.33,366,4,"Loja de Roupas",0.6 },
	{ -1193.13,-767.93,17.32,366,4,"Loja de Roupas",0.6 },
	{ -1449.83,-237.01,49.82,366,4,"Loja de Roupas",0.6 },
	{ 4.83,6512.44,31.88,366,4,"Loja de Roupas",0.6 },
	{ 1693.95,4822.78,42.07,366,4,"Loja de Roupas",0.6 },
	{ 125.82,-223.82,54.56,366,4,"Loja de Roupas",0.6 },
	{ 614.2,2762.83,42.09,366,4,"Loja de Roupas",0.6 },
	{ 1196.72,2710.26,38.23,366,4,"Loja de Roupas",0.6 },
	{ -3170.53,1043.68,20.87,366,4,"Loja de Roupas",0.6 },
	{ -1101.42,2710.63,19.11,366,4,"Loja de Roupas",0.6 },
	{ 425.6,-806.25,29.5,366,4,"Loja de Roupas",0.6 },
	{ -1082.22,-247.54,37.77,617,4,"Premium Store",0.6 },
	{ -1728.06,-1050.69,1.71,266,4,"Embarcações",0.6 },
	{ 1966.36,3975.86,31.51,266,4,"Embarcações",0.6 },
	{ -776.72,-1495.02,2.29,266,4,"Embarcações",0.6 },
	{ -893.97,5687.78,3.29,266,4,"Embarcações",0.6 },

	{ 132.6,-1305.06,29.2,93,4,"Vanilla Unicorn",0.6 },
	{ -565.14,271.56,83.02,93,4,"Tequi-la-la",0.6 },
	{ -1839.16,-1186.89,19.19,93,4,"Pearls",0.6 },
	{ 346.81,296.82,99.7,93,4,"Galaxy",0.6 },
	--{ -163.52,298.61,98.9,89,0,"Restaurante Chinês",0.6 },
	{ 420.08,-1085.15,30.05,408,3,"Tribunal",0.6 },
	{ -603.07,-932.9,23.87,184,1,"Weazel News",0.6 },
	{ 377.49,-828.07,29.31,496,2,"WeedZ",0.6 }, 
	{737.04,2522.04,73.21,564,0,"Gravadora",0.6},
	{-1173.68,-887.94,13.93,103,1,"BurgerShot",0.6},
	--{79.05,264.9,109.2,103,1,"Mc Donalds",0.6},
	{371.74,-943.12,29.44,206,0,"Igreja",0.6},
	{-430.52,269.13,83.43,102,4,"Clube de Comédia",0.6},
	{1847.32,2604.27,45.59,285,0,"Prisão",0.6},
	{134.22,-143.69,54.87,225,4,"Atlanta Luxury Vehicles",0.6},

	-- { 4.58,-705.95,45.98,351,4,"Escritório",0.6 },
	-- { -117.29,-604.52,36.29,351,4,"Escritório",0.6 },
	-- { -826.9,-699.89,28.06,351,4,"Escritório",0.6 },
	-- { -935.68,-378.77,38.97,351,4,"Escritório",0.6 },

	{ 306.74,-601.9,43.29,403,3,"Farmácia",0.6 },
	{ 237.81,-413.08,48.12,498,8,"Cartório",0.6 },
	{ 46.66,-1749.79,29.64,78,11,"Mega Mall",0.6 },
	{ 11.12,-1605.65,29.4,79,4,"Tacos",0.6 },
	{ -428.56,-1728.33,19.79,467,11,"Reciclagem",0.6 },

	{ -741.56,5594.94,41.66,36,4,"Teleférico",0.6 },
	{ 454.46,5571.95,781.19,36,4,"Teleférico",0.6 },

	{ 1134.33,-469.45,66.49,459,11,"Digital Den",0.6 },
	-- { 392.7,-831.61,29.3,459,11,"Eletrônicos",0.6 },
	--{ -41.37,-1036.79,28.49,459,11,"Eletrônicos",0.6 },
	--{ -509.38,278.8,83.33,459,11,"Eletrônicos",0.6 },
	--{ 1137.52,-470.69,66.67,459,11,"Eletrônicos",0.6 },

	{ 398.31,97.03,101.49,586,2,"Loja de Mochilas",0.6 },
	{280.25,-971.93,29.42,499,21,"Brash Coffee",0.6 },
	{-633.53,235.28,81.89,499,21,"Bean Machine Coffee",0.6 },
	-- {336.69,175.42,103.18,135,1,"Cinema",0.6 },

	-- Empregos legais
	--{ -422.29,-2788.15,6.01,42.33,4,"Emprego | Entregador",0.6 },
	{ 909.8,-176.49,74.23,56,4,"Emprego | Taxista",0.6 },
	{ -581.84,-1644.79,19.47,318,4,"Emprego | Lixeiro",0.6 },
	{ -837.97,5406.55,34.59,285,4,"Emprego | Lenhador",0.6 },
	{ 456.02,-600.1,28.52,82.73,4,"Emprego | Motorista",0.6 },
	{ -1563.32,-975.79,13.02,68,4,"Emprego | Pescador",0.6 },
	{ -1591.95,-1005.87,13.03,68,4,"Vender Peixes",0.6 },
	{ -1188.27,2727.94,2.4,68,4,"Local de Pesca",0.6 },
	{ 239.31,242.81,106.69,67,4,"Emprego | Transportador",0.6 }
}

Citizen.CreateThread(function()
	for _,v in pairs(blips) do
		local blip = AddBlipForCoord(v[1],v[2],v[3])
		SetBlipSprite(blip,v[4])
		SetBlipAsShortRange(blip,true)
		SetBlipColour(blip,v[5])
		SetBlipScale(blip,v[7])
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(v[6])
		EndTextCommandSetBlipName(blip)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECOIL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()

		if IsPedArmed(ped,6) then
			DisableControlAction(1,140,true)
			DisableControlAction(1,141,true)
			DisableControlAction(1,142,true)
			Citizen.Wait(1)
		else
			Citizen.Wait(1000)
		end

		if IsPedShooting(ped) then
			local cam = GetFollowPedCamViewMode()
			local veh = IsPedInAnyVehicle(ped)
			
			local speed = math.ceil(GetEntitySpeed(ped))
			if speed > 70 then
				speed = 70
			end

			local _,wep = GetCurrentPedWeapon(ped)
			local class = GetWeapontypeGroup(wep)
			local p = GetGameplayCamRelativePitch()
			local camDist = #(GetGameplayCamCoord() - GetEntityCoords(ped))

			local recoil = math.random(110,120+(math.ceil(speed*0.5)))/100
			local rifle = false

			if class == 970310034 or class == 1159398588 then
				rifle = true
			end

			if camDist < 5.3 then
				camDist = 1.5
			else
				if camDist < 8.0 then
					camDist = 4.0
				else
					camDist =  7.0
				end
			end

			if veh then
				recoil = recoil + (recoil * camDist)
			else
				recoil = recoil * 0.1
			end

			if cam == 4 then
				recoil = recoil * 0.6
				if rifle then
					recoil = recoil * 0.1
				end
			end

			if rifle then
				recoil = recoil * 0.6
			end

			local spread = math.random(4)
			local h = GetGameplayCamRelativeHeading()
			local hf = math.random(10,40+speed) / 100

			if veh then
				hf = hf * 2.0
			end

			if spread == 1 then
				SetGameplayCamRelativeHeading(h+hf)
			elseif spread == 2 then
				SetGameplayCamRelativeHeading(h-hf)
			end

			local set = p + recoil
			SetGameplayCamRelativePitch(set,0.8)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGLOBAL - 1000
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		N_0xf4f2c0d4ee209e20()
		DistantCopCarSirens(false)
		

		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PISTOL50"),0.6)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_REVOLVER"),0.4)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PISTOL"),0.8)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PISTOL_MK2"),0.6)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_COMBATPISTOL"),0.8)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_FLASHLIGHT"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_HATCHET"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_KNIFE"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BAT"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BATTLEAXE"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_BOTTLE"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_CROWBAR"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_DAGGER"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_GOLFCLUB"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_HAMMER"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MACHETE"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_POOLCUE"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_STONE_HATCHET"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SWITCHBLADE"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_WRENCH"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_KNUCKLE"),0.1)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_COMPACTRIFLE"),0.4)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_APPISTOL"),0.6)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_HEAVYPISTOL"),0.6)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MACHINEPISTOL"),0.7)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MICROSMG"),0.7)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MINISMG"),0.7)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SNSPISTOL"),0.6)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SNSPISTOL_MK2"),0.6)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_VINTAGEPISTOL"),0.6)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_CARBINERIFLE"),0.6)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_ASSAULTRIFLE"),0.6)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),0.6)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_ASSAULTSMG"),0.7)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_GUSENBERG"),0.7)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SAWNOFFSHOTGUN"),1.3)
		N_0x4757f00bc6323cfe(GetHashKey("WEAPON_PUMPSHOTGUN"),2.0)
		
		--ClearAreaOfPeds(GetEntityCoords(PlayerPedId()),1000.0,1)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGLOBAL - 5
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		HideHudComponentThisFrame(1)
		HideHudComponentThisFrame(2)
		HideHudComponentThisFrame(3)
		HideHudComponentThisFrame(4)
		HideHudComponentThisFrame(5)
		HideHudComponentThisFrame(6)
		HideHudComponentThisFrame(7)
		HideHudComponentThisFrame(8)
		HideHudComponentThisFrame(9)
		HideHudComponentThisFrame(10)
		HideHudComponentThisFrame(11)
		HideHudComponentThisFrame(12)
		HideHudComponentThisFrame(13)
		HideHudComponentThisFrame(15)
		HideHudComponentThisFrame(17)
		HideHudComponentThisFrame(18)
		HideHudComponentThisFrame(20)
		HideHudComponentThisFrame(21)
		HideHudComponentThisFrame(22)
		DisableControlAction(1,37,true)
		DisableControlAction(1,192,true)
		DisableControlAction(1,204,true)
		DisableControlAction(1,211,true)
		DisableControlAction(1,349,true)
		DisableControlAction(1,157,false)
		DisableControlAction(1,158,false)
		DisableControlAction(1,160,false)
		DisableControlAction(1,164,false)
		DisableControlAction(1,165,false)
		DisableControlAction(1,159,false)
		DisableControlAction(1,161,false)
		DisableControlAction(1,162,false)
		DisableControlAction(1,163,false)
		
		RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_KNIFE"))
		RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_PISTOL"))
		RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_MINISMG"))
		RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_SMG"))
		RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_PUMPSHOTGUN"))
		RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_CARBINERIFLE"))
		RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_COMBATPISTOL"))

		DisablePlayerVehicleRewards(PlayerId())

		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			SetPedInfiniteAmmo(ped,true,"WEAPON_FIREEXTINGUISHER")
		end
		Citizen.Wait(5)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGLOBAL - 0
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
	SetAudioFlag("PoliceScannerDisabled",true)

	while true do
		Citizen.Wait(0)

		SetRandomBoats(false)
		SetGarbageTrucks(false)
		SetCreateRandomCops(false)
		SetCreateRandomCopsOnScenarios(false)
		SetCreateRandomCopsNotOnScenarios(false)

		DisableVehicleDistantlights(true)
		-- SetPedDensityMultiplierThisFrame(0.0)
		SetVehicleDensityMultiplierThisFrame(0.75)
		ClearAreaOfPeds(963.0,-144.79,74.48, 100.0, 1); -- thelost clear peds
		ClearAreaOfPeds(-304.71,-1352.6,18.29, 100.0, 1); -- mafia clear peds
		ClearAreaOfPeds(954.15,-1502.1,30.95, 100.0, 1); -- clear DK peds
		ClearAreaOfPeds(197.89,-924.81,30.68, 500.0, 1); -- clear Praça peds
		
		
		SetParkedVehicleDensityMultiplierThisFrame(0.75)
		-- SetScenarioPedDensityMultiplierThisFrame(0.0,0.0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGLOBAL - 10
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		RemoveVehiclesFromGeneratorsInArea(65.95 - 5.0,-1719.34 - 5.0,29.32 - 5.0,65.95 + 5.0,-1719.34 + 5.0,29.32 + 5.0)
		RemoveVehiclesFromGeneratorsInArea(115.57 - 5.0,-1758.6 - 5.0,29.34 - 5.0,115.57 + 5.0,-1758.6 + 5.0,29.34 + 5.0)
		RemoveVehiclesFromGeneratorsInArea(-4.02 - 5.0,-1533.7 - 5.0,29.63 - 5.0,-4.02 + 5.0,-1533.7 + 5.0,29.63 + 5.0)
		RemoveVehiclesFromGeneratorsInArea(100.79 - 5.0,-1605.9 - 5.0,29.52 - 5.0,100.79 + 5.0,-1605.9 + 5.0,29.52 + 5.0)
		RemoveVehiclesFromGeneratorsInArea(43.77 - 5.0,-1288.61 - 5.0,29.15 - 5.0,43.77 + 5.0,-1288.61 + 5.0,29.15 + 5.0)


		------ agachar
		local ped = PlayerPedId()
        DisableControlAction(0,36,true)
        if not IsPedInAnyVehicle(ped) then
            RequestAnimSet("move_ped_crouched")
            RequestAnimSet("move_ped_crouched_strafing")
            if IsDisabledControlJustPressed(0,36) then
                if agachar then
                    ResetPedStrafeClipset(ped)
                    ResetPedMovementClipset(ped,0.25)
                    agachar = false
                else
                    SetPedStrafeClipset(ped,"move_ped_crouched_strafing")
                    SetPedMovementClipset(ped,"move_ped_crouched",0.25)
                    agachar = true
                end
            end
        end

	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- IPLOADER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	LoadInterior(GetInteriorAtCoords(313.36,-591.02,43.29))
	LoadInterior(GetInteriorAtCoords(440.84,-983.14,30.69))
	LoadInterior(GetInteriorAtCoords(1768.09,3327.09,41.45))
	
	
	-- Ilha
	Citizen.InvokeNative(0x9A9D1BA639675CF1, 'HeistIsland', true)

	-- misc natives
	Citizen.InvokeNative(0xF74B1FFA4A15FBEA, true)
	Citizen.InvokeNative(0x53797676AD34A9AA, false)    
	SetScenarioGroupEnabled('Heist_Island_Peds', true)

	-- audio stuff
	SetAudioFlag('PlayerOnDLCHeist4Island', true)
	SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Zones', true, true)
	SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Disabled_Zones', false, true)



	---
	for _,v in pairs(allIpls) do
		loadInt(v.coords,v.interiorsProps)
	end
end)

function loadInt(coordsTable,table)
	for _,v in pairs(coordsTable) do
		local interior = GetInteriorAtCoords(v[1],v[2],v[3])
		LoadInterior(interior)
		for _,i in pairs(table) do
			EnableInteriorProp(interior,i)
			Citizen.Wait(10)
		end
		RefreshInterior(interior)
	end
end

allIpls = {
	{
		interiorsProps = {
			"swap_clean_apt",
			"layer_debra_pic",
			"layer_whiskey",
			"swap_sofa_A"
		},
		coords = {{ -1150.7,-1520.7,10.6 }}
	},{
		interiorsProps = {
			"csr_beforeMission",
			"csr_inMission"
		},
		coords = {{ -47.1,-1115.3,26.5 }}
	},{
		interiorsProps = {
			"V_Michael_bed_tidy",
			"V_Michael_M_items",
			"V_Michael_D_items",
			"V_Michael_S_items",
			"V_Michael_L_Items"
		},
		coords = {{ -802.3,175.0,72.8 }}
	},{
		interiorsProps = {
			"meth_lab_production",
			"meth_lab_upgrade",
			"meth_lab_setup"
		},
		coords = {{ 38.49,3714.1,11.01 }}
	}--,{
		--interiorsProps = {
		--	"branded_style_set",
		--	"car_floor_hatch"
		--},
		--coords = {{ 941.00,-972.66,39.14 }}
	--}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TASERTIME
-----------------------------------------------------------------------------------------------------------------------------------------
local tasertime = false
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()

		if IsPedBeingStunned(ped) then
			timeDistance = 4
			SetPedToRagdoll(ped,7500,7500,0,0,0,0)
		end

		if IsPedBeingStunned(ped) and not tasertime then
			tasertime = true
			timeDistance = 4
			TriggerEvent("cancelando",true)
			ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE",1.0)
		elseif not IsPedBeingStunned(ped) and tasertime then
			tasertime = false
			Citizen.Wait(7500)
			StopGameplayCamShaking()
			TriggerEvent("cancelando",false)
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
local teleport = {
	{ 338.65,-583.87,74.17,330.34,-601.22,43.29,"DESCER" },  ----hospital parte do heli
	{ 330.34,-601.22,43.29,338.65,-583.87,74.17,"SUBIR" },

	{ 332.26,-595.6,43.29,359.55,-584.95,28.82,"DESCER" },  ---- hospital subir da rua pro hp
	{ 359.55,-584.95,28.82,332.26,-595.6,43.29,"SUBIR" },

	{ 253.96,225.2,101.88,252.3,220.23,101.69,"ENTRAR" },
	{ 252.3,220.23,101.69,253.96,225.2,101.88,"SAIR" },

	{ 4.58,-705.95,45.98,-139.85,-627.0,168.83,"ENTRAR" },
	{ -139.85,-627.0,168.83,4.58,-705.95,45.98,"SAIR" },

	{ -117.29,-604.52,36.29,-74.48,-820.8,243.39,"ENTRAR" },
	{ -74.48,-820.8,243.39,-117.29,-604.52,36.29,"SAIR" },

	{ -826.9,-699.89,28.06,-1575.14,-569.15,108.53,"ENTRAR" },
	{ -1575.14,-569.15,108.53,-826.9,-699.89,28.06,"SAIR" },

	{ -935.68,-378.77,38.97,-1386.84,-478.56,72.05,"ENTRAR" },
	{ -1386.84,-478.56,72.05,-935.68,-378.77,38.97,"SAIR" },

	{ -741.07,5593.13,41.66,446.19,5568.79,781.19,"SUBIR" },
	{ 446.19,5568.79,781.19,-741.07,5593.13,41.66,"DESCER" },

	{ -740.78,5597.04,41.66,446.37,5575.02,781.19,"SUBIR" },
	{ 446.37,5575.02,781.19,-740.78,5597.04,41.66,"DESCER" },

	{ 40.69,3715.73,39.68,28.1,3711.62,13.6,"ENTRAR" }, -- META
	{ 28.1,3711.62,13.6,40.69,3715.73,39.68,"SAIR" },

	{ 241.14,-1378.93,33.75,275.8,-1361.48,24.54,"ENTRAR" },
	{ 275.8,-1361.48,24.54,241.14,-1378.93,33.75,"SAIR" },

	-- { 232.89,-411.39,48.12,224.63,-360.7,-98.78,"ENTRAR" },
	-- { 224.63,-360.7,-98.78,232.89,-411.39,48.12,"SAIR" },

	{ 234.33,-387.57,-98.78,244.34,-429.14,-98.78,"ENTRAR" },
	{ 244.34,-429.14,-98.78,234.33,-387.57,-98.78,"SAIR" }
}

Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for k,v in pairs(teleport) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 2 then
					timeDistance = 4
					DrawText3D(v[1],v[2],v[3],"~g~E~w~   "..v[7])
					if IsControlJustPressed(1,38) then
						DoScreenFadeOut(1000)
						Citizen.Wait(2000)
						SetEntityCoords(ped,v[4],v[5],v[6])
						Citizen.Wait(1000)
						DoScreenFadeIn(1000)
					end
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,100)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 450
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,100)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLESUPPRESSED
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local SUPPRESSED_MODELS = { "SHAMAL","LUXOR","LUXOR2","JET","LAZER","TITAN","BARRACKS","BARRACKS2","CRUSADER","RHINO","AIRTUG","RIPLEY","PHANTOM","HAULER","RUBBLE","BIFF","TACO","PACKER","TRAILERS","TRAILERS2","TRAILERS3","TRAILERS4","BLIMP","POLMAV","MULE","MULE2","MULE3","MULE4" }
	while true do
		for _,model in next,SUPPRESSED_MODELS do
			SetVehicleModelIsSuppressed(GetHashKey(model),true)
		end
		Wait(10000)
	end
end)