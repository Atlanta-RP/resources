-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Notify")
AddEventHandler("Notify",function(css,mensagem,timer)
	SendNUIMessage({ css = css, mensagem = mensagem, timer = timer })
	if(css == "negado" or css == "aviso") then
		PlaySoundFrontend(-1,"Menu_Accept","Phone_SoundSet_Default",false)
	else
		PlaySoundFrontend(-1,"Event_Message_Purple","GTAO_FM_Events_Soundset",false)
	end
end)