local blipp = 0
local policeblipp = 0
local policetrack = false
local normaltrack = false

local animDict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@"
local anim = "weed_spraybottle_crouch_base_inspector"

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)



RegisterNetEvent("esx_AR-CarTracker:UseNormalTracker")
AddEventHandler("esx_AR-CarTracker:UseNormalTracker", function ()
    local ped = PlayerPedId()
    local pedcoords = GetEntityCoords(ped)
    local veh = GetClosestVehicle(pedcoords.x, pedcoords.y, pedcoords.z, 1.0, 0, 70)

    if normaltrack == false then
    if DoesEntityExist(veh) then -- just check :)
    normaltrack = true
    TriggerServerEvent("esx_AR-CarTracker:RemoveItem", "tracker")
    loadAnimDict(animDict)
    Citizen.Wait(1000)
    TaskPlayAnim(ped, animDict, anim, 3.0, 1.0, -1, 0, 1, 0, 0, 0)
    Citizen.Wait(Config.AnimationTime * 1000) 
    ClearPedTasksImmediately(ped)
    while blipp > 10 do
        if blipp > 10 then
        Citizen.Wait(Config.RefreshTime)
        BLIPCREATE(veh, true)
        blipp = blipp + 1
        else
            blipp = 0
            normaltrack = false
    end
     end
    else
        ESX.ShowNotification(Config.Translations.Novehicles)
    end
else
    ESX.ShowNotification(Config.Translations.YouHaveOtherTracker)
    end
end)



RegisterNetEvent("esx_AR-CarTracker:UsePoliceTracker")
AddEventHandler("esx_AR-CarTracker:UsePoliceTracker", function()
    local ped = PlayerPedId()
    local pedcoords = GetEntityCoords(ped)
    local veh = GetClosestVehicle(pedcoords.x, pedcoords.y, pedcoords.z, 1.0, 0, 70)

    if policetrack == false then
        if DoesEntityExist(veh) then -- just check :)
        policetrack = true
        TriggerServerEvent("esx_AR-CarTracker:RemoveItem", "policetracker")
        loadAnimDict(animDict)
        Citizen.Wait(1000)
        TaskPlayAnim(ped, animDict, anim, 3.0, 1.0, -1, 0, 1, 0, 0, 0)
        Citizen.Wait(Config.AnimationTime * 1000)
        ClearPedTasksImmediately(ped)
        while policeblipp > 30 do
         if policeblipp > 30 then
          Citizen.Wait(Config.RefreshTime)
          BLIPCREATE(veh, true)
          policeblipp = policeblipp + 1
          else
            policeblipp = 0
            policetrack = false
          end
         end
     else
        ESX.ShowNotification(Config.Translations.Novehicles)
     end
    else
      ESX.ShowNotification(Config.Translations.YouHaveOtherTracker)
    end
end)

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(20)
    end
end

function BLIPCREATE(veh, bool)
    if bool then
    blip = AddBlipForEntity(veh)
    SetBlipSprite (blip, 85)
    SetBlipDisplay(blip, 6)
    SetBlipScale  (blip, 1.0)
    SetBlipColour (blip, 8)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.TrackerBlipName)
    EndTextCommandSetBlipName(blip)
    Citizen.Wait(1000)
    RemoveBlip(blip)
    else
        RemoveBlip(blip)
    end
end

