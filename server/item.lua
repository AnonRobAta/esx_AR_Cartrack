ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem("cartracker", function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
      for k , job in pairs(Config.WhitelistedJobs) do
         if xPlayer.job.name ~= job then
         TriggerClientEvent("esx_AR-CarTracker:UseNormalTracker", _source)
         else
            TriggerClientEvent('esx:showNotification', _source, Config.Translations.Policecantusenormaltrack)
        end
    end
end)

ESX.RegisterUsableItem("policetracker", function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
        for k , job in pairs(Config.WhitelistedJobs) do
        if xPlayer.job.name == job then
            TriggerClientEvent("esx_AR-CarTracker:UsePoliceTracker", _source)
        else
            TriggerClientEvent('esx:showNotification', _source, Config.Translations.Youdontarepolice)
        end
    end
end)

RegisterNetEvent("esx_AR-CarTracker:RemoveItem")
AddEventHandler("esx_AR-CarTracker:RemoveItem", function(item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem(item, 1)
end)