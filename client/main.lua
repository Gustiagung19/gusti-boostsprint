if Config.Framework == "ESX" then
    ESX = exports['es_extended']:getSharedObject()
elseif Config.Framework == "QBCore" then
    QBCore = exports['qb-core']:GetCoreObject()
end

RegisterNetEvent("gusti-boostsprint:active")
AddEventHandler("gusti-boostsprint:active", function()
    local playerPed = GetPlayerPed(-1)

    RequestAnimDict('mp_suicide')
    while not HasAnimDictLoaded('mp_suicide') do
        Wait(0)
    end
    
    TaskPlayAnim(playerPed, 'mp_suicide', 'pill_fp', 8.0, -8.0, -1, 0, 0, false, false, false)
    Wait(2000)
    ClearPedTasks(playerPed)
    RequestAnimDict('misscommon@response')
    while not HasAnimDictLoaded('misscommon@response') do
        Wait(0)
    end
    
    TaskPlayAnim(playerPed, 'misscommon@response', 'bring_it_on', 8.0, -8.0, -1, 0, 0, false, false, false)
    Wait(2000)
    ClearPedTasks(playerPed)
    if Config.UseOxInventory == true then
        TriggerServerEvent('gusti-boostsprint:active')
    end
    TriggerEvent('gusti-boostsprint:notify', Config.Language.active, 'info', 3000)
    SetPedMoveRateOverride(PlayerId(), 10.0)
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
    RestorePlayerStamina(PlayerId(), 1.0)
    Wait(Config.DurationBoostSprint)
    TriggerEvent('gusti-boostsprint:notify', Config.Language.notactive, 'error', 3000)
    TriggerEvent("gusti-boostsprint:notactive")
end)

RegisterNetEvent("gusti-boostsprint:notactive")
AddEventHandler("gusti-boostsprint:notactive", function()
    SetPedMoveRateOverride(PlayerId(), 1.0)
	SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end)

RegisterNetEvent('gusti-boostsprint:notify')
AddEventHandler('gusti-boostsprint:notify', function(args, _type, time)
    if Config.Framework == "ESX" then
        ESX.ShowNotification(args, _type, time)
    elseif Config.Framework == "QBCore" then
        QBCore.Functions.Notify(args, _type, time)
    end
end)