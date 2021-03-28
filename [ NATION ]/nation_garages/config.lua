local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

config = {}
Proxy.addInterface("nation_garages", config)

----------------------------------------------
----------------- CONFIG ---------------------
----------------------------------------------

config.detido = 10 -- taxa para ser paga quando o veiculo for detido (porcentagem do valor do veiculo)
config.seguradora = 5 -- taxa para ser paga quando o veiculo estiver apreendido (porcentagem do valor do veiculo)
config.ipva = 2 -- taxa para ser paga quando o veiculo estiver com o ipva atrasado (porcentagem do valor do veiculo)
config.use_tryFullPayment = false -- quando true, aceita pagamentos de taxas com o dinheiro do banco
config.dv_permission = "admin.permissao" -- permissao para dv
config.guardar_veiculo_proximo = false -- mostrar botão de guardar veículo próximo
config.server_side_check = true -- checa se o veículo já foi retirado da garagem pelo player via server-side (o player não conseguirá retirar o veículo até guardá-lo novamente / DV)
config.client_vehicle = true -- MARQ
----------------------------------------------
----------------- MARKERS --------------------
----------------------------------------------


--- TIPOS DE MARKERS (DEFINIDO NO ATRIBUTO MARKER DE CADA GARAGEM) ---
config.markers = {
	["avião"] = 33,
	["helicóptero"] = 34,
	["barco"] = 35,
	["carro"] = 36,
	["moto"] = 37,
	["bicicleta"] = 38,
	["truck"] = 39,
}

config.drawMarker = function(coords,marker) -- funcao para desenhar os markers das garagens no chão
	local idTop = config.markers[marker] or config.markers["carro"] 
	local idBase = 27
	DrawMarker(idTop,coords,0,0,0,0,0,0,1.0,1.0,1.0,153, 102, 255,155,1,1,1,1)
	DrawMarker(idBase,coords.x,coords.y,coords.z-0.97,0,0,0,0,0,0,1.0,1.0,0.5,102, 0, 255,155,0,0,0,1)
end

----------------------------------------------
----------------- BLIPS ----------------------
----------------------------------------------

config.showBlips = false -- quando true, mostra os blips das garagens públicas no mapa
config.blipId = 357 -- id do blip
config.blipColor = 7 -- cor do blip
config.blipSize = 0.4 -- tamanho do blip

----------------------------------------------
----------------------------------------------
----------------------------------------------


----------------------------------------------
-------- DELETAR VEICULOS INATIVOS -----------
----------------------------------------------

config.reset = false -- quando true, deleta os veículos que estão parados durante um determinado tempo
config.tempoReset = 60 -- tempo para deletar um veículo inativo (em minutos)

----------------------------------------------
----------------------------------------------
----------------------------------------------

----------------------------------------------
----------------- IMAGENS --------------------
----------------------------------------------

config.defaultImg = "https://svgsilh.com/svg/160895.svg" -- imagem default
config.imgDir = "http://198.100.158.225/vehicles/" -- url ou diretorio das imagens

----------------------------------------------
----------------------------------------------
----------------------------------------------



----------------------------------------------
----------- LISTA DE VEÍCULOS ----------------
----------------------------------------------



