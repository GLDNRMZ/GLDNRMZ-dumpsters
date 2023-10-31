local entities = {}
QBCore = exports['qb-core']:GetCoreObject()

-----------
----BIN----
-----------
RegisterNetEvent('lb-dumpster:server:ResetEntity', function(entity)
    entities[entity] = 0
end)

function EntityRespawn()
    if entities ~= nil or entities ~= {} then
        for _,t in pairs(entities) do
            entities[_] = t + 1
            if t >= 0 and t >= Config.ResetTime then
                entities[_] = -1
            end
        end
    end
    SetTimeout(60000, EntityRespawn)
end

if not Config.ResetOnReboot then
    EntityRespawn()
end

RegisterNetEvent('lb-dumpster:server:SetEntity', function(netId, isFinished)
    entities[netId] = 0
    DropItem(isFinished, netId, source)
end)

local function pGive(playerId, item, amount)
    local Player = QBCore.Functions.GetPlayer(playerId)
    if not Player then return end
    if type(item) == 'string' then
        Player.Functions.AddItem(item, amount)
        if QBCore.Shared.Items[i.item].label then
            local itemString = amount .. 'x ' .. QBCore.Shared.Items[i.item].label
            TriggerClientEvent('QBCore:Notify', playerId, Lang:t('notifies.you_got', {items = itemString}))
        else
            TriggerClientEvent('QBCore:Notify', playerId, Lang:t('notifies.you_got', {items = item}))
        end
    elseif type(item) == 'table' and amount == 10000 then
        local itemString = ''
        if #item <= 0 then TriggerClientEvent('QBCore:Notify', playerId, Lang:t('notifies.got_nothing')) return end
        for _,i in pairs(item) do
            Player.Functions.AddItem(i.item, i.amount)
            itemString = i.amount .. 'x ' .. QBCore.Shared.Items[i.item].label .. ', ' .. itemString
        end

        if itemString ~= '' then
            TriggerClientEvent('QBCore:Notify', playerId, Lang:t('notifies.you_got', {items = itemString}))
        else
            TriggerClientEvent('QBCore:Notify', playerId, Lang:t('notifies.got_nothing'))
        end
    end
end

function DropItem(finished, netId, playerId)
    local Player = QBCore.Functions.GetPlayer(playerId)
    if not Player then return end
    if not netId then return end
    if not finished then return end

    local totalChances = 0
    for _, tierData in pairs(Config.LootTiers) do
        totalChances = totalChances + tierData.chances
    end

    local tierRoll = math.random(1, totalChances)
    local selectedTier = nil
    for tierName, tierData in pairs(Config.LootTiers) do
        if tierRoll <= tierData.chances then
            selectedTier = tierData
            --print("Selected Tier:", tierName, "with roll:", tierRoll)
            break
        else
            tierRoll = tierRoll - tierData.chances
        end
    end

    if not selectedTier then
        --print("ERROR: No tier selected for loot drop")
        return
    end

    if Config.CanLootMultiple then
        local itemTable = {}
        local itemAmount = math.random(1, Config.MaxLootItem)

        for i = 1, itemAmount do
            local item = selectedTier.loottable[math.random(1, #selectedTier.loottable)]
            itemTable[#itemTable+1] = {item = item.item, amount = math.floor(math.random(item.min, item.max))}
        end

        return pGive(playerId, itemTable, 10000)
    else
        local item = selectedTier.loottable[math.random(1, #selectedTier.loottable)]
        return pGive(playerId, item.item, math.random(item.min, item.max))
    end
end

QBCore.Functions.CreateCallback('lb-dumpster:server:getEntityState', function(source, cb, netId)
    if entities[netId] == -1 or entities[netId] == nil then cb(false) else cb(true) end
end)

AddEventHandler('onResourceStop', function(resName)
    if resName ~= GetCurrentResourceName() then return end
    for _,v in pairs(entities) do
        if v == -1 then
            TriggerClientEvent('lb-dumpster:client:ResetEntity', -1, _)
        end
    end
end)

-----------
----BUM----
-----------

--selling
RegisterNetEvent('lb-dumpster:server:sellItems', function()
    local src = source
    local totalPrice = 0
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.PlayerData.items then
        local removedItems = {}

        for k, v in pairs(Player.PlayerData.items) do
            local itemName = v.name

            if Config.ItemsSell[itemName] then
                local itemPrice = Config.ItemsSell[itemName].price * v.amount
                totalPrice = totalPrice + itemPrice
                removedItems[k] = { name = itemName, amount = v.amount }
                Player.Functions.RemoveItem(itemName, v.amount, k)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], "remove")
            end
        end

        if totalPrice > 0 then
            Player.Functions.AddMoney("cash", totalPrice)
            TriggerClientEvent('QBCore:Notify', src, "Here's $"..totalPrice..", piss off.")
        else
            TriggerEvent('lb-dumpster:server:pedStealItems', src)
        end
    end
end)

--stealing
RegisterNetEvent('lb-dumpster:server:pedStealItems', function(src)
    local Player = QBCore.Functions.GetPlayer(src)
    local itemsStolen = false -- Flag to track if any items are stolen

    if Player.PlayerData.items then
        local removedItems = {}

        for k, v in pairs(Player.PlayerData.items) do
            local itemName = v.name

            if Config.ItemsSteal[itemName] then
                local chance = math.random(1, 100)

                if chance <= Config.StealChance then
                    local amountToSteal = math.random(1, v.amount)
                    removedItems[k] = { name = itemName, amount = amountToSteal }
                    Player.Functions.RemoveItem(itemName, amountToSteal, k)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], "remove")
                    itemsStolen = true -- Set the flag to true
                end
            end
        end

        if next(removedItems) then
            TriggerClientEvent('QBCore:Notify', src, "GIVE ME YO SHIT, BITCH!")
            TriggerEvent('lb-dumpster:server:onPedStealItems', src, removedItems)
        end
    end

    -- If no items are stolen, trigger the "You ain't got shit I want" notification
    if not itemsStolen then
        TriggerClientEvent('QBCore:Notify', src, "You ain't got shit I want")
    end
end)
