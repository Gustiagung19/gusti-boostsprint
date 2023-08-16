if Config.Framework == "ESX" then
    ESX = exports['es_extended']:getSharedObject()
elseif Config.Framework == "QBCore" then
    QBCore = exports['qb-core']:GetCoreObject()
end

if Config.UseOxInventory == true then
    RegisterServerEvent('gusti-boostsprint:active')
    AddEventHandler('gusti-boostsprint:active', function()
        local source = source
        local xPlayer = ESX.GetPlayerFromId(source)
        exports.ox_inventory:RemoveItem(source, 'pill_boost_sprint', 1)
    end)
end

if Config.Framework == "ESX" then
    ESX.RegisterUsableItem('pill_boost_sprint', function(source)
        local source = source
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.removeInventoryItem("pill_boost_sprint", 1)
        TriggerClientEvent("gusti-boostsprint:active", source)
    end)
elseif Config.Framework == "QBCore" then
    QBCore.Functions.CreateUseableItem('pill_boost_sprint', function(source)
        local source = source
        local xPlayer = QBCore.Functions.GetPlayer(source)
        xPlayer.Functions.RemoveItem("pill_boost_sprint", 1)
        TriggerClientEvent("gusti-boostsprint:active", source)
    end)
end

--[[ Version Checker ]]--
local version = "1.0.0"

AddEventHandler("onResourceStart", function(resource)
    if Config.CheckForUpdates then
        if resource == GetCurrentResourceName() then
            CheckFrameworkVersion()
        end
    end
end)

function CheckFrameworkVersion()
    PerformHttpRequest("https://raw.githubusercontent.com/Gustiagung19/gusti-boostsprint/master/version.txt", function(err, text, headers)
        if string.match(text, version) then
            print(" ")
            print("--------- ^4GUSTI BOOSTSPRINT VERSION^7 ---------")
            print("gusti-boostsprint ^2is up to date^7 and ready to go!")
            print("Running on Version: ^2" .. version .."^7")
            print("^4https://github.com/Gustiagung19/gusti-boostsprint^7")
            print("--------------------------------------------")
            print(" ")
        else
          print(" ")
          print("--------- ^4GUSTI BOOSTSPRINT VERSION^7 ---------")
          print("gusti-boostsprint ^1is not up to date!^7 Please update!")
          print("Curent Version: ^1" .. version .. "^7 Latest Version: ^2" .. text .."^7")
          print("^4https://github.com/Gustiagung19/gusti-boostsprint^7")
          print("--------------------------------------------")
          print(" ")
        end

    end, "GET", "", {})

end