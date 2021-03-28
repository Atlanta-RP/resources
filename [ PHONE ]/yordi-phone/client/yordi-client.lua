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
Tunnel.bindInterface("gcphone",cnVRP)
vSERVER = Tunnel.getInterface("gcphone")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local KeyToucheCloseEvent = {
	{ code = 172, event = "ArrowUp" },
	{ code = 173, event = "ArrowDown" },
	{ code = 174, event = "ArrowLeft" },
	{ code = 175, event = "ArrowRight" },
	{ code = 176, event = "Enter" },
	{ code = 177, event = "Backspace" }
}

local menuIsOpen = false
local contacts = {}
local messages = {}
local myPhoneNumber = ""
local useMouse = true
local ignoreFocus = false
local lastFrameIsOpen = false
local TokoVoipID = nil
local inCall = false
local phoneActive = false
local firstmessage = false


RegisterCommand("keybindphone",function(source,args)
	local ped = PlayerPedId()
	if not IsEntityInWater(ped) and vSERVER.checkPhone() then
		vRP.stopActived()
		
		if menuIsOpen then
			PhonePlayOut()
			menuIsOpen = false
			SendNUIMessage({ show = false })
			TriggerEvent("status:celular",false)
		else
			PhonePlayIn()
			menuIsOpen = true
			SendNUIMessage({ show = true })
			TriggerEvent("status:celular",true)
		end
	end
end)
RegisterKeyMapping("keybindphone","Abrir Celular","keyboard","k")

Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		if menuIsOpen then
			timeDistance = 4
			for _,value in ipairs(KeyToucheCloseEvent) do
				if IsControlJustPressed(1,value.code) then
					SendNUIMessage({ keyUp = value.event })
				end
			end
			local nuiFocus = useMouse and not ignoreFocus
			SetNuiFocus(nuiFocus,nuiFocus)
			lastFrameIsOpen = true
		else
			if lastFrameIsOpen then
				SetNuiFocus(false,false)
				lastFrameIsOpen = false
			end
		end

		Citizen.Wait(timeDistance)
	end
end)

RegisterNetEvent("gcPhone:handcuff")
AddEventHandler("gcPhone:handcuff",function()
	PhonePlayOut()
	vRP.stopActived()
	menuIsOpen = false
	SendNUIMessage({ show = false })
	TriggerEvent("status:celular",false)
end)

RegisterNetEvent("gcPhone:activePhone")
AddEventHandler("gcPhone:activePhone",function()
	if phoneActive then
		phoneActive = false
		TriggerEvent("phonenotify:sendMessage","Desativado o modo avião.")
	else
		phoneActive = true
		TriggerEvent("phonenotify:sendMessage","Ativado o modo avião.")
	end
end)

RegisterNetEvent("gcPhone:myPhoneNumber")
AddEventHandler("gcPhone:myPhoneNumber",function(_myPhoneNumber)
	myPhoneNumber = _myPhoneNumber
	SendNUIMessage({ event = "updateMyPhoneNumber", myPhoneNumber = myPhoneNumber })
end)

RegisterNetEvent("gcPhone:contactList")
AddEventHandler("gcPhone:contactList",function(_contacts)
	SendNUIMessage({ event = "updateContacts", contacts = _contacts })
	contacts = _contacts
end)

RegisterNetEvent("gcPhone:allMessage")
AddEventHandler("gcPhone:allMessage",function(allmessages)
	SendNUIMessage({ event = "updateMessages", messages = allmessages })
	messages = allmessages
end)

RegisterNetEvent("gcPhone:receiveMessage")
AddEventHandler("gcPhone:receiveMessage",function(message)
	-- print(json.encode(message))
	SendNUIMessage({ event = "newMessage", message = message })

	if message.owner == 0 and vSERVER.checkPhone() and not IsEntityInWater(PlayerPedId()) and not phoneActive then
		PlaySoundFrontend(-1,"Menu_Accept","Phone_SoundSet_Default",false)
	end

	if message.owner == 0 and phoneActive then
		TriggerEvent("phonenotify:sendMessage",message)
	end
end)

function addContact(display,num)
	TriggerServerEvent("gcPhone:addContact",display,num)
end

function deleteContact(num)
	TriggerServerEvent("gcPhone:deleteContact",num)
end

function sendMessage(num,message)
	TriggerServerEvent("gcPhone:sendMessage",num,message)
end

function deleteMessage(msgId)
	TriggerServerEvent("gcPhone:deleteMessage",msgId)
	for k, v in ipairs(messages) do
		if v.id == msgId then
			table.remove(messages,k)
			SendNUIMessage({ event = "updateMessages", messages = messages })
			return
		end
	end
