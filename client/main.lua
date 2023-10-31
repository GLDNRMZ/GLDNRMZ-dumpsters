-----------
----BIN----
-----------
CreateThread(function()
    exports['qb-target']:AddTargetModel(Config.Props, {
        options = {
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
            },
            {
                type = "client",
                event = "lb-dumpster:client:open:Dumpster:storage",
                icon = "far fa-trash-alt",
                label = "Open Dumpster",
            },
        },
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
        distance = 1.5, 
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
    local DumpsterFound = ClosestContainer()
    local Dumpster = 'Container | '..math.floor(DumpsterFound.x).. ' | '..math.floor(DumpsterFound.y)..' |'
    TriggerServerEvent("inventory:server:OpenInventory", "stash", Dumpster, {maxweight = 1000000, slots = 50})
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