config.vehList = {
	{ hash = 358580688, name = 'Carreta', price = 1000000, banido = false, modelo = 'Carreta', capacidade = 40, tipo = 'carros' },
	{ hash = 1038274186, name = 'Treme', price = 1000000, banido = false, modelo = 'Engate Carreta Fechada', capacidade = 40, tipo = 'carros' },
	{ hash = -1680938805, name = 'TremeTreme', price = 1000000, banido = false, modelo = 'Engate Carreta Aberta', capacidade = 40, tipo = 'carros' },
	{ hash = 167397304, name = 'paredao', price = 1000000, banido = false, modelo = 'paredao', capacidade = 40, tipo = 'carros' },
	{ hash = 1995020435, name = 'celta', price = 200000, banido = false, modelo = 'celta', capacidade = 40, tipo = 'carros' },
	{ hash = -264618235, name = 'lamtmc', price = 1000000, banido = false, modelo = 'Lamborghini Terzo', capacidade = 20, tipo = 'exclusive' },
	{ hash = -1481236684, name = 'aperta', price = 1000000, banido = false, modelo = 'Ferrari Aperta', capacidade = 60, tipo = 'exclusive' },
	{ hash = -189438188, name = 'p1', price = 200000, banido = false, modelo = 'p1', capacidade = 40, tipo = 'carros' },
	{ hash = 580861919, name = 'fc15', price = 200000, banido = false, modelo = 'fc15', capacidade = 40, tipo = 'carros' },
	{ hash = -42051018, name = 'veneno', price = 200000, banido = false, modelo = 'veneno', capacidade = 40, tipo = 'carros' },
	{ hash = -1435904776, name = '19ram', price = 1000000, banido = false, modelo = 'RAM 2019', capacidade = 40, tipo = 'exclusive' },
	{ hash = -1686080635, name = 'F250Deboxe', price = 1000000, banido = false, modelo = 'F250', capacidade = 40, tipo = 'exclusive' },
	{ hash = -110704625, name = 's10', price = 1000000, banido = false, modelo = 'S10', capacidade = 200, tipo = 'exclusive' },
	{ hash = 131498600, name = 'vwsava', price = 1000000, banido = false, modelo = 'VW Saveiro', capacidade = 40, tipo = 'exclusive' },
	{ hash = 874739883, name = 'c7', price = 2000000, banido = false, modelo = 'Corvette C7', capacidade = 40, tipo = 'carros' },
	{ hash = 1999409339, name = '63lb', price = 1000000, banido = false, modelo = 'Porshe C3LB', capacidade = 40, tipo = 'exclusive' },
	{ hash = 1962283677, name = 'paradiso1800', price = 500000, banido = false, modelo = 'Marcopolo Paradiso', capacidade = 500, tipo = 'rental' },
	{ hash = -883244519, name = 'xre300', price = 90000, banido = false, modelo = 'Honda XRE300', capacidade = 20, tipo = 'motos' },
	{ hash = 344199304, name = 'lp670sv', price = 1000000, banido = false, modelo = 'Lamborghini LP670SV', capacidade = 40, tipo = 'exclusive' },
	{ hash = 341441189, name = 'fz07', price = 1000000, banido = false, modelo = 'Yamaha FZ07', capacidade = 40, tipo = 'exclusive' },
	{ hash = 1599265874, name = 'str20', price = 1000000, banido = false, modelo = 'Porsche 911 Speedster', capacidade = 40, tipo = 'exclusive' },
	{ hash = 542147885, name = 'velar', price = 1000000, banido = false, modelo = 'Ranger Rover Velar', capacidade = 40, tipo = 'import' },
	{ hash = 1094481404, name = 'urus2018', price = 1500000, banido = false, modelo = 'Lamborghini Urus', capacidade = 40, tipo = 'carros' },
	{ hash = -1627000575, name = 'police2', price = 1000000, banido = false, modelo = 'GTR Policia', capacidade = 100, tipo = 'work' },
	{ hash = 991407206, name = 'r1250', price = 1000000, banido = false, modelo = 'BMW R1250 GS', capacidade = 40, tipo = 'exclusive' },
	{ hash = -602194604, name = 'eldorado59', price = 80000, banido = false, modelo = 'Eldorado 59', capacidade = 40, tipo = 'carros' },
	{ hash = 805658531, name = 'r3', price = 1000000, banido = false, modelo = 'Yamaha R3', capacidade = 20, tipo = 'motos' },
	{ hash = -1553046335, name = 'saveiroreb', price = 80000, banido = false, modelo = 'VW Saveiro', capacidade = 50, tipo = 'carros' },
	{ hash = 531756283, name = 'zl12017', price = 1450000, banido = false, modelo = 'Camaro 2017', capacidade = 40, tipo = 'carros' },
	{ hash = 1598710733, name = 'jeeppolicia', price = 1000, banido = true, modelo = 'Jeep', capacidade = 20, tipo = 'work' },
	{ hash = -1878793377, name = 'chevypolicia', price = 1000, banido = true, modelo = 'Chevy', capacidade = 100, tipo = 'work' },
	{ hash = 1743739647, name = 'policiacharger2018', price = 1000, banido = true, modelo = 'Dodge Charger 2018', capacidade = 0, tipo = 'work' },
	{ hash = 81717913, name = 'policiacapricesid', price = 1000, banido = true, modelo = 'GM Caprice SID', capacidade = 0, tipo = 'work' },
	{ hash = 1865641415, name = 'policiatahoe', price = 1000, banido = true, modelo = 'Chevrolet Tahoe', capacidade = 0, tipo = 'work' },
	{ hash = 112218935, name = 'policiataurus', price = 1000, banido = true, modelo = 'Ford Taurus', capacidade = 0, tipo = 'work' },
	{ hash = 1611501436, name = 'policiavictoria', price = 1000, banido = true, modelo = 'Ford Victoria', capacidade = 0, tipo = 'work' },
	{ hash = 796154746, name = 'policiamustanggt', price = 1000, banido = true, modelo = 'Mustang GT', capacidade = 0, tipo = 'work' },
	{ hash = 1884511084, name = 'policiasilverado', price = 1000, banido = true, modelo = 'Chevrolet Silverado', capacidade = 0, tipo = 'work' },
	{ hash = -377693317, name = 'policiaexplorer', price = 1000, banido = true, modelo = 'Ford Explorer', capacidade = 0, tipo = 'work' },
	{ hash = -1705304628, name = 'rubble', price = 1000, banido = true, modelo = 'Caminhão', capacidade = 0, tipo = 'work' },
	{ hash = 1303167849, name = 'f4rr', price = 400000, banido = false, modelo = 'Augusta', capacidade = 40, tipo = 'exclusive' },
	{ hash = -286046740, name = 'rcbandito', price = 1000000, banido = false, modelo = 'RC Bandito', capacidade = 1000, tipo = 'rental' },
	{ hash = 2047166283, name = 'bmws', price = 400000, banido = false, modelo = 'BMW S1000', capacidade = 40, tipo = 'exclusive' },
	{ hash = -1667727259, name = 'nh2r', price = 200000, banido = false, modelo = 'nh2r', capacidade = 40, tipo = 'carros' },
	{ hash = 1503141430, name = 'divo', price = 200000, banido = false, modelo = 'divo', capacidade = 40, tipo = 'carros' },
	{ hash = -1444047101, name = 'bugatti', price = 200000, banido = false, modelo = 'bugatti', capacidade = 40, tipo = 'carros' },
	{ hash = -344943009, name = 'blista', price = 60000, banido = false, modelo = 'Blista', capacidade = 40, tipo = 'carros' },
	{ hash = 1549126457, name = 'brioso', price = 20000, banido = false, modelo = 'Brioso', capacidade = 30, tipo = 'carros' },
	{ hash = 1549126457, name = 'code3cvpi', price = 1000000, banido = false, modelo = 'code3cvpi', capacidade = 40, tipo = 'work' },
	{ hash = 1549126457, name = 'code3cap', price = 1000000, banido = false, modelo = 'code3cap', capacidade = 40, tipo = 'work' },
	{ hash = 1549126457, name = 'code3fpis', price = 1000000, banido = false, modelo = 'code3fpis', capacidade = 40, tipo = 'work' },
	{ hash = 1549126457, name = 'code3gator', price = 1000000, banido = false, modelo = 'code3gator', capacidade = 40, tipo = 'work' },
	{ hash = 1549126457, name = 'code316fpiu', price = 1000000, banido = false, modelo = 'code316fpiu', capacidade = 40, tipo = 'work' },
	{ hash = 1549126457, name = 'code314charg', price = 1000000, banido = false, modelo = 'code314charg', capacidade = 40, tipo = 'work' },
	{ hash = 1549126457, name = 'chevypolicia', price = 1000, banido = false, modelo = 'Chevy', capacidade = 100, tipo = 'work' },
	{ hash = 1549126457, name = 'jeeppolicia', price = 1000, banido = false, modelo = 'Jeep', capacidade = 20, tipo = 'work' },
	{ hash = -1130810103, name = 'dilettante', price = 60000, banido = false, modelo = 'Dilettante', capacidade = 30, tipo = 'carros' },
	{ hash = -1177863319, name = 'issi2', price = 90000, banido = false, modelo = 'Issi2', capacidade = 20, tipo = 'carros' },
	{ hash = -431692672, name = 'policiaamarok', price = 5000, banido = false, modelo = 'Policia Amarok', capacidade = 20, tipo = 'carros' },
	{ hash = -431692672, name = 'chevypolicia', price = 1000, banido = false, modelo = 'Chevy', capacidade = 100, tipo = 'work' },
	{ hash = -431692672, name = 'jeeppolicia', price = 1000, banido = false, modelo = 'Jeep', capacidade = 20, tipo = 'work' },
	{ hash = -431692672, name = 'panto', price = 12000, banido = false, modelo = 'Panto', capacidade = 20, tipo = 'carros' },
	{ hash = -431692672, name = 'leo1', price = 12000, banido = false, modelo = 'Viatura 1', capacidade = 20, tipo = 'carros' },
	{ hash = -431692672, name = 'leo2', price = 12000, banido = false, modelo = 'Viatura 2', capacidade = 20, tipo = 'carros' },
	{ hash = -431692672, name = 'leo3', price = 12000, banido = false, modelo = 'Viatura 3', capacidade = 20, tipo = 'carros' },
	{ hash = -431692672, name = 'leo4', price = 12000, banido = false, modelo = 'Viatura 4', capacidade = 20, tipo = 'carros' },
	{ hash = -431692672, name = 'leo5', price = 12000, banido = false, modelo = 'Viatura 5', capacidade = 20, tipo = 'carros' },
	{ hash = -431692672, name = 'leo6', price = 12000, banido = false, modelo = 'Viatura 6', capacidade = 20, tipo = 'carros' },
	{ hash = -431692672, name = 'leo7', price = 12000, banido = false, modelo = 'Viatura 7', capacidade = 20, tipo = 'carros' },
	{ hash = -431692672, name = 'leo8', price = 12000, banido = false, modelo = 'Viatura 8', capacidade = 20, tipo = 'carros' },
	{ hash = -4816535, name = 'nissanskyliner34', price = 400000, banido = false, modelo = 'Nissan Skyline R34', capacidade = 50, tipo = 'exclusive' },
	{ hash = 805658531, name = 'r3', price = 1000000, banido = false, modelo = 'Yamaha R3', capacidade = 20, tipo = 'motos' },
	{ hash = -431692672, name = 'pounder', price = 15000, banido = false, modelo = 'pounder', capacidade = 1000, tipo = 'carros' },
	{ hash = -1450650718, name = 'prairie', price = 1000, banido = false, modelo = 'Prairie', capacidade = 25, tipo = 'carros' },
	{ hash = 841808271, name = 'rhapsody', price = 20000, banido = false, modelo = 'Rhapsody', capacidade = 30, tipo = 'carros' },
	{ hash = 330661258, name = 'cogcabrio', price = 130000, banido = false, modelo = 'Cogcabrio', capacidade = 60, tipo = 'carros' },
	{ hash = -685276541, name = 'emperor', price = 50000, banido = false, modelo = 'Emperor', capacidade = 60, tipo = 'carros' },
	{ hash = -1883002148, name = 'emperor2', price = 50000, banido = false, modelo = 'Emperor 2', capacidade = 60, tipo = 'carros' },
	{ hash = -2095439403, name = 'phoenix', price = 250000, banido = false, modelo = 'Phoenix', capacidade = 40, tipo = 'carros' },
	{ hash = -1883869285, name = 'premier', price = 35000, banido = false, modelo = 'Premier', capacidade = 50, tipo = 'carros' },
	{ hash = 75131841, name = 'glendale', price = 70000, banido = false, modelo = 'Glendale', capacidade = 50, tipo = 'carros' },
	{ hash = 886934177, name = 'intruder', price = 60000, banido = false, modelo = 'Intruder', capacidade = 50, tipo = 'carros' },
	{ hash = -5153954, name = 'exemplar', price = 80000, banido = false, modelo = 'Exemplar', capacidade = 20, tipo = 'carros' },
	{ hash = -591610296, name = 'f620', price = 55000, banido = false, modelo = 'F620', capacidade = 30, tipo = 'carros' },
	{ hash = -391594584, name = 'felon', price = 70000, banido = false, modelo = 'Felon', capacidade = 50, tipo = 'carros' },
	{ hash = -1289722222, name = 'ingot', price = 160000, banido = false, modelo = 'Ingot', capacidade = 60, tipo = 'carros' },
	{ hash = -89291282, name = 'felon2', price = 1000, banido = false, modelo = 'Felon2', capacidade = 40, tipo = 'work' },
	{ hash = -624529134, name = 'jackal', price = 60000, banido = false, modelo = 'Jackal', capacidade = 50, tipo = 'carros' },
	{ hash = 1348744438, name = 'oracle', price = 60000, banido = false, modelo = 'Oracle', capacidade = 50, tipo = 'carros' },
	{ hash = -511601230, name = 'oracle2', price = 80000, banido = false, modelo = 'Oracle2', capacidade = 60, tipo = 'carros' },
	{ hash = 1349725314, name = 'sentinel', price = 50000, banido = false, modelo = 'Sentinel', capacidade = 50, tipo = 'carros' },
	{ hash = 873639469, name = 'sentinel2', price = 60000, banido = false, modelo = 'Sentinel2', capacidade = 40, tipo = 'carros' },
	{ hash = 1581459400, name = 'windsor', price = 150000, banido = false, modelo = 'Windsor', capacidade = 20, tipo = 'carros' },
	{ hash = -1930048799, name = 'windsor2', price = 195000, banido = false, modelo = 'Windsor2', capacidade = 40, tipo = 'carros' },
	{ hash = -1122289213, name = 'zion', price = 50000, banido = false, modelo = 'Zion', capacidade = 50, tipo = 'carros' },
	{ hash = -1193103848, name = 'zion2', price = 60000, banido = false, modelo = 'Zion2', capacidade = 40, tipo = 'carros' },
	{ hash = -1205801634, name = 'blade', price = 110000, banido = false, modelo = 'Blade', capacidade = 40, tipo = 'carros' },
	{ hash = -682211828, name = 'buccaneer', price = 130000, banido = false, modelo = 'Buccaneer', capacidade = 50, tipo = 'carros' },
	{ hash = -1013450936, name = 'buccaneer2', price = 260000, banido = false, modelo = 'Buccaneer2', capacidade = 60, tipo = 'carros' },
	{ hash = -1150599089, name = 'primo', price = 200000, banido = false, modelo = 'Primo', capacidade = 50, tipo = 'carros' },
	{ hash = -2040426790, name = 'primo2', price = 200000, banido = false, modelo = 'Primo2', capacidade = 60, tipo = 'work' },
	{ hash = 349605904, name = 'chino', price = 130000, banido = false, modelo = 'Chino', capacidade = 50, tipo = 'carros' },
	{ hash = -1361687965, name = 'chino2', price = 200000, banido = false, modelo = 'Chino2', capacidade = 60, tipo = 'work' },
	{ hash = 784565758, name = 'coquette3', price = 195000, banido = false, modelo = 'Coquette3', capacidade = 40, tipo = 'carros' },
	{ hash = 80636076, name = 'dominator', price = 230000, banido = false, modelo = 'Dominator', capacidade = 50, tipo = 'carros' },
	{ hash = 915704871, name = 'dominator2', price = 230000, banido = false, modelo = 'Dominator2', capacidade = 50, tipo = 'carros' },
	{ hash = 723973206, name = 'dukes', price = 150000, banido = false, modelo = 'Dukes', capacidade = 40, tipo = 'carros' },
	{ hash = -2119578145, name = 'faction', price = 200000, banido = false, modelo = 'Faction', capacidade = 50, tipo = 'carros' },
	{ hash = -1790546981, name = 'faction2', price = 200000, banido = false, modelo = 'Faction2', capacidade = 40, tipo = 'work' },
	{ hash = -2039755226, name = 'faction3', price = 350000, banido = false, modelo = 'Faction3', capacidade = 60, tipo = 'carros' },
	{ hash = -1800170043, name = 'gauntlet', price = 165000, banido = false, modelo = 'Gauntlet', capacidade = 40, tipo = 'carros' },
	{ hash = 349315417, name = 'gauntlet2', price = 165000, banido = false, modelo = 'Gauntlet2', capacidade = 40, tipo = 'carros' },
	{ hash = 15219735, name = 'hermes', price = 300000, banido = false, modelo = 'Hermes', capacidade = 50, tipo = 'carros' },
	{ hash = 37348240, name = 'hotknife', price = 180000, banido = false, modelo = 'Hotknife', capacidade = 30, tipo = 'carros' },
	{ hash = 525509695, name = 'moonbeam', price = 220000, banido = false, modelo = 'Moonbeam', capacidade = 80, tipo = 'carros' },
	{ hash = 1896491931, name = 'moonbeam2', price = 250000, banido = false, modelo = 'Moonbeam2', capacidade = 70, tipo = 'carros' },
	{ hash = -1943285540, name = 'nightshade', price = 270000, banido = false, modelo = 'Nightshade', capacidade = 30, tipo = 'carros' },
	{ hash = 1507916787, name = 'picador', price = 150000, banido = false, modelo = 'Picador', capacidade = 90, tipo = 'carros' },
	{ hash = -227741703, name = 'ruiner', price = 150000, banido = false, modelo = 'Ruiner', capacidade = 100, tipo = 'carros' },
	{ hash = -1685021548, name = 'sabregt', price = 260000, banido = false, modelo = 'Sabregt', capacidade = 100, tipo = 'carros' },
	{ hash = 223258115, name = 'sabregt2', price = 150000, banido = false, modelo = 'Sabregt2', capacidade = 100, tipo = 'carros' },
	{ hash = -1745203402, name = 'gburrito', price = 200000, banido = false, modelo = 'GBurrito', capacidade = 100, tipo = 'work' },
	{ hash = 729783779, name = 'slamvan', price = 180000, banido = false, modelo = 'Slamvan', capacidade = 100, tipo = 'carros' },
	{ hash = 833469436, name = 'slamvan2', price = 200000, banido = false, modelo = 'Slamvan2', capacidade = 100, tipo = 'work' },
	{ hash = 1119641113, name = 'slamvan3', price = 230000, banido = false, modelo = 'Slamvan3', capacidade = 100, tipo = 'carros' },
	{ hash = 1923400478, name = 'stalion', price = 150000, banido = false, modelo = 'Stalion', capacidade = 100, tipo = 'carros' },
	{ hash = -401643538, name = 'stalion2', price = 150000, banido = false, modelo = 'Stalion2', capacidade = 100, tipo = 'carros' },
	{ hash = 972671128, name = 'tampa', price = 170000, banido = false, modelo = 'Tampa', capacidade = 100, tipo = 'carros' },
	{ hash = -825837129, name = 'vigero', price = 170000, banido = false, modelo = 'Vigero', capacidade = 100, tipo = 'carros' },
	{ hash = -498054846, name = 'virgo', price = 150000, banido = false, modelo = 'Virgo', capacidade = 100, tipo = 'carros' },
	{ hash = -899509638, name = 'virgo2', price = 250000, banido = false, modelo = 'Virgo2', capacidade = 100, tipo = 'carros' },
	{ hash = 16646064, name = 'virgo3', price = 180000, banido = false, modelo = 'Virgo3', capacidade = 100, tipo = 'carros' },
	{ hash = 1127131465, name = 'fbi', price = 1000, banido = false, modelo = 'Porsche FBI', capacidade = 100, tipo = 'work' },
	{ hash = 2006667053, name = 'voodoo', price = 220000, banido = false, modelo = 'Voodoo', capacidade = 100, tipo = 'carros' },
	{ hash = 523724515, name = 'voodoo2', price = 220000, banido = false, modelo = 'Voodoo2', capacidade = 100, tipo = 'carros' },
	{ hash = 1871995513, name = 'yosemite', price = 350000, banido = false, modelo = 'Yosemite', capacidade = 130, tipo = 'carros' },
	{ hash = 1126868326, name = 'bfinjection', price = 80000, banido = false, modelo = 'Bfinjection', capacidade = 100, tipo = 'carros' },
	{ hash = -349601129, name = 'bifta', price = 190000, banido = false, modelo = 'Bifta', capacidade = 20, tipo = 'carros' },
	{ hash = -1435919434, name = 'bodhi2', price = 170000, banido = false, modelo = 'Bodhi2', capacidade = 90, tipo = 'carros' },
	{ hash = -1479664699, name = 'brawler', price = 250000, banido = false, modelo = 'Brawler', capacidade = 50, tipo = 'carros' },
	{ hash = 101905590, name = 'trophytruck', price = 400000, banido = false, modelo = 'Trophytruck', capacidade = 15, tipo = 'carros' },
	{ hash = -663299102, name = 'trophytruck2', price = 400000, banido = false, modelo = 'Trophytruck2', capacidade = 15, tipo = 'carros' },
	{ hash = -1237253773, name = 'dubsta3', price = 350000, banido = false, modelo = 'Dubsta3', capacidade = 90, tipo = 'carros' },
	{ hash = -2064372143, name = 'mesa3', price = 300000, banido = false, modelo = 'Mesa3', capacidade = 60, tipo = 'carros' },
	{ hash = 1645267888, name = 'rancherxl', price = 220000, banido = false, modelo = 'Rancherxl', capacidade = 70, tipo = 'carros' },
	{ hash = -1207771834, name = 'rebel', price = 370000, banido = false, modelo = 'Rebel', capacidade = 80, tipo = 'work' },
	{ hash = -2045594037, name = 'rebel2', price = 250000, banido = false, modelo = 'Rebel2', capacidade = 100, tipo = 'carros' },
	{ hash = -1532697517, name = 'riata', price = 350000, banido = false, modelo = 'Riata', capacidade = 80, tipo = 'carros' },
	{ hash = 1770332643, name = 'dloader', price = 300000, banido = false, modelo = 'Dloader', capacidade = 80, tipo = 'carros' },
	{ hash = -667151410, name = 'ratloader', price = 1000, banido = false, modelo = 'Caminhão', capacidade = 80, tipo = 'work' },
	{ hash = -1189015600, name = 'sandking', price = 400000, banido = false, modelo = 'Sandking', capacidade = 120, tipo = 'carros' },
	{ hash = 989381445, name = 'sandking2', price = 370000, banido = false, modelo = 'Sandking2', capacidade = 120, tipo = 'carros' },
	{ hash = -808831384, name = 'baller', price = 150000, banido = false, modelo = 'Baller', capacidade = 50, tipo = 'carros' },
	{ hash = 142944341, name = 'baller2', price = 160000, banido = false, modelo = 'Baller2', capacidade = 50, tipo = 'carros' },
	{ hash = 1878062887, name = 'baller3', price = 175000, banido = false, modelo = 'Baller3', capacidade = 50, tipo = 'carros' },
	{ hash = 634118882, name = 'baller4', price = 270000, banido = false, modelo = 'Baller4', capacidade = 50, tipo = 'carros' },
	{ hash = 470404958, name = 'baller5', price = 270000, banido = false, modelo = 'Baller5', capacidade = 50, tipo = 'carros' },
	{ hash = 666166960, name = 'baller6', price = 280000, banido = false, modelo = 'Baller6', capacidade = 50, tipo = 'carros' },
	{ hash = 850565707, name = 'bjxl', price = 110000, banido = false, modelo = 'Bjxl', capacidade = 50, tipo = 'carros' },
	{ hash = 2006918058, name = 'cavalcade', price = 110000, banido = false, modelo = 'Cavalcade', capacidade = 60, tipo = 'carros' },
	{ hash = -789894171, name = 'cavalcade2', price = 130000, banido = false, modelo = 'Cavalcade2', capacidade = 60, tipo = 'carros' },
	{ hash = 683047626, name = 'contender', price = 300000, banido = false, modelo = 'Contender', capacidade = 80, tipo = 'carros' },
	{ hash = 1177543287, name = 'dubsta', price = 210000, banido = false, modelo = 'Dubsta', capacidade = 70, tipo = 'carros' },
	{ hash = -394074634, name = 'dubsta2', price = 240000, banido = false, modelo = 'Dubsta2', capacidade = 70, tipo = 'carros' },
	{ hash = -1137532101, name = 'fq2', price = 110000, banido = false, modelo = 'Fq2', capacidade = 50, tipo = 'carros' },
	{ hash = -1775728740, name = 'granger', price = 345000, banido = false, modelo = 'Granger', capacidade = 100, tipo = 'carros' },
	{ hash = -1543762099, name = 'gresley', price = 150000, banido = false, modelo = 'Gresley', capacidade = 50, tipo = 'carros' },
	{ hash = 884422927, name = 'habanero', price = 110000, banido = false, modelo = 'Habanero', capacidade = 50, tipo = 'carros' },
	{ hash = 1221512915, name = 'seminole', price = 110000, banido = false, modelo = 'Seminole', capacidade = 60, tipo = 'carros' },
	{ hash = 1337041428, name = 'serrano', price = 150000, banido = false, modelo = 'Serrano', capacidade = 50, tipo = 'carros' },
	{ hash = 1203490606, name = 'xls', price = 150000, banido = false, modelo = 'Xls', capacidade = 50, tipo = 'carros' },
	{ hash = -432008408, name = 'xls2', price = 350000, banido = false, modelo = 'Xls2', capacidade = 50, tipo = 'carros' },
	{ hash = -1809822327, name = 'asea', price = 55000, banido = false, modelo = 'Asea', capacidade = 30, tipo = 'carros' },
	{ hash = -1903012613, name = 'asterope', price = 65000, banido = false, modelo = 'Asterope', capacidade = 30, tipo = 'carros' },
	{ hash = 906642318, name = 'cog55', price = 200000, banido = false, modelo = 'Cog55', capacidade = 50, tipo = 'work' },
	{ hash = 704435172, name = 'cog552', price = 400000, banido = false, modelo = 'Cog552', capacidade = 50, tipo = 'carros' },
	{ hash = -2030171296, name = 'cognoscenti', price = 280000, banido = false, modelo = 'Cognoscenti', capacidade = 50, tipo = 'carros' },
	{ hash = -604842630, name = 'cognoscenti2', price = 400000, banido = false, modelo = 'Cognoscenti2', capacidade = 50, tipo = 'carros' },
	{ hash = -1477580979, name = 'stanier', price = 60000, banido = false, modelo = 'Stanier', capacidade = 60, tipo = 'carros' },
	{ hash = 1723137093, name = 'stratum', price = 90000, banido = false, modelo = 'Stratum', capacidade = 70, tipo = 'carros' },
	{ hash = 1123216662, name = 'superd', price = 200000, banido = false, modelo = 'Superd', capacidade = 50, tipo = 'work' },
	{ hash = -1894894188, name = 'surge', price = 110000, banido = false, modelo = 'Surge', capacidade = 60, tipo = 'carros' },
	{ hash = -1008861746, name = 'tailgater', price = 110000, banido = false, modelo = 'Tailgater', capacidade = 50, tipo = 'carros' },
	{ hash = 1373123368, name = 'warrener', price = 90000, banido = false, modelo = 'Warrener', capacidade = 40, tipo = 'carros' },
	{ hash = 1777363799, name = 'washington', price = 130000, banido = false, modelo = 'Washington', capacidade = 60, tipo = 'carros' },
	{ hash = 767087018, name = 'alpha', price = 230000, banido = false, modelo = 'Alpha', capacidade = 40, tipo = 'carros' },
	{ hash = -1041692462, name = 'banshee', price = 300000, banido = false, modelo = 'Banshee', capacidade = 30, tipo = 'carros' },
	{ hash = 1274868363, name = 'bestiagts', price = 290000, banido = false, modelo = 'Bestiagts', capacidade = 60, tipo = 'carros' },
	{ hash = 1039032026, name = 'blista2', price = 55000, banido = false, modelo = 'Blista2', capacidade = 40, tipo = 'carros' },
	{ hash = -591651781, name = 'blista3', price = 80000, banido = false, modelo = 'Blista3', capacidade = 40, tipo = 'carros' },
	{ hash = -304802106, name = 'buffalo', price = 300000, banido = false, modelo = 'Buffalo', capacidade = 50, tipo = 'carros' },
	{ hash = 736902334, name = 'buffalo2', price = 300000, banido = false, modelo = 'Buffalo2', capacidade = 50, tipo = 'carros' },
	{ hash = 237764926, name = 'buffalo3', price = 300000, banido = false, modelo = 'Buffalo3', capacidade = 50, tipo = 'carros' },
	{ hash = 2072687711, name = 'carbonizzare', price = 750000, banido = false, modelo = 'Carbonizzare', capacidade = 30, tipo = 'carros' },
	{ hash = -2022483795, name = 'comet3', price = 290000, banido = false, modelo = 'Comet3', capacidade = 40, tipo = 'carros' },
	{ hash = 661493923, name = 'comet5', price = 300000, banido = false, modelo = 'Comet5', capacidade = 40, tipo = 'carros' },
	{ hash = 108773431, name = 'coquette', price = 400000, banido = false, modelo = 'Coquette', capacidade = 30, tipo = 'carros' },
	{ hash = 196747873, name = 'elegy', price = 350000, banido = false, modelo = 'Elegy', capacidade = 30, tipo = 'carros' },
	{ hash = -566387422, name = 'elegy2', price = 355000, banido = false, modelo = 'Elegy2', capacidade = 30, tipo = 'carros' },
	{ hash = -1995326987, name = 'feltzer2', price = 150000, banido = false, modelo = 'Feltzer2', capacidade = 40, tipo = 'carros' },
	{ hash = -1089039904, name = 'furoregt', price = 290000, banido = false, modelo = 'Furoregt', capacidade = 30, tipo = 'carros' },
	{ hash = 499169875, name = 'fusilade', price = 210000, banido = false, modelo = 'Fusilade', capacidade = 40, tipo = 'carros' },
	{ hash = 2016857647, name = 'futo', price = 170000, banido = false, modelo = 'Futo', capacidade = 40, tipo = 'carros' },
	{ hash = -1297672541, name = 'jester', price = 300000, banido = false, modelo = 'Jester', capacidade = 30, tipo = 'carros' },
	{ hash = 544021352, name = 'khamelion', price = 110000, banido = false, modelo = 'Khamelion', capacidade = 50, tipo = 'carros' },
	{ hash = -1372848492, name = 'kuruma', price = 500000, banido = false, modelo = 'Kuruma', capacidade = 50, tipo = 'carros' },
	{ hash = -142942670, name = 'massacro', price = 330000, banido = false, modelo = 'Massacro', capacidade = 40, tipo = 'carros' },
	{ hash = -631760477, name = 'massacro2', price = 330000, banido = false, modelo = 'Massacro2', capacidade = 40, tipo = 'carros' },
	{ hash = 1032823388, name = 'ninef', price = 290000, banido = false, modelo = 'Ninef', capacidade = 40, tipo = 'carros' },
	{ hash = -1461482751, name = 'ninef2', price = 290000, banido = false, modelo = 'Ninef2', capacidade = 40, tipo = 'carros' },
	{ hash = -777172681, name = 'omnis', price = 240000, banido = false, modelo = 'Omnis', capacidade = 20, tipo = 'carros' },
	{ hash = 867799010, name = 'pariah', price = 700000, banido = false, modelo = 'Pariah', capacidade = 30, tipo = 'carros' },
	{ hash = -377465520, name = 'penumbra', price = 150000, banido = false, modelo = 'Penumbra', capacidade = 40, tipo = 'carros' },
	{ hash = -1529242755, name = 'raiden', price = 240000, banido = false, modelo = 'Raiden', capacidade = 50, tipo = 'carros' },
	{ hash = -1934452204, name = 'rapidgt', price = 220000, banido = false, modelo = 'Rapidgt', capacidade = 20, tipo = 'carros' },
	{ hash = 1737773231, name = 'rapidgt2', price = 300000, banido = false, modelo = 'Rapidgt2', capacidade = 20, tipo = 'carros' },
	{ hash = 719660200, name = 'ruston', price = 370000, banido = false, modelo = 'Ruston', capacidade = 20, tipo = 'carros' },
	{ hash = -1485523546, name = 'schafter3', price = 275000, banido = false, modelo = 'Schafter3', capacidade = 50, tipo = 'carros' },
	{ hash = 1489967196, name = 'schafter4', price = 420000, banido = false, modelo = 'Schafter4', capacidade = 50, tipo = 'carros' },
	{ hash = -888242983, name = 'schafter5', price = 275000, banido = false, modelo = 'Schafter5', capacidade = 50, tipo = 'carros' },
	{ hash = -746882698, name = 'schwarzer', price = 170000, banido = false, modelo = 'Schwarzer', capacidade = 50, tipo = 'carros' },
	{ hash = 1104234922, name = 'sentinel3', price = 230000, banido = false, modelo = 'Sentinel3', capacidade = 30, tipo = 'carros' },
	{ hash = -1757836725, name = 'seven70', price = 370000, banido = false, modelo = 'Seven70', capacidade = 20, tipo = 'carros' },
	{ hash = 1886268224, name = 'specter', price = 320000, banido = false, modelo = 'Specter', capacidade = 20, tipo = 'carros' },
	{ hash = 1074745671, name = 'specter2', price = 355000, banido = false, modelo = 'Specter2', capacidade = 20, tipo = 'carros' },
	{ hash = 1741861769, name = 'streiter', price = 250000, banido = false, modelo = 'Streiter', capacidade = 70, tipo = 'carros' },
	{ hash = 970598228, name = 'sultan', price = 720000, banido = false, modelo = 'Sultan', capacidade = 50, tipo = 'carros' },
	{ hash = 384071873, name = 'surano', price = 310000, banido = false, modelo = 'Surano', capacidade = 30, tipo = 'carros' },
	{ hash = -1071380347, name = 'tampa2', price = 200000, banido = false, modelo = 'Tampa2', capacidade = 20, tipo = 'carros' },
	{ hash = 1887331236, name = 'tropos', price = 170000, banido = false, modelo = 'Tropos', capacidade = 20, tipo = 'carros' },
	{ hash = 1102544804, name = 'verlierer2', price = 380000, banido = false, modelo = 'Verlierer2', capacidade = 20, tipo = 'carros' },
	{ hash = 117401876, name = 'btype', price = 200000, banido = false, modelo = 'Btype', capacidade = 40, tipo = 'work' },
	{ hash = -831834716, name = 'btype2', price = 460000, banido = false, modelo = 'Btype2', capacidade = 20, tipo = 'carros' },
	{ hash = -602287871, name = 'btype3', price = 390000, banido = false, modelo = 'Btype3', capacidade = 40, tipo = 'carros' },
	{ hash = 941800958, name = 'casco', price = 355000, banido = false, modelo = 'Casco', capacidade = 50, tipo = 'carros' },
	{ hash = -1311154784, name = 'cheetah', price = 425000, banido = false, modelo = 'Cheetah', capacidade = 20, tipo = 'carros' },
	{ hash = 1011753235, name = 'coquette2', price = 285000, banido = false, modelo = 'Coquette2', capacidade = 40, tipo = 'carros' },
	{ hash = -1566741232, name = 'feltzer3', price = 220000, banido = false, modelo = 'Feltzer3', capacidade = 40, tipo = 'carros' },
	{ hash = -2079788230, name = 'gt500', price = 250000, banido = false, modelo = 'Gt500', capacidade = 40, tipo = 'carros' },
	{ hash = -1405937764, name = 'infernus2', price = 450000, banido = false, modelo = 'Infernus2', capacidade = 20, tipo = 'carros' },
	{ hash = 1051415893, name = 'jb700', price = 220000, banido = false, modelo = 'Jb700', capacidade = 30, tipo = 'carros' },
	{ hash = -1660945322, name = 'mamba', price = 1200000, banido = false, modelo = 'Mamba', capacidade = 50, tipo = 'carros' },
	{ hash = -2124201592, name = 'manana', price = 130000, banido = false, modelo = 'Manana', capacidade = 60, tipo = 'carros' },
	{ hash = -433375717, name = 'monroe', price = 260000, banido = false, modelo = 'Monroe', capacidade = 20, tipo = 'carros' },
	{ hash = 1830407356, name = 'peyote', price = 150000, banido = false, modelo = 'Peyote', capacidade = 50, tipo = 'carros' },
	{ hash = 1078682497, name = 'pigalle', price = 250000, banido = false, modelo = 'Pigalle', capacidade = 60, tipo = 'carros' },
	{ hash = 2049897956, name = 'rapidgt3', price = 220000, banido = false, modelo = 'Rapidgt3', capacidade = 40, tipo = 'carros' },
	{ hash = 1841130506, name = 'retinue', price = 150000, banido = false, modelo = 'Retinue', capacidade = 40, tipo = 'carros' },
	{ hash = 1545842587, name = 'stinger', price = 220000, banido = false, modelo = 'Stinger', capacidade = 20, tipo = 'carros' },
	{ hash = -2098947590, name = 'stingergt', price = 230000, banido = false, modelo = 'Stingergt', capacidade = 20, tipo = 'carros' },
	{ hash = 1504306544, name = 'torero', price = 160000, banido = false, modelo = 'Torero', capacidade = 30, tipo = 'carros' },
	{ hash = 464687292, name = 'tornado', price = 150000, banido = false, modelo = 'Tornado', capacidade = 70, tipo = 'carros' },
	{ hash = 1531094468, name = 'tornado2', price = 160000, banido = false, modelo = 'Tornado2', capacidade = 60, tipo = 'carros' },
	{ hash = -1797613329, name = 'tornado5', price = 200000, banido = false, modelo = 'Tornado5', capacidade = 60, tipo = 'work' },
	{ hash = -1558399629, name = 'tornado6', price = 250000, banido = false, modelo = 'Tornado6', capacidade = 50, tipo = 'carros' },
	{ hash = -982130927, name = 'turismo2', price = 250000, banido = false, modelo = 'Turismo2', capacidade = 30, tipo = 'carros' },
	{ hash = 758895617, name = 'ztype', price = 400000, banido = false, modelo = 'Ztype', capacidade = 20, tipo = 'carros' },
	{ hash = -1216765807, name = 'adder', price = 620000, banido = false, modelo = 'Adder', capacidade = 20, tipo = 'carros' },
	{ hash = -313185164, name = 'autarch', price = 760000, banido = false, modelo = 'Autarch', capacidade = 20, tipo = 'carros' },
	{ hash = 633712403, name = 'banshee2', price = 370000, banido = false, modelo = 'Banshee2', capacidade = 20, tipo = 'carros' },
	{ hash = -1696146015, name = 'bullet', price = 400000, banido = false, modelo = 'Bullet', capacidade = 20, tipo = 'carros' },
	{ hash = 223240013, name = 'cheetah2', price = 240000, banido = false, modelo = 'Cheetah2', capacidade = 20, tipo = 'carros' },
	{ hash = -1291952903, name = 'entityxf', price = 460000, banido = false, modelo = 'Entityxf', capacidade = 20, tipo = 'carros' },
	{ hash = 1426219628, name = 'fmj', price = 520000, banido = false, modelo = 'Fmj', capacidade = 20, tipo = 'carros' },
	{ hash = 1234311532, name = 'gp1', price = 495000, banido = false, modelo = 'Gp1', capacidade = 20, tipo = 'carros' },
	{ hash = 418536135, name = 'infernus', price = 450000, banido = false, modelo = 'Infernus', capacidade = 20, tipo = 'carros' },
	{ hash = 1034187331, name = 'nero', price = 450000, banido = false, modelo = 'Nero', capacidade = 20, tipo = 'carros' },
	{ hash = 1093792632, name = 'nero2', price = 520000, banido = false, modelo = 'Nero2', capacidade = 20, tipo = 'carros' },
	{ hash = 1987142870, name = 'osiris', price = 460000, banido = false, modelo = 'Osiris', capacidade = 20, tipo = 'carros' },
	{ hash = -1758137366, name = 'penetrator', price = 480000, banido = false, modelo = 'Penetrator', capacidade = 20, tipo = 'carros' },
	{ hash = -1829802492, name = 'pfister811', price = 530000, banido = false, modelo = 'Pfister811', capacidade = 20, tipo = 'carros' },
	{ hash = 234062309, name = 'reaper', price = 620000, banido = false, modelo = 'Reaper', capacidade = 20, tipo = 'carros' },
	{ hash = 1352136073, name = 'sc1', price = 495000, banido = false, modelo = 'Sc1', capacidade = 20, tipo = 'carros' },
	{ hash = -295689028, name = 'sultanrs', price = 450000, banido = false, modelo = 'Sultan RS', capacidade = 30, tipo = 'carros' },
	{ hash = 1663218586, name = 't20', price = 770000, banido = false, modelo = 'T20', capacidade = 20, tipo = 'carros' },
	{ hash = 272929391, name = 'tempesta', price = 600000, banido = false, modelo = 'Tempesta', capacidade = 20, tipo = 'carros' },
	{ hash = 408192225, name = 'turismor', price = 620000, banido = false, modelo = 'Turismor', capacidade = 20, tipo = 'carros' },
	{ hash = 2067820283, name = 'tyrus', price = 620000, banido = false, modelo = 'Tyrus', capacidade = 20, tipo = 'carros' },
	{ hash = 338562499, name = 'vacca', price = 620000, banido = false, modelo = 'Vacca', capacidade = 30, tipo = 'carros' },
	{ hash = -998177792, name = 'visione', price = 690000, banido = false, modelo = 'Visione', capacidade = 20, tipo = 'carros' },
	{ hash = -1622444098, name = 'voltic', price = 440000, banido = false, modelo = 'Voltic', capacidade = 20, tipo = 'carros' },
	{ hash = -1403128555, name = 'zentorno', price = 1200000, banido = false, modelo = 'Zentorno', capacidade = 20, tipo = 'carros' },
	{ hash = -599568815, name = 'sadler', price = 180000, banido = false, modelo = 'Sadler', capacidade = 70, tipo = 'carros' },
	{ hash = -16948145, name = 'bison', price = 220000, banido = false, modelo = 'Bison', capacidade = 70, tipo = 'carros' },
	{ hash = 2072156101, name = 'bison2', price = 180000, banido = false, modelo = 'Bison2', capacidade = 70, tipo = 'carros' },
	{ hash = 1069929536, name = 'bobcatxl', price = 260000, banido = false, modelo = 'Bobcatxl', capacidade = 100, tipo = 'carros' },
	{ hash = -1346687836, name = 'burrito', price = 260000, banido = false, modelo = 'Burrito', capacidade = 120, tipo = 'carros' },
	{ hash = -907477130, name = 'burrito2', price = 260000, banido = false, modelo = 'Burrito2', capacidade = 120, tipo = 'carros' },
	{ hash = -1743316013, name = 'burrito3', price = 260000, banido = false, modelo = 'Burrito3', capacidade = 120, tipo = 'carros' },
	{ hash = 893081117, name = 'burrito4', price = 260000, banido = false, modelo = 'Burrito4', capacidade = 120, tipo = 'carros' },
	{ hash = -310465116, name = 'minivan', price = 110000, banido = false, modelo = 'Minivan', capacidade = 70, tipo = 'carros' },
	{ hash = -1126264336, name = 'minivan2', price = 220000, banido = false, modelo = 'Minivan2', capacidade = 60, tipo = 'carros' },
	{ hash = 1488164764, name = 'paradise', price = 260000, banido = false, modelo = 'Paradise', capacidade = 120, tipo = 'carros' },
	{ hash = -119658072, name = 'pony', price = 260000, banido = false, modelo = 'Pony', capacidade = 120, tipo = 'carros' },
	{ hash = 943752001, name = 'pony2', price = 260000, banido = false, modelo = 'Pony2', capacidade = 120, tipo = 'carros' },
	{ hash = 1162065741, name = 'rumpo', price = 260000, banido = false, modelo = 'Rumpo', capacidade = 120, tipo = 'carros' },
	{ hash = -1776615689, name = 'rumpo2', price = 260000, banido = false, modelo = 'Rumpo2', capacidade = 120, tipo = 'carros' },
	{ hash = 1475773103, name = 'rumpo3', price = 350000, banido = false, modelo = 'Rumpo3', capacidade = 120, tipo = 'carros' },
	{ hash = -810318068, name = 'speedo', price = 200000, banido = false, modelo = 'Speedo', capacidade = 120, tipo = 'work' },
	{ hash = 699456151, name = 'surfer', price = 55000, banido = false, modelo = 'Surfer', capacidade = 80, tipo = 'carros' },
	{ hash = 65402552, name = 'youga', price = 260000, banido = false, modelo = 'Youga', capacidade = 120, tipo = 'carros' },
	{ hash = 1026149675, name = 'youga2', price = 1000, banido = false, modelo = 'Youga2', capacidade = 80, tipo = 'work' },
	{ hash = -1207771834, name = 'rebel', price = 370000, banido = false, modelo = 'Rebel', capacidade = 80, tipo = 'work' },
	{ hash = -2076478498, name = 'tractor2', price = 1000, banido = false, modelo = 'Tractor2', capacidade = 80, tipo = 'work' },
	{ hash = 486987393, name = 'huntley', price = 110000, banido = false, modelo = 'Huntley', capacidade = 60, tipo = 'carros' },
	{ hash = 1269098716, name = 'landstalker', price = 130000, banido = false, modelo = 'Landstalker', capacidade = 70, tipo = 'carros' },
	{ hash = 914654722, name = 'mesa', price = 90000, banido = false, modelo = 'Mesa', capacidade = 50, tipo = 'carros' },
	{ hash = -808457413, name = 'patriot', price = 250000, banido = false, modelo = 'Patriot', capacidade = 70, tipo = 'carros' },
	{ hash = -1651067813, name = 'radi', price = 110000, banido = false, modelo = 'Radi', capacidade = 50, tipo = 'carros' },
	{ hash = 2136773105, name = 'rocoto', price = 110000, banido = false, modelo = 'Rocoto', capacidade = 60, tipo = 'carros' },
	{ hash = -376434238, name = 'tyrant', price = 690000, banido = false, modelo = 'Tyrant', capacidade = 30, tipo = 'carros' },
	{ hash = -2120700196, name = 'entity2', price = 550000, banido = false, modelo = 'Entity2', capacidade = 20, tipo = 'carros' },
	{ hash = -988501280, name = 'cheburek', price = 170000, banido = false, modelo = 'Cheburek', capacidade = 50, tipo = 'carros' },
	{ hash = 1115909093, name = 'hotring', price = 300000, banido = false, modelo = 'Hotring', capacidade = 60, tipo = 'carros' },
	{ hash = -214906006, name = 'jester3', price = 345000, banido = false, modelo = 'Jester3', capacidade = 30, tipo = 'carros' },
	{ hash = -1259134696, name = 'flashgt', price = 370000, banido = false, modelo = 'Flashgt', capacidade = 30, tipo = 'carros' },
	{ hash = -1267543371, name = 'ellie', price = 320000, banido = false, modelo = 'Ellie', capacidade = 50, tipo = 'carros' },
	{ hash = 1046206681, name = 'michelli', price = 160000, banido = false, modelo = 'Michelli', capacidade = 40, tipo = 'carros' },
	{ hash = 1617472902, name = 'fagaloa', price = 320000, banido = false, modelo = 'Fagaloa', capacidade = 80, tipo = 'carros' },
	{ hash = -915704871, name = 'dominator2', price = 230000, banido = false, modelo = 'Dominator2', capacidade = 50, tipo = 'carros' },
	{ hash = -986944621, name = 'dominator3', price = 370000, banido = false, modelo = 'Dominator3', capacidade = 30, tipo = 'carros' },
	{ hash = 931280609, name = 'issi3', price = 190000, banido = false, modelo = 'Issi3', capacidade = 20, tipo = 'carros' },
	{ hash = -1134706562, name = 'taipan', price = 620000, banido = false, modelo = 'Taipan', capacidade = 20, tipo = 'carros' },
	{ hash = 1909189272, name = 'gb200', price = 195000, banido = false, modelo = 'Gb200', capacidade = 20, tipo = 'carros' },
	{ hash = -1961627517, name = 'stretch', price = 520000, banido = false, modelo = 'Stretch', capacidade = 60, tipo = 'carros' },
	{ hash = -2107990196, name = 'guardian', price = 540000, banido = false, modelo = 'Guardian', capacidade = 300, tipo = 'carros' },
	{ hash = -121446169, name = 'kamacho', price = 460000, banido = false, modelo = 'Kamacho', capacidade = 90, tipo = 'carros' },
	{ hash = -1848994066, name = 'neon', price = 1000000, banido = false, modelo = 'Neon', capacidade = 30, tipo = 'carros' },
	{ hash = 1392481335, name = 'cyclone', price = 800000, banido = false, modelo = 'Cyclone', capacidade = 20, tipo = 'carros' },
	{ hash = -2048333973, name = 'italigtb', price = 600000, banido = false, modelo = 'Italigtb', capacidade = 20, tipo = 'carros' },
	{ hash = -482719877, name = 'italigtb2', price = 610000, banido = false, modelo = 'Italigtb2', capacidade = 20, tipo = 'carros' },
	{ hash = 1939284556, name = 'vagner', price = 680000, banido = false, modelo = 'Vagner', capacidade = 20, tipo = 'carros' },
	{ hash = 917809321, name = 'xa21', price = 630000, banido = false, modelo = 'Xa21', capacidade = 20, tipo = 'carros' },
	{ hash = 1031562256, name = 'tezeract', price = 920000, banido = false, modelo = 'Tezeract', capacidade = 20, tipo = 'carros' },
	{ hash = 2123327359, name = 'prototipo', price = 1030000, banido = false, modelo = 'Prototipo', capacidade = 20, tipo = 'carros' },
	{ hash = -420911112, name = 'patriot2', price = 550000, banido = false, modelo = 'Patriot2', capacidade = 60, tipo = 'carros' },
	{ hash = 321186144, name = 'stafford', price = 200000, banido = false, modelo = 'Stafford', capacidade = 40, tipo = 'work' },
	{ hash = 500482303, name = 'swinger', price = 250000, banido = false, modelo = 'Swinger', capacidade = 20, tipo = 'carros' },
	{ hash = -1566607184, name = 'clique', price = 360000, banido = false, modelo = 'Clique', capacidade = 40, tipo = 'carros' },
	{ hash = 1591739866, name = 'deveste', price = 920000, banido = false, modelo = 'Deveste', capacidade = 20, tipo = 'carros' },
	{ hash = 1279262537, name = 'deviant', price = 370000, banido = false, modelo = 'Deviant', capacidade = 50, tipo = 'carros' },
	{ hash = -2096690334, name = 'impaler', price = 320000, banido = false, modelo = 'Impaler', capacidade = 60, tipo = 'carros' },
	{ hash = -331467772, name = 'italigto', price = 850000, banido = false, modelo = 'Italigto', capacidade = 30, tipo = 'carros' },
	{ hash = -507495760, name = 'schlagen', price = 690000, banido = false, modelo = 'Schlagen', capacidade = 30, tipo = 'carros' },
	{ hash = -1168952148, name = 'toros', price = 520000, banido = false, modelo = 'Toros', capacidade = 50, tipo = 'carros' },
	{ hash = 1456744817, name = 'tulip', price = 320000, banido = false, modelo = 'Tulip', capacidade = 60, tipo = 'carros' },
	{ hash = -49115651, name = 'vamos', price = 320000, banido = false, modelo = 'Vamos', capacidade = 60, tipo = 'carros' },
	{ hash = -54332285, name = 'freecrawler', price = 350000, banido = false, modelo = 'Freecrawler', capacidade = 50, tipo = 'carros' },
	{ hash = 1909141499, name = 'fugitive', price = 50000, banido = false, modelo = 'Fugitive', capacidade = 50, tipo = 'carros' },
	{ hash = -1232836011, name = 'le7b', price = 700000, banido = false, modelo = 'Le7b', capacidade = 20, tipo = 'carros' },
	{ hash = 2068293287, name = 'lurcher', price = 150000, banido = false, modelo = 'Lurcher', capacidade = 60, tipo = 'carros' },
	{ hash = 482197771, name = 'lynx', price = 370000, banido = false, modelo = 'Lynx', capacidade = 30, tipo = 'carros' },
	{ hash = -674927303, name = 'raptor', price = 300000, banido = false, modelo = 'Raptor', capacidade = 20, tipo = 'carros' },
	{ hash = 819197656, name = 'sheava', price = 700000, banido = false, modelo = 'Sheava', capacidade = 20, tipo = 'carros' },
	{ hash = 838982985, name = 'z190', price = 350000, banido = false, modelo = 'Z190', capacidade = 40, tipo = 'carros' },
	{ hash = 1672195559, name = 'akuma', price = 520000, banido = false, modelo = 'Akuma', capacidade = 15, tipo = 'motos' },
	{ hash = -2115793025, name = 'avarus', price = 350000, banido = false, modelo = 'Avarus', capacidade = 15, tipo = 'motos' },
	{ hash = -2140431165, name = 'bagger', price = 300000, banido = false, modelo = 'Bagger', capacidade = 40, tipo = 'motos' },
	{ hash = -114291515, name = 'bati', price = 370000, banido = false, modelo = 'Bati', capacidade = 15, tipo = 'motos' },
	{ hash = -891462355, name = 'bati2', price = 300000, banido = false, modelo = 'Bati2', capacidade = 15, tipo = 'motos' },
	{ hash = 86520421, name = 'bf400', price = 360000, banido = false, modelo = 'Bf400', capacidade = 15, tipo = 'motos' },
	{ hash = 11251904, name = 'carbonrs', price = 350000, banido = false, modelo = 'Carbonrs', capacidade = 15, tipo = 'motos' },
	{ hash = 6774487, name = 'chimera', price = 345000, banido = false, modelo = 'Chimera', capacidade = 15, tipo = 'motos' },
	{ hash = 390201602, name = 'cliffhanger', price = 310000, banido = false, modelo = 'Cliffhanger', capacidade = 15, tipo = 'motos' },
	{ hash = 2006142190, name = 'daemon', price = 200000, banido = false, modelo = 'Daemon', capacidade = 15, tipo = 'work' },
	{ hash = -1404136503, name = 'daemon2', price = 200000, banido = false, modelo = 'Daemon2', capacidade = 15, tipo = 'motos' },
	{ hash = 822018448, name = 'defiler', price = 380000, banido = false, modelo = 'Defiler', capacidade = 15, tipo = 'motos' },
	{ hash = -239841468, name = 'diablous', price = 430000, banido = false, modelo = 'Diablous', capacidade = 15, tipo = 'motos' },
	{ hash = 1790834270, name = 'diablous2', price = 380000, banido = false, modelo = 'Diablous2', capacidade = 15, tipo = 'motos' },
	{ hash = -1670998136, name = 'double', price = 300000, banido = false, modelo = 'Double', capacidade = 15, tipo = 'motos' },
	{ hash = 1753414259, name = 'enduro', price = 195000, banido = false, modelo = 'Enduro', capacidade = 15, tipo = 'motos' },
	{ hash = 2035069708, name = 'esskey', price = 320000, banido = false, modelo = 'Esskey', capacidade = 15, tipo = 'motos' },
	{ hash = -1842748181, name = 'faggio', price = 4000, banido = false, modelo = 'Faggio', capacidade = 30, tipo = 'motos' },
	{ hash = 55628203, name = 'faggio2', price = 5000, banido = false, modelo = 'Faggio2', capacidade = 30, tipo = 'motos' },
	{ hash = -1289178744, name = 'faggio3', price = 5000, banido = false, modelo = 'Faggio3', capacidade = 30, tipo = 'motos' },
	{ hash = 627535535, name = 'fcr', price = 390000, banido = false, modelo = 'Fcr', capacidade = 15, tipo = 'motos' },
	{ hash = -757735410, name = 'fcr2', price = 390000, banido = false, modelo = 'Fcr2', capacidade = 15, tipo = 'motos' },
	{ hash = 741090084, name = 'gargoyle', price = 280000, banido = false, modelo = 'Gargoyle', capacidade = 15, tipo = 'motos' },
	{ hash = 1265391242, name = 'hakuchou', price = 310000, banido = false, modelo = 'Hakuchou', capacidade = 15, tipo = 'motos' },
	{ hash = -255678177, name = 'hakuchou2', price = 550000, banido = false, modelo = 'Hakuchou2', capacidade = 15, tipo = 'motos' },
	{ hash = 301427732, name = 'hexer', price = 180000, banido = false, modelo = 'Hexer', capacidade = 15, tipo = 'motos' },
	{ hash = -159126838, name = 'innovation', price = 250000, banido = false, modelo = 'Innovation', capacidade = 15, tipo = 'motos' },
	{ hash = 640818791, name = 'lectro', price = 380000, banido = false, modelo = 'Lectro', capacidade = 15, tipo = 'motos' },
	{ hash = -1523428744, name = 'manchez', price = 355000, banido = false, modelo = 'Manchez', capacidade = 15, tipo = 'motos' },
	{ hash = -634879114, name = 'nemesis', price = 345000, banido = false, modelo = 'Nemesis', capacidade = 15, tipo = 'motos' },
	{ hash = -1606187161, name = 'nightblade', price = 34000, banido = false, modelo = 'Nightblade', capacidade = 15, tipo = 'motos' },
	{ hash = -909201658, name = 'pcj', price = 180000, banido = false, modelo = 'Pcj', capacidade = 15, tipo = 'motos' },
	{ hash = -893578776, name = 'ruffian', price = 345000, banido = false, modelo = 'Ruffian', capacidade = 15, tipo = 'motos' },
	{ hash = 788045382, name = 'sanchez', price = 150000, banido = false, modelo = 'Sanchez', capacidade = 15, tipo = 'motos' },
	{ hash = -1453280962, name = 'sanchez2', price = 185000, banido = false, modelo = 'Sanchez2', capacidade = 15, tipo = 'motos' },
	{ hash = 1491277511, name = 'sanctus', price = 350000, banido = false, modelo = 'Sanctus', capacidade = 15, tipo = 'work' },
	{ hash = 743478836, name = 'sovereign', price = 285000, banido = false, modelo = 'Sovereign', capacidade = 50, tipo = 'motos' },
	{ hash = 1836027715, name = 'thrust', price = 375000, banido = false, modelo = 'Thrust', capacidade = 15, tipo = 'motos' },
	{ hash = -140902153, name = 'vader', price = 345000, banido = false, modelo = 'Vader', capacidade = 15, tipo = 'motos' },
	{ hash = -1353081087, name = 'vindicator', price = 340000, banido = false, modelo = 'Vindicator', capacidade = 15, tipo = 'motos' },
	{ hash = -609625092, name = 'vortex', price = 300000, banido = false, modelo = 'Vortex', capacidade = 15, tipo = 'motos' },
	{ hash = -618617997, name = 'wolfsbane', price = 290000, banido = false, modelo = 'Wolfsbane', capacidade = 15, tipo = 'motos' },
	{ hash = -1009268949, name = 'zombiea', price = 290000, banido = false, modelo = 'Zombiea', capacidade = 15, tipo = 'motos' },
	{ hash = -570033273, name = 'zombieb', price = 300000, banido = false, modelo = 'Zombieb', capacidade = 15, tipo = 'motos' },
	{ hash = -2128233223, name = 'blazer', price = 230000, banido = true, modelo = 'Blazer', capacidade = 15, tipo = 'motos' },
	{ hash = -440768424, name = 'blazer4', price = 370000, banido = true, modelo = 'Blazer4', capacidade = 15, tipo = 'motos' },
	{ hash = -405626514, name = 'shotaro', price = 1000000, banido = false, modelo = 'Shotaro', capacidade = 15, tipo = 'motos' },
	{ hash = 1873600305, name = 'ratbike', price = 230000, banido = false, modelo = 'Ratbike', capacidade = 15, tipo = 'motos' },
	{ hash = 1743739647, name = 'policiacharger2018', price = 1000, banido = true, modelo = 'Dodge Charger 2018', capacidade = 0, tipo = 'work' },
	{ hash = 796154746, name = 'policiamustanggt', price = 1000, banido = true, modelo = 'Mustang GT', capacidade = 0, tipo = 'work' },
	{ hash = 81717913, name = 'policiacapricesid', price = 1000, banido = true, modelo = 'GM Caprice SID', capacidade = 0, tipo = 'work' },
	{ hash = 589099944, name = 'policiaschaftersid', price = 1000, banido = true, modelo = 'GM Schafter SID', capacidade = 0, tipo = 'work' },
	{ hash = 1884511084, name = 'policiasilverado', price = 1000, banido = true, modelo = 'Chevrolet Silverado', capacidade = 0, tipo = 'work' },
	{ hash = 1865641415, name = 'policiatahoe', price = 1000, banido = true, modelo = 'Chevrolet Tahoe', capacidade = 0, tipo = 'work' },
	{ hash = -377693317, name = 'policiaexplorer', price = 1000, banido = true, modelo = 'Ford Explorer', capacidade = 0, tipo = 'work' },
	{ hash = 112218935, name = 'policiataurus', price = 1000, banido = true, modelo = 'Ford Taurus', capacidade = 0, tipo = 'work' },
	{ hash = 1611501436, name = 'policiavictoria', price = 1000, banido = true, modelo = 'Ford Victoria', capacidade = 0, tipo = 'work' },
	{ hash = 875040595, name = '11cvpi', price = 1000, banido = false, modelo = 'Policia Cvpi', capacidade = 0, tipo = 'work' },
	{ hash = 2015535545, name = '13tahoe', price = 1000, banido = false, modelo = 'Policia Tahoe', capacidade = 0, tipo = 'work' },
	{ hash = 1932408710, name = '16fpiu', price = 1000, banido = false, modelo = 'Policia Fpiu', capacidade = 0, tipo = 'work' },
	{ hash = -1004153400, name = 'k9fpiu', price = 1000, banido = false, modelo = 'Policia K9fpiu', capacidade = 0, tipo = 'work' },
	{ hash = -1609154515, name = '15chgr', price = 1000, banido = false, modelo = 'Policia 15chgr', capacidade = 0, tipo = 'work' },
	{ hash = -2002090738, name = 'umcvpi', price = 1000, banido = false, modelo = 'Policia Umcvpi', capacidade = 0, tipo = 'work' },
	{ hash = 1348568756, name = 'umfpiu', price = 1000, banido = false, modelo = 'Policia Umfpiu', capacidade = 0, tipo = 'work' },
	{ hash = -1624991916, name = 'policiabmwr1200', price = 1000, banido = false, modelo = 'BMW R1200', capacidade = 0, tipo = 'work' },
	{ hash = -875050963, name = 'policiaheli', price = 1000, banido = true, modelo = 'Policia Helicóptero', capacidade = 0, tipo = 'work' },
	{ hash = -1647941228, name = 'fbi2', price = 1000, banido = true, modelo = 'Granger SOG', capacidade = 0, tipo = 'work' },
	{ hash = -34623805, name = 'policeb', price = 1000, banido = true, modelo = 'Harley Davidson', capacidade = 0, tipo = 'work' },
	{ hash = -792745162, name = 'paramedicoambu', price = 1000, banido = true, modelo = 'Ambulância', capacidade = 0, tipo = 'work' },
	{ hash = 108063727, name = 'paramedicocharger2014', price = 1000, banido = true, modelo = 'Dodge Charger 2014', capacidade = 0, tipo = 'work' },
	{ hash = 2020690903, name = 'paramedicoheli', price = 1000, banido = true, modelo = 'Paramédico Helicóptero', capacidade = 0, tipo = 'work' },
	{ hash = -2007026063, name = 'pbus', price = 1000, banido = true, modelo = 'PBus', capacidade = 0, tipo = 'work' },
	{ hash = 1945374990, name = 'mule4', price = 260000, banido = false, modelo = 'Burrito4', capacidade = 400, tipo = 'carros' },
	{ hash = -2103821244, name = 'rallytruck', price = 260000, banido = false, modelo = 'Burrito4', capacidade = 400, tipo = 'carros' },
	{ hash = -1205689942, name = 'riot', price = 1000, banido = true, modelo = 'Blindado', capacidade = 0, tipo = 'work' },
	{ hash = -2072933068, name = 'coach', price = 1000, banido = true, modelo = 'Coach', capacidade = 0, tipo = 'work' },
	{ hash = -713569950, name = 'bus', price = 1000, banido = true, modelo = 'Ônibus', capacidade = 0, tipo = 'work' },
	{ hash = 1353720154, name = 'flatbed', price = 1000, banido = true, modelo = 'Reboque', capacidade = 0, tipo = 'work' },
	{ hash = -1323100960, name = 'towtruck', price = 1000, banido = true, modelo = 'Towtruck', capacidade = 0, tipo = 'work' },
	{ hash = -442313018, name = 'towtruck2', price = 1000, banido = true, modelo = 'Towtruck2', capacidade = 0, tipo = 'work' },
	{ hash = -667151410, name = 'ratloader', price = 1000, banido = true, modelo = 'Caminhão', capacidade = 80, tipo = 'work' },
	{ hash = -589178377, name = 'ratloader2', price = 1000, banido = false, modelo = 'Ratloader2', capacidade = 70, tipo = 'work' },
	{ hash = -1705304628, name = 'rubble', price = 1000, banido = false, modelo = 'Caminhão', capacidade = 0, tipo = 'work' },
	{ hash = -956048545, name = 'taxi', price = 1000, banido = true, modelo = 'Taxi', capacidade = 0, tipo = 'work' },
	{ hash = 444171386, name = 'boxville4', price = 1000, banido = false, modelo = 'Caminhão', capacidade = 70, tipo = 'work' },
	{ hash = -1255698084, name = 'trash2', price = 1000, banido = false, modelo = 'Caminhão', capacidade = 80, tipo = 'work' },
	{ hash = 48339065, name = 'tiptruck', price = 1000, banido = false, modelo = 'Tiptruck', capacidade = 70, tipo = 'work' },
	{ hash = -186537451, name = 'scorcher', price = 1000, banido = true, modelo = 'Scorcher', capacidade = 0, tipo = 'work' },
	{ hash = 1127861609, name = 'tribike', price = 1000, banido = true, modelo = 'Tribike', capacidade = 0, tipo = 'work' },
	{ hash = -1233807380, name = 'tribike2', price = 1000, banido = true, modelo = 'Tribike2', capacidade = 0, tipo = 'work' },
	{ hash = -400295096, name = 'tribike3', price = 1000, banido = true, modelo = 'Tribike3', capacidade = 0, tipo = 'work' },
	{ hash = -836512833, name = 'fixter', price = 1000, banido = true, modelo = 'Fixter', capacidade = 0, tipo = 'work' },
	{ hash = 448402357, name = 'cruiser', price = 1000, banido = true, modelo = 'Cruiser', capacidade = 0, tipo = 'work' },
	{ hash = 1131912276, name = 'bmx', price = 1000, banido = true, modelo = 'Bmx', capacidade = 0, tipo = 'work' },
	{ hash = 1033245328, name = 'dinghy', price = 1000, banido = true, modelo = 'Dinghy', capacidade = 0, tipo = 'work' },
	{ hash = 861409633, name = 'jetmax', price = 1000, banido = true, modelo = 'Jetmax', capacidade = 0, tipo = 'work' },
	{ hash = -1043459709, name = 'marquis', price = 1000, banido = true, modelo = 'Marquis', capacidade = 0, tipo = 'work' },
	{ hash = -311022263, name = 'seashark3', price = 1000, banido = true, modelo = 'Seashark3', capacidade = 0, tipo = 'work' },
	{ hash = 231083307, name = 'speeder', price = 1000, banido = true, modelo = 'Speeder', capacidade = 0, tipo = 'work' },
	{ hash = 437538602, name = 'speeder2', price = 1000, banido = true, modelo = 'Speeder2', capacidade = 0, tipo = 'work' },
	{ hash = 400514754, name = 'squalo', price = 1000, banido = true, modelo = 'Squalo', capacidade = 0, tipo = 'work' },
	{ hash = -282946103, name = 'suntrap', price = 1000, banido = true, modelo = 'Suntrap', capacidade = 0, tipo = 'work' },
	{ hash = 1070967343, name = 'toro', price = 1000, banido = true, modelo = 'Toro', capacidade = 0, tipo = 'work' },
	{ hash = 908897389, name = 'toro2', price = 1000, banido = true, modelo = 'Toro2', capacidade = 0, tipo = 'work' },
	{ hash = 290013743, name = 'tropic', price = 1000, banido = true, modelo = 'Tropic', capacidade = 0, tipo = 'work' },
	{ hash = 1448677353, name = 'tropic2', price = 1000, banido = true, modelo = 'Tropic2', capacidade = 0, tipo = 'work' },
	{ hash = -2137348917, name = 'phantom', price = 1000, banido = true, modelo = 'Phantom', capacidade = 0, tipo = 'work' },
	{ hash = 569305213, name = 'packer', price = 1000, banido = true, modelo = 'Packer', capacidade = 0, tipo = 'work' },
	{ hash = 710198397, name = 'supervolito', price = 1000, banido = true, modelo = 'Supervolito', capacidade = 0, tipo = 'work' },
	{ hash = -1671539132, name = 'supervolito2', price = 1000, banido = true, modelo = 'Supervolito2', capacidade = 0, tipo = 'work' },
	{ hash = -726768679, name = 'seasparrow', price = 1000, banido = true, modelo = 'Paramédico Helicóptero Água', capacidade = 0, tipo = 'work' },
	{ hash = -644710429, name = 'cuban800', price = 1000, banido = true, modelo = 'Cuban800', capacidade = 0, tipo = 'work' },
	{ hash = -1746576111, name = 'mammatus', price = 1000, banido = true, modelo = 'Mammatus', capacidade = 0, tipo = 'work' },
	{ hash = 1341619767, name = 'vestra', price = 1000, banido = true, modelo = 'Vestra', capacidade = 0, tipo = 'work' },
	{ hash = 1077420264, name = 'velum2', price = 1000, banido = true, modelo = 'Velum2', capacidade = 0, tipo = 'work' },
	{ hash = 745926877, name = 'buzzard2', price = 1000, banido = true, modelo = 'Buzzard2', capacidade = 0, tipo = 'work' },
	{ hash = 744705981, name = 'frogger', price = 1000, banido = true, modelo = 'Frogger', capacidade = 0, tipo = 'work' },
	{ hash = -1660661558, name = 'maverick', price = 400000, banido = false, modelo = 'Maverick', capacidade = 100, tipo = 'exclusive' },
	{ hash = 1956216962, name = 'tanker2', price = 1000, banido = true, modelo = 'Gas', capacidade = 0, tipo = 'work' },
	{ hash = -1207431159, name = 'armytanker', price = 1000, banido = true, modelo = 'Diesel', capacidade = 0, tipo = 'work' },
	{ hash = -1770643266, name = 'tvtrailer', price = 1000, banido = true, modelo = 'Show', capacidade = 0, tipo = 'work' },
	{ hash = 2016027501, name = 'trailerlogs', price = 1000, banido = true, modelo = 'Woods', capacidade = 0, tipo = 'work' },
	{ hash = 2091594960, name = 'tr4', price = 1000, banido = true, modelo = 'Cars', capacidade = 0, tipo = 'work' },
	{ hash = -60313827, name = 'nissangtr', price = 400000, banido = false, modelo = 'Nissan GTR', capacidade = 40, tipo = 'exclusive' },
	{ hash = -2015218779, name = 'nissan370z', price = 400000, banido = false, modelo = 'Nissan 370Z', capacidade = 40, tipo = 'exclusive' },
	{ hash = 1601422646, name = 'dodgechargersrt', price = 1500000, banido = false, modelo = 'Dodge Charger SRT', capacidade = 50, tipo = 'carros' },
	{ hash = -1173768715, name = 'ferrariitalia', price = 400000, banido = false, modelo = 'Ferrari Italia 478', capacidade = 30, tipo = 'exclusive' },
	{ hash = 1676738519, name = 'audirs6', price = 1500000, banido = false, modelo = 'Audi RS6', capacidade = 60, tipo = 'carros' },
	{ hash = -157095615, name = 'bmwm3f80', price = 1500000, banido = false, modelo = 'BMW M3 F80', capacidade = 50, tipo = 'carros' },
	{ hash = -13524981, name = 'bmwm4gts', price = 400000, banido = false, modelo = 'BMW M4 GTS', capacidade = 50, tipo = 'exclusive' },
	{ hash = -1573350092, name = 'fordmustang', price = 1000000, banido = false, modelo = 'Ford Mustang', capacidade = 40, tipo = 'exclusive' },
	{ hash = 1114244595, name = 'lamborghinihuracan', price = 400000, banido = false, modelo = 'Lamborghini Huracan', capacidade = 30, tipo = 'exclusive' },
	{ hash = 1978088379, name = 'lancerevolutionx', price = 1700000, banido = false, modelo = 'Lancer Evolution X', capacidade = 50, tipo = 'exclusive' },
	{ hash = 2034235290, name = 'mazdarx7', price = 800000, banido = false, modelo = 'Mazda RX7', capacidade = 40, tipo = 'carros' },
	{ hash = 670022011, name = 'nissangtrnismo', price = 2250000, banido = false, modelo = 'Nissan GTR Nismo', capacidade = 40, tipo = 'carros' },
	{ hash = -1660661558, name = 'maverick', price = 400000, banido = false, modelo = 'Maverick', capacidade = 100, tipo = 'exclusive' },
	{ hash = -339587598, name = 'swift', price = 400000, banido = false, modelo = 'Swift', capacidade = 100, tipo = 'exclusive' },
	{ hash = -339587598, name = 'swift', price = 400000, banido = false, modelo = 'Swift', capacidade = 100, tipo = 'exclusive' },
	{ hash = 2046537925, name = 'police', price = 1000000, banido = false, modelo = 'BMW Policia', capacidade = 100, tipo = 'work' },
	{ hash = 351980252, name = 'teslaprior', price = 1750000, banido = false, modelo = 'Tesla Prior', capacidade = 50, tipo = 'exclusive' },
	{ hash = 723779872, name = 'toyotasupra', price = 400000, banido = false, modelo = 'Toyota Supra', capacidade = 35, tipo = 'exclusive' },
	{ hash = -740742391, name = 'mercedesa45', price = 1000000, banido = false, modelo = 'Mercedes A45', capacidade = 40, tipo = 'carros' },
	{ hash = 819937652, name = 'focusrs', price = 900000, banido = false, modelo = 'Focus RS', capacidade = 40, tipo = 'exclusive' },
	{ hash = -133349447, name = 'lancerevolution9', price = 1400000, banido = false, modelo = 'Lancer Evolution 9', capacidade = 50, tipo = 'carros' },
	{ hash = -189438188, name = 'p1', price = 200000, banido = false, modelo = 'p1', capacidade = 40, tipo = 'carros' },
	{ hash = 1718441594, name = 'i8', price = 400000, banido = false, modelo = 'BMW i8', capacidade = 35, tipo = 'exclusive' },
	{ hash = -1481236684, name = 'aperta', price = 1000000, banido = false, modelo = 'Ferrari Aperta', capacidade = 60, tipo = 'exclusive' },
	{ hash = -433961724, name = 'senna', price = 200000, banido = false, modelo = 'senna', capacidade = 40, tipo = 'carros' },
	{ hash = 2045784380, name = 'rmodx6', price = 400000, banido = false, modelo = 'BMW X6', capacidade = 40, tipo = 'carros' },
	{ hash = 1503141430, name = 'divo', price = 200000, banido = false, modelo = 'divo', capacidade = 40, tipo = 'carros' },
	{ hash = 1966489524, name = 's15', price = 200000, banido = false, modelo = 's15', capacidade = 40, tipo = 'carros' },
	{ hash = -915188472, name = 'amggtr', price = 200000, banido = false, modelo = 'amggtr', capacidade = 40, tipo = 'carros' },
	{ hash = -264618235, name = 'lamtmc', price = 1000000, banido = false, modelo = 'Lamborghini Terzo', capacidade = 20, tipo = 'exclusive' },
	{ hash = -1067176722, name = 'vantage', price = 200000, banido = false, modelo = 'vantage', capacidade = 40, tipo = 'carros' },
	{ hash = -520214134, name = 'urus', price = 200000, banido = false, modelo = 'urus', capacidade = 40, tipo = 'carros' },
	{ hash = 2093958905, name = 'slsamg', price = 200000, banido = false, modelo = 'slsamg', capacidade = 40, tipo = 'carros' },
	{ hash = 104532066, name = 'g65amg', price = 200000, banido = false, modelo = 'g65amg', capacidade = 40, tipo = 'carros' },
	{ hash = 1995020435, name = 'celta', price = 200000, banido = false, modelo = 'celta', capacidade = 40, tipo = 'carros' },
	{ hash = 2047166283, name = 'bmws', price = 400000, banido = false, modelo = 'BMW S1000', capacidade = 40, tipo = 'exclusive' },
	{ hash = 494265960, name = 'cb500x', price = 200000, banido = false, modelo = 'cb500x', capacidade = 20, tipo = 'motos' },
	{ hash = -42051018, name = 'veneno', price = 200000, banido = false, modelo = 'veneno', capacidade = 40, tipo = 'carros' },
	{ hash = -654239719, name = 'agerars', price = 200000, banido = false, modelo = 'agerars', capacidade = 40, tipo = 'carros' },
	{ hash = 580861919, name = 'fc15', price = 200000, banido = false, modelo = 'fc15', capacidade = 40, tipo = 'carros' },
	{ hash = 1402024844, name = 'bbentayga', price = 200000, banido = false, modelo = 'bbentayga', capacidade = 40, tipo = 'carros' },
	{ hash = 1221510024, name = 'nissantitan17', price = 200000, banido = false, modelo = 'nissantitan17', capacidade = 40, tipo = 'carros' },
	{ hash = -653358508, name = 'msohs', price = 200000, banido = false, modelo = 'msohs', capacidade = 40, tipo = 'carros' },
	{ hash = 1224601968, name = '19ftype', price = 200000, banido = false, modelo = '19ftype', capacidade = 40, tipo = 'carros' },
	{ hash = -1593808613, name = '488gtb', price = 400000, banido = false, modelo = 'Ferrari 488 GTB', capacidade = 30, tipo = 'exclusive' },
	{ hash = 1270688730, name = 'm6e63', price = 200000, banido = false, modelo = 'm6e63', capacidade = 40, tipo = 'carros' },
	{ hash = -1467569396, name = '180sx', price = 200000, banido = false, modelo = '180sx', capacidade = 40, tipo = 'carros' },
	{ hash = -192929549, name = 'audirs7', price = 1800000, banido = false, modelo = 'Audi RS7', capacidade = 60, tipo = 'exclusive' },
	{ hash = 653510754, name = 'hondafk8', price = 900000, banido = false, modelo = 'Honda FK8', capacidade = 40, tipo = 'import' },
	{ hash = -148915999, name = 'mustangmach1', price = 350000, banido = false, modelo = 'Mustang Mach 1', capacidade = 50, tipo = 'import' },
	{ hash = 2009693397, name = 'porsche930', price = 1200000, banido = false, modelo = 'Porsche 930', capacidade = 40, tipo = 'exclusive' },
	{ hash = 624514487, name = 'raptor2017', price = 1250000, banido = false, modelo = 'Ford Raptor 2017', capacidade = 300, tipo = 'carros' },
	{ hash = -2096912321, name = 'filthynsx', price = 200000, banido = false, modelo = 'filthynsx', capacidade = 40, tipo = 'carros' },
	{ hash = 1603211447, name = 'eclipse', price = 180000, banido = false, modelo = 'Mitsubishi Eclipse', capacidade = 30, tipo = 'carros' },
	{ hash = 949614817, name = 'lp700r', price = 200000, banido = false, modelo = 'lp700r', capacidade = 40, tipo = 'carros' },
	{ hash = 2037834373, name = 'flatbed3', price = 1000, banido = false, modelo = 'flatbed3', capacidade = 0, tipo = 'work' },
	{ hash = 1663453404, name = 'evoque', price = 2000000, banido = false, modelo = 'Range Rover Evoque', capacidade = 50, tipo = 'carros' },
	{ hash = -1845487887, name = 'volatus', price = 1000000, banido = false, modelo = 'Volatus', capacidade = 1000, tipo = 'work' },
	{ hash = -2049243343, name = 'rc', price = 200000, banido = false, modelo = 'rc', capacidade = 40, tipo = 'carros' },
	{ hash = 16211617168, name = 'cargobob2', price = 1000000, banido = false, modelo = 'Cargo Bob 2', capacidade = 1000, tipo = 'work' },
	{ hash = -50547061, name = 'cargobob', price = 1000000, banido = false, modelo = 'Cargo Bob', capacidade = 1000, tipo = 'exclusive' },
	{ hash = 69730216, name = 'foxshelby', price = 950000, banido = false, modelo = 'foxshelby', capacidade = 40, tipo = 'carros' },
	{ hash = -221995372, name = 'gtr50', price = 200000, banido = false, modelo = 'gtr50', capacidade = 40, tipo = 'carros' },
	{ hash = 898224721, name = '19raptor', price = 200000, banido = false, modelo = '19raptor', capacidade = 300, tipo = 'carros' },
	{ hash = 69730216, name = 'foxshelby', price = 950000, banido = false, modelo = 'foxshelby', capacidade = 40, tipo = 'carros' },
	{ hash = 926685683, name = 'huayrar', price = 200000, banido = false, modelo = 'huayrar', capacidade = 40, tipo = 'carros' },
	{ hash = -143695728, name = 'r820', price = 200000, banido = false, modelo = 'r820', capacidade = 40, tipo = 'carros' },
	{ hash = -1222347999, name = 'rmodmk7', price = 700000, banido = false, modelo = 'Golf', capacidade = 40, tipo = 'carros' },
	{ hash = 1527683961, name = 'ursa', price = 200000, banido = false, modelo = 'ursa', capacidade = 40, tipo = 'carros' },
	{ hash = 1305247149, name = 'gs310', price = 200000, banido = false, modelo = 'gs310', capacidade = 20, tipo = 'motos' },
	{ hash = 273638318, name = 'gle21', price = 650000, banido = false, modelo = 'gle21', capacidade = 40, tipo = 'carros' },
	{ hash = 730959932, name = 'bolide', price = 200000, banido = false, modelo = 'bolide', capacidade = 40, tipo = 'carros' },
	{ hash = 1862249453, name = '4runner', price = 200000, banido = false, modelo = '4runner', capacidade = 40, tipo = 'carros' },
	{ hash = 285057540, name = 'gemera', price = 200000, banido = false, modelo = 'gemera', capacidade = 40, tipo = 'carros' },
	{ hash = -113052809, name = 'sultanrs2', price = 200000, banido = false, modelo = 'sultanrs2', capacidade = 40, tipo = 'exclusive' },
	{ hash = -856469349, name = 'aimgainnsx', price = 200000, banido = false, modelo = 'aimgainnsx', capacidade = 40, tipo = 'carros' },
	{ hash = -1555105668, name = 'fox', price = 100000, banido = false, modelo = 'Fox', capacidade = 40, tipo = 'carros' },
	{ hash = 69336460, name = 'sian', price = 200000, banido = false, modelo = 'sian', capacidade = 40, tipo = 'carros' },
	{ hash = -1426938578, name = 'silvia', price = 200000, banido = false, modelo = 'silvia', capacidade = 40, tipo = 'carros' },
	{ hash = 1088829493, name = 'cg160', price = 100000, banido = false, modelo = 'CG 160 Titan', capacidade = 20, tipo = 'motos' },
	{ hash = -1399780972, name = 'cb650fr', price = 200000, banido = false, modelo = 'cb650fr', capacidade = 20, tipo = 'motos' },
	{ hash = -411549476, name = 'Bike', price = 8000, banido = false, modelo = 'Mobilete', capacidade = 20, tipo = 'motos' },
	{ hash = -1194399245, name = 'hornet2014', price = 200000, banido = false, modelo = 'hornet2014', capacidade = 20, tipo = 'motos' },
	{ hash = 358580688, name = 'Carreta', price = 1000000, banido = false, modelo = 'Carreta', capacidade = 40, tipo = 'carros' },
	{ hash = 1038274186, name = 'Treme', price = 1000000, banido = false, modelo = 'Engate Carreta Fechada', capacidade = 40, tipo = 'carros' },
	{ hash = -1680938805, name = 'TremeTreme', price = 1000000, banido = false, modelo = 'Engate Carreta Aberta', capacidade = 40, tipo = 'carros' },
	{ hash = 1047274985, name = 'africat', price = 200000, banido = false, modelo = 'africat', capacidade = 20, tipo = 'motos' },
	{ hash = -915188472, name = 'amggtr', price = 200000, banido = false, modelo = 'amggtr', capacidade = 40, tipo = 'carros' },
	{ hash = -1696240789, name = 'cx75', price = 200000, banido = false, modelo = 'cx75', capacidade = 40, tipo = 'carros' },
	{ hash = -1816146634, name = 'spyker', price = 200000, banido = false, modelo = 'spyker', capacidade = 40, tipo = 'carros' },
	{ hash = -85613452, name = 'charger', price = 200000, banido = false, modelo = 'charger', capacidade = 40, tipo = 'carros' },
	{ hash = -2089974945, name = 'moss', price = 200000, banido = false, modelo = 'moss', capacidade = 40, tipo = 'carros' },
	{ hash = 1503141430, name = 'divo', price = 200000, banido = false, modelo = 'divo', capacidade = 40, tipo = 'carros' },
	{ hash = -992812151, name = 'dk350z', price = 200000, banido = false, modelo = 'dk350z', capacidade = 40, tipo = 'carros' },
	{ hash = -486920242, name = 'dm1200', price = 200000, banido = false, modelo = 'dm1200', capacidade = 20, tipo = 'motos' },
	{ hash = 110033087, name = 'f8t', price = 200000, banido = false, modelo = 'f8t', capacidade = 40, tipo = 'carros' },
	{ hash = 1514325878, name = 'jes', price = 200000, banido = false, modelo = 'jes', capacidade = 40, tipo = 'carros' },
	{ hash = -751163311, name = 'mlnovitec', price = 200000, banido = false, modelo = 'mlnovitec', capacidade = 40, tipo = 'carros' },
	{ hash = -1667727259, name = 'nh2r', price = 200000, banido = false, modelo = 'nh2r', capacidade = 40, tipo = 'carros' },
	{ hash = 194366558, name = 'panamera17turbo', price = 200000, banido = false, modelo = 'panamera17turbo', capacidade = 40, tipo = 'carros' },
	{ hash = -2049243343, name = 'rc', price = 200000, banido = false, modelo = 'rc', capacidade = 40, tipo = 'carros' },
	{ hash = 1454998807, name = 'rmodsian', price = 200000, banido = false, modelo = 'rmodsian', capacidade = 40, tipo = 'carros' },
	{ hash = -1111150036, name = 'sbrWRX', price = 200000, banido = false, modelo = 'sbrWRX', capacidade = 40, tipo = 'carros' },
	{ hash = -433961724, name = 'senna', price = 200000, banido = false, modelo = 'senna', capacidade = 40, tipo = 'carros' },
	{ hash = 119794591, name = 'sq72016', price = 200000, banido = false, modelo = 'sq72016', capacidade = 40, tipo = 'carros' },
	{ hash = -1884420644, name = 'sti', price = 200000, banido = false, modelo = 'sti', capacidade = 40, tipo = 'carros' },
	{ hash = -2132463276, name = 'terzo', price = 200000, banido = false, modelo = 'terzo', capacidade = 40, tipo = 'carros' },
	{ hash = -520214134, name = 'urus', price = 200000, banido = false, modelo = 'urus', capacidade = 40, tipo = 'carros' },
	{ hash = 1744543800, name = 'z1000', price = 200000, banido = false, modelo = 'z1000', capacidade = 20, tipo = 'motos' },
	{ hash = -1461287895, name = '2013r8', price = 200000, banido = false, modelo = '2013r8', capacidade = 40, tipo = 'carros' },
	{ hash = -1156537658, name = 'tiger', price = 200000, banido = false, modelo = 'tiger', capacidade = 40, tipo = 'motos' },
	{ hash = -1339710539, name = '4c', price = 200000, banido = false, modelo = '4c', capacidade = 40, tipo = 'carros' },
	{ hash = -216150906, name = '16challenger', price = 200000, banido = false, modelo = '16challenger', capacidade = 40, tipo = 'carros' },
	{ hash = 726460559, name = '99viper', price = 200000, banido = false, modelo = '99viper', capacidade = 40, tipo = 'carros' },
	{ hash = 1301689862, name = 'acs8', price = 200000, banido = false, modelo = 'acs8', capacidade = 40, tipo = 'carros' },
	{ hash = -1549019518, name = 'ap2', price = 200000, banido = false, modelo = 'ap2', capacidade = 40, tipo = 'carros' },
	{ hash = -1265899455, name = 'hcbr17', price = 200000, banido = false, modelo = 'hcbr17', capacidade = 20, tipo = 'motos' },
	{ hash = -1528058219, name = 'contgt2011', price = 200000, banido = false, modelo = 'contgt2011', capacidade = 40, tipo = 'carros' },
	{ hash = 580861919, name = 'fc15', price = 200000, banido = false, modelo = 'fc15', capacidade = 40, tipo = 'carros' },
	{ hash = -1752116803, name = 'gtr', price = 200000, banido = false, modelo = 'gtr', capacidade = 40, tipo = 'carros' },
	{ hash = -688419137, name = 'hayabusa', price = 200000, banido = false, modelo = 'hayabusa', capacidade = 40, tipo = 'motos' },
	{ hash = -204311418, name = 'lp770', price = 200000, banido = false, modelo = 'lp770', capacidade = 40, tipo = 'carros' },
	{ hash = -2033519206, name = 'lw458s', price = 200000, banido = false, modelo = 'lw458s', capacidade = 40, tipo = 'carros' },
	{ hash = -747269546, name = 'm2f22', price = 200000, banido = false, modelo = 'm2f22', capacidade = 40, tipo = 'carros' },
	{ hash = 1026616240, name = 'mteche39', price = 200000, banido = false, modelo = 'mteche39', capacidade = 40, tipo = 'carros' },
	{ hash = 162432206, name = 'mst', price = 200000, banido = false, modelo = 'mst', capacidade = 40, tipo = 'carros' },
	{ hash = -189438188, name = 'p1', price = 200000, banido = false, modelo = 'p1', capacidade = 40, tipo = 'carros' },
	{ hash = 1474015055, name = 'r1', price = 200000, banido = false, modelo = 'r1', capacidade = 40, tipo = 'motos' },
	{ hash = -188978926, name = 'r6', price = 200000, banido = false, modelo = 'r6', capacidade = 40, tipo = 'carros' },
	{ hash = -213537235, name = 'rcf', price = 200000, banido = false, modelo = 'rcf', capacidade = 40, tipo = 'carros' },
	{ hash = -1943656060, name = 'rs5', price = 200000, banido = false, modelo = 'rs5', capacidade = 40, tipo = 'carros' },
	{ hash = 216350205, name = 'rs318', price = 200000, banido = false, modelo = 'rs318', capacidade = 40, tipo = 'carros' },
	{ hash = 481790297, name = 's600w220', price = 200000, banido = false, modelo = 's600w220', capacidade = 40, tipo = 'carros' },
	{ hash = 1709518892, name = 'zx10', price = 200000, banido = false, modelo = 'zx10', capacidade = 40, tipo = 'motos' },
	{ hash = 469441176, name = 'accord', price = 200000, banido = false, modelo = 'accord', capacidade = 40, tipo = 'carros' },
	{ hash = -1551307112, name = 'amggt', price = 200000, banido = false, modelo = 'amggt', capacidade = 40, tipo = 'carros' },
	{ hash = 2084023169, name = 'balltruck', price = 200000, banido = false, modelo = 'balltruck', capacidade = 40, tipo = 'carros' },
	{ hash = 1998346768, name = 'f82', price = 200000, banido = false, modelo = 'f82', capacidade = 40, tipo = 'carros' },
	{ hash = -1150723658, name = 'gmt900escalade', price = 200000, banido = false, modelo = 'gmt900escalade', capacidade = 40, tipo = 'carros' },
	{ hash = -1304790695, name = 'f150', price = 200000, banido = false, modelo = 'f150', capacidade = 40, tipo = 'carros' },
	{ hash = -196245904, name = 'fx50s', price = 200000, banido = false, modelo = 'fx50s', capacidade = 40, tipo = 'carros' },
	{ hash = 1073207512, name = 'ARgiulia', price = 200000, banido = false, modelo = 'ARgiulia', capacidade = 40, tipo = 'carros' },
	{ hash = -1962234663, name = 'kiagt', price = 200000, banido = false, modelo = 'kiagt', capacidade = 40, tipo = 'carros' },
	{ hash = 2147463464, name = 'megaram', price = 200000, banido = false, modelo = 'megaram', capacidade = 40, tipo = 'carros' },
	{ hash = -32005528, name = 'boss302', price = 200000, banido = false, modelo = 'boss302', capacidade = 40, tipo = 'carros' },
	{ hash = 1651626097, name = 'pana', price = 200000, banido = false, modelo = 'pana', capacidade = 40, tipo = 'carros' },
	{ hash = 250002773, name = 'pg8', price = 200000, banido = false, modelo = 'pg8', capacidade = 40, tipo = 'carros' },
	{ hash = 1295671424, name = 'rrsport', price = 200000, banido = false, modelo = 'rrsport', capacidade = 40, tipo = 'carros' },
	{ hash = 2117711508, name = 'skyline', price = 200000, banido = false, modelo = 'skyline', capacidade = 40, tipo = 'carros' },
	{ hash = 680866909, name = 'vapidlow', price = 200000, banido = false, modelo = 'vapidlow', capacidade = 40, tipo = 'carros' },
	{ hash = 1405376157, name = 'z28', price = 200000, banido = false, modelo = 'z28', capacidade = 40, tipo = 'carros' },
	{ hash = -235523255, name = 'a8audi', price = 200000, banido = false, modelo = 'a8audi', capacidade = 40, tipo = 'carros' },
	{ hash = -465446781, name = 'audis8om', price = 200000, banido = false, modelo = 'audis8om', capacidade = 40, tipo = 'carros' },
	{ hash = 348351557, name = 'brokenet', price = 200000, banido = false, modelo = 'brokenet', capacidade = 40, tipo = 'carros' },
	{ hash = 71033349, name = 'c10', price = 200000, banido = false, modelo = 'c10', capacidade = 40, tipo = 'carros' },
	{ hash = -1039183340, name = 'cherokee96', price = 200000, banido = false, modelo = 'cherokee96', capacidade = 40, tipo = 'carros' },
	{ hash = -538151212, name = 'chgrsrt8', price = 200000, banido = false, modelo = 'chgrsrt8', capacidade = 40, tipo = 'carros' },
	{ hash = 1898693225, name = 'chry300', price = 200000, banido = false, modelo = 'chry300', capacidade = 40, tipo = 'carros' },
	{ hash = -1709733450, name = 'cm69', price = 200000, banido = false, modelo = 'cm69', capacidade = 40, tipo = 'carros' },
	{ hash = -1203725842, name = 'ctsv16', price = 200000, banido = false, modelo = 'ctsv16', capacidade = 40, tipo = 'carros' },
	{ hash = -1556078545, name = 'cv96', price = 200000, banido = false, modelo = 'cv96', capacidade = 40, tipo = 'carros' },
	{ hash = 70813415, name = 'cxt', price = 200000, banido = false, modelo = 'cxt', capacidade = 40, tipo = 'carros' },
	{ hash = 1303860548, name = 'deathcap', price = 200000, banido = false, modelo = 'deathcap', capacidade = 40, tipo = 'carros' },
	{ hash = 885421525, name = 'demon', price = 200000, banido = false, modelo = 'demon', capacidade = 40, tipo = 'carros' },
	{ hash = -662904049, name = 'e63amg', price = 200000, banido = false, modelo = 'e63amg', capacidade = 40, tipo = 'carros' },
	{ hash = 5917646, name = 'excursion', price = 200000, banido = false, modelo = 'excursion', capacidade = 40, tipo = 'carros' },
	{ hash = 1083452760, name = 'fjc', price = 200000, banido = false, modelo = 'fjc', capacidade = 40, tipo = 'carros' },
	{ hash = 1499192790, name = 'fuluxt2', price = 200000, banido = false, modelo = 'fuluxt2', capacidade = 40, tipo = 'carros' },
	{ hash = -994884211, name = 'g20', price = 200000, banido = false, modelo = 'g20', capacidade = 40, tipo = 'carros' },
	{ hash = 104532066, name = 'g65amg', price = 200000, banido = false, modelo = 'g65amg', capacidade = 40, tipo = 'carros' },
	{ hash = -565536581, name = 'GT86', price = 200000, banido = false, modelo = 'GT86', capacidade = 40, tipo = 'carros' },
	{ hash = -198908, name = 'h1humm', price = 200000, banido = false, modelo = 'h1humm', capacidade = 40, tipo = 'carros' },
	{ hash = 1896246476, name = 'h6', price = 200000, banido = false, modelo = 'h6', capacidade = 40, tipo = 'carros' },
	{ hash = -1472179531, name = 'hilux99', price = 200000, banido = false, modelo = 'hilux99', capacidade = 40, tipo = 'carros' },
	{ hash = -1691715558, name = 'jeep2012', price = 200000, banido = false, modelo = 'jeep2012', capacidade = 40, tipo = 'carros' },
	{ hash = -2080737741, name = 'k5blzr', price = 200000, banido = false, modelo = 'k5blzr', capacidade = 40, tipo = 'carros' },
	{ hash = -709820282, name = 'kodiak', price = 200000, banido = false, modelo = 'kodiak', capacidade = 40, tipo = 'carros' },
	{ hash = -1796140063, name = 'lp610', price = 200000, banido = false, modelo = 'lp610', capacidade = 40, tipo = 'carros' },
	{ hash = -904630477, name = 'luaz', price = 200000, banido = false, modelo = 'luaz', capacidade = 40, tipo = 'carros' },
	{ hash = -1760022916, name = 'lx570', price = 200000, banido = false, modelo = 'lx570', capacidade = 40, tipo = 'carros' },
	{ hash = -536030675, name = 'MBW124', price = 200000, banido = false, modelo = 'MBW124', capacidade = 40, tipo = 'carros' },
	{ hash = 1675614131, name = 'mfc', price = 200000, banido = false, modelo = 'mfc', capacidade = 40, tipo = 'carros' },
	{ hash = -346924611, name = 'mlbrabus', price = 200000, banido = false, modelo = 'mlbrabus', capacidade = 40, tipo = 'carros' },
	{ hash = -252836656, name = 'models', price = 200000, banido = false, modelo = 'models', capacidade = 40, tipo = 'carros' },
	{ hash = -1370043968, name = 'mudsl', price = 200000, banido = false, modelo = 'mudsl', capacidade = 40, tipo = 'carros' },
	{ hash = 204836792, name = 'mz3', price = 200000, banido = false, modelo = 'mz3', capacidade = 40, tipo = 'carros' },
	{ hash = 1418132356, name = 'prius', price = 200000, banido = false, modelo = 'prius', capacidade = 40, tipo = 'carros' },
	{ hash = -421330575, name = 'ram3500', price = 200000, banido = false, modelo = 'ram3500', capacidade = 40, tipo = 'carros' },
	{ hash = -499353413, name = 'retired', price = 200000, banido = false, modelo = 'retired', capacidade = 40, tipo = 'carros' },
	{ hash = -1698677681, name = 'rmodlp750', price = 200000, banido = false, modelo = 'rmodlp750', capacidade = 40, tipo = 'carros' },
	{ hash = -291927921, name = 'rmodsupra', price = 200000, banido = false, modelo = 'rmodsupra', capacidade = 40, tipo = 'carros' },
	{ hash = -1724630220, name = 'rrphantom', price = 200000, banido = false, modelo = 'rrphantom', capacidade = 40, tipo = 'carros' },
	{ hash = 797917810, name = 'rx450h', price = 200000, banido = false, modelo = 'rx450h', capacidade = 40, tipo = 'carros' },
	{ hash = -1532567086, name = 'silverado', price = 200000, banido = false, modelo = 'silverado', capacidade = 40, tipo = 'carros' },
	{ hash = -1946742891, name = 'slsamg', price = 200000, banido = false, modelo = 'slsamg', capacidade = 40, tipo = 'carros' },
	{ hash = -1298373790, name = 'subwrx', price = 200000, banido = false, modelo = 'subwrx', capacidade = 40, tipo = 'carros' },
	{ hash = 82894084, name = 'tule', price = 200000, banido = false, modelo = 'tule', capacidade = 40, tipo = 'carros' },
	{ hash = 1270688730, name = 'm6e63', price = 200000, banido = false, modelo = 'm6e63', capacidade = 40, tipo = 'carros' },
	{ hash = 1402024844, name = 'bbentayga', price = 200000, banido = false, modelo = 'bbentayga', capacidade = 40, tipo = 'carros' },
	{ hash = -42051018, name = 'veneno', price = 200000, banido = false, modelo = 'veneno', capacidade = 40, tipo = 'carros' },
	{ hash = 1221510024, name = 'nissantitan17', price = 200000, banido = false, modelo = 'nissantitan17', capacidade = 40, tipo = 'carros' },
	{ hash = 1224601968, name = '19ftype', price = 200000, banido = false, modelo = '19ftype', capacidade = 40, tipo = 'carros' },
	{ hash = -654239719, name = 'agerars', price = 200000, banido = false, modelo = 'agerars', capacidade = 40, tipo = 'carros' },
	{ hash = -653358508, name = 'msohs', price = 200000, banido = false, modelo = 'msohs', capacidade = 40, tipo = 'carros' },
	{ hash = 836213613, name = '18performante', price = 200000, banido = false, modelo = '18performante', capacidade = 40, tipo = 'carros' },
	{ hash = 1718441594, name = 'i8', price = 400000, banido = false, modelo = 'BMW i8', capacidade = 35, tipo = 'exclusive' },
	{ hash = 494265960, name = 'cb500x', price = 200000, banido = false, modelo = 'cb500x', capacidade = 20, tipo = 'motos' },
	{ hash = 949614817, name = 'lp700r', price = 200000, banido = false, modelo = 'lp700r', capacidade = 40, tipo = 'carros' },
	{ hash = -2096912321, name = 'filthynsx', price = 200000, banido = false, modelo = 'filthynsx', capacidade = 40, tipo = 'carros' },
	{ hash = -1467569396, name = '180sx', price = 200000, banido = false, modelo = '180sx', capacidade = 40, tipo = 'carros' },
	{ hash = -1942383131, name = '2020ss', price = 200000, banido = false, modelo = '2020ss', capacidade = 40, tipo = 'carros' },
	{ hash = -1067176722, name = 'vantage', price = 200000, banido = false, modelo = 'vantage', capacidade = 40, tipo = 'carros' },
	{ hash = -1444047101, name = 'bugatti', price = 200000, banido = false, modelo = 'bugatti', capacidade = 40, tipo = 'carros' },
	{ hash = 1995020435, name = 'celta', price = 200000, banido = false, modelo = 'celta', capacidade = 40, tipo = 'carros' },
	{ hash = 429522388, name = 'lbsihu', price = 200000, banido = false, modelo = 'lbsihu', capacidade = 40, tipo = 'carros' },
	{ hash = -1432034260, name = 'mgt', price = 200000, banido = false, modelo = 'mgt', capacidade = 40, tipo = 'carros' },
	{ hash = 1966489524, name = 's15', price = 200000, banido = false, modelo = 's15', capacidade = 40, tipo = 'carros' },
	{ hash = -586459613, name = 'ttrs', price = 200000, banido = false, modelo = 'ttrs', capacidade = 40, tipo = 'carros' },
	{ hash = 730959932, name = 'W900', price = 200000, banido = false, modelo = 'W900', capacidade = 40, tipo = 'carros' },
	{ hash = 342059638, name = 'xj6', price = 200000, banido = false, modelo = 'xj6', capacidade = 20, tipo = 'motos' },
	{ hash = -842094945, name = 'xt660', price = 200000, banido = false, modelo = 'xt660', capacidade = 20, tipo = 'motos' },
	{ hash = -814861819, name = 'code3cvpi', price = 1000000, banido = false, modelo = 'code3cvpi', capacidade = 40, tipo = 'work' },
	{ hash = -1377401256, name = 'code3cap', price = 1000000, banido = false, modelo = 'code3cap', capacidade = 40, tipo = 'work' },
	{ hash = -418871737, name = 'code3fpis', price = 1000000, banido = false, modelo = 'code3fpis', capacidade = 40, tipo = 'work' },
	{ hash = 1646620716, name = 'code3gator', price = 1000000, banido = false, modelo = 'code3gator', capacidade = 40, tipo = 'work' },
	{ hash = 422395975, name = 'code316fpiu', price = 1000000, banido = false, modelo = 'code316fpiu', capacidade = 40, tipo = 'work' },
	{ hash = -1057372170, name = 'code314charg', price = 1000000, banido = false, modelo = 'code314charg', capacidade = 40, tipo = 'work' },
	{ hash = 837100403, name = 'mercedespolicia', price = 1, banido = false, modelo = 'mercedespolicia', capacidade = 30, tipo = 'work' },
	{ hash = 1957711224, name = '20EXPLO', price = 1, banido = false, modelo = '20EXPLO', capacidade = 30, tipo = 'work' },
	{ hash = 1230579450, name = '1200RT', price = 1, banido = false, modelo = '1200RT', capacidade = 10, tipo = 'work' },
}
----------------------------------------------
----------------------------------------------