end

function deleteMessageContact(num)
	TriggerServerEvent("gcPhone:deleteMessageNumber",num)
end

function deleteAllMessage()
	TriggerServerEvent("gcPhone:deleteAllMessage")
end

function setReadMessageNumber(num)
	TriggerServerEvent("gcPhone:setReadMessageNumber",num)
	for k, v in ipairs(messages) do
		if v.transmitter == num then
			v.isRead = 1
		end
	end
end

function requestAllMessages()
	TriggerServerEvent("gcPhone:requestAllMessages")
end

function requestAllContact()
	TriggerServerEvent("gcPhone:requestAllContact")
end

RegisterNetEvent("gcPhone:waitingCall")
AddEventHandler("gcPhone:waitingCall",function(infoCall,initiator)
	if not initiator and vSERVER.checkPhone() and not phoneActive then
		SendNUIMessage({ event = "waitingCall", infoCall = infoCall, initiator = initiator })
	end

	if not initiator and phoneActive then
		TriggerEvent("phonenotify:sendMessage","Chamada recebidade.")
	end

	if initiator then
		inCall = true
		SendNUIMessage({ event = "waitingCall", infoCall = infoCall, initiator = initiator })
		PhonePlayCall()
	end
end)

RegisterNetEvent("gcPhone:acceptCall")
AddEventHandler("gcPhone:acceptCall",function(infoCall,initiator)
	inCall = true
	exports["mumble-voip"]:SetCallChannel(infoCall.id + 1)
	PhonePlayCall()
	SendNUIMessage({ event = "acceptCall", infoCall = infoCall, initiator = initiator })
end)

RegisterNetEvent("gcPhone:rejectCall")
AddEventHandler("gcPhone:rejectCall",function(infoCall)
	exports["mumble-voip"]:SetCallChannel(0)
	if inCall then
		inCall = false
		PhonePlayText()
	end

	SendNUIMessage({ event = "rejectCall", infoCall = infoCall })
end)

RegisterNetEvent("gcPhone:historiqueCall")
AddEventHandler("gcPhone:historiqueCall",function(historique)
	SendNUIMessage({ event = "historiqueCall", historique = historique })
end)

function startCall(phone_number,rtcOffer,extraData)
	TriggerServerEvent("gcPhone:startCall",phone_number,rtcOffer,extraData)
end

function acceptCall(infoCall,rtcAnswer)
	TriggerServerEvent("gcPhone:acceptCall",infoCall,rtcAnswer)
end

function rejectCall(infoCall)
	TriggerServerEvent("gcPhone:rejectCall",infoCall)
end

function ignoreCall(infoCall)
	TriggerServerEvent("gcPhone:ignoreCall",infoCall)
end

function requestHistoriqueCall() 
	TriggerServerEvent("gcPhone:getHistoriqueCall")
end

function appelsDeleteHistorique(num)
	TriggerServerEvent("gcPhone:appelsDeleteHistorique",num)
end

function appelsDeleteAllHistorique()
	TriggerServerEvent("gcPhone:appelsDeleteAllHistorique")
end

RegisterNUICallback("startCall",function(data,cb)
	startCall(data.numero,data.rtcOffer,data.extraData)
	cb()
end)

RegisterNetEvent("gcPhone:callNotifyPush")
AddEventHandler("gcPhone:callNotifyPush",function(number)
	if not IsEntityInWater(PlayerPedId()) and vSERVER.checkPhone() then
		PhonePlayIn()
		menuIsOpen = true
		SendNUIMessage({ show = true })
		TriggerEvent("status:celular",true)

		Citizen.Wait(1000)

		TriggerServerEvent("gcPhone:startCall",tostring(number),nil,nil)
	end
end)

RegisterNUICallback("acceptCall",function(data,cb)
	acceptCall(data.infoCall,data.rtcAnswer)
	cb()
end)

RegisterNUICallback("rejectCall",function(data,cb)
	rejectCall(data.infoCall)
	cb()
end)

RegisterNUICallback("ignoreCall",function(data,cb)
	ignoreCall(data.infoCall)
	cb()
end)

RegisterNUICallback("notififyUseRTC",function(use,cb)
	if TokoVoipID ~= nil then
		exports.tokovoip_script:removePlayerFromRadio(TokoVoipID)
		TokoVoipID = nil
	end
	cb()
end)

RegisterNUICallback("onCandidates",function(data,cb)
	TriggerServerEvent("gcPhone:candidates",data.id,data.candidates)
	cb()
end)

RegisterNetEvent("gcPhone:candidates")
AddEventHandler("gcPhone:candidates",function(candidates)
	SendNUIMessage({ event = "candidatesAvailable", candidates = candidates })
end)

RegisterNetEvent("gcphone:autoCall")
AddEventHandler("gcphone:autoCall",function(number,extraData)
	if number ~= nil then
		SendNUIMessage({ event = "autoStartCall", number = number, extraData = extraData })
	end
end)

RegisterNetEvent("gcphone:autoCallNumber")
AddEventHandler("gcphone:autoCallNumber",function(data)
	TriggerEvent("gcphone:autoCall",data.number)
end)

RegisterNetEvent("gcphone:autoAcceptCall")
AddEventHandler("gcphone:autoAcceptCall",function(infoCall)
	SendNUIMessage({ event = "autoAcceptCall", infoCall = infoCall })
end)

RegisterNUICallback("log",function(data,cb)
	cb()
end)

RegisterNUICallback("focus",function(data,cb)
	cb()
end)

RegisterNUICallback("blur",function(data,cb)
	cb()
end)

RegisterNUICallback("reponseText",function(data,cb)
	local text = data.text or ""
	local limit = 200
  
	DisplayOnscreenKeyboard(1,"FMMC_MPM_NA","",text,"","","",limit)
	while UpdateOnscreenKeyboard() == 0 do
		DisableAllControlActions(0)
		Citizen.Wait(10)
	end

	if GetOnscreenKeyboardResult() then
		text = GetOnscreenKeyboardResult()
	end

	if text ~= nil and text ~= "" then
		cb(json.encode({ text = text }))
	end
end)

RegisterNUICallback("getMessages",function(data,cb)
	cb(json.encode(messages))
end)

function mathLegth(n)
	return math.ceil(n*100) / 100
end

RegisterNUICallback("sendMessage",function(data,cb)
	if data.message == '%pos%' then
		local myPos = GetEntityCoords(PlayerPedId())
		data.message = 'Loc: '..mathLegth(myPos.x)..', '..mathLegth(myPos.y)
	end

	TriggerServerEvent("gcPhone:sendMessage",data.phoneNumber,data.message)
end)

RegisterNUICallback("deleteMessage",function(data,cb)
	deleteMessage(data.id)
	cb()
end)

RegisterNUICallback("deleteMessageNumber",function(data,cb)
	deleteMessageContact(data.number)
	cb()
end)

RegisterNUICallback("deleteAllMessage",function(data,cb)
	deleteAllMessage()
	cb()
end)

RegisterNUICallback("setReadMessageNumber",function(data,cb)
	setReadMessageNumber(data.number)
	cb()
end)

RegisterNUICallback("addContact",function(data,cb) 
	TriggerServerEvent("gcPhone:addContact",data.display,data.phoneNumber)
end)

RegisterNUICallback("updateContact",function(data,cb)
	TriggerServerEvent("gcPhone:updateContact",data.id,data.display,data.phoneNumber)
end)

RegisterNUICallback("deleteContact",function(data,cb)
	TriggerServerEvent("gcPhone:deleteContact",data.id)
end)

RegisterNUICallback("getContacts",function(data,cb)
	cb(json.encode(contacts))
end)

RegisterNUICallback("setGPS",function(data,cb)
	SetNewWaypoint(tonumber(data.x),tonumber(data.y))
	cb()
end)

RegisterNUICallback("callEvent",function(data,cb)
	local eventName = data.eventName or ""
	if string.match(eventName,"gcphone") then
		if data.data ~= nil then 
			TriggerEvent(data.eventName,data.data)
		else
			TriggerEvent(data.eventName)
		end
	end
	cb()
end)

RegisterNUICallback("useMouse",function(um,cb)
	useMouse = um
end)

RegisterNUICallback("deleteALL",function(data,cb)
	TriggerServerEvent("gcPhone:deleteALL")
	cb()
end)

RegisterNUICallback("closePhone",function(data,cb)
	TriggerEvent("status:celular",false)
	vRP.stopActived()
	menuIsOpen = false
	SendNUIMessage({ show = false })
	PhonePlayOut()
	cb()
end)

RegisterNUICallback("appelsDeleteHistorique",function(data,cb)
	appelsDeleteHistorique(data.numero)
	cb()
end)

RegisterNUICallback("appelsDeleteAllHistorique",function(data,cb)
	appelsDeleteAllHistorique(data.infoCall)
	cb()
end)

AddEventHandler("onClientResourceStart",function(res)
	if res == "yordi-phone" then
		TriggerServerEvent("gcPhone:allUpdate")
	end
end)

RegisterNUICallback("setIgnoreFocus",function(data,cb)
	ignoreFocus = data.ignoreFocus
	cb()
end)