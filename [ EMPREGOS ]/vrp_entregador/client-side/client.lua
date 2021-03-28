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
Tunnel.bindInterface("vrp_delivery",cnVRP)
vSERVER = Tunnel.getInterface("vrp_delivery")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local locates = {}
local inSelect = 1
local inLocate = 1
local timeSeconds = 0
local inService = false
local serviceBlip = nil
local vehModel = 1951180813
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELIVERY
-----------------------------------------------------------------------------------------------------------------------------------------
local delivery = {
	[1] = {
		{ -122.67,-1459.86,37.0 },
		{ -127.58,-1456.89,37.8 },
		{ -132.34,-1462.65,37.0 },
		{ -138.31,-1470.85,37.0 },
		{ -125.96,-1473.79,37.0 },
		{ -120.33,-1478.48,37.0 },
		{ -119.37,-1486.45,36.99 },
		{ -112.57,-1479.49,37.0 },
		{ -107.53,-1473.43,37.0 },
		{ -113.35,-1467.79,37.0 },
		{ -122.75,-1459.91,33.83 },
		{ -126.56,-1456.59,34.62 },
		{ -132.39,-1462.67,33.83 },
		{ -125.92,-1473.72,33.83 },
		{ -120.19,-1478.43,33.83 },
		{ -112.59,-1479.47,33.83 },
		{ -107.53,-1473.51,33.83 },
		{ -113.39,-1467.74,33.83 },
		{ -119.91,-1574.51,37.41 },
		{ -113.9,-1579.5,37.41 },
		{ -118.77,-1586.16,37.41 },
		{ -123.07,-1591.22,37.41 },
		{ -134.37,-1580.36,37.41 },
		{ -140.17,-1587.29,37.41 },
		{ -147.77,-1596.29,38.22 },
		{ -147.52,-1597.02,38.22 },
		{ -140.47,-1599.6,38.22 },
		{ -123.08,-1591.24,34.21 },
		{ -118.83,-1586.17,34.22 },
		{ -113.94,-1579.56,34.18 },
		{ -119.92,-1574.56,34.18 },
		{ -134.33,-1580.33,34.21 },
		{ -140.19,-1587.3,34.25 },
		{ -147.87,-1596.39,34.84 },
		{ -140.43,-1599.61,34.84 },
		{ -159.98,-1636.19,34.03 },
		{ -161.1,-1638.77,34.03 },
		{ -153.46,-1641.17,36.86 },
		{ -161.72,-1638.43,37.25 },
		{ -159.93,-1636.24,37.25 },
		{ -150.35,-1625.72,33.66 },
		{ -151.31,-1622.3,33.65 },
		{ -145.01,-1618.68,36.05 },
		{ -146.12,-1614.56,36.05 },
		{ -152.46,-1623.86,36.85 },
		{ -150.33,-1625.67,36.85 },
		{ -93.55,-1607.11,32.32 },
		{ -87.85,-1601.48,32.32 },
		{ -80.19,-1607.86,31.49 },
		{ -97.81,-1612.3,32.32 },
		{ -109.67,-1628.49,32.91 },
		{ -105.61,-1632.67,32.91 },
		{ -97.09,-1639.13,32.11 },
		{ -89.5,-1630.09,31.51 },
		{ -83.59,-1623.07,31.48 },
		{ -80.1,-1607.86,34.69 },
		{ -87.84,-1601.38,35.49 },
		{ -93.56,-1607.16,35.49 },
		{ -97.8,-1612.22,35.49 },
		{ -83.59,-1623.09,34.69 },
		{ -89.44,-1630.06,34.69 },
		{ -97.08,-1639.12,35.49 },
		{ -98.17,-1638.91,35.49 },
		{ -105.6,-1632.65,36.29 },
		{ -109.63,-1628.41,36.29 },
		{ -124.04,-1671.35,32.57 },
		{ -131.65,-1665.58,32.57 },
		{ -138.71,-1658.86,33.34 },
		{ -128.99,-1647.28,33.31 },
		{ -121.16,-1653.24,32.57 },
		{ -114.35,-1659.81,32.57 },
		{ -130.96,-1679.59,34.92 },
		{ -124.05,-1671.37,35.72 },
		{ -131.68,-1665.55,35.72 },
		{ -138.65,-1658.85,36.52 },
		{ -107.38,-1651.47,34.89 },
		{ -114.34,-1659.79,35.72 },
		{ -121.1,-1653.25,35.72 },
		{ -128.89,-1647.32,36.52 },
		{ -158.54,-1679.3,36.97 },
		{ -157.81,-1679.25,36.97 },
		{ -147.95,-1687.51,36.17 },
		{ -146.84,-1688.45,36.17 },
		{ -141.62,-1692.83,36.17 },
		{ -141.6,-1693.64,36.17 },
		{ -141.58,-1693.65,33.07 },
		{ -141.63,-1692.88,32.88 },
		{ -146.81,-1688.47,33.07 },
		{ -147.94,-1687.52,33.07 },
		{ -157.88,-1679.8,33.84 },
		{ -36.09,-1536.9,31.45 },
		{ -44.59,-1547.03,31.45 },
		{ -35.83,-1555.21,30.68 },
		{ -24.82,-1556.9,30.69 },
		{ -19.68,-1550.82,30.68 },
		{ -26.5,-1544.2,30.68 },
		{ -33.46,-1567.33,33.03 },
		{ -28.16,-1561.0,33.83 },
		{ -35.89,-1555.17,33.83 },
		{ -44.52,-1547.09,34.63 },
		{ -14.06,-1544.15,33.03 },
		{ -19.71,-1550.85,33.83 },
		{ -26.46,-1544.21,33.83 },
		{ -36.02,-1536.82,34.63 },
		{ -77.7,-1515.11,34.25 },
		{ -71.74,-1508.03,33.44 },
		{ -65.05,-1512.84,33.44 },
		{ -59.92,-1517.15,33.44 },
		{ -53.21,-1523.81,33.44 },
		{ -62.39,-1532.66,34.24 },
		{ -69.45,-1526.74,34.24 },
		{ -77.75,-1515.08,37.42 },
		{ -71.79,-1507.97,36.63 },
		{ -65.02,-1512.85,36.63 },
		{ -59.93,-1517.14,36.63 },
		{ -53.24,-1523.71,36.63 },
		{ -59.1,-1530.85,37.42 },
		{ -62.42,-1532.62,37.42 },
		{ -69.4,-1526.79,37.42 },
		{ -167.44,-1534.47,35.1 },
		{ -174.42,-1528.6,34.36 },
		{ -184.48,-1539.44,34.36 },
		{ -196.31,-1555.72,34.96 },
		{ -192.17,-1559.81,34.96 },
		{ -187.26,-1563.43,35.76 },
		{ -179.59,-1554.33,35.13 },
		{ -173.76,-1547.23,35.13 },
		{ -167.32,-1534.5,38.33 },
		{ -174.45,-1528.6,37.54 },
		{ -180.14,-1534.25,37.54 },
		{ -184.49,-1539.43,37.54 },
		{ -173.73,-1547.33,38.34 },
		{ -179.61,-1554.33,38.34 },
		{ -187.19,-1563.32,39.14 },
		{ -188.3,-1563.12,39.14 },
		{ -192.18,-1559.83,38.34 },
		{ -196.25,-1555.58,38.34 },
		{ -223.1,-1585.76,34.87 },
		{ -223.13,-1601.04,34.89 },
		{ -223.06,-1617.65,34.87 },
		{ -212.93,-1618.16,34.87 },
		{ -212.08,-1617.66,34.87 },
		{ -209.95,-1607.19,34.87 },
		{ -205.66,-1585.64,38.06 },
		{ -215.66,-1576.27,38.06 },
		{ -219.31,-1579.85,38.06 },
		{ -223.12,-1585.74,38.06 },
		{ -223.12,-1601.1,38.06 },
		{ -223.14,-1617.53,38.06 },
		{ -212.89,-1618.15,38.06 },
		{ -212.1,-1617.68,38.06 },
		{ -209.98,-1607.13,38.05 },
		{ -208.64,-1600.6,38.05 },
		{ -224.98,-1666.23,34.47 },
		{ -224.37,-1674.5,34.47 },
		{ -216.61,-1674.47,34.47 },
		{ -212.19,-1668.07,34.47 },
		{ -212.2,-1660.64,34.47 },
		{ -216.45,-1648.41,34.47 },
		{ -225.05,-1649.01,35.26 },
		{ -224.91,-1653.93,37.64 },
		{ -223.99,-1648.48,38.45 },
		{ -216.46,-1648.45,37.64 },
		{ -212.18,-1660.68,37.64 },
		{ -212.18,-1668.16,37.64 },
		{ -216.59,-1674.47,37.64 },
		{ -224.38,-1674.39,37.64 },
		{ -224.98,-1666.23,37.64 },
		{ 332.48,-2018.49,22.36 },
		{ 336.17,-2021.59,22.36 },
		{ 343.51,-2027.74,22.36 },
		{ 344.89,-2028.89,22.36 },
		{ 352.22,-2035.09,22.36 },
		{ 353.64,-2036.22,22.36 },
		{ 360.9,-2042.39,22.36 },
		{ 364.63,-2045.45,22.36 },
		{ 372.47,-2056.1,21.75 },
		{ 371.34,-2057.39,21.75 },
		{ 365.21,-2064.73,21.75 },
		{ 357.92,-2073.43,21.75 },
		{ 356.78,-2074.8,21.75 },
		{ 345.45,-2067.55,20.94 },
		{ 341.79,-2064.48,20.94 },
		{ 334.35,-2058.25,20.94 },
		{ 333.01,-2057.09,20.94 },
		{ 325.71,-2050.9,20.94 },
		{ 324.25,-2049.74,20.94 },
		{ 316.96,-2043.63,20.94 },
		{ 313.23,-2040.52,20.94 },
		{ 297.79,-2034.58,19.84 },
		{ 293.31,-2044.15,19.65 },
		{ 290.71,-2047.25,19.65 },
		{ 286.33,-2052.47,19.65 },
		{ 306.51,-2045.36,20.92 },
		{ 312.69,-2053.94,20.94 },
		{ 315.76,-2056.52,20.94 },
		{ 321.07,-2060.96,20.94 },
		{ 324.16,-2063.55,20.94 },
		{ 332.48,-2070.53,20.94 },
		{ 334.13,-2092.94,18.25 },
		{ 330.09,-2095.37,18.25 },
		{ 321.75,-2100.14,18.25 },
		{ 320.35,-2100.88,18.25 },
		{ 305.96,-2096.95,17.54 },
		{ 304.93,-2086.63,17.71 },
		{ 302.56,-2080.03,17.71 },
		{ 301.19,-2076.37,17.71 },
		{ 295.16,-2067.68,17.65 },
		{ 288.38,-2072.55,17.67 },
		{ 290.13,-2077.04,17.67 },
		{ 293.43,-2086.02,17.67 },
		{ 294.05,-2087.79,17.67 },
		{ 296.01,-2093.1,17.67 },
		{ 297.57,-2097.68,17.67 },
		{ 323.2,-2111.62,18.13 },
		{ 329.22,-2108.14,18.13 },
		{ 332.68,-2106.14,18.13 },
		{ 340.18,-2098.72,18.21 },
		{ 363.8,-2082.99,21.76 },
		{ 368.21,-2077.73,21.76 },
		{ 370.84,-2074.6,21.76 },
		{ 375.22,-2069.37,21.76 },
		{ 377.82,-2066.29,21.76 },
		{ 382.24,-2061.01,21.76 },
		{ 392.11,-2043.87,23.42 },
		{ 395.05,-2037.64,23.42 },
		{ 396.68,-2034.06,23.42 },
		{ 399.6,-2027.79,23.42 },
		{ 401.29,-2024.18,23.42 },
		{ 404.22,-2017.89,23.42 },
		{ 385.19,-1995.58,24.24 },
		{ 383.58,-1994.96,24.24 },
		{ 374.55,-1991.68,24.24 },
		{ 363.94,-1987.85,24.24 },
		{ 362.26,-1987.16,24.24 },
		{ 342.23,-1982.14,24.16 },
		{ 334.63,-1978.65,24.17 },
		{ 331.46,-1982.32,24.17 },
		{ 325.38,-1989.75,24.17 },
		{ 324.18,-1991.12,24.17 },
		{ 330.69,-1999.86,24.05 },
		{ 335.09,-1994.62,24.05 },
		{ 337.61,-1991.62,24.05 },
		{ 357.1,-1996.69,24.25 },
		{ 363.44,-1998.99,24.25 },
		{ 367.11,-2000.33,24.25 },
		{ 373.71,-2002.73,24.25 },
		{ 377.43,-2004.08,24.25 },
		{ 383.85,-2006.42,24.25 },
		{ 393.53,-2015.64,23.41 },
		{ 392.76,-2017.28,23.41 },
		{ 388.76,-2025.86,23.41 },
		{ 383.87,-2036.12,23.41 },
		{ 383.19,-2037.73,23.41 },
		{ 371.4,-2040.64,22.2 },
		{ 365.18,-2032.03,22.4 },
		{ 362.18,-2029.49,22.4 },
		{ 356.83,-2024.99,22.4 },
		{ 353.77,-2022.44,22.4 },
		{ 345.41,-2015.42,22.4 },
		{ 335.81,-2011.01,22.32 },
		{ -34.23,-1847.0,26.2 },
		{ -20.42,-1858.98,25.41 },
		{ -4.75,-1872.17,24.16 },
		{ 5.19,-1884.35,23.7 },
		{ 23.18,-1896.66,22.97 },
		{ 38.98,-1911.5,21.96 },
		{ 56.54,-1922.75,21.92 },
		{ 72.1,-1939.13,21.37 },
		{ 76.29,-1948.07,21.18 },
		{ 85.85,-1959.7,21.13 },
		{ 114.29,-1961.23,21.34 },
		{ 126.82,-1930.06,21.39 },
		{ 118.42,-1921.14,21.33 },
		{ 101.05,-1912.2,21.41 },
		{ 54.46,-1873.06,22.81 },
		{ 46.08,-1864.22,23.28 },
		{ 29.98,-1854.77,24.07 },
		{ 21.39,-1844.71,24.61 },
		{ 103.98,-1885.34,24.32 },
		{ 115.42,-1887.95,23.93 },
		{ 128.22,-1897.06,23.68 },
		{ 148.69,-1904.46,23.54 },
		{ 179.28,-1923.93,21.38 },
		{ 165.11,-1944.87,20.24 },
		{ 148.89,-1960.47,19.46 },
		{ 144.3,-1968.86,18.86 },
		{ 208.56,-1895.36,24.82 },
		{ 192.4,-1883.32,25.06 },
		{ 171.54,-1871.52,24.41 },
		{ 150.1,-1864.69,24.6 },
		{ 130.65,-1853.2,25.24 },
		{ 152.81,-1823.75,27.87 },
		{ 197.58,-1725.76,29.67 },
		{ 216.49,-1717.44,29.68 },
		{ 222.58,-1702.46,29.7 },
		{ 240.65,-1687.7,29.7 },
		{ 252.94,-1670.78,29.67 },
		{ 250.1,-1730.8,29.67 },
		{ 257.66,-1722.84,29.66 },
		{ 269.71,-1712.78,29.67 },
		{ 282.07,-1694.8,29.65 },
		{ 333.04,-1740.83,29.74 },
		{ 320.64,-1759.76,29.64 },
		{ 304.48,-1775.54,29.11 },
		{ 300.25,-1783.68,28.44 },
		{ 288.66,-1792.59,28.09 },
		{ 405.91,-1751.16,29.72 },
		{ 419.13,-1735.46,29.61 },
		{ 431.28,-1725.51,29.61 },
		{ 443.43,-1707.31,29.71 },
		{ 500.77,-1697.21,29.79 },
		{ 489.67,-1713.98,29.71 },
		{ 479.8,-1735.72,29.16 },
		{ 474.45,-1757.59,29.1 },
		{ 472.18,-1775.25,29.08 },
		{ 495.29,-1823.38,28.87 },
		{ 500.43,-1813.18,28.9 },
		{ 512.54,-1790.71,28.92 },
		{ 514.28,-1780.98,28.92 },
		{ 440.58,-1829.64,28.37 },
		{ 427.19,-1842.14,28.47 },
		{ 412.37,-1856.34,27.33 },
		{ 399.24,-1865.06,26.72 },
		{ 385.09,-1881.51,26.04 },
		{ 368.71,-1895.8,25.18 },
		{ 320.33,-1854.12,27.52 },
		{ 329.4,-1845.93,27.75 },
		{ 338.64,-1829.6,28.34 },
		{ 348.73,-1820.99,28.9 },
		{ 324.37,-1937.27,25.02 },
		{ 311.91,-1956.18,24.62 },
		{ 295.75,-1971.73,22.91 },
		{ 291.64,-1980.18,21.61 },
		{ 279.52,-1993.88,20.81 },
		{ 256.43,-2023.4,19.27 },
		{ 251.02,-2030.23,18.71 },
		{ 235.98,-2046.24,18.38 },
		{ 250.8,-1935.03,24.7 },
		{ 258.35,-1927.23,25.45 },
		{ 270.52,-1917.07,26.19 },
		{ 282.81,-1899.11,27.27 }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADKITCHEN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()

		if not IsPedInAnyVehicle(ped) then
			if not inService then
				local coords = GetEntityCoords(ped)
				for k,v in pairs(locates) do
					local distance = #(coords - vector3(v[1],v[2],v[3]))
					if distance <= 2.5 then
						timeDistance = 4

						if v[7] ~= nil then
							DrawText3D(v[1],v[2],v[3],"~g~E~w~   EMPACOTAR   [ ~y~"..string.upper(v[7]).."~w~ ]",450)
							if distance <= 0.6 and IsControlJustPressed(1,38) then
								vSERVER.dropFood(parseInt(k))
							end
						else
							DrawText3D(v[1],v[2],v[3],"~w~AGUARDE UM ~g~ENTREGADOR~w~ PEGAR O PACOTE",350)
						end
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()

		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)

			if not inService then
				for k,v in pairs(locates) do
					local distance = #(coords - vector3(v[4],v[5],v[6]))
					if distance <= 5 then
						timeDistance = 4
						DrawText3D(v[4],v[5],v[6],"~g~E~w~   PEGAR O PACOTE",400)
						if distance <= 0.6 and IsControlJustPressed(1,38) and vSERVER.checkDelivery(k) then
							inService = true
							inLocate = parseInt(k)
							vSERVER.takeDelivery(parseInt(k))
							inSelected = math.random(#delivery[inLocate])
							makeBlipMarked()
						end
					end
				end
			else
				local distance = #(coords - vector3(delivery[inLocate][inSelected][1],delivery[inLocate][inSelected][2],delivery[inLocate][inSelected][3]))
				if distance <= 30 then
					timeDistance = 4
					DrawText3D(delivery[inLocate][inSelected][1],delivery[inLocate][inSelected][2],delivery[inLocate][inSelected][3],"~g~E~w~   ENTREGAR PACOTE",400)
					if distance <= 0.6 and IsControlJustPressed(1,38) and GetEntityModel(GetPlayersLastVehicle()) == vehModel then
						inService = false
						vSERVER.paymentMethod()
						if DoesBlipExist(serviceBlip) then
							RemoveBlip(serviceBlip)
							serviceBlip = nil
						end
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_delivery:updateItem")
AddEventHandler("vrp_delivery:updateItem",function(status)
	locates = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text,height)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,100)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / height
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,100)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEBLIPMARKED
-----------------------------------------------------------------------------------------------------------------------------------------
function makeBlipMarked()
	if DoesBlipExist(serviceBlip) then
		RemoveBlip(serviceBlip)
		serviceBlip = nil
	end

	serviceBlip = AddBlipForCoord(delivery[inLocate][inSelected][1],delivery[inLocate][inSelected][2],delivery[inLocate][inSelected][3])
	SetBlipSprite(serviceBlip,1)
	SetBlipColour(serviceBlip,84)
	SetBlipScale(serviceBlip,0.4)
	SetBlipAsShortRange(serviceBlip,false)
	SetBlipRoute(serviceBlip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Delivery")
	EndTextCommandSetBlipName(serviceBlip)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- NPC no Blip
-----------------------------------------------------------------------------------------------------------------------------------------
local pedList = {
	{
		['x'] = -424.36,
		['y'] = -2789.78,
		['z'] = 6.53,
		['h'] = 316.08,
		["hash"] = 0x94562DD7,
		["hash2"] = "a_m_m_farmer_01"
	}
}

Citizen.CreateThread( function()
	for k, v in pairs(pedList) do
		RequestModel(GetHashKey(v.hash2))

		while not HasModelLoaded(GetHashKey(v.hash2)) do
			Citizen.Wait(100)
		end

		local ped = CreatePed(4, v.hash, v.x, v.y, v.z -1, v.h, false, true)
		FreezeEntityPosition(ped, true)
		SetEntityInvincible(ped, true)
		SetBlockingOfNonTemporaryEvents(ped, true)
	end
end)