-- RETORNA A LISTA DE VEÍCULOS
config.getVehList = function()
	return config.vehList
end

-- RETORNA AS INFORMAÇÕES CONTIDAS NA LISTA DE UM VEÍCULO ESPECÍFICO
config.getVehicleInfo = function(vehicle)
	for i in ipairs(config.vehList) do
		if vehicle == config.vehList[i].hash or vehicle == config.vehList[i].name then
            return config.vehList[i]
        end
    end
    return false
end

-- RETORNA O MODELO DE UM VEÍCULO ESPECÍFICO (NOME BONITINHO)
config.getVehicleModel = function(vehicle)
	local vehInfo = config.getVehicleInfo(vehicle)
	if vehInfo then
		return vehInfo.modelo or vehicle
	end
	return vehicle
end

-- RETORNA A CAPACIDADE DO PORTA-MALAS DE UM VEÍCULO ESPECÍFICO
config.getVehicleTrunk = function(vehicle)
	local vehInfo = config.getVehicleInfo(vehicle)
	if vehInfo then
		return vehInfo.capacidade or 0
	end
	return 0
end

-- RETORNA O PREÇO DE UM VEÍCULO ESPECÍFICO
config.getVehiclePrice = function(vehicle)
	local vehInfo = config.getVehicleInfo(vehicle)
	if vehInfo then
		return vehInfo.price or 0
	end
	return 0
end

-- RETORNA O TIPO DE UM VEÍCULO ESPECÍFICO
config.getVehicleType = function(vehicle)
	local vehInfo = config.getVehicleInfo(vehicle)
	if vehInfo then
		return vehInfo.tipo or 0
	end
	return "none"
end

-- RETORNA O STATUS DE BANIDO DE UM VEÍCULO ESPECÍFICO
config.isVehicleBanned = function(vehicle)
	local vehInfo = config.getVehicleInfo(vehicle)
	if vehInfo then
		return vehInfo.banido
	end
	return false
end



-----------------------------------------------------------------
------------- GARAGENS PÚBLICAS E DE SERVIÇO --------------------
-----------------------------------------------------------------

config.garages = {
	[1] = { type = 'public', coords = vec3(55.43,-876.19,30.66), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(50.66,-873.02,30.45), h = 159.65 },
		[2] = { vec3(47.34,-871.81,30.45), h = 159.65 },
		[3] = { vec3(44.17,-870.5,30.45), h = 159.65 },
	  },
	},
	[2] = { type = 'public', coords = vec3(596.4,90.65,93.12), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(599.38,98.16,92.06), h = 249.86 },
		[2] = { vec3(600.74,101.16,92.06), h = 249.86 },
	  },
	},
	[3] = { type = 'public', coords = vec3(-340.76,265.97,85.67), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(-329.74,274.2,85.44), h = 93.8 },
		[2] = { vec3(-329.88,277.63,85.43), h = 93.8 },
	  },
	},
	[4] = { type = 'public', coords = vec3(-2030.01,-465.97,11.6), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(-2024.27,-471.93,11.4), h = 140.0 },
		[2] = { vec3(-2021.9,-474.17,11.4), h = 140.0 },
	  },
	},
	[5] = { type = 'public', coords = vec3(-1184.92,-1510.0,4.64), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(-1183.49,-1495.92,4.37), h = 125.0 },
		[2] = { vec3(-1186.7,-1490.54,4.37), h = 125.0 },
	  },
	},
	[6] = { type = 'public', coords = vec3(-73.44,-2004.99,18.27), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(-84.96,-2004.22,18.01), h = 352.0 },
	  },
	},
	[7] = { type = 'public', coords = vec3(214.02,-808.44,31.01), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(222.11,-804.16,29.83), h = 247.0 },
		[2] = { vec3(224.14,-799.27,29.83), h = 247.0 },
	  },
	},
	[8] = { type = 'public', coords = vec3(-348.88,-874.02,31.31), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(-343.73,-875.45,30.22), h = 168.42 },
		[2] = { vec3(-340.11,-877.03,30.22), h = 168.42 },
		[3] = { vec3(-336.49,-877.69,30.22), h = 168.42 },
	  },
	},
	[9] = { type = 'public', coords = vec3(67.74,12.27,69.21), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(64.17,17.22,68.37), h = 339.38 },
		[2] = { vec3(61.17,18.4,68.42), h = 339.38 },
	  },
	},
	[10] = { type = 'public', coords = vec3(361.9,297.81,103.88), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(361.08,293.5,102.65), h = 249.67 },
		[2] = { vec3(360.02,289.8,102.64), h = 249.67 },
		[3] = { vec3(358.35,286.42,102.62), h = 249.67 },
	  },
	},
	[11] = { type = 'public', coords = vec3(-773.34,5598.15,33.6), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(-772.82,5578.48,32.64), h = 89.01 },
		[2] = { vec3(-773.07,5575.31,32.64), h = 89.01 },
	  },
	},
	[12] = { type = 'public', coords = vec3(323.5,-203.07,54.08), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(318.07,-203.28,53.24), h = 249.14 },
		[2] = { vec3(316.71,-206.49,53.24), h = 249.14 },
		[3] = { vec3(315.57,-209.74,53.24), h = 249.14 },
	  },
	},
	[13] = { type = 'public', coords = vec3(317.25,2623.14,44.46), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(334.52,2623.09,44.49), h = 20.0 },
	  },
	},
	[14] = { type = 'public', coords = vec3(1156.9,-453.73,66.98), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(1155.2,-461.58,65.97), h = 167.96 },
		[2] = { vec3(1151.76,-460.61,65.96), h = 167.96 },
	  },
	},
	[15] = { type = 'public', coords = vec3(-102.21,6345.18,31.57), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(-98.29,6341.76,30.64), h = 224.27 },
		[2] = { vec3(-95.52,6344.59,30.64), h = 224.27 },
		[3] = { vec3(-92.98,6347.16,30.64), h = 224.27 },
		[4] = { vec3(-85.39,6338.94,30.64), h = 44.8 },
	  },
	},
	[16] = { type = 'service', coords = vec3(459.22,-1007.98,28.25), perm = 'policia.permissao',
	  vehiclePositions = {
		[1] = { vec3(446.24,-1024.77,27.77), h = 2.75 },
		[2] = { vec3(442.46,-1025.19,27.84), h = 2.75 },
		[3] = { vec3(438.52,-1025.73,27.92), h = 2.75 },
	  },
	  vehicles = {
		{ vehicle = '20EXPLO', modelo = '20EXPLO' },
		{ vehicle = 'mercedespolicia', modelo = 'mercedespolicia' },
		{ vehicle = '1200RT', modelo = '1200RT' },
		-- { vehicle = 'k9fpiu', modelo = 'k9fpiu' },
		-- { vehicle = '15chgr', modelo = '15chgr' },
		-- { vehicle = 'umcvpi', modelo = 'umcvpi' },
		-- { vehicle = 'umfpiu', modelo = 'umfpiu' },
		-- { vehicle = 'policiabmwr1200', modelo = 'policiabmwr1200' },  
	  }
	},
	[17] = { type = 'service', coords = vec3(1851.23,3683.34,34.26), perm = 'policia.permissao',
	  vehiclePositions = {
		[1] = { vec3(1854.16,3675.55,32.89), h = 211.29 },
		[2] = { vec3(1850.73,3673.58,32.91), h = 211.29 },
	  },
	  vehicles = {
		{ vehicle = '20EXPLO', modelo = '20EXPLO' },
		{ vehicle = 'mercedespolicia', modelo = 'mercedespolicia' },
		{ vehicle = '1200RT', modelo = '1200RT' },
		-- { vehicle = 'k9fpiu', modelo = 'k9fpiu' },
		-- { vehicle = '15chgr', modelo = '15chgr' },
		-- { vehicle = 'umcvpi', modelo = 'umcvpi' },
		-- { vehicle = 'umfpiu', modelo = 'umfpiu' },
		-- { vehicle = 'policiabmwr1200', modelo = 'policiabmwr1200' },  
	 }
	},
	[18] = { type = 'service', coords = vec3(-452.07,6005.75,31.84), perm = 'policia.permissao',
	  vehiclePositions = {
		[1] = { vec3(-456.17,6001.9,30.49), h = 88.15 },
		[2] = { vec3(-452.35,5998.32,30.49), h = 88.15 },
	  },
	  vehicles = {
			{ vehicle = '20EXPLO', modelo = '20EXPLO' },
			{ vehicle = 'mercedespolicia', modelo = 'mercedespolicia' },
			{ vehicle = '1200RT', modelo = '1200RT' },
			-- { vehicle = 'k9fpiu', modelo = 'k9fpiu' },
			-- { vehicle = '15chgr', modelo = '15chgr' },
			-- { vehicle = 'umcvpi', modelo = 'umcvpi' },
			-- { vehicle = 'umfpiu', modelo = 'umfpiu' },
			-- { vehicle = 'policiabmwr1200', modelo = 'policiabmwr1200' },  
	 }
	},
	[19] = { type = 'service', coords = vec3(619.81,17.09,87.81), perm = 'policia.permissao',
	  vehiclePositions = {
		[1] = { vec3(627.78,23.87,87.27), h = 251.16 },
		[2] = { vec3(621.65,26.01,87.9), h = 251.16 },
	  },
	  vehicles = {
		{ vehicle = '20EXPLO', modelo = '20EXPLO' },
		{ vehicle = 'mercedespolicia', modelo = 'mercedespolicia' },
		{ vehicle = '1200RT', modelo = '1200RT' },
		-- { vehicle = 'k9fpiu', modelo = 'k9fpiu' },
		-- { vehicle = '15chgr', modelo = '15chgr' },
		-- { vehicle = 'umcvpi', modelo = 'umcvpi' },
		-- { vehicle = 'umfpiu', modelo = 'umfpiu' },
		-- { vehicle = 'policiabmwr1200', modelo = 'policiabmwr1200' },  
	  }
	},
	[20] = { type = 'service', coords = vec3(473.06,-1019.21,28.1), perm = 'policia.permissao',
	  vehiclePositions = {
		[1] = { vec3(477.87,-1021.89,28.02), h = 272.65 },
	  },
	  vehicles = {
		{ vehicle = 'pbus', modelo = 'pbus' },  
	  }
	},
	[21] = { type = 'service', coords = vec3(463.24,-982.53,43.69), perm = 'policia.permissao',
	  vehiclePositions = {
		[1] = { vec3(449.34,-981.14,43.69), h = 91.28 },
	  },
	  vehicles = {
		{ vehicle = 'policiaheli', modelo = 'policiaheli' },  
	  }
	},
	[22] = { type = 'service', coords = vec3(-941.0,-2954.12,13.94), perm = 'policia.permissao',
	  vehiclePositions = {
		[1] = { vec3(-960.31,-2964.36,14.88), h = 114.27 },
	  },
	  vehicles = {
		{ vehicle = 'velum2', modelo = 'velum2' },  
	  }
	},
	[23] = { type = 'service', coords = vec3(295.12,-600.61,43.3), perm = 'paramedico.permissao',
	  vehiclePositions = {
		[1] = { vec3(295.03,-607.22,43.36), h = 70.0 },
		[2] = { vec3(292.22,-610.2,43.36), h = 70.0 },
	  },
	  vehicles = {
		{ vehicle = 'paramedicoambu', modelo = 'paramedicoambu' },
		{ vehicle = 'paramedicocharger2014', modelo = 'paramedicocharger2014' },  
	  }
	},
	[24] = { type = 'service', coords = vec3(1815.96,3678.71,34.27), perm = 'paramedico.permissao',
	  vehiclePositions = {
		[1] = { vec3(1805.27,3680.97,34.22), h = 120.0 },
	  },
	  vehicles = {
		{ vehicle = 'paramedicoambu', modelo = 'paramedicoambu' },
		{ vehicle = 'paramedicocharger2014', modelo = 'paramedicocharger2014' },  
	  }
	},
	[25] = { type = 'service', coords = vec3(-248.14,6332.97,32.42), perm = 'paramedico.permissao',
	  vehiclePositions = {
		[1] = { vec3(-259.22,6344.43,32.42), h = 90.0 },
	  },
	  vehicles = {
		{ vehicle = 'paramedicoambu', modelo = 'paramedicoambu' },
		{ vehicle = 'paramedicocharger2014', modelo = 'paramedicocharger2014' },  
	  }
	},
	[26] = { type = 'service', coords = vec3(339.93,-581.07,74.16), perm = 'paramedico.permissao',
	  vehiclePositions = {
		[1] = { vec3(351.66,-588.13,74.16), h = 247.48 },
	  },
	  vehicles = {
		{ vehicle = 'paramedicoheli', modelo = 'paramedicoheli' },
		{ vehicle = 'seasparrow', modelo = 'seasparrow' },  
	  }
	},
	[27] = { type = 'service', coords = vec3(888.97,-1028.11,35.12), perm = 'mecanico.permissao',
	  vehiclePositions = {
		[1] = { vec3(893.31,-1023.89,35.06), h = 270.14 },
		[2] = { vec3(903.01,-1028.97,35.06), h = 359.74 },
	  },
	  vehicles = {
		{ vehicle = 'flatbed', modelo = 'flatbed' },
		{ vehicle = 'flatbed3', modelo = 'flatbed3' },
		{ vehicle = 'towtruck', modelo = 'towtruck' },
		{ vehicle = 'towtruck2', modelo = 'towtruck2' },  
	  }
	},
	[28] = { type = 'service', coords = vec3(-368.77,-101.94,39.54), perm = 'mecanico.permissao',
	  vehiclePositions = {
		[1] = { vec3(-381.28,-106.44,38.78), h = 160.8 },
	  },
	  vehicles = {
		{ vehicle = 'flatbed', modelo = 'flatbed' },
		{ vehicle = 'flatbed3', modelo = 'flatbed3' },
		{ vehicle = 'towtruck', modelo = 'towtruck' },
		{ vehicle = 'towtruck2', modelo = 'towtruck2' },  
	  }
	},
	[29] = { type = 'service', coords = vec3(895.36,-179.28,74.7), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(900.05,-180.84,73.02), h = 237.93 },
		[2] = { vec3(898.1,-183.93,72.94), h = 237.93 },
	  },
	  vehicles = {
		{ vehicle = 'taxi', modelo = 'taxi' },  
	  }
	},
	[30] = { type = 'service', coords = vec3(453.89,-600.57,28.58), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(462.51,-605.27,29.32), h = 214.04 },
		[2] = { vec3(461.44,-611.34,29.33), h = 214.04 },
	  },
	  vehicles = {
		{ vehicle = 'coach', modelo = 'coach' },
		{ vehicle = 'bus', modelo = 'bus' },  
	  }
	},
	[31] = { type = 'service', coords = vec3(-416.85,-2797.39,6.0), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(-410.6,-2791.39,5.9), h = 315.52 },
		[2] = { vec3(-405.31,-2796.73,5.89), h = 315.52 },
	  },
	  vehicles = {
		{ vehicle = 'boxville4', modelo = 'boxville4' },
		{ vehicle = 'tribike3', modelo = 'tribike3' },  
	  }
	},
	[32] = { type = 'service', coords = vec3(-341.58,-1567.46,25.22), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(-342.17,-1560.1,25.23), h = 100.0 },
	  },
	  vehicles = {
		{ vehicle = 'trash2', modelo = 'trash2' },  
	  }
	},
	[33] = { type = 'service', coords = vec3(1054.13,-1952.76,32.09), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(1074.33,-1964.17,31.1), h = 55.04 },
		[2] = { vec3(1073.1,-1951.72,31.1), h = 144.83 },
	  },
	  vehicles = {
		{ vehicle = 'tiptruck', modelo = 'tiptruck' },  
	  }
	},
	[34] = { type = 'service', coords = vec3(1200.41,-1276.48,35.22), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(1212.45,-1273.6,34.93), h = 85.64 },
		[2] = { vec3(1212.11,-1278.5,34.93), h = 85.64 },
	  },
	  vehicles = {
		{ vehicle = 'ratloader', modelo = 'ratloader' },  
	  }
	},
	[35] = { type = 'service', coords = vec3(173.1,-26.0,68.34), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(171.91,-35.42,67.97), h = 182.07 },
		[2] = { vec3(166.26,-33.42,67.86), h = 182.07 },
	  },
	  vehicles = {
		{ vehicle = 'youga2', modelo = 'youga2' },  
	  }
	},
	[36] = { type = 'service', coords = vec3(1196.8,-3253.68,7.09), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(1185.2,-3251.4,6.02), h = 91.07 },
	  },
	  vehicles = {
		{ vehicle = 'phantom', modelo = 'phantom' },
		{ vehicle = 'packer', modelo = 'packer' },  
	  }
	},
	[37] = { type = 'service', coords = vec3(472.1,-1078.44,29.36), perm = 'advogado.permissao',
	  vehiclePositions = {
		[1] = { vec3(472.3,-1089.12,28.61), h = 269.43 },
	  },
	  vehicles = {
		{ vehicle = 'felon2', modelo = 'felon2' },  
	  }
	},
	[38] = { type = 'service', coords = vec3(-1605.19,-1164.37,1.28), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(-1619.61,-1175.78,-0.08), h = 130.0 },
	  },
	  vehicles = {
		{ vehicle = 'dinghy', modelo = 'dinghy' },
		{ vehicle = 'jetmax', modelo = 'jetmax' },
		{ vehicle = 'marquis', modelo = 'marquis' },
		{ vehicle = 'seashark3', modelo = 'seashark3' },
		{ vehicle = 'speeder', modelo = 'speeder' },
		{ vehicle = 'speeder2', modelo = 'speeder2' },
		{ vehicle = 'squalo', modelo = 'squalo' },
		{ vehicle = 'suntrap', modelo = 'suntrap' },
		{ vehicle = 'toro', modelo = 'toro' },
		{ vehicle = 'toro2', modelo = 'toro2' },
		{ vehicle = 'tropic', modelo = 'tropic' },
		{ vehicle = 'tropic2', modelo = 'tropic2' },  
	  }
	},
	[39] = { type = 'service', coords = vec3(-1522.68,1494.92,111.58), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(-1526.63,1499.64,109.08), h = 350.0 },
	  },
	  vehicles = {
		{ vehicle = 'dinghy', modelo = 'dinghy' },
		{ vehicle = 'jetmax', modelo = 'jetmax' },
		{ vehicle = 'marquis', modelo = 'marquis' },
		{ vehicle = 'seashark3', modelo = 'seashark3' },
		{ vehicle = 'speeder', modelo = 'speeder' },
		{ vehicle = 'speeder2', modelo = 'speeder2' },
		{ vehicle = 'squalo', modelo = 'squalo' },
		{ vehicle = 'suntrap', modelo = 'suntrap' },
		{ vehicle = 'toro', modelo = 'toro' },
		{ vehicle = 'toro2', modelo = 'toro2' },
		{ vehicle = 'tropic', modelo = 'tropic' },
		{ vehicle = 'tropic2', modelo = 'tropic2' },  
	  }
	},
	[40] = { type = 'service', coords = vec3(1337.36,4269.71,31.5), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(1343.24,4269.59,30.11), h = 190.0 },
	  },
	  vehicles = {
		{ vehicle = 'dinghy', modelo = 'dinghy' },
		{ vehicle = 'jetmax', modelo = 'jetmax' },
		{ vehicle = 'marquis', modelo = 'marquis' },
		{ vehicle = 'seashark3', modelo = 'seashark3' },
		{ vehicle = 'speeder', modelo = 'speeder' },
		{ vehicle = 'speeder2', modelo = 'speeder2' },
		{ vehicle = 'squalo', modelo = 'squalo' },
		{ vehicle = 'suntrap', modelo = 'suntrap' },
		{ vehicle = 'toro', modelo = 'toro' },
		{ vehicle = 'toro2', modelo = 'toro2' },
		{ vehicle = 'tropic', modelo = 'tropic' },
		{ vehicle = 'tropic2', modelo = 'tropic2' },  
	  }
	},
	[41] = { type = 'service', coords = vec3(-192.32,791.54,198.1), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(-195.95,788.35,195.93), h = 230.0 },
	  },
	  vehicles = {
		{ vehicle = 'dinghy', modelo = 'dinghy' },
		{ vehicle = 'jetmax', modelo = 'jetmax' },
		{ vehicle = 'marquis', modelo = 'marquis' },
		{ vehicle = 'seashark3', modelo = 'seashark3' },
		{ vehicle = 'speeder', modelo = 'speeder' },
		{ vehicle = 'speeder2', modelo = 'speeder2' },
		{ vehicle = 'squalo', modelo = 'squalo' },
		{ vehicle = 'suntrap', modelo = 'suntrap' },
		{ vehicle = 'toro', modelo = 'toro' },
		{ vehicle = 'toro2', modelo = 'toro2' },
		{ vehicle = 'tropic', modelo = 'tropic' },
		{ vehicle = 'tropic2', modelo = 'tropic2' },  
	  }
	},
	[42] = { type = 'service', coords = vec3(485.36,-3383.09,6.06), perm = 'serpentes.permissao',
	  vehiclePositions = {
		[1] = { vec3(456.38,-3375.78,0.32), h = 357.84 },
	  },
	  vehicles = {
		{ vehicle = 'seashark3', modelo = 'seashark3' },
		{ vehicle = 'speeder2', modelo = 'speeder2' },  
	  }
	},
	[43] = { type = 'service', coords = vec3(976.49,-129.31,74.09), perm = 'motoclub.permissao',
	  vehiclePositions = {
		[1] = { vec3(973.18,-125.6,74.28), h = 152.04 },
	  },
	  vehicles = {
		{ vehicle = 'daemon', modelo = 'daemon' },
		{ vehicle = 'sanctus', modelo = 'sanctus' },
		{ vehicle = 'gburrito', modelo = 'gburrito' },
		{ vehicle = 'slamvan2', modelo = 'slamvan2' },  
	  }
	},
	[44] = { type = 'service', coords = vec3(1283.53,-1720.98,54.65), perm = 'marabunta.permissao',
	  vehiclePositions = {
		[1] = { vec3(1282.89,-1731.41,52.76), h = 113.06 },
	  },
	  vehicles = {
		{ vehicle = 'primo2', modelo = 'primo2' },
		{ vehicle = 'speedo', modelo = 'speedo' },  
	  }
	},
	[45] = { type = 'public', coords = vec3(-2674.54,1303.44,147.16), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(-2669.33,1304.77,146.61), h = 269.7 },
		[2] = { vec3(-2668.78,1309.79,146.61), h = 269.7 },
	  },
	},
	[46] = { type = 'service', coords = vec3(-962.15,-1488.04,5.0), perm = 'yakuza.permissao',
	  vehiclePositions = {
		[1] = { vec3(-963.92,-1484.67,4.56), h = 110.12 },
		[2] = { vec3(-965.21,-1481.24,4.56), h = 110.12 },
	  },
	  vehicles = {
		{ vehicle = 'superd', modelo = 'superd' },
		{ vehicle = 'speedo', modelo = 'speedo' },  
	  }
	},
	[47] = { type = 'service', coords = vec3(-72.29,-804.2,36.74), perm = 'corleone.permissao',
	  vehiclePositions = {
		[1] = { vec3(-68.47,-807.84,36.0), h = 132.52 },
		[2] = { vec3(-66.34,-810.52,35.89), h = 124.4 },
	  },
	  vehicles = {
		{ vehicle = 'btype', modelo = 'btype' },
		{ vehicle = 'speedo', modelo = 'speedo' },  
	  }
	},
	[48] = { type = 'service', coords = vec3(-21.79,219.16,106.71), perm = 'cosanostra.permissao',
	  vehiclePositions = {
		[1] = { vec3(-26.33,207.8,106.3), h = 342.5 },
		[2] = { vec3(-23.08,206.58,106.3), h = 342.5 },
	  },
	  vehicles = {
		{ vehicle = 'stafford', modelo = 'stafford' },
		{ vehicle = 'speedo', modelo = 'speedo' },  
	  }
	},
	[49] = { type = 'public', coords = vec3(-1163.51,-2021.29,13.19), perm = 'corredores.permissao',
	  vehiclePositions = {
		[1] = { vec3(-1159.86,-2014.29,12.86), h = 358.03 },
		[2] = { vec3(-1155.87,-2010.51,12.86), h = 358.03 },
	  },
	},
	[50] = { type = 'public', coords = vec3(-1195.29,-1740.14,11.8), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(-1206.59,-1743.49,3.85), h = 261.48 },
	  },
	},
	[51] = { type = 'public', coords = vec3(-1186.76,-1705.22,4.45), perm = 'conce.permissao',
	  vehiclePositions = {
		[1] = { vec3(-1192.79,-1709.47,3.85), h = 180.8 },
		[2] = { vec3(-1197.18,-1712.97,3.85), h = 180.8 },
		[3] = { vec3(-1201.01,-1716.02,3.85), h = 180.8 },
		[4] = { vec3(-1205.03,-1718.37,3.85), h = 180.8 },
		[5] = { vec3(-1209.09,-1721.55,3.85), h = 180.8 },
	  },
	},
	[52] = { type = 'public', coords = vec3(-1161.4,-1708.66,11.8), perm = 'conce.permissao',
	  vehiclePositions = {
		[1] = { vec3(-1142.97,-1706.76,11.24), h = 124.8 },
		[2] = { vec3(-1156.94,-1716.64,11.24), h = 305.37 },
		[3] = { vec3(-1162.84,-1711.1,11.24), h = 61.82 },
		[4] = { vec3(-1167.19,-1705.06,11.24), h = 61.82 },
		[5] = { vec3(-1171.69,-1698.8,11.24), h = 61.82 },
	  },
	},
	[53] = { type = 'service', coords = vec3(-1179.94,-1564.77,4.36), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(-1187.28,-1573.2,3.71), h = 305.88 },
		[2] = { vec3(-1188.13,-1571.97,3.71), h = 305.88 },
		[3] = { vec3(-1188.92,-1570.83,3.71), h = 305.88 },
	  },
	  vehicles = {
		{ vehicle = 'scorcher', modelo = 'scorcher' },
		{ vehicle = 'tribike', modelo = 'tribike' },
		{ vehicle = 'tribike2', modelo = 'tribike2' },
		{ vehicle = 'tribike3', modelo = 'tribike3' },
		{ vehicle = 'fixter', modelo = 'fixter' },
		{ vehicle = 'cruiser', modelo = 'cruiser' },
		{ vehicle = 'bmx', modelo = 'bmx' },  
	  }
	},
	[54] = { type = 'service', coords = vec3(448.15,6462.45,28.99), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(448.85,6454.48,29.3), h = 256.35 },
		[2] = { vec3(444.74,6448.56,29.61), h = 272.94 },
	  },
	  vehicles = {
		{ vehicle = 'tractor2', modelo = 'tractor2' },
		{ vehicle = 'rebel', modelo = 'rebel' },  
	  }
	},
	[55] = { type = 'service', coords = vec3(2356.98,3051.84,48.58), perm = 'desmanche.permissao',
	  vehiclePositions = {
		[1] = { vec3(2352.52,3036.32,48.16), h = 359.0 },
	  },
	  vehicles = {
		{ vehicle = 'zion', modelo = 'zion' },  
	  }
	},
	[56] = { type = 'public', coords = vec3(-53.4,-1105.55,26.44), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(-56.36,-1116.71,26.44), h = 0.0 },
		[2] = { vec3(-61.9,-1116.55,26.44), h = 0.0 },
		[3] = { vec3(-53.42,-1117.21,26.44), h = 0.0 },
		[4] = { vec3(-50.7,-1116.72,26.44), h = 0.0 },	
	  },
	},
	[57] = { type = 'service', coords = vec3(-1038.17,-2723.65,13.76), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(-1039.19,-2720.38,13.05), h = 331.24 },
		[2] = { vec3(-1042.45,-2717.81,13.08), h = 331.24 },
	  },
	  vehicles = {
		{ vehicle = 'bmx', modelo = 'bmx' },  
	  }
	},
	[58] = { type = 'public', coords = vec3(338.97,-2035.11,21.51), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(332.38,-2031.56,21.19), h = 140.15 },
	  },
	},
	[59] = { type = 'public', coords = vec3(-33.65,-1515.37,30.6), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(-29.01,-1515.5,30.56), h = 322.67 },
	  },
	},
	[60] = { type = 'public', coords = vec3(-608.55,-1600.88,26.76), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(-610.27,-1594.55,26.76), h = 87.49 },
	  },
	},
	[61] = { type = 'public', coords = vec3(-68.14,-810.86,326.18), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(-76.04,-818.62,326.18), h = 3241.48 },
	  },
	},
	[62] = { type = 'public', coords = vec3(734.49,-2984.12,-38.99), perm = 'admin.permissao',
	  vehiclePositions = {
		[1] = { vec3(729.17,-2988.95,-38.99), h = 175.63 },
	  },
	},
	[63] = { type = 'service', coords = vec3(-1084.36,-1644.75,4.45), perm = 'blood.permissao',
	  vehiclePositions = {
		[1] = { vec3(-1094.13,-1640.19,4.39), h = 58.34 },
	  },
	  vehicles = {
		{ vehicle = 'buccaneer2', modelo = 'buccaneer2' },
		{ vehicle = 'speedo', modelo = 'speedo' },  
	  }
	},
	[64] = { type = 'public', coords = vec3(1399.45,1115.16,114.84), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(1408.08,1118.08,114.84), h = 91.04 },
	  },
	},
	[65] = { type = 'public', coords = vec3(-193.13,-1260.63,31.3), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(-184.65,-1260.22,30.85), h = 91.87 },
	  },
	},
	[66] = { type = 'service', coords = vec3(-193.17,-1293.27,31.3), perm = 'mecanico.permissao',
	  vehiclePositions = {
		[1] = { vec3(-189.76,-1290.94,31.3), h = 273.42 },
	  },
	  vehicles = {
		{ vehicle = 'flatbed', modelo = 'flatbed' },
		{ vehicle = 'flatbed3', modelo = 'flatbed3' },
		{ vehicle = 'towtruck', modelo = 'towtruck' },
		{ vehicle = 'towtruck2', modelo = 'towtruck2' },  
	  }
	},
	[67] = { type = 'public', coords = vec3(101.14,-1073.6,29.38), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(104.33,-1079.07,29.2), h = 340.61 },
		[2] = { vec3(108.11,-1078.86,28.52), h = 340.61 },
	  },
	},
	[68] = { type = 'public', coords = vec3(102.82,-1959.78,20.84), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(104.57,-1954.94,20.95), h = 355.58 },
	  },
	},
	[69] = { type = 'service', coords = vec3(1851.75,2601.19,45.68), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(1854.84,2598.21,45.68), h = 331.24 },
		[2] = { vec3(1855.26,2601.5,45.68), h = 331.24 },
	  },
	  vehicles = {
		{ vehicle = 'bmx', modelo = 'bmx' },  
	  },
	},
	[70] = { type = 'public', coords = vec3(495.71,-1340.02,29.32), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(501.83,-1337.04,29.32), h = 3.55 },
		[2] = { vec3(490.86,-1338.86,29.3), h = 355.62 },
	  },
	},
	[71] = { type = 'public', coords = vec3(1550.91,3526.7,35.63), perm = nil,
	  vehiclePositions = {
		[1] = { vec3(1545.42,3525.24,35.55), h = 31.15 },
		[2] = { vec3(1537.41,3525.69,35.05), h = 292.08 },
	  },
	},
}
  
-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------



-----------------------------------------------------------------
------------------ GARAGENS DAS CASAS ---------------------------
-----------------------------------------------------------------


config.homeGarages = {
	[1] = { type = 'home', coords = vec3(21.41,548.3,176.02),
	  vehiclePositions = {
		[1] = { vec3(14.98,549.89,175.5), h = 60.7 },
	  },
	  home = 'MS01'
	},
	[2] = { type = 'home', coords = vec3(-813.06,184.23,72.47),
	  vehiclePositions = {
		[1] = { vec3(-821.16,185.31,71.25), h = 119.13 },
	  },
	  home = 'MS02'
	},
	[3] = { type = 'home', coords = vec3(-681.48,901.64,230.57),
	  vehiclePositions = {
		[1] = { vec3(-675.44,903.59,229.73), h = 326.35 },
	  },
	  home = 'MS03'
	},
	[4] = { type = 'home', coords = vec3(-2596.87,1927.04,167.31),
	  vehiclePositions = {
		[1] = { vec3(-2588.73,1929.85,166.46), h = 275.01 },
	  },
	  home = 'MS04'
	},
	[5] = { type = 'home', coords = vec3(-3014.84,740.75,27.58),
	  vehiclePositions = {
		[1] = { vec3(-3019.92,740.24,26.63), h = 103.34 },
	  },
	  home = 'MS05'
	},
	[6] = { type = 'home', coords = vec3(-1890.29,-572.99,11.82),
	  vehiclePositions = {
		[1] = { vec3(-1886.63,-571.43,10.93), h = 319.54 },
	  },
	  home = 'MS09'
	},
	[7] = { type = 'home', coords = vec3(1551.96,2190.1,78.85),
	  vehiclePositions = {
		[1] = { vec3(1554.26,2196.07,78.5), h = 352.11 },
	  },
	  home = 'SS01'
	},
	[8] = { type = 'home', coords = vec3(-2977.14,650.92,25.78),
	  vehiclePositions = {
		[1] = { vec3(-2982.74,654.65,25.015), h = 106.83 },
	  },
	  home = 'MS08'
	},
	[9] = { type = 'home', coords = vec3(-864.47,463.46,88.22),
	  vehiclePositions = {
		[1] = { vec3(-861.31,462.66,86.93), h = 276.73 },
	  },
	  home = 'FH01'
	},
	[10] = { type = 'home', coords = vec3(-850.62,522.18,90.62),
	  vehiclePositions = {
		[1] = { vec3(-851.05,514.29,90.15), h = 106.56 },
	  },
	  home = 'FH04'
	},
	[11] = { type = 'home', coords = vec3(-938.56,445.34,80.42),
	  vehiclePositions = {
		[1] = { vec3(-942.71,443.81,79.99), h = 198.88 },
	  },
	  home = 'FH11'
	},
	[12] = { type = 'home', coords = vec3(-1074.27,468.75,77.82),
	  vehiclePositions = {
		[1] = { vec3(-1079.1,465.49,76.79), h = 144.79 },
	  },
	  home = 'FH15'
	},
	[13] = { type = 'home', coords = vec3(-971.31,455.98,79.82),
	  vehiclePositions = {
		[1] = { vec3(-967.03,450.03,78.97), h = 199.58 },
	  },
	  home = 'FH19'
	},
	[14] = { type = 'home', coords = vec3(-736.59,439.85,106.9),
	  vehiclePositions = {
		[1] = { vec3(-736.19,446.59,105.88), h = 3.21 },
	  },
	  home = 'FH23'
	},
	[15] = { type = 'home', coords = vec3(-716.59,500.53,109.27),
	  vehiclePositions = {
		[1] = { vec3(-716.94,495.36,108.43), h = 206.78 },
	  },
	  home = 'FH24'
	},
	[16] = { type = 'home', coords = vec3(-692.91,507.84,110.36),
	  vehiclePositions = {
		[1] = { vec3(-688.85,500.77,109.21), h = 201.51 },
	  },
	  home = 'FH26'
	},
	[17] = { type = 'home', coords = vec3(-574.21,492.54,106.97),
	  vehiclePositions = {
		[1] = { vec3(-573.79,498.15,105.38), h = 9.46 },
	  },
	  home = 'FH29'
	},
	[18] = { type = 'home', coords = vec3(-589.59,531.83,108.17),
	  vehiclePositions = {
		[1] = { vec3(-586.67,526.68,106.72), h = 215.41 },
	  },
	  home = 'FH31'
	},
	[19] = { type = 'home', coords = vec3(-574.01,394.76,100.67),
	  vehiclePositions = {
		[1] = { vec3(-574.73,401.65,99.82), h = 19.61 },
	  },
	  home = 'FH32'
	},
	[20] = { type = 'home', coords = vec3(-447.07,376.54,104.77),
	  vehiclePositions = {
		[1] = { vec3(-456.49,372.48,103.93), h = 358.58 },
	  },
	  home = 'FH45'
	},
	[21] = { type = 'home', coords = vec3(-523.67,525.26,112.44),
	  vehiclePositions = {
		[1] = { vec3(-526.66,530.68,110.95), h = 44.11 },
	  },
	  home = 'FH48'
	},
	[22] = { type = 'home', coords = vec3(-524.63,573.16,121.24),
	  vehiclePositions = {
		[1] = { vec3(-519.47,574.05,120.61), h = 281.57 },
	  },
	  home = 'FH49'
	},
	[23] = { type = 'home', coords = vec3(-470.24,538.11,121.46),
	  vehiclePositions = {
		[1] = { vec3(-468.04,542.62,119.92), h = 355.06 },
	  },
	  home = 'FH52'
	},
	[24] = { type = 'home', coords = vec3(-397.25,512.34,120.19),
	  vehiclePositions = {
		[1] = { vec3(-398.63,518.94,119.68), h = 355.21 },
	  },
	  home = 'FH54'
	},
	[25] = { type = 'home', coords = vec3(-356.43,473.56,112.52),
	  vehiclePositions = {
		[1] = { vec3(-351.33,474.7,111.89), h = 299.59 },
	  },
	  home = 'FH55'
	},
	[26] = { type = 'home', coords = vec3(-357.14,517.38,120.15),
	  vehiclePositions = {
		[1] = { vec3(-362.62,514.72,118.67), h = 134.89 },
	  },
	  home = 'FH58'
	},
	[27] = { type = 'home', coords = vec3(-312.45,483.18,113.46),
	  vehiclePositions = {
		[1] = { vec3(-320.42,480.85,111.44), h = 118.55 },
	  },
	  home = 'FH59'
	},
	[28] = { type = 'home', coords = vec3(-1371.63,451.89,105.34),
	  vehiclePositions = {
		[1] = { vec3(-1376.73,453.26,104.04), h = 80.28 },
	  },
	  home = 'FH68'
	},
	[29] = { type = 'home', coords = vec3(-463.57,676.11,148.54),
	  vehiclePositions = {
		[1] = { vec3(-467.37,673.46,146.8), h = 148.4 },
	  },
	  home = 'FH81'
	},
	[30] = { type = 'home', coords = vec3(-956.88,804.188,177.56),
	  vehiclePositions = {
		[1] = { vec3(-958.62,800.59,176.76), h = 152.94 },
	  },
	  home = 'FH91'
	},
	[31] = { type = 'home', coords = vec3(-921.15,813.8,184.33),
	  vehiclePositions = {
		[1] = { vec3(-920.0,806.38,183.37), h = 189.06 },
	  },
	  home = 'FH92'
	},
	[32] = { type = 'home', coords = vec3(-1004.0,783.99,171.38),
	  vehiclePositions = {
		[1] = { vec3(-997.95,786.76,171.06), h = 293.5 },
	  },
	  home = 'FH93'
	},
	[33] = { type = 'home', coords = vec3(-810.25,803.55,202.18),
	  vehiclePositions = {
		[1] = { vec3(-811.6,809.51,201.24), h = 19.71 },
	  },
	  home = 'FH94'
	},
	[34] = { type = 'home', coords = vec3(-876.54,-57.11,38.05),
	  vehiclePositions = {
		[1] = { vec3(-869.45,-54.25,37.6), h = 281.38 },
	  },
	  home = 'LX01'
	},
	[35] = { type = 'home', coords = vec3(-890.55,-17.35,43.1),
	  vehiclePositions = {
		[1] = { vec3(-885.98,-16.18,42.15), h = 304.12 },
	  },
	  home = 'LX02'
	},
	[36] = { type = 'home', coords = vec3(-872.28,51.35,48.78),
	  vehiclePositions = {
		[1] = { vec3(-875.02,46.86,48.39), h = 195.46 },
	  },
	  home = 'LX03'
	},
	[37] = { type = 'home', coords = vec3(-969.08,107.74,55.66),
	  vehiclePositions = {
		[1] = { vec3(-960.77,109.36,55.49), h = 314.26 },
	  },
	  home = 'LX04'
	},
	[38] = { type = 'home', coords = vec3(-1885.63,629.92,129.99),
	  vehiclePositions = {
		[1] = { vec3(-1890.51,626.0,129.15), h = 136.16 },
	  },
	  home = 'LX05'
	},
	[39] = { type = 'home', coords = vec3(-997.43,142.37,60.66),
	  vehiclePositions = {
		[1] = { vec3(-992.02,144.19,59.81), h = 269.99 },
	  },
	  home = 'LX06'
	},
	[40] = { type = 'home', coords = vec3(-1045.16,224.98,63.76),
	  vehiclePositions = {
		[1] = { vec3(-1048.01,219.47,62.91), h = 184.73 },
	  },
	  home = 'LX07'
	},
	[41] = { type = 'home', coords = vec3(-923.9,212.7,67.46),
	  vehiclePositions = {
		[1] = { vec3(-933.57,210.69,66.61), h = 163.52 },
	  },
	  home = 'LX08'
	},
	[42] = { type = 'home', coords = vec3(-905.04,196.27,69.5),
	  vehiclePositions = {
		[1] = { vec3(-911.78,190.68,68.59), h = 179.92 },
	  },
	  home = 'LX09'
	},
	[43] = { type = 'home', coords = vec3(-915.48,114.68,55.31),
	  vehiclePositions = {
		[1] = { vec3(-920.41,112.49,54.47), h = 84.9 },
	  },
	  home = 'LX10'
	},
	[44] = { type = 'home', coords = vec3(-931.72,13.37,47.91),
	  vehiclePositions = {
		[1] = { vec3(-925.27,9.31,46.87), h = 214.83 },
	  },
	  home = 'LX11'
	},
	[45] = { type = 'home', coords = vec3(-835.07,119.47,55.46),
	  vehiclePositions = {
		[1] = { vec3(-839.12,112.3,54.43), h = 210.36 },
	  },
	  home = 'LX12'
	},
	[46] = { type = 'home', coords = vec3(-1058.75,299.58,66.0),
	  vehiclePositions = {
		[1] = { vec3(-1061.49,305.25,65.13), h = 353.81 },
	  },
	  home = 'LX13'
	},
	[47] = { type = 'home', coords = vec3(-827.87,267.95,86.2),
	  vehiclePositions = {
		[1] = { vec3(-824.72,273.44,85.68), h = 342.78 },
	  },
	  home = 'LX14'
	},
	[48] = { type = 'home', coords = vec3(-869.56,322.71,83.97),
	  vehiclePositions = {
		[1] = { vec3(-870.29,317.83,83.13), h = 186.23 },
	  },
	  home = 'LX15'
	},
	[49] = { type = 'home', coords = vec3(-887.96,360.73,85.04),
	  vehiclePositions = {
		[1] = { vec3(-888.36,367.35,84.55), h = 3.4 },
	  },
	  home = 'LX16'
	},
	[50] = { type = 'home', coords = vec3(-1026.73,363.75,71.36),
	  vehiclePositions = {
		[1] = { vec3(-1011.08,360.01,70.05), h = 331.43 },
	  },
	  home = 'LX17'
	},
	[51] = { type = 'home', coords = vec3(-1555.85,426.75,109.62),
	  vehiclePositions = {
		[1] = { vec3(-1547.98,426.58,109.09), h = 272.82 },
	  },
	  home = 'LX18'
	},
	[52] = { type = 'home', coords = vec3(-1211.88,274.79,69.51),
	  vehiclePositions = {
		[1] = { vec3(-1204.83,267.12,68.69), h = 284.35 },
	  },
	  home = 'LX19'
	},
	[53] = { type = 'home', coords = vec3(-1101.71,354.46,68.48),
	  vehiclePositions = {
		[1] = { vec3(-1096.63,360.3,67.69), h = 357.45 },
	  },
	  home = 'LX20'
	},
	[54] = { type = 'home', coords = vec3(-1490.24,18.76,54.71),
	  vehiclePositions = {
		[1] = { vec3(-1490.16,23.07,53.88), h = 354.88 },
	  },
	  home = 'LX21'
	},
	[55] = { type = 'home', coords = vec3(-1457.65,-50.22,54.65),
	  vehiclePositions = {
		[1] = { vec3(-1455.68,-55.37,52.6), h = 240.6 },
	  },
	  home = 'LX22'
	},
	[56] = { type = 'home', coords = vec3(-1504.43,19.84,56.4),
	  vehiclePositions = {
		[1] = { vec3(-1503.75,26.86,55.15), h = 8.38 },
	  },
	  home = 'LX23'
	},
	[57] = { type = 'home', coords = vec3(-1581.46,-81.3,54.2),
	  vehiclePositions = {
		[1] = { vec3(-1577.19,-86.02,53.29), h = 270.66 },
	  },
	  home = 'LX24'
	},
	[58] = { type = 'home', coords = vec3(-1585.69,-55.63,56.48),
	  vehiclePositions = {
		[1] = { vec3(-1582.02,-61.06,55.64), h = 270.18 },
	  },
	  home = 'LX25'
	},
	[59] = { type = 'home', coords = vec3(-1558.52,17.86,58.83),
	  vehiclePositions = {
		[1] = { vec3(-1552.69,22.78,57.7), h = 347.5 },
	  },
	  home = 'LX26'
	},
	[60] = { type = 'home', coords = vec3(-1616.73,14.71,62.17),
	  vehiclePositions = {
		[1] = { vec3(-1613.07,20.02,61.32), h = 335.94 },
	  },
	  home = 'LX27'
	},
	[61] = { type = 'home', coords = vec3(-1892.99,120.59,81.64),
	  vehiclePositions = {
		[1] = { vec3(-1887.23,123.26,80.86), h = 338.84 },
	  },
	  home = 'LX28'
	},
	[62] = { type = 'home', coords = vec3(-1940.13,179.1,84.66),
	  vehiclePositions = {
		[1] = { vec3(-1932.93,182.84,83.68), h = 307.83 },
	  },
	  home = 'LX29'
	},
	[63] = { type = 'home', coords = vec3(-2000.65,296.59,91.76),
	  vehiclePositions = {
		[1] = { vec3(-1994.21,290.29,90.85), h = 221.21 },
	  },
	  home = 'LX32'
	},
	[64] = { type = 'home', coords = vec3(-2013.18,453.64,102.67),
	  vehiclePositions = {
		[1] = { vec3(-2006.95,454.86,101.79), h = 276.63 },
	  },
	  home = 'LX34'
	},
	[65] = { type = 'home', coords = vec3(-2016.62,485.7,107.18),
	  vehiclePositions = {
		[1] = { vec3(-2011.39,482.71,106.07), h = 255.38 },
	  },
	  home = 'LX35'
	},
	[66] = { type = 'home', coords = vec3(-1868.36,192.09,84.29),
	  vehiclePositions = {
		[1] = { vec3(-1874.17,194.45,83.77), h = 126.46 },
	  },
	  home = 'LX36'
	},
	[67] = { type = 'home', coords = vec3(-1899.62,241.7,86.26),
	  vehiclePositions = {
		[1] = { vec3(-1904.45,242.14,85.6), h = 27.89 },
	  },
	  home = 'LX37'
	},
	[68] = { type = 'home', coords = vec3(-1918.91,285.25,89.07),
	  vehiclePositions = {
		[1] = { vec3(-1925.28,283.01,88.23), h = 182.84 },
	  },
	  home = 'LX38'
	},
	[69] = { type = 'home', coords = vec3(-1935.69,366.09,93.82),
	  vehiclePositions = {
		[1] = { vec3(-1940.58,360.31,92.55), h = 160.68 },
	  },
	  home = 'LX39'
	},
	[70] = { type = 'home', coords = vec3(-1938.82,386.17,96.5),
	  vehiclePositions = {
		[1] = { vec3(-1943.95,385.19,95.6), h = 96.89 },
	  },
	  home = 'LX40'
	},
	[71] = { type = 'home', coords = vec3(-1937.4,462.55,102.42),
	  vehiclePositions = {
		[1] = { vec3(-1947.37,462.9,101.12), h = 99.05 },
	  },
	  home = 'LX41'
	},
	[72] = { type = 'home', coords = vec3(-1856.34,322.6,88.72),
	  vehiclePositions = {
		[1] = { vec3(-1857.45,328.42,87.8), h = 11.41 },
	  },
	  home = 'LX42'
	},
	[73] = { type = 'home', coords = vec3(-1789.94,345.73,88.55),
	  vehiclePositions = {
		[1] = { vec3(-1790.72,353.87,87.72), h = 64.22 },
	  },
	  home = 'LX43'
	},
	[74] = { type = 'home', coords = vec3(-1745.31,368.33,89.72),
	  vehiclePositions = {
		[1] = { vec3(-1750.77,365.56,88.85), h = 114.91 },
	  },
	  home = 'LX44'
	},
	[75] = { type = 'home', coords = vec3(-1665.21,385.25,89.49),
	  vehiclePositions = {
		[1] = { vec3(-1663.42,391.43,88.39), h = 9.57 },
	  },
	  home = 'LX45'
	},
	[76] = { type = 'home', coords = vec3(-1785.52,456.14,128.3),
	  vehiclePositions = {
		[1] = { vec3(-1794.11,459.4,127.46), h = 98.09 },
	  },
	  home = 'LX46'
	},
	[77] = { type = 'home', coords = vec3(-1991.66,605.61,117.9),
	  vehiclePositions = {
		[1] = { vec3(-1985.63,602.72,117.28), h = 238.48 },
	  },
	  home = 'LX47'
	},
	[78] = { type = 'home', coords = vec3(-1937.7,529.39,110.73),
	  vehiclePositions = {
		[1] = { vec3(-1944.07,521.99,108.31), h = 71.0 },
	  },
	  home = 'LX48'
	},
	[79] = { type = 'home', coords = vec3(-1977.58,624.88,122.53),
	  vehiclePositions = {
		[1] = { vec3(-1971.35,620.69,121.14), h = 246.1 },
	  },
	  home = 'LX50'
	},
	[80] = { type = 'home', coords = vec3(-165.4,919.61,235.65),
	  vehiclePositions = {
		[1] = { vec3(-162.36,926.68,234.8), h = 234.16 },
	  },
	  home = 'LX51'
	},
	[81] = { type = 'home', coords = vec3(-172.67,966.12,237.53),
	  vehiclePositions = {
		[1] = { vec3(-167.03,970.73,235.79), h = 316.56 },
	  },
	  home = 'LX52'
	},
	[82] = { type = 'home', coords = vec3(-124.76,1010.75,235.73),
	  vehiclePositions = {
		[1] = { vec3(-127.89,1001.16,234.88), h = 198.68 },
	  },
	  home = 'LX53'
	},
	[83] = { type = 'home', coords = vec3(-101.17,823.95,235.72),
	  vehiclePositions = {
		[1] = { vec3(-105.63,832.61,234.86), h = 10.25 },
	  },
	  home = 'LX54'
	},
	[84] = { type = 'home', coords = vec3(220.71,755.29,204.85),
	  vehiclePositions = {
		[1] = { vec3(215.84,759.38,203.83), h = 47.56 },
	  },
	  home = 'LX55'
	},
	[85] = { type = 'home', coords = vec3(100.21,563.99,182.94),
	  vehiclePositions = {
		[1] = { vec3(93.13,575.77,182.13), h = 86.85 },
	  },
	  home = 'LX58'
	},
	[86] = { type = 'home', coords = vec3(52.84,559.77,180.21),
	  vehiclePositions = {
		[1] = { vec3(53.19,563.71,179.54), h = 21.7 },
	  },
	  home = 'LX59'
	},
	[87] = { type = 'home', coords = vec3(-143.65,593.14,203.9),
	  vehiclePositions = {
		[1] = { vec3(-142.21,597.23,203.12), h = 358.34 },
	  },
	  home = 'LX60'
	},
	[88] = { type = 'home', coords = vec3(-196.6,621.58,197.91),
	  vehiclePositions = {
		[1] = { vec3(-199.24,615.31,196.21), h = 178.98 },
	  },
	  home = 'LX61'
	},
	[89] = { type = 'home', coords = vec3(-174.92,590.04,197.63),
	  vehiclePositions = {
		[1] = { vec3(-178.23,587.21,197.03), h = 359.63 },
	  },
	  home = 'LX62'
	},
	[90] = { type = 'home', coords = vec3(-224.87,588.93,190.02),
	  vehiclePositions = {
		[1] = { vec3(-221.77,593.25,189.61), h = 331.22 },
	  },
	  home = 'LX63'
	},
	[91] = { type = 'home', coords = vec3(-271.65,599.1,181.68),
	  vehiclePositions = {
		[1] = { vec3(-272.26,603.6,181.15), h = 346.6 },
	  },
	  home = 'LX64'
	},
	[92] = { type = 'home', coords = vec3(-241.91,614.9,187.77),
	  vehiclePositions = {
		[1] = { vec3(-244.12,610.79,186.09), h = 149.22 },
	  },
	  home = 'LX65'
	},
	[93] = { type = 'home', coords = vec3(-338.28,630.36,172.35),
	  vehiclePositions = {
		[1] = { vec3(-343.97,634.83,171.43), h = 52.04 },
	  },
	  home = 'LX66'
	},
	[94] = { type = 'home', coords = vec3(312.7,566.57,154.53),
	  vehiclePositions = {
		[1] = { vec3(316.29,568.06,153.55), h = 220.69 },
	  },
	  home = 'LX67'
	},
	[95] = { type = 'home', coords = vec3(315.32,493.62,153.14),
	  vehiclePositions = {
		[1] = { vec3(321.07,494.12,151.61), h = 283.1 },
	  },
	  home = 'LX68'
	},
	[96] = { type = 'home', coords = vec3(326.54,481.25,151.26),
	  vehiclePositions = {
		[1] = { vec3(330.37,482.12,149.86), h = 195.82 },
	  },
	  home = 'LX69'
	},
	[97] = { type = 'home', coords = vec3(238.09,526.58,140.58),
	  vehiclePositions = {
		[1] = { vec3(236.21,536.62,139.88), h = 114.71 },
	  },
	  home = 'LX70'
	},
	[98] = { type = 'home', coords = vec3(1290.05,-585.69,71.75),
	  vehiclePositions = {
		[1] = { vec3(1295.49,-567.62,71.49), h = 344.65 },
	  },
	  home = 'LS01'
	},
	[99] = { type = 'home', coords = vec3(1311.03,-593.07,72.93),
	  vehiclePositions = {
		[1] = { vec3(1319.19,-575.18,73.25), h = 336.97 },
	  },
	  home = 'LS02'
	},
	[100] = { type = 'home', coords = vec3(1344.65,-609.86,74.36),
	  vehiclePositions = {
		[1] = { vec3(1348.97,-603.76,74.64), h = 334.73 },
	  },
	  home = 'LS03'
	},
	[101] = { type = 'home', coords = vec3(1359.91,-620.48,74.34),
	  vehiclePositions = {
		[1] = { vec3(1360.55,-601.83,74.62), h = 359.42 },
	  },
	  home = 'LS04'
	},
	[102] = { type = 'home', coords = vec3(1392.87,-607.72,74.35),
	  vehiclePositions = {
		[1] = { vec3(1378.33,-596.21,74.61), h = 52.88 },
	  },
	  home = 'LS05'
	},
	[103] = { type = 'home', coords = vec3(1404.84,-570.68,74.35),
	  vehiclePositions = {
		[1] = { vec3(1387.73,-577.37,74.62), h = 113.2 },
	  },
	  home = 'LS06'
	},
	[104] = { type = 'home', coords = vec3(1366.95,-544.46,74.34),
	  vehiclePositions = {
		[1] = { vec3(1363.05,-551.94,74.62), h = 157.25 },
	  },
	  home = 'LS07'
	},
	[105] = { type = 'home', coords = vec3(1360.66,-536.8,73.78),
	  vehiclePositions = {
		[1] = { vec3(1352.89,-553.3,74.31), h = 156.76 },
	  },
	  home = 'LS08'
	},
	[106] = { type = 'home', coords = vec3(1322.0,-524.9,72.13),
	  vehiclePositions = {
		[1] = { vec3(1318.24,-532.96,72.35), h = 160.86 },
	  },
	  home = 'LS09'
	},
	[107] = { type = 'home', coords = vec3(1314.79,-516.59,71.41),
	  vehiclePositions = {
		[1] = { vec3(1307.96,-533.58,71.56), h = 160.38 },
	  },
	  home = 'LS10'
	},
	[108] = { type = 'home', coords = vec3(1245.08,-518.7,69.0),
	  vehiclePositions = {
		[1] = { vec3(1247.17,-522.7,69.25), h = 257.36 },
	  },
	  home = 'LS11'
	},
	[109] = { type = 'home', coords = vec3(1251.25,-490.29,69.5),
	  vehiclePositions = {
		[1] = { vec3(1260.63,-494.22,69.59), h = 255.66 },
	  },
	  home = 'LS12'
	},
	[110] = { type = 'home', coords = vec3(1259.55,-477.81,70.19),
	  vehiclePositions = {
		[1] = { vec3(1280.06,-472.81,69.24), h = 170.02 },
	  },
	  home = 'LS13'
	},
	[111] = { type = 'home', coords = vec3(1268.56,-461.81,69.84),
	  vehiclePositions = {
		[1] = { vec3(1270.98,-463.9,69.87), h = 328.18 },
	  },
	  home = 'LS14'
	},
	[112] = { type = 'home', coords = vec3(1261.12,-426.7,69.81),
	  vehiclePositions = {
		[1] = { vec3(1261.45,-419.35,69.58), h = 297.04 },
	  },
	  home = 'LS15'
	},
	[113] = { type = 'home', coords = vec3(1234.75,-578.25,69.49),
	  vehiclePositions = {
		[1] = { vec3(1243.86,-579.36,69.64), h = 271.53 },
	  },
	  home = 'LS16'
	},
	[114] = { type = 'home', coords = vec3(1236.79,-589.55,69.79),
	  vehiclePositions = {
		[1] = { vec3(1242.92,-586.85,69.55), h = 269.57 },
	  },
	  home = 'LS17'
	},
	[115] = { type = 'home', coords = vec3(1250.47,-626.17,69.35),
	  vehiclePositions = {
		[1] = { vec3(1259.06,-624.91,69.58), h = 296.96 },
	  },
	  home = 'LS18'
	},
	[116] = { type = 'home', coords = vec3(1257.67,-660.38,67.93),
	  vehiclePositions = {
		[1] = { vec3(1271.84,-659.12,68.0), h = 293.69 },
	  },
	  home = 'LS19'
	},
	[117] = { type = 'home', coords = vec3(1267.25,-673.65,65.75),
	  vehiclePositions = {
		[1] = { vec3(1276.75,-673.42,66.25), h = 277.48 },
	  },
	  home = 'LS20'
	},
	[118] = { type = 'home', coords = vec3(1259.79,-711.08,64.72),
	  vehiclePositions = {
		[1] = { vec3(1263.72,-716.66,64.75), h = 239.07 },
	  },
	  home = 'LS21'
	},
	[119] = { type = 'home', coords = vec3(1225.19,-723.04,60.64),
	  vehiclePositions = {
		[1] = { vec3(1223.46,-730.21,60.4), h = 163.48 },
	  },
	  home = 'LS22'
	},
	[120] = { type = 'home', coords = vec3(1228.5,-703.47,60.68),
	  vehiclePositions = {
		[1] = { vec3(1217.85,-704.09,60.7), h = 97.24 },
	  },
	  home = 'LS23'
	},
	[121] = { type = 'home', coords = vec3(1220.91,-664.18,63.13),
	  vehiclePositions = {
		[1] = { vec3(1214.36,-665.12,62.85), h = 103.07 },
	  },
	  home = 'LS24'
	},
	[122] = { type = 'home', coords = vec3(1206.75,-614.0,66.12),
	  vehiclePositions = {
		[1] = { vec3(1199.98,-612.47,65.36), h = 94.4 },
	  },
	  home = 'LS25'
	},
	[123] = { type = 'home', coords = vec3(1192.48,-597.08,64.01),
	  vehiclePositions = {
		[1] = { vec3(1188.28,-595.06,64.23), h = 34.45 },
	  },
	  home = 'LS26'
	},
	[124] = { type = 'home', coords = vec3(1189.79,-573.78,64.32),
	  vehiclePositions = {
		[1] = { vec3(1185.82,-569.96,64.56), h = 25.68 },
	  },
	  home = 'LS27'
	},
	[125] = { type = 'home', coords = vec3(1191.61,-554.97,64.71),
	  vehiclePositions = {
		[1] = { vec3(1187.47,-550.38,64.83), h = 86.85 },
	  },
	  home = 'LS28'
	},
	[126] = { type = 'home', coords = vec3(1089.59,-495.42,65.07),
	  vehiclePositions = {
		[1] = { vec3(1084.78,-493.34,64.4), h = 79.01 },
	  },
	  home = 'LS29'
	},
	[127] = { type = 'home', coords = vec3(1101.7,-468.42,67.06),
	  vehiclePositions = {
		[1] = { vec3(1091.28,-470.87,65.47), h = 77.7 },
	  },
	  home = 'LS30'
	},
	[128] = { type = 'home', coords = vec3(1111.03,-417.0,67.16),
	  vehiclePositions = {
		[1] = { vec3(1111.15,-419.57,67.43), h = 83.31 },
	  },
	  home = 'LS31'
	},
	[129] = { type = 'home', coords = vec3(1112.77,-394.29,68.74),
	  vehiclePositions = {
		[1] = { vec3(1106.07,-399.24,68.2), h = 78.01 },
	  },
	  home = 'LS32'
	},
	[130] = { type = 'home', coords = vec3(1057.42,-384.09,67.86),
	  vehiclePositions = {
		[1] = { vec3(1056.9,-388.45,68.09), h = 221.13 },
	  },
	  home = 'LS33'
	},
	[131] = { type = 'home', coords = vec3(1021.13,-414.33,65.95),
	  vehiclePositions = {
		[1] = { vec3(1022.37,-419.52,66.05), h = 219.15 },
	  },
	  home = 'LS34'
	},
	[132] = { type = 'home', coords = vec3(1009.82,-418.88,64.96),
	  vehiclePositions = {
		[1] = { vec3(1015.92,-423.87,65.32), h = 217.1 },
	  },
	  home = 'LS35'
	},
	[133] = { type = 'home', coords = vec3(987.71,-438.07,63.75),
	  vehiclePositions = {
		[1] = { vec3(995.76,-435.43,64.23), h = 271.01 },
	  },
	  home = 'LS36'
	},
	[134] = { type = 'home', coords = vec3(971.53,-447.94,62.41),
	  vehiclePositions = {
		[1] = { vec3(975.54,-454.41,62.86), h = 213.74 },
	  },
	  home = 'LS37'
	},
	[135] = { type = 'home', coords = vec3(939.3,-463.22,61.26),
	  vehiclePositions = {
		[1] = { vec3(942.05,-469.79,61.53), h = 212.33 },
	  },
	  home = 'LS38'
	},
	[136] = { type = 'home', coords = vec3(928.77,-475.65,60.7),
	  vehiclePositions = {
		[1] = { vec3(933.31,-480.49,60.88), h = 203.27 },
	  },
	  home = 'LS39'
	},
	[137] = { type = 'home', coords = vec3(909.42,-489.73,59.02),
	  vehiclePositions = {
		[1] = { vec3(914.46,-490.17,59.29), h = 204.27 },
	  },
	  home = 'LS40'
	},
	[138] = { type = 'home', coords = vec3(873.98,-503.77,57.5),
	  vehiclePositions = {
		[1] = { vec3(874.77,-507.45,57.72), h = 226.29 },
	  },
	  home = 'LS41'
	},
	[139] = { type = 'home', coords = vec3(854.95,-516.17,57.33),
	  vehiclePositions = {
		[1] = { vec3(858.81,-522.39,57.59), h = 227.66 },
	  },
	  home = 'LS42'
	},
	[140] = { type = 'home', coords = vec3(848.57,-540.12,57.33),
	  vehiclePositions = {
		[1] = { vec3(853.51,-542.76,57.6), h = 266.06 },
	  },
	  home = 'LS43'
	},
	[141] = { type = 'home', coords = vec3(842.1,-567.41,57.71),
	  vehiclePositions = {
		[1] = { vec3(849.29,-567.47,57.99), h = 279.71 },
	  },
	  home = 'LS44'
	},
	[142] = { type = 'home', coords = vec3(868.47,-594.02,58.3),
	  vehiclePositions = {
		[1] = { vec3(872.86,-590.11,58.28), h = 317.23 },
	  },
	  home = 'LS45'
	},
	[143] = { type = 'home', coords = vec3(875.58,-602.34,58.45),
	  vehiclePositions = {
		[1] = { vec3(875.55,-598.36,58.45), h = 316.61 },
	  },
	  home = 'LS46'
	},
	[144] = { type = 'home', coords = vec3(912.15,-631.81,58.05),
	  vehiclePositions = {
		[1] = { vec3(917.67,-627.46,58.32), h = 319.36 },
	  },
	  home = 'LS47'
	},
	[145] = { type = 'home', coords = vec3(913.03,-645.12,57.87),
	  vehiclePositions = {
		[1] = { vec3(917.96,-639.77,58.14), h = 318.18 },
	  },
	  home = 'LS48'
	},
	[146] = { type = 'home', coords = vec3(946.14,-657.5,58.02),
	  vehiclePositions = {
		[1] = { vec3(951.67,-654.13,58.16), h = 309.34 },
	  },
	  home = 'LS49'
	},
	[147] = { type = 'home', coords = vec3(940.18,-672.19,58.02),
	  vehiclePositions = {
		[1] = { vec3(946.99,-669.22,58.29), h = 297.96 },
	  },
	  home = 'LS50'
	},
	[148] = { type = 'home', coords = vec3(969.7,-688.32,57.95),
	  vehiclePositions = {
		[1] = { vec3(973.59,-685.58,57.91), h = 309.99 },
	  },
	  home = 'LS51'
	},
	[149] = { type = 'home', coords = vec3(976.24,-713.97,57.87),
	  vehiclePositions = {
		[1] = { vec3(982.5,-709.42,57.88), h = 312.02 },
	  },
	  home = 'LS52'
	},
	[150] = { type = 'home', coords = vec3(1004.32,-734.1,57.46),
	  vehiclePositions = {
		[1] = { vec3(1008.02,-731.13,57.88), h = 311.05 },
	  },
	  home = 'LS53'
	},
	[151] = { type = 'home', coords = vec3(981.21,-614.8,58.84),
	  vehiclePositions = {
		[1] = { vec3(973.52,-619.61,59.1), h = 128.1 },
	  },
	  home = 'LS54'
	},
	[152] = { type = 'home', coords = vec3(959.79,-601.7,59.5),
	  vehiclePositions = {
		[1] = { vec3(955.45,-598.08,59.65), h = 27.96 },
	  },
	  home = 'LS55'
	},
	[153] = { type = 'home', coords = vec3(984.25,-579.14,59.28),
	  vehiclePositions = {
		[1] = { vec3(982.93,-572.6,59.53), h = 31.32 },
	  },
	  home = 'LS56'
	},
	[154] = { type = 'home', coords = vec3(1008.54,-565.15,60.2),
	  vehiclePositions = {
		[1] = { vec3(1012.51,-563.56,60.44), h = 263.72 },
	  },
	  home = 'LS57'
	},
	[155] = { type = 'home', coords = vec3(943.81,-243.89,68.63),
	  vehiclePositions = {
		[1] = { vec3(939.22,-250.12,68.69), h = 150.37 },
	  },
	  home = 'LS58'
	},
	[156] = { type = 'home', coords = vec3(1003.79,-588.12,59.14),
	  vehiclePositions = {
		[1] = { vec3(1009.07,-590.25,59.2), h = 258.95 },
	  },
	  home = 'LS59'
	},
	[157] = { type = 'home', coords = vec3(922.71,-564.06,57.97),
	  vehiclePositions = {
		[1] = { vec3(926.46,-567.39,58.24), h = 206.14 },
	  },
	  home = 'LS60'
	},
	[158] = { type = 'home', coords = vec3(956.87,-546.73,59.53),
	  vehiclePositions = {
		[1] = { vec3(957.91,-552.49,59.55), h = 211.12 },
	  },
	  home = 'LS61'
	},
	[159] = { type = 'home', coords = vec3(981.96,-530.0,60.12),
	  vehiclePositions = {
		[1] = { vec3(983.27,-536.41,60.19), h = 211.11 },
	  },
	  home = 'LS62'
	},
	[160] = { type = 'home', coords = vec3(1001.36,-510.47,60.7),
	  vehiclePositions = {
		[1] = { vec3(1003.89,-518.48,60.98), h = 205.24 },
	  },
	  home = 'LS63'
	},
	[161] = { type = 'home', coords = vec3(1045.95,-495.92,64.08),
	  vehiclePositions = {
		[1] = { vec3(1049.91,-488.79,64.19), h = 257.03 },
	  },
	  home = 'LS64'
	},
	[162] = { type = 'home', coords = vec3(1049.12,-479.89,64.1),
	  vehiclePositions = {
		[1] = { vec3(1056.64,-483.32,64.11), h = 257.85 },
	  },
	  home = 'LS65'
	},
	[163] = { type = 'home', coords = vec3(1055.36,-445.56,65.97),
	  vehiclePositions = {
		[1] = { vec3(1062.56,-445.67,66.16), h = 257.58 },
	  },
	  home = 'LS66'
	},
	[164] = { type = 'home', coords = vec3(1020.06,-464.4,63.9),
	  vehiclePositions = {
		[1] = { vec3(1019.04,-459.29,64.37), h = 38.05 },
	  },
	  home = 'LS67'
	},
	[165] = { type = 'home', coords = vec3(966.19,-505.37,61.74),
	  vehiclePositions = {
		[1] = { vec3(960.86,-500.52,61.65), h = 29.8 },
	  },
	  home = 'LS68'
	},
	[166] = { type = 'home', coords = vec3(950.42,-516.97,60.25),
	  vehiclePositions = {
		[1] = { vec3(948.5,-511.66,60.5), h = 29.22 },
	  },
	  home = 'LS69'
	},
	[167] = { type = 'home', coords = vec3(921.11,-527.47,59.58),
	  vehiclePositions = {
		[1] = { vec3(915.83,-522.63,59.03), h = 25.35 },
	  },
	  home = 'LS70'
	},
	[168] = { type = 'home', coords = vec3(893.88,-547.44,58.17),
	  vehiclePositions = {
		[1] = { vec3(888.36,-551.92,58.24), h = 115.0 },
	  },
	  home = 'LS71'
	},
	[169] = { type = 'home', coords = vec3(1103.28,-429.62,67.4),
	  vehiclePositions = {
		[1] = { vec3(1097.86,-428.24,66.68), h = 80.97 },
	  },
	  home = 'LS72'
	},
	[170] = { type = 'home', coords = vec3(72.16,-1935.47,20.99),
	  vehiclePositions = {
		[1] = { vec3(81.72,-1932.41,21.02), h = 316.63 },
	  },
	  home = 'KR02'
	},
	[171] = { type = 'home', coords = vec3(14.13,-1886.93,23.24),
	  vehiclePositions = {
		[1] = { vec3(18.48,-1880.11,23.28), h = 320.5 },
	  },
	  home = 'KR03'
	},
	[172] = { type = 'home', coords = vec3(98.75,-1907.55,21.07),
	  vehiclePositions = {
		[1] = { vec3(89.81,-1917.18,20.98), h = 140.59 },
	  },
	  home = 'KR04'
	},
	[173] = { type = 'home', coords = vec3(101.95,-1883.62,24.02),
	  vehiclePositions = {
		[1] = { vec3(105.76,-1879.36,24.22), h = 319.71 },
	  },
	  home = 'KR05'
	},
	[174] = { type = 'home', coords = vec3(157.6,-1901.16,23.0),
	  vehiclePositions = {
		[1] = { vec3(162.82,-1899.28,23.26), h = 334.81 },
	  },
	  home = 'KR06'
	},
	[175] = { type = 'home', coords = vec3(163.9,-1954.67,19.32),
	  vehiclePositions = {
		[1] = { vec3(165.73,-1959.08,19.43), h = 227.78 },
	  },
	  home = 'KR07'
	},
	[176] = { type = 'home', coords = vec3(152.53,-1960.61,19.08),
	  vehiclePositions = {
		[1] = { vec3(152.79,-1965.88,19.04), h = 228.5 },
	  },
	  home = 'KR08'
	},
	[177] = { type = 'home', coords = vec3(58.69,-1878.41,22.39),
	  vehiclePositions = {
		[1] = { vec3(52.14,-1878.42,22.53), h = 136.83 },
	  },
	  home = 'KR09'
	},
	[178] = { type = 'home', coords = vec3(45.4,-1849.13,22.84),
	  vehiclePositions = {
		[1] = { vec3(41.44,-1853.34,23.11), h = 135.2 },
	  },
	  home = 'KR10'
	},
	[179] = { type = 'home', coords = vec3(-45.22,-1791.79,27.45),
	  vehiclePositions = {
		[1] = { vec3(-53.0,-1801.42,27.36), h = 50.04 },
	  },
	  home = 'KR11'
	},
	[180] = { type = 'home', coords = vec3(-54.09,-1781.86,27.88),
	  vehiclePositions = {
		[1] = { vec3(-57.67,-1785.85,28.12), h = 136.73 },
	  },
	  home = 'KR12'
	},
	[181] = { type = 'home', coords = vec3(140.35,-1866.11,24.32),
	  vehiclePositions = {
		[1] = { vec3(136.94,-1869.3,24.4), h = 155.02 },
	  },
	  home = 'KR13'
	},
	[182] = { type = 'home', coords = vec3(189.37,-1872.27,24.73),
	  vehiclePositions = {
		[1] = { vec3(186.58,-1877.13,24.85), h = 154.49 },
	  },
	  home = 'KR14'
	},
	[183] = { type = 'home', coords = vec3(248.21,-1732.71,29.38),
	  vehiclePositions = {
		[1] = { vec3(244.51,-1728.83,29.5), h = 49.0 },
	  },
	  home = 'KR15'
	},
	[184] = { type = 'home', coords = vec3(272.34,-1704.01,29.31),
	  vehiclePositions = {
		[1] = { vec3(268.09,-1700.73,29.57), h = 49.31 },
	  },
	  home = 'KR16'
	},
	[185] = { type = 'home', coords = vec3(291.46,-1783.92,28.26),
	  vehiclePositions = {
		[1] = { vec3(297.45,-1791.53,28.19), h = 228.58 },
	  },
	  home = 'KR17'
	},
	[186] = { type = 'home', coords = vec3(319.33,-1769.51,29.08),
	  vehiclePositions = {
		[1] = { vec3(321.52,-1773.31,28.93), h = 229.23 },
	  },
	  home = 'KR18'
	},
	[187] = { type = 'home', coords = vec3(142.93,-1832.74,27.07),
	  vehiclePositions = {
		[1] = { vec3(138.97,-1830.69,27.29), h = 49.32 },
	  },
	  home = 'KR19'
	},
	[188] = { type = 'home', coords = vec3(83.64,-1973.9,20.93),
	  vehiclePositions = {
		[1] = { vec3(87.72,-1968.8,21.03), h = 319.25 },
	  },
	  home = 'KR20'
	},
	[189] = { type = 'home', coords = vec3(80.39,-1949.55,20.8),
	  vehiclePositions = {
		[1] = { vec3(89.19,-1934.65,20.91), h = 217.76 },
	  },
	  home = 'KR21'
	},
	[190] = { type = 'home', coords = vec3(54.53,-1921.05,21.66),
	  vehiclePositions = {
		[1] = { vec3(62.29,-1910.55,21.78), h = 230.76 },
	  },
	  home = 'KR22'
	},
	[191] = { type = 'home', coords = vec3(37.3,-1926.34,21.8),
	  vehiclePositions = {
		[1] = { vec3(42.47,-1920.65,21.94), h = 320.78 },
	  },
	  home = 'KR23'
	},
	[192] = { type = 'home', coords = vec3(-10.49,-1883.78,24.15),
	  vehiclePositions = {
		[1] = { vec3(0.4,-1878.23,23.07), h = 319.84 },
	  },
	  home = 'KR24'
	},
	[193] = { type = 'home', coords = vec3(7.46,-1884.39,23.32),
	  vehiclePositions = {
		[1] = { vec3(15.62,-1871.47,23.56), h = 228.24 },
	  },
	  home = 'KR25'
	},
	[194] = { type = 'home', coords = vec3(-23.09,-1857.7,25.04),
	  vehiclePositions = {
		[1] = { vec3(-22.28,-1852.32,25.35), h = 318.16 },
	  },
	  home = 'KR26'
	},
	[195] = { type = 'home', coords = vec3(-33.91,-1855.64,26.01),
	  vehiclePositions = {
		[1] = { vec3(-36.14,-1861.29,26.03), h = 318.25 },
	  },
	  home = 'KR27'
	},
	[196] = { type = 'home', coords = vec3(123.49,-1927.1,21.01),
	  vehiclePositions = {
		[1] = { vec3(118.66,-1940.02,20.95), h = 86.06 },
	  },
	  home = 'KR28'
	},
	[197] = { type = 'home', coords = vec3(116.48,-1918.75,20.94),
	  vehiclePositions = {
		[1] = { vec3(109.49,-1924.84,21.03), h = 159.44 },
	  },
	  home = 'KR29'
	},
	[198] = { type = 'home', coords = vec3(112.4,-1884.8,23.59),
	  vehiclePositions = {
		[1] = { vec3(125.42,-1877.96,23.98), h = 245.04 },
	  },
	  home = 'KR30'
	},
	[199] = { type = 'home', coords = vec3(163.74,-1922.7,21.2),
	  vehiclePositions = {
		[1] = { vec3(166.25,-1929.66,21.29), h = 230.07 },
	  },
	  home = 'KR31'
	},
	[200] = { type = 'home', coords = vec3(142.93,-1970.81,18.86),
	  vehiclePositions = {
		[1] = { vec3(153.95,-1978.59,18.55), h = 139.63 },
	  },
	  home = 'KR32'
	},
	[201] = { type = 'home', coords = vec3(28.49,-1852.1,23.68),
	  vehiclePositions = {
		[1] = { vec3(20.42,-1863.32,23.63), h = 50.07 },
	  },
	  home = 'KR33'
	},
	[202] = { type = 'home', coords = vec3(11.84,-1843.19,24.53),
	  vehiclePositions = {
		[1] = { vec3(8.43,-1845.9,24.64), h = 139.44 },
	  },
	  home = 'KR34'
	},
	[203] = { type = 'home', coords = vec3(167.84,-1854.07,24.29),
	  vehiclePositions = {
		[1] = { vec3(165.62,-1861.16,24.41), h = 155.81 },
	  },
	  home = 'KR35'
	},
	[204] = { type = 'home', coords = vec3(206.99,-1892.89,24.43),
	  vehiclePositions = {
		[1] = { vec3(198.9,-1897.55,24.5), h = 142.92 },
	  },
	  home = 'KR36'
	},
	[205] = { type = 'home', coords = vec3(302.56,-1777.35,29.1),
	  vehiclePositions = {
		[1] = { vec3(312.42,-1785.76,28.42), h = 229.27 },
	  },
	  home = 'KR37'
	},
	[206] = { type = 'home', coords = vec3(289.96,-1789.91,27.7),
	  vehiclePositions = {
		[1] = { vec3(297.45,-1791.53,28.19), h = 228.58 },
	  },
	  home = 'KR38'
	},
	[207] = { type = 'home', coords = vec3(311.04,-1735.44,29.54),
	  vehiclePositions = {
		[1] = { vec3(315.43,-1739.08,29.73), h = 231.04 },
	  },
	  home = 'KR39'
	},
	[208] = { type = 'home', coords = vec3(269.11,-1728.64,29.65),
	  vehiclePositions = {
		[1] = { vec3(264.26,-1718.68,29.56), h = 49.25 },
	  },
	  home = 'KR40'
	},
	[209] = { type = 'home', coords = vec3(269.79,-1710.52,29.34),
	  vehiclePositions = {
		[1] = { vec3(257.55,-1701.71,29.31), h = 320.02 },
	  },
	  home = 'KR41'
	},
	[210] = { type = 'home', coords = vec3(248.94,-1936.94,24.35),
	  vehiclePositions = {
		[1] = { vec3(240.16,-1927.99,24.39), h = 319.7 },
	  },
	  home = 'LV01'
	},
	[211] = { type = 'home', coords = vec3(269.8,-1932.86,25.44),
	  vehiclePositions = {
		[1] = { vec3(263.07,-1921.28,25.41), h = 54.74 },
	  },
	  home = 'LV02'
	},
	[212] = { type = 'home', coords = vec3(270.61,-1914.8,25.81),
	  vehiclePositions = {
		[1] = { vec3(270.12,-1905.53,26.78), h = 51.02 },
	  },
	  home = 'LV03'
	},
	[213] = { type = 'home', coords = vec3(279.17,-1899.45,26.89),
	  vehiclePositions = {
		[1] = { vec3(269.73,-1892.82,26.83), h = 319.63 },
	  },
	  home = 'LV04'
	},
	[214] = { type = 'home', coords = vec3(318.07,-1856.29,27.11),
	  vehiclePositions = {
		[1] = { vec3(305.2,-1850.27,27.0), h = 320.21 },
	  },
	  home = 'LV05'
	},
	[215] = { type = 'home', coords = vec3(340.81,-1849.98,27.77),
	  vehiclePositions = {
		[1] = { vec3(335.81,-1835.98,27.61), h = 44.87 },
	  },
	  home = 'LV06'
	},
	[216] = { type = 'home', coords = vec3(344.21,-1828.31,27.95),
	  vehiclePositions = {
		[1] = { vec3(333.16,-1817.23,27.99), h = 320.18 },
	  },
	  home = 'LV07'
	},
	[217] = { type = 'home', coords = vec3(350.15,-1811.51,28.8),
	  vehiclePositions = {
		[1] = { vec3(342.37,-1806.23,28.48), h = 319.97 },
	  },
	  home = 'LV08'
	},
	[218] = { type = 'home', coords = vec3(404.54,-1753.91,29.37),
	  vehiclePositions = {
		[1] = { vec3(403.61,-1739.39,29.54), h = 46.7 },
	  },
	  home = 'LV09'
	},
	[219] = { type = 'home', coords = vec3(430.66,-1741.22,29.61),
	  vehiclePositions = {
		[1] = { vec3(431.33,-1735.54,28.65), h = 50.2 },
	  },
	  home = 'LV10'
	},
	[220] = { type = 'home', coords = vec3(434.96,-1715.43,29.33),
	  vehiclePositions = {
		[1] = { vec3(430.06,-1715.87,28.69), h = 49.34 },
	  },
	  home = 'LV11'
	},
	[221] = { type = 'home', coords = vec3(442.86,-1698.41,29.38),
	  vehiclePositions = {
		[1] = { vec3(442.78,-1693.12,28.66), h = 51.33 },
	  },
	  home = 'LV12'
	},
	[222] = { type = 'home', coords = vec3(498.38,-1698.89,29.41),
	  vehiclePositions = {
		[1] = { vec3(498.01,-1702.77,29.64), h = 236.28 },
	  },
	  home = 'LV13'
	},
	[223] = { type = 'home', coords = vec3(479.02,-1718.03,29.37),
	  vehiclePositions = {
		[1] = { vec3(490.02,-1721.93,29.62), h = 251.19 },
	  },
	  home = 'LV14'
	},
	[224] = { type = 'home', coords = vec3(464.62,-1740.78,29.11),
	  vehiclePositions = {
		[1] = { vec3(473.8,-1744.08,29.21), h = 250.4 },
	  },
	  home = 'LV15'
	},
	[225] = { type = 'home', coords = vec3(475.52,-1755.13,28.76),
	  vehiclePositions = {
		[1] = { vec3(488.5,-1757.75,28.71), h = 163.16 },
	  },
	  home = 'LV16'
	},
	[226] = { type = 'home', coords = vec3(475.02,-1772.84,28.7),
	  vehiclePositions = {
		[1] = { vec3(478.21,-1779.06,28.93), h = 270.19 },
	  },
	  home = 'LV17'
	},
	[227] = { type = 'home', coords = vec3(511.46,-1778.19,28.51),
	  vehiclePositions = {
		[1] = { vec3(499.79,-1777.14,28.64), h = 201.67 },
	  },
	  home = 'LV18'
	},
	[228] = { type = 'home', coords = vec3(504.82,-1799.04,28.49),
	  vehiclePositions = {
		[1] = { vec3(500.19,-1792.86,28.65), h = 161.09 },
	  },
	  home = 'LV19'
	},
	[229] = { type = 'home', coords = vec3(504.77,-1808.65,28.51),
	  vehiclePositions = {
		[1] = { vec3(491.87,-1805.02,28.65), h = 138.92 },
	  },
	  home = 'LV20'
	},
	[230] = { type = 'home', coords = vec3(487.7,-1826.73,28.53),
	  vehiclePositions = {
		[1] = { vec3(479.28,-1819.72,28.1), h = 139.7 },
	  },
	  home = 'LV21'
	},
	[231] = { type = 'home', coords = vec3(431.96,-1828.9,28.18),
	  vehiclePositions = {
		[1] = { vec3(437.06,-1837.91,28.21), h = 223.26 },
	  },
	  home = 'LV22'
	},
	[232] = { type = 'home', coords = vec3(428.72,-1839.65,28.08),
	  vehiclePositions = {
		[1] = { vec3(434.57,-1841.14,28.23), h = 222.18 },
	  },
	  home = 'LV23'
	},
	[233] = { type = 'home', coords = vec3(401.5,-1849.32,27.32),
	  vehiclePositions = {
		[1] = { vec3(401.08,-1855.1,27.06), h = 223.65 },
	  },
	  home = 'LV24'
	},
	[234] = { type = 'home', coords = vec3(396.69,-1872.65,26.25),
	  vehiclePositions = {
		[1] = { vec3(397.28,-1877.44,26.35), h = 222.91 },
	  },
	  home = 'LV25'
	},
	[235] = { type = 'home', coords = vec3(385.03,-1890.77,25.32),
	  vehiclePositions = {
		[1] = { vec3(384.63,-1896.36,25.21), h = 222.83 },
	  },
	  home = 'LV26'
	},
	[236] = { type = 'home', coords = vec3(360.06,-1894.9,24.99),
	  vehiclePositions = {
		[1] = { vec3(357.8,-1896.77,25.08), h = 227.0 },
	  },
	  home = 'LV27'
	},
	[237] = { type = 'home', coords = vec3(315.73,-1937.5,24.82),
	  vehiclePositions = {
		[1] = { vec3(315.5,-1942.05,24.92), h = 230.52 },
	  },
	  home = 'LV28'
	},
	[238] = { type = 'home', coords = vec3(310.66,-1965.91,23.74),
	  vehiclePositions = {
		[1] = { vec3(316.82,-1970.62,23.69), h = 138.57 },
	  },
	  home = 'LV29'
	},
	[239] = { type = 'home', coords = vec3(299.42,-1971.96,22.49),
	  vehiclePositions = {
		[1] = { vec3(306.82,-1982.39,22.39), h = 139.63 },
	  },
	  home = 'LV30'
	},
	[240] = { type = 'home', coords = vec3(282.89,-1980.29,21.4),
	  vehiclePositions = {
		[1] = { vec3(285.64,-1985.85,21.41), h = 229.16 },
	  },
	  home = 'LV31'
	},
	[241] = { type = 'home', coords = vec3(280.83,-1991.24,20.46),
	  vehiclePositions = {
		[1] = { vec3(286.37,-1992.54,20.81), h = 228.61 },
	  },
	  home = 'LV32'
	},
	[242] = { type = 'home', coords = vec3(256.42,-2026.71,18.86),
	  vehiclePositions = {
		[1] = { vec3(267.58,-2029.38,18.82), h = 142.23 },
	  },
	  home = 'LV33'
	},
	[243] = { type = 'home', coords = vec3(240.68,-2021.42,18.71),
	  vehiclePositions = {
		[1] = { vec3(246.74,-2035.94,18.53), h = 228.9 },
	  },
	  home = 'LV34'
	},
	[244] = { type = 'home', coords = vec3(241.9,-2042.78,18.02),
	  vehiclePositions = {
		[1] = { vec3(245.74,-2053.88,18.1), h = 134.18 },
	  },
	  home = 'LV35'
	},
	[245] = { type = 'home', coords = vec3(-442.95,6202.62,29.56),
	  vehiclePositions = {
		[1] = { vec3(-435.4,6206.42,29.57), h = 278.13 },
	  },
	  home = 'PB01'
	},
	[246] = { type = 'home', coords = vec3(-375.5,6187.37,31.54),
	  vehiclePositions = {
		[1] = { vec3(-379.5,6184.85,31.4), h = 223.82 },
	  },
	  home = 'PB02'
	},
	[247] = { type = 'home', coords = vec3(-361.91,6204.76,31.58),
	  vehiclePositions = {
		[1] = { vec3(-367.92,6200.05,31.4), h = 224.98 },
	  },
	  home = 'PB03'
	},
	[248] = { type = 'home', coords = vec3(-359.1,6227.29,31.5),
	  vehiclePositions = {
		[1] = { vec3(-349.5,6217.17,31.4), h = 223.88 },
	  },
	  home = 'PB04'
	},
	[249] = { type = 'home', coords = vec3(-381.48,6254.9,31.49),
	  vehiclePositions = {
		[1] = { vec3(-388.73,6273.42,30.02), h = 50.83 },
	  },
	  home = 'PB05'
	},
	[250] = { type = 'home', coords = vec3(-360.84,6265.04,31.53),
	  vehiclePositions = {
		[1] = { vec3(-352.17,6265.07,31.32), h = 46.14 },
	  },
	  home = 'PB06'
	},
	[251] = { type = 'home', coords = vec3(-436.46,6264.1,30.09),
	  vehiclePositions = {
		[1] = { vec3(-429.99,6260.87,30.31), h = 258.67 },
	  },
	  home = 'PB07'
	},
	[252] = { type = 'home', coords = vec3(-402.95,6317.15,28.95),
	  vehiclePositions = {
		[1] = { vec3(-396.68,6311.99,28.84), h = 220.7 },
	  },
	  home = 'PB08'
	},
	[253] = { type = 'home', coords = vec3(-364.3,6337.74,29.85),
	  vehiclePositions = {
		[1] = { vec3(-360.16,6328.54,29.75), h = 220.61 },
	  },
	  home = 'PB09'
	},
	[254] = { type = 'home', coords = vec3(-311.14,6310.94,32.48),
	  vehiclePositions = {
		[1] = { vec3(-318.17,6317.76,31.77), h = 45.39 },
	  },
	  home = 'PB10'
	},
	[255] = { type = 'home', coords = vec3(-291.83,6335.9,32.49),
	  vehiclePositions = {
		[1] = { vec3(-296.49,6340.57,31.82), h = 46.26 },
	  },
	  home = 'PB11'
	},
	[256] = { type = 'home', coords = vec3(-272.11,6353.73,32.49),
	  vehiclePositions = {
		[1] = { vec3(-267.41,6355.22,32.4), h = 47.15 },
	  },
	  home = 'PB12'
	},
	[257] = { type = 'home', coords = vec3(-250.27,6355.12,31.5),
	  vehiclePositions = {
		[1] = { vec3(-255.08,6360.48,31.39), h = 45.08 },
	  },
	  home = 'PB13'
	},
	[258] = { type = 'home', coords = vec3(-271.22,6408.91,31.12),
	  vehiclePositions = {
		[1] = { vec3(-265.26,6406.49,30.88), h = 210.49 },
	  },
	  home = 'PB14'
	},
	[259] = { type = 'home', coords = vec3(-217.34,6374.6,31.68),
	  vehiclePositions = {
		[1] = { vec3(-219.54,6383.16,31.52), h = 45.87 },
	  },
	  home = 'PB15'
	},
	[260] = { type = 'home', coords = vec3(-238.3,6423.56,31.46),
	  vehiclePositions = {
		[1] = { vec3(-233.04,6420.27,31.16), h = 220.84 },
	  },
	  home = 'PB16'
	},
	[261] = { type = 'home', coords = vec3(-201.42,6396.75,31.87),
	  vehiclePositions = {
		[1] = { vec3(-201.53,6401.82,31.77), h = 46.62 },
	  },
	  home = 'PB17'
	},
	[262] = { type = 'home', coords = vec3(-229.57,6445.5,31.2),
	  vehiclePositions = {
		[1] = { vec3(-224.33,6435.29,31.11), h = 22964 },
	  },
	  home = 'PB18'
	},
	[263] = { type = 'home', coords = vec3(-187.33,6412.01,31.92),
	  vehiclePositions = {
		[1] = { vec3(-187.43,6418.12,31.78), h = 44.99 },
	  },
	  home = 'PB19'
	},
	[264] = { type = 'home', coords = vec3(-122.88,6561.7,29.53),
	  vehiclePositions = {
		[1] = { vec3(-115.59,6567.64,29.43), h = 224.24 },
	  },
	  home = 'PB20'
	},
	[265] = { type = 'home', coords = vec3(-101.69,6531.68,29.81),
	  vehiclePositions = {
		[1] = { vec3(-106.48,6536.09,29.72), h = 45.2 },
	  },
	  home = 'PB21'
	},
	[266] = { type = 'home', coords = vec3(-37.32,6578.82,32.35),
	  vehiclePositions = {
		[1] = { vec3(-40.97,6593.44,30.34), h = 37.22 },
	  },
	  home = 'PB22'
	},
	[267] = { type = 'home', coords = vec3(-15.06,6566.75,31.91),
	  vehiclePositions = {
		[1] = { vec3(-8.44,6561.16,31.88), h = 224.22 },
	  },
	  home = 'PB23'
	},
	[268] = { type = 'home', coords = vec3(11.48,6578.36,33.08),
	  vehiclePositions = {
		[1] = { vec3(15.78,6583.02,32.35), h = 223.198 },
	  },
	  home = 'PB24'
	},
	[269] = { type = 'home', coords = vec3(-17.04,6598.51,31.48),
	  vehiclePositions = {
		[1] = { vec3(-8.5,6598.24,31.38), h = 39.88 },
	  },
	  home = 'PB25'
	},
	[270] = { type = 'home', coords = vec3(-43.93,6634.26,30.23),
	  vehiclePositions = {
		[1] = { vec3(-52.4,6623.94,29.87), h = 221 },
	  },
	  home = 'PB26'
	},
	[271] = { type = 'home', coords = vec3(-14.79,6650.52,31.15),
	  vehiclePositions = {
		[1] = { vec3(-15.82,6645.42,31.03), h = 208.0 },
	  },
	  home = 'PB27'
	},
	[272] = { type = 'home', coords = vec3(2.37,6618.26,31.47),
	  vehiclePositions = {
		[1] = { vec3(-5.0,6618.68,31.34), h = 60.09 },
	  },
	  home = 'PB28'
	},
	[273] = { type = 'home', coords = vec3(25.06,6601.97,32.48),
	  vehiclePositions = {
		[1] = { vec3(36.23,6606.74,32.38), h = 267.62 },
	  },
	  home = 'PB29'
	},
	[274] = { type = 'home', coords = vec3(24.79,6659.22,31.65),
	  vehiclePositions = {
		[1] = { vec3(21.16,6661.48,31.44), h = 182.65 },
	  },
	  home = 'PB30'
	},
	[275] = { type = 'home', coords = vec3(81.27,6644.04,31.93),
	  vehiclePositions = {
		[1] = { vec3(72.41,6635.25,31.75), h = 142.72 },
	  },
	  home = 'PB31'
	},
}
-----------------------------------------------------------------
-----------------------------------------------------------------



--------------------------------------------------------------------------------
-- função para checar se o player é dono da casa para poder acessar à garagem --
--------------------------------------------------------------------------------
config.hasHome = function(source,user_id,home)
	local address = vRP.query("homes/get_homeuserid",{ user_id = user_id })
	if address and #address > 0 then
		for i in ipairs(address) do 
			if address[i].home == home then
				return true
			end
		end
	end
	TriggerClientEvent("Notify",source,"negado","Você não tem acesso à essa residência.",3000)
	return false
end
  