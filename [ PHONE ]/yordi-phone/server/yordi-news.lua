-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

function newsgetNews (accountId, cb)
  if accountId == nil then
    MySQL.Async.fetchAll([===[
	SELECT * FROM `yordi_news` ORDER BY `yordi_news`.`id` DESC
      ]===], {}, cb)
  end
end

function newsgetUser(phone_number, firstname, cb)
  MySQL.Async.fetchAll("SELECT firstname, phone_number FROM users WHERE users.firstname = @firstname AND users.phone_number = @phone_number", {
    ['@phone_number'] = phone_number,
	  ['@firstname'] = firstname
  }, function (data)
    cb(data[1])
  end)
end

function newsnewAdd (title, message, sourcePlayer, cb)
    local source = source
    local user = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user)

    MySQL.Async.insert("INSERT INTO yordi_news (`phone_number`, `firstname`, `lastname`, `title`, `message`) VALUES(@phone_number, @firstname, @lastname, @title, @message);", {
	  ['@phone_number'] = identity.phone,
	  ['@firstname'] = identity.name,
    ['@lastname'] = identity.name2,
    ['@title'] = title,
    ['@message'] = message
    }, function (id)
      MySQL.Async.fetchAll('SELECT * from yordi_news WHERE id = @id', {
        ['@id'] = id
      }, function (getNews)
        getNews = getNews[1]
        getNews['firstname'] = identity.name
        getNews['phone_number'] = identity.phone
        TriggerClientEvent('yordi-phone:addNews', -1, getNews)
        TriggerEvent('yordi-phone:addNews', getNews)
      end)
    end)
end


RegisterServerEvent('yordi-phone:addNews')
AddEventHandler('yordi-phone:addNews', function(firstname, phone_number, lastname, title, message)
  local sourcePlayer = tonumber(source)
  newsnewAdd(title, message, sourcePlayer)
end)

RegisterServerEvent('yordi-phone:newsGet')
AddEventHandler('yordi-phone:newsGet', function(phone_number, firstname)
  local sourcePlayer = tonumber(source)
  if phone_number ~= nil and phone_number ~= "" and firstname ~= nil and firstname ~= "" then
    newsgetUser(phone_number, firstname, function (user)
      local accountId = user and user.id
      newsgetNews(accountId, function (getNews)
        TriggerClientEvent('yordi-phone:newsGet', sourcePlayer, getNews)
      end)
    end)
  else
    newsgetNews(nil, function (getNews)
      TriggerClientEvent('yordi-phone:newsGet', sourcePlayer, getNews)
    end)
  end
end)

RegisterServerEvent('yordi-phone:newscheckJob')
AddEventHandler('yordi-phone:newscheckJob', function(yordi)
  local sourcePlayer = tonumber(source)
  local xPlayer = vRP.getUserId(source)

  if vRP.hasPermission(xPlayer,"Report") then
    TriggerClientEvent('yordi-phone:newscheckJob', yordi)
    TriggerClientEvent('yordi-phone:routerNews', sourcePlayer)
  else
    TriggerClientEvent('mythic_notify:client:SendAlert', sourcePlayer, { type = 'error', text = 'Buraya girebilmek için haberci olman gerekiyor!'})
  end

end)