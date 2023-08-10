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
            }
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