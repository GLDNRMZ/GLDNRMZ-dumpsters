-----------
----BIN----
-----------
CreateThread(function()
    local targetOptions = {
        {
            label = Lang:t('target.label'),
            icon = 'fas fa-dumpster',
            action = function(ent)
                QBCore.Functions.TriggerCallback('lb-dumpster:server:getEntityState', function(wasDived)
                    if not wasDived then
                        isBusy = true
                        PoliceAlert()

                        if not Config.Minigame then
                            ProgressBar(ent)
                        else
                            local success = MiniGame()
                            if success then
                                ProgressBar(ent)
                            else
                                QBCore.Functions.Notify(Lang:t('notifies.failed_minigame'))
                                isBusy = false
                            end
                        end
                    else
                        QBCore.Functions.Notify(Lang:t('notifies.already_dived'), 'error', 5000)
                    end
                end, ObjToNet(ent))
            end,
            canInteract = function(ent)
                return not isBusy
            end
        }
    }

    -- Only add the "Open Dumpster" option if Config.Storage is true
    if Config.Storage then
        table.insert(targetOptions, {
            type = "client",
            event = "lb-dumpster:client:open:Dumpster:storage",
            icon = "far fa-trash-alt",
            label = "Open Dumpster",
        })
    end

    exports['qb-target']:AddTargetModel(Config.Props, {
        options = targetOptions,
        distance = 1.5
    })
end)


RegisterNetEvent('lb-dumpster:client:ResetEntity', function(netId)
    if NetworkGetEntityIsNetworked(netId) then NetworkUnregisterNetworkedEntity(netId) end
end)

-----------
----BUM----
-----------
CreateThread(function()
    exports['qb-target']:AddTargetModel(Config.pedModels, {
        options = {
            { 
                type = "client",
                event = "lb-dumpster:client:MainMenu",
                icon = "fa-solid fa-location-dot",
                label = "Sell Trash",
            },
            
        }, 
        distance = 2.5, 
    })
end)

RegisterNetEvent('lb-dumpster:client:MainMenu', function()
    local MainMenu = {
        {
            isMenuHeader = true,
            header = "Sell Trash"
        },
        {
            header = "Sell me all your shit",
            txt = "",
            icon = "fa-solid fa-bars",
            params = {
                isServer = true,
                event = "lb-dumpster:server:sellItems",
            }
        },
       
    }

    exports['qb-menu']:openMenu(MainMenu)
end)

-----------
--STORAGE--
-----------
RegisterNetEvent('lb-dumpster:client:open:Dumpster:storage')
AddEventHandler('lb-dumpster:client:open:Dumpster:storage', function()
    if not Config.Storage then return end

    local DumpsterFound = ClosestContainer()
    local Dumpster = 'Container | '..math.floor(DumpsterFound.x).. ' | '..math.floor(DumpsterFound.y)..' |'

    if Config.Inventory == "Old" then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", Dumpster, {maxweight = Config.StorageWeight, slots = Config.StorageSize})
    else
        TriggerServerEvent("lb-dumpster:server:openDumpsterInventory", Dumpster)
    end

    TriggerEvent("inventory:client:SetCurrentStash", Dumpster)
end)

function ClosestContainer()
    for _, propModel in ipairs(Config.Props) do
        local StartShape = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, 0.1, 0)
        local EndShape = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, 1.8, -0.4)
        local RayCast = StartShapeTestRay(StartShape.x, StartShape.y, StartShape.z, EndShape.x, EndShape.y, EndShape.z, 16, PlayerPedId(), 0)
        local Retval, Hit, Coords, Surface, EntityHit = GetShapeTestResult(RayCast)
        local BinModel = 0

        if EntityHit then
            BinModel = GetEntityModel(EntityHit)
        end

        if GetHashKey(propModel) == BinModel then
            local EntityHitCoords = GetEntityCoords(EntityHit)
            if EntityHitCoords.x < 0 or EntityHitCoords.y < 0 then
                EntityHitCoords = { x = EntityHitCoords.x + 5000, y = EntityHitCoords.y + 5000 }
            end
            return EntityHitCoords
        end
    end
end

------------
--BUM PEDS--
------------

function loadAnimDict(dict) 
    while not HasAnimDictLoaded(dict) do 
        RequestAnimDict(dict) 
        Wait(0) 
    end 
end

function StartJobPed(coords, model, scenario)
    local ped
    if not DoesEntityExist(ped) then
        RequestModel(model) 
        while not HasModelLoaded(model) do 
            Wait(0) 
        end
        ped = CreatePed(0, model, coords, false, false)
               
        SetEntityAsMissionEntity(ped)
        SetPedFleeAttributes(ped, 0, 0)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetEntityInvincible(ped, true)
        FreezeEntityPosition(ped, true)
        TaskStartScenarioInPlace(ped, scenario, 0, true)
    end
    return ped
end

CreateThread(function()
    for key, value in pairs(Config.BumsLocation) do
        StartJobPed(value.coords, value.model, value.scenario)
    end
end)
