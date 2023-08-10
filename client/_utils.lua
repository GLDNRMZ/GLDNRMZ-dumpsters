QBCore = exports['qb-core']:GetCoreObject()
isBusy = false

if Config.Minigame == 'memorygame' then
    function MiniGame()
        local success = false
        local holdResult = true

        exports["memorygame"]:thermiteminigame(5, 3, 3, 15, function()
            success = true
            holdResult = false
        end, function()
            success = false
            holdResult = false
        end)

        while holdResult do Wait(100) end
        return success
    end
elseif Config.Minigame == 'qb-lock' then
    function MiniGame()
        local success = exports['qb-lock']:StartLockPickCircle(3, 10)
        return success or false
    end
elseif Config.Minigame == 'ps-ui' then
    function MiniGame()
        local success = false
        exports['ps-ui']:Circle(function(result)
            success = result
        end, 3, 10)
        return success
    end
elseif Config.Minigame and Config.Minigame ~= 'none' then
    print('[lb-dumpster] Invalid minigame specified in config.lua')
end

function PoliceAlert()
    if Config.Illegal then
        if math.random(1,100) >= Config.AlertChance then return end
        if Config.Dispatch == 'ps-dispatch' then
            exports["ps-dispatch"]:CustomAlert({
                coords = GetEntityCoords(PlayerPedId()),
                message = Lang:t('police.message'),
                dispatchCode = Lang:t('police.code'),
                description = Lang:t('police.bliptitle'),
                radius = 0,
                sprite = 318,
                color = 1,
                scale = 0.5,
                length = 3,
            })
        elseif Config.Dispatch == 'qb-core' then
            TriggerServerEvent('police:server:policeAlert', Lang:t('police.bliptitle'))
        else
            print('[lb-dumpster] Config.Dispatch does not have a valid argument')
        end
    end
end

function ProgressBar(ent)
    QBCore.Functions.Progressbar('diving_in_dumpster', Lang:t('progress.diving'), Config.ProgressTime * 1000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
        anim = 'machinic_loop_mechandplayer',
        flags = 1,
    }, {}, {}, function()
        if not NetworkGetEntityIsNetworked(ent) then NetworkRegisterEntityAsNetworked(ent) end
        TriggerServerEvent('lb-dumpster:server:SetEntity', ObjToNet(ent), true)
        if not Config.ResetOnReboot then TriggerServerEvent('lb-dumpster:server:ResetEntity', ObjToNet(ent)) end
        isBusy = false
        ClearPedTasks(PlayerPedId())
    end, function()
        isBusy = false
        HurtPlayer(true)
        ClearPedTasks(PlayerPedId())
    end)
end

function HurtPlayer(cancelled)
    local doubled = 0.5
    if cancelled then doubled = 1.5 end

    if Config.Hurting then
        if math.random(1,100) >= Config.HurtChance * doubled then return end

        local health = GetEntityHealth(PlayerPedId())
        local newHealth = health - math.random(Config.HurtDamage.min, Config.HurtDamage.max)
        SetEntityHealth(PlayerPedId(), newHealth)

        if Config.CanBleed then
            if math.random(1,100) >= Config.BleedChance then return end
            TriggerEvent('hospital:client:SetPain')
        end
    end
end