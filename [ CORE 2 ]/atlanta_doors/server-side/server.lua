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
Tunnel.bindInterface("atlanta_doors",cnVRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
local doors = {

	-- DEPARTAMENT POLICE ANTIGA

	[1] = { ["x"] = 361.77, ["y"] = -1584.5, ["z"] = 29.3, ["hash"] = -1501157055, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true, ["other"] = 2 },
	[2] = { ["x"] = 360.95, ["y"] = -1585.57, ["z"] = 29.3, ["hash"] = -1501157055, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true, ["other"] = 1 },
	[3] = { ["x"] = 365.63, ["y"] = -1588.71, ["z"] = 29.3, ["hash"] = -1320876379, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[4] = { ["x"] = 361.9, ["y"] = -1593.08, ["z"] = 29.3, ["hash"] = -1320876379, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[5] = { ["x"] = 368.3, ["y"] = -1596.09, ["z"] = 29.3, ["hash"] = -1320876379, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[6] = { ["x"] = 370.03, ["y"] = -1590.86, ["z"] = 29.3, ["hash"] = -1320876379, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[7] = { ["x"] = 379.03, ["y"] = -1598.43, ["z"] = 29.3, ["hash"] = -1320876379, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[8] = { ["x"] = 374.72, ["y"] = -1603.75, ["z"] = 29.3, ["hash"] = -1320876379, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[9] = { ["x"] = 383.35, ["y"] = -1603.82, ["z"] = 29.3, ["hash"] = -1320876379, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[10] = { ["x"] = 368.52, ["y"] = -1607.82, ["z"] = 29.3, ["hash"] = -1501157055, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true, ["other"] = 11 },
	[11] = { ["x"] = 369.58, ["y"] = -1606.65, ["z"] = 29.3, ["hash"] = -1501157055, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true, ["other"] = 10 },
	[12] = { ["x"] = 366.45, ["y"] = -1608.44, ["z"] = 29.3, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[13] = { ["x"] = 364.12, ["y"] = -1606.44, ["z"] = 29.3, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[14] = { ["x"] = 355.22, ["y"] = -1599.09, ["z"] = 29.3, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[15] = { ["x"] = 352.74, ["y"] = -1597.14, ["z"] = 29.3, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[16] = { ["x"] = 360.6, ["y"] = -1611.01, ["z"] = 29.3, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[17] = { ["x"] = 362.92, ["y"] = -1612.79, ["z"] = 29.3, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[18] = { ["x"] = 351.48, ["y"] = -1603.33, ["z"] = 29.3, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },
	[19] = { ["x"] = 349.17, ["y"] = -1601.64, ["z"] = 29.3, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Police", ["sound"] = true },

	[20] = { ["x"] = -630.81, ["y"] = -237.96, ["z"] = 38.1, ["hash"] = 9467943, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Admin", ["other"] = 21 },
	[21] = { ["x"] = -631.62, ["y"] = -236.92, ["z"] = 38.06, ["hash"] = 1425919976, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Admin", ["other"] = 20 },
	[22] = { ["x"] = -14.14, ["y"] = -1441.17, ["z"] = 31.11, ["hash"] = 520341586, ["lock"] = true, ["text"] = false, ["distance"] = 10, ["press"] = 1.5, ["perm"] = "Admin" },
	[23] = { ["x"] = 981.72, ["y"] = -102.78, ["z"] = 74.85, ["hash"] = 190770132, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "TheLost", ["sound"] = true },
	[24] = { ["x"] = 1846.049, ["y"] = 2604.733, ["z"] = 45.579, ["hash"] = 741314661, ["lock"] = true, ["text"] = true, ["distance"] = 30, ["press"] = 10.0, ["perm"] = "Police" },
	[25] = { ["x"] = 1819.475, ["y"] = 2604.743, ["z"] = 45.577, ["hash"] = 741314661, ["lock"] = true, ["text"] = true, ["distance"] = 30, ["press"] = 10.0, ["perm"] = "Police" },
	[26] = { ["x"] = 488.89, ["y"] = -1017.49, ["z"] = 28.15, ["hash"] = 2691149580, ["lock"] = true, ["text"] = true, ["distance"] = 30, ["press"] = 7.5, ["perm"] = "Police" },
	[27] = { ["x"] = -324.2, ["y"] = -1356.26, ["z"] = 31.3, ["hash"] = -1920147247, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true },
	[28] = { ["x"] = 887.43, ["y"] = -954.03, ["z"] = 39.22, ["hash"] = 776184575, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Groove", ["sound"] = true },
	[29] = { ["x"] = 443.32, ["y"] = -1899.9, ["z"] = 31.74, ["hash"] = -710818483, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Vagos", ["sound"] = true },
	[30] = { ["x"] = 114.19, ["y"] = -1961.23, ["z"] = 21.34, ["hash"] = 23523821, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Ballas", ["sound"] = true },
	[31] = { ["x"] = -186.2, ["y"] = -1702.86, ["z"] = 32.87, ["hash"] = -1859992197, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Groove", ["sound"] = true }, --
	[32] = { ["x"] = -197.79, ["y"] = -1700.26, ["z"] = 33.5, ["hash"] = -1859992197, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Groove", ["sound"] = true },
	[33] = { ["x"] = 113.63, ["y"] = -1974.1, ["z"] = 21.33, ["hash"] = -1912632538, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Ballas", ["sound"] = true },
	[34] = { ["x"] = -307.03, ["y"] = -1352.75, ["z"] = 18.29, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true },
	[35] = { ["x"] = -304.71, ["y"] = -1352.6, ["z"] = 18.29, ["hash"] = 631614199, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true },
	[36] = { ["x"] = 723.42, ["y"] = -1088.59, ["z"] = 22.23, ["hash"] = 270330101, ["lock"] = true, ["text"] = true, ["distance"] = 70	, ["press"] = 10, ["perm"] = "Dk", ["sound"] = true },
	[37] = { ["x"] = -1123.18, ["y"] = -2013.15, ["z"] = 13.2, ["hash"] = -703043502, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mechanic", ["sound"] = true },
	[38] = { ["x"] = -1142.68, ["y"] = -1993.52, ["z"] = 13.17, ["hash"] = -1434889563, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mechanic", ["sound"] = true },
	[39] = { ["x"] = 282.33, ["y"] = -974.54, ["z"] = 29.43, ["hash"] = -1320876379, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "BeanMachineMaster", ["sound"] = true },
	[40] = { ["x"] = 395.57, ["y"] = 76.1, ["z"] = 100.69, ["hash"] = -1687047623, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "BagShop", ["sound"] = true },
	[41] = { ["x"] = -629.19, ["y"] = 229.21, ["z"] = 81.89, ["hash"] = 736699661, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "BeanMachine2", ["sound"] = true },
	[42] = { ["x"] = -632.87, ["y"] = 227.68, ["z"] = 81.89, ["hash"] = 736699661, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "BeanMachine2Master", ["sound"] = true },
	[43] = { ["x"] = 430.65, ["y"] = -1107.45, ["z"] = 30.03, ["hash"] = -1744020211, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Judiciario", ["sound"] = true },
	[44] = { ["x"] = 428.95, ["y"] = -1100.76, ["z"] = 30.05, ["hash"] = -1119680854, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Judiciario", ["sound"] = true },
	[45] = { ["x"] = 439.22, ["y"] = -1092.47, ["z"] = 30.06, ["hash"] = -1176919893, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Judiciario", ["sound"] = true },
	[46] = { ["x"] = 439.02, ["y"] = -1091.13, ["z"] = 30.07, ["hash"] = -1176919893, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Judiciario", ["sound"] = true },
	[47] = { ["x"] = 443.63, ["y"] = -1103.66, ["z"] = 30.04, ["hash"] = -1744020211, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Juiz", ["sound"] = true },
	[48] = { ["x"] = -1888.34, ["y"] = 2052.01, ["z"] = 140.99, ["hash"] = 1077118233, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true , ["other"] = 49},
	[49] = { ["x"] = -1889.59, ["y"] = 2052.47, ["z"] = 140.99, ["hash"] = 1077118233, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true , ["other"] = 48},
	[50] = { ["x"] = 1, ["y"] = 1, ["z"] = 1, ["hash"] = 1077118233, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true},
	[51] = { ["x"] = -1907.88, ["y"] = 2072.7, ["z"] = 140.41, ["hash"] = 1843224684, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true , ["other"] = 52 },
	[52] = { ["x"] = -1908.98, ["y"] = 2073.59, ["z"] = 140.41, ["hash"] = 1843224684, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true , ["other"] = 51 },
	[53] = { ["x"] = -1910.39, ["y"] = 2074.68, ["z"] = 140.41, ["hash"] = 1843224684, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true , ["other"] = 54 },
	[54] = { ["x"] = -1911.37, ["y"] = 2075.52, ["z"] = 140.41, ["hash"] = 1843224684, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true , ["other"] = 53 },
	[55] = { ["x"] = -1910.95, ["y"] = 2079.02, ["z"] = 140.41, ["hash"] = 1843224684, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true , ["other"] = 56 },
	[56] = { ["x"] = -1910.25, ["y"] = 2079.83, ["z"] = 140.41, ["hash"] = 1843224684, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true , ["other"] = 55 },
	[57] = { ["x"] = -1906.83, ["y"] = 2083.99, ["z"] = 140.41, ["hash"] = 1843224684, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true , ["other"] = 58 },
	[58] = { ["x"] = -1906.07, ["y"] = 2084.88, ["z"] = 140.41, ["hash"] = 1843224684, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true , ["other"] = 57 },
	[59] = { ["x"] = -1902.66, ["y"] = 2085.82, ["z"] = 140.41, ["hash"] = 1843224684, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true , ["other"] = 60 },
	[60] = { ["x"] = -1901.68, ["y"] = 2084.92, ["z"] = 140.41, ["hash"] = 1843224684, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true , ["other"] = 59 },
	[61] = { ["x"] = -1900.23, ["y"] = 2083.75, ["z"] = 140.41, ["hash"] = 1843224684, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true , ["other"] = 62 },
	[62] = { ["x"] = -1899.18, ["y"] = 2082.89, ["z"] = 140.41, ["hash"] = 1843224684, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true , ["other"] = 61 },
	[63] = { ["x"] = -1894.47, ["y"] = 2075.22, ["z"] = 141.01, ["hash"] = 1077118233, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true , ["other"] = 64 },
	[64] = { ["x"] = -1893.59, ["y"] = 2074.48, ["z"] = 141.01, ["hash"] = 1077118233, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true , ["other"] = 63 },
	[65] = { ["x"] = -1886.72, ["y"] = 2073.61, ["z"] = 140.99, ["hash"] = 1077118233, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true , ["other"] = 66 },
	[66] = { ["x"] = -1885.68, ["y"] = 2073.26, ["z"] = 140.99, ["hash"] = 1077118233, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true , ["other"] = 65 },
	[67] = { ["x"] = -1875.16, ["y"] = 2069.44, ["z"] = 140.99, ["hash"] = 1077118233, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true , ["other"] = 68 },
	[68] = { ["x"] = -1874.09, ["y"] = 2069.04, ["z"] = 140.99, ["hash"] = 1077118233, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true , ["other"] = 67 },
	[69] = { ["x"] = -1859.83, ["y"] = 2054.54, ["z"] = 140.98, ["hash"] = 1077118233, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true, ["other"] = 70  },
	[70] = { ["x"] = -1861.09, ["y"] = 2054.56, ["z"] = 140.98, ["hash"] = 1077118233, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true, ["other"] = 69  },
	[71] = { ["x"] = -1864.64, ["y"] = 2060.99, ["z"] = 140.98, ["hash"] = 988364535, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true, ["other"] = 72 },
	[72] = { ["x"] = -1864.66, ["y"] = 2060.11, ["z"] = 140.98, ["hash"] = -1141522158, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true, ["other"] = 71 },
	[73] = { ["x"] = -1886.93, ["y"] = 2051.51, ["z"] = 140.99, ["hash"] = 1077118233, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true, ["other"] = 74 },
	[74] = { ["x"] = -1885.64, ["y"] = 2051.03, ["z"] = 140.99, ["hash"] = 1077118233, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Mafia", ["sound"] = true, ["other"] = 73 },
	[75] = { ["x"] = 461.83, ["y"] = -1001.99, ["z"] = 24.92, ["hash"] = 631614199, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Admin", ["sound"] = true},
	[76] = { ["x"] = 461.86, ["y"] = -998.37, ["z"] = 24.92, ["hash"] = 631614199, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Admin", ["sound"] = true},
	[77] = { ["x"] = 461.77, ["y"] = -993.63, ["z"] = 24.92, ["hash"] = 631614199, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Admin", ["sound"] = true},
	[78] = { ["x"] = 468.97, ["y"] = -1014.46, ["z"] = 26.39, ["hash"] = 2271212864, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Admin", ["other"] = 5, ["sound"] = true },
	[79] = { ["x"] = 468.35, ["y"] = -1014.44, ["z"] = 26.39, ["hash"] = 2271212864, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Admin", ["other"] = 4, ["sound"] = true },
	[80] = { ["x"] = 453.12, ["y"] = -982.52, ["z"] = 30.68, ["hash"] = 749848321, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Admin", ["sound"] = true },
	[81] = { ["x"] = 461.23, ["y"] = -986.01, ["z"] = 30.68, ["hash"] = 749848321, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Admin", ["sound"] = true },
	[82] = { ["x"] = 431.83, ["y"] = -979.51, ["z"] = 26.67, ["hash"] = -1033001619, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Admin", ["sound"] = true },
	[83] = { ["x"] = 428.04, ["y"] = -979.42, ["z"] = 26.67, ["hash"] = -1033001619, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Admin", ["sound"] = true },
	[84] = { ["x"] = 468.47, ["y"] = -997.93, ["z"] = 24.9, ["hash"] = -1033001619, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Admin", ["sound"] = true },
	[85] = { ["x"] = 471.33, ["y"] = -997.92, ["z"] = 24.9, ["hash"] = -1033001619, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Admin", ["sound"] = true },
	[86] = { ["x"] = 474.18, ["y"] = -997.95, ["z"] = 24.9, ["hash"] = -1033001619, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Admin", ["sound"] = true },
	[87] = { ["x"] = 477.09, ["y"] = -997.92, ["z"] = 24.9, ["hash"] = -1033001619, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Admin", ["sound"] = true },
	[88] = { ["x"] = 479.98, ["y"] = -997.95, ["z"] = 24.9, ["hash"] = -1033001619, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Admin", ["sound"] = true },
	[89] = { ["x"] = 435.93, ["y"] = -979.45, ["z"] = 26.67, ["hash"] = -1033001619, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Admin", ["sound"] = true },
	[90] = { ["x"] = 434.34, ["y"] = -982.57, ["z"] = 30.72, ["hash"] = 320433149, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Admin", ["sound"] = true },
	[91] = { ["x"] = 434.34, ["y"] = -981.42, ["z"] = 30.72, ["hash"] = -1215222675, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Admin", ["sound"] = true },
	[92] = { ["x"] = 1136.1, ["y"] = -467.39, ["z"] = 66.49, ["hash"] = 547719377, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "DigitalDen", ["sound"] = true },
	[93] = { ["x"] = 1131.59, ["y"] = -463.11, ["z"] = 66.49, ["hash"] = -1714438833, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "DigitalDen", ["sound"] = true },
	[94] = { ["x"] = 1128.85, ["y"] = -463.89, ["z"] = 66.49, ["hash"] = -1565285813, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "DigitalDen", ["sound"] = true },
	[95] = { ["x"] = 1136.25, ["y"] = -463.67, ["z"] = 66.49, ["hash"] = -1577379202, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "DigitalDen", ["sound"] = true, ["other"] = 96 },
	[96] = { ["x"] = 1135.7, ["y"] = -463.48, ["z"] = 66.49, ["hash"] = -1577379202, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "DigitalDen", ["sound"] = true, ["other"] = 95 },
	[97] = { ["x"] = -469.79, ["y"] = 43.19, ["z"] = 46.24, ["hash"] = -2066395222, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "VulturMaster", ["sound"] = true},
	[98] = { ["x"] = -439.95, ["y"] = 52.4, ["z"] = 52.88, ["hash"] = 1566764593, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Vultur", ["sound"] = true, ["other"] = 99 },
	[99] = { ["x"] = -440.05, ["y"] = 50.87, ["z"] = 52.88, ["hash"] = 1967988229, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Vultur", ["sound"] = true, ["other"] = 98 },
	[100] = { ["x"] = -469.79, ["y"] = 43.19, ["z"] = 46.24, ["hash"] = -471877243, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Admin", ["sound"] = true },
	[101] = { ["x"] = -464.76, ["y"] = 28.81, ["z"] = 46.69, ["hash"] = -2066395222, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Vultur", ["sound"] = true },
	[102] = { ["x"] = -456.89, ["y"] = 43.86, ["z"] = 46.24, ["hash"] = -2066395222, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Vultur", ["sound"] = true },
	[103] = { ["x"] = -452.67, ["y"] = -24.29, ["z"] = 44.52, ["hash"] = 796655254, ["lock"] = true, ["text"] = false, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "VulturMaster", ["sound"] = false },
	[104] = { ["x"] = 95.88, ["y"] = -1285.58, ["z"] = 29.27, ["hash"] = 668467214, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Vanilla", ["sound"] = true },
	[105] = { ["x"] = 99.26, ["y"] = -1292.87, ["z"] = 29.27, ["hash"] = -626684119, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Vanilla", ["sound"] = true },
	[106] = { ["x"] = 113.35, ["y"] = -1297.12, ["z"] = 29.27, ["hash"] = -495720969, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Vanilla", ["sound"] = true },
	[107] = { ["x"] = -570.33, ["y"] = 293.11, ["z"] = 79.18, ["hash"] = -626684119, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Tequila", ["sound"] = true },
	[108] = { ["x"] = -559.82, ["y"] = 292.44, ["z"] = 82.18, ["hash"] = -626684119, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Tequila", ["sound"] = true },
	[109] = { ["x"] = -561.79, ["y"] = 293.93, ["z"] = 87.6, ["hash"] = 993120320, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Tequila", ["sound"] = true },
	[110] = { ["x"] = -568.17, ["y"] = 281.29, ["z"] = 82.98, ["hash"] = 1289778077, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Tequila", ["sound"] = true },
	[111] = { ["x"] = -1830.79, ["y"] = -1181.23, ["z"] = 19.19, ["hash"] = -1196002204, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Pearls", ["sound"] = true },
	[112] = { ["x"] = -1835.99, ["y"] = -1190.12, ["z"] = 19.19, ["hash"] = -1197804771, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Pearls", ["sound"] = true },
	[113] = { ["x"] = -1846.78, ["y"] = -1190.8, ["z"] = 14.33, ["hash"] = -1285189121, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Pearls", ["sound"] = true },
	[114] = { ["x"] = 118.42, ["y"] = -1973.35, ["z"] = 21.35, ["hash"] = -204046185, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Ballas", ["sound"] = true, ["other"] = 115 },
	[115] = { ["x"] = 117.14, ["y"] = -1973.8, ["z"] = 21.35, ["hash"] = 989957872, ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "Ballas", ["sound"] = true, ["other"] = 114 },
	-- [XX] = { ["x"] = , ["y"] = , ["z"] = , ["hash"] = , ["lock"] = true, ["text"] = true, ["distance"] = 5, ["press"] = 1.5, ["perm"] = "XXXXXX", ["sound"] = true }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSSTATISTICS
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.doorsStatistics(doorNumber,doorStatus)
	local source = source

	doors[parseInt(doorNumber)].lock = doorStatus

	if doors[parseInt(doorNumber)].other ~= nil then
		local doorSecond = doors[parseInt(doorNumber)].other
		doors[doorSecond].lock = doorStatus
	end

	TriggerClientEvent("atlanta_doors:doorsUpdate",-1,doors)

	if doors[parseInt(doorNumber)].sound then
		TriggerClientEvent("vrp_sound:source",source,"doorlock",0.1)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSSTATISTICS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("atlanta_doors:doorsStatistics")
AddEventHandler("atlanta_doors:doorsStatistics",function(doorNumber,doorStatus)
	doors[parseInt(doorNumber)].lock = doorStatus

	if doors[parseInt(doorNumber)].other ~= nil then
		local doorSecond = doors[parseInt(doorNumber)].other
		doors[doorSecond].lock = doorStatus
	end

	TriggerClientEvent("atlanta_doors:doorsUpdate",-1,doors)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.doorsPermission(doorNumber)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if doors[parseInt(doorNumber)].perm ~= nil then
			if vRP.hasPermission(user_id,doors[parseInt(doorNumber)].perm) then
				return true
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	TriggerClientEvent("atlanta_doors:doorsUpdate",source,doors)
end)

