local QBCore = exports['qb-core']:GetCoreObject()
local robbableHouses = {
    [1] = {id = 1, x = 362.1497, y = -1987.4723, z = 24.5913, heading = 343.83, info = '20 Jamestown St Apt 6', building = 'furnished_lowerpart', isOpen = false, lockpickId = 0, zOffset = -50, busy = false },
    [2] = {id = 2, x = 324.5307, y = -1937.0815, z = 25.3552, heading = 138.97, info = '18 Jamestown St', building = 'furnished_lowerpart', isOpen = false, lockpickId = 0, zOffset = -50, busy = false },
    [3] = {id = 3, x = 235.8002, y = -2046.5437, z = 19.0571, heading = 327.2, info = '1 Jamestown St', building = 'furnished_lowerpart', isOpen = false, lockpickId = 0, zOffset = -50, busy = false },
    [4] = {id = 4, x = 86.1359, y = -1959.9418, z = 21.5927, heading = 57.41, info = '10 Grove St', building = 'furnished_lowerpart', isOpen = false, lockpickId = 0, zOffset = -50, busy = false },
    [5] = {id = 5, x = 118.6033, y = -1921.3142, z = 21.6059, heading = 54.03, info = '13 Grove St', building = 'furnished_lowerpart', isOpen = false, lockpickId = 0, zOffset = -50, busy = false },
    [6] = {id = 6, x = 54.7013, y = -1872.954, z = 23.1316, heading = 135.1, info = '15 Grove St', building = 'furnished_lowerpart', isOpen = false, lockpickId = 0, zOffset = -50, busy = false },
    [7] = {id = 7, x = -64.836, y =-1449.6095, z = 33.1804, heading = 281.46, info = '5 Forum Dr', building = 'furnished_lowerpart', isOpen = false, lockpickId = 0, zOffset = -50, busy = false },
    [8] = {id = 8, x = -107.3155, y = -1473.3796, z = 34.4792, heading = 50.27, info = '7 Forum Dr Apt 3', building = 'furnished_lowerpart', isOpen = false, lockpickId = 0, zOffset = -50, busy = false },
    [9] = {id = 9, x = -184.6663, y = -1539.2432, z = 34.895, heading = 229.45, info = '10 Forum Dr Apt 6', building = 'furnished_lowerpart', isOpen = false, lockpickId = 0, zOffset = -50, busy = false },
    [10] = {id = 10, x =-716.6721, y = -864.4634, z = 23.6612, heading = 270.77, info = '345 Vespucci Blvd', building = 'furnitured_midapart', isOpen = false, lockpickId = 0, zOffset = -50, busy = false },
    [11] = {id = 11, x = -729.6409, y = -882.4182, z = 23.2479, heading = 358.49, info = '68 Ginger St', building = 'furnitured_midapart', isOpen = false, lockpickId = 0, zOffset = -50, busy = false },
    [12] = {id = 12, x = -787.7238, y = -911.861, z = 18.4792, heading = 268.34, info = '72 Lindsay Circus', building = 'furnitured_midapart', isOpen = false, lockpickId = 0, zOffset = -50, busy = false },
    [13] = {id = 13, x = 1259.2283, y = -1762.2118, z = 50.0433, heading = 27.32, info = '12 Amarillo Vista', building = 'furnitured_midapart', isOpen = false, lockpickId = 0, zOffset = -50, busy = false },
    [14] = {id = 14, x = 1297.12, y =  -1618.0, z = 54.58, heading = 199.11, info = '17 Amarillo Vista', building = 'furnitured_midapart', isOpen = false, lockpickId = 0, zOffset = -50, busy = false },
    [15] = {id = 15, x = 1230.4792, y = -1590.6406, z = 54.1651, heading = 212.44, info = '5 Fudge Lane', building = 'furnitured_midapart', isOpen = false, lockpickId = 0, zOffset = -50, busy = false },
    [16] = {id = 16, x = -1668.0868, y =-385.1615, z = 49.2893, heading = 53.28, info = '523 West Eclipse Blvd Apt 6', building = 'furnitured_midapart', isOpen = false, lockpickId = 0, zOffset = -50, busy = false },
    [17] = {id = 17, x = -1790.38, y = -369.49, z = 45.11, heading = 53.28, info = '523 West Eclipse Blvd Apt 2', building = 'furnitured_midapart', isOpen = false, lockpickId = 0, zOffset = -50, busy = false },
    [18] = {id = 18, x = -1692.7496, y = -464.4333, z = 42.0288, heading = 142.01, info = '213 Bay City Ave Apt 1', building = 'furnitured_midapart', isOpen = false, lockpickId = 0, zOffset = -50, busy = false },
    [19] = {id = 19, x = 953.037, y = -252.6138, z = 68.4616, heading = 60.31, info = '12 Bridge St', building = 'furnitured_midapart', isOpen = false, lockpickId = 0, zOffset = -50, busy = false },
    [20] = {id = 20, x = 1028.908, y = -408.5496, z = 66.608, heading = 220.52, info = '53 West Mirror Dr', building = 'furnitured_midapart', isOpen = false, lockpickId = 0, zOffset = -50, busy = false },
    [21] = {id = 21, x = 1262.1327, y = -430.0098, z = 70.3137, heading = 297.77, info = '90 East Mirror Dr', building = 'furnitured_midapart', isOpen = false, lockpickId = 0 , zOffset = -50, busy = false },
}

QBCore.Functions.CreateCallback('gems-houserobbery:server:getAllHouses', function(source, cb)
    cb(robbableHouses)
end)

QBCore.Functions.CreateCallback('gems-houserobbery:server:getHouseDetails', function(source, cb)
    local propertyDetails = nil
    while not propertyDetails do
        local index = math.random(#robbableHouses)
        if not robbableHouses[index].busy then
            propertyDetails = robbableHouses[index]
            robbableHouses[index].busy = true
        end
    end 
    cb(propertyDetails)
end)

QBCore.Functions.CreateCallback('gems-houserobbery:server:getHouseDetailsByIndex', function(source, cb, index)
    local propertyDetails = robbableHouses[index]
    cb(propertyDetails)
end)

QBCore.Functions.CreateCallback('gems-houserobbery:server:getPoliceCount', function (source, cb)
    local policeCount = 0
    local list = QBCore.Functions.GetPlayers()
    for k, v in pairs(list) do
        local player = QBCore.Functions.GetPlayer(v)
        if player.PlayerData.job.name == 'police' then
            policeCount = policeCount + 1
        end
    end
    cb(policeCount)
end)

RegisterNetEvent('gems-houserobbery:server:setLockpickId', function(index, id)
    robbableHouses[index].lockpickId = id
end)

RegisterNetEvent('gems-houserobbery:server:setIsOpen', function(index, isOpen)
    robbableHouses[index].isOpen = isOpen
end)

RegisterNetEvent('gems-houserobbery:server:createBlipForGroup', function(group, name, data)
    exports['qb-phone']:CreateBlipForGroup(group, name, data)
end)

RegisterNetEvent('gems-houserobbery:server:removeBlipForGroup', function(group, name)
    exports['qb-phone']:RemoveBlipForGroup(group, name)
end)

QBCore.Functions.CreateCallback('gems-houserobbery:server:getGroupByMembers', function(source, cb)
    local src = source
    local group = exports['qb-phone']:GetGroupByMembers(src)
    cb(group)
end)

QBCore.Functions.CreateCallback('gems-houserobbery:server:getGroupLeader', function(source, cb, group)
    local lgroup = group
    local leader = exports['qb-phone']:GetGroupLeader(lgroup)
    cb(leader)
end)

QBCore.Functions.CreateCallback('gems-houserobbery:server:getGroupMembers', function(source, cb, group)
    local returnValue = exports['qb-phone']:getGroupMembers(group)
    cb(returnValue)
end)

RegisterNetEvent('gems-houserobbery:server:setJobStatus', function(group, stages)
    exports['qb-phone']:setJobStatus(group, "Burglary", stages)
end)

RegisterNetEvent('gems-houserobbery:server:notifiyGroup', function(group, message)
    exports['qb-phone']:pNotifyGroup(group, "BURGLARY", message, "fas fa-mask", "#808080", 7500)
end)

QBCore.Functions.CreateCallback('gems-houserobbery:server:getGroupSize', function(source, cb, group)
    local groupSize = exports['qb-phone']:getGroupSize(group)
    cb(groupSize)    
end)

RegisterNetEvent('gems-houserobbery:server:createDoorTargetForGroup', function(group, propertyToRob, propertyId)
    local Players = QBCore.Functions.GetPlayers() 
    local members = exports['qb-phone']:getGroupMembers(group)
    for _, v in pairs(members) do
        TriggerClientEvent('gems-houserobbery:client:setPropertyToRob', v, propertyToRob, propertyId)
        TriggerClientEvent('gems-houserobbery:client:createTargetsAndZone', v)
    end
end)

RegisterNetEvent('gems-houserobbery:server:setGroupStage', function(group, stages)
    local groupList = exports['qb-phone']:getGroupMembers(group)
    local lStages = stages
    for _, v in pairs(groupList) do
        TriggerClientEvent('gems-houserobbery:client:setStage', v, lStages)
    end
end)

RegisterNetEvent("gems-houserobbery:server:AddItem", function(item, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem(item, amount)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add", amount)
    if Config.isCGH then
        exports['gems-jewels']:DropJewels(src)
    end
end)

RegisterNetEvent("gems-houserobbery:server:RemoveItem", function(item, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(item, amount)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove", amount)
end)

RegisterNetEvent('gems-houserobbery:server:createHouseForGroup', function(group, propertyId)
    local groupList = exports['qb-phone']:getGroupMembers(group)
    for _, v in pairs(groupList) do
        TriggerClientEvent('gems-houserobbery:client:createHouse', v, propertyId)
    end
end)

RegisterNetEvent('gems-houserobbery:server:startHandback', function(group)
    local groupLeader = exports['qb-phone']:GetGroupLeader(group)
    TriggerClientEvent('gems-houserobbery:client:startHandback', groupLeader)
end)

RegisterNetEvent('gems-houserobbery:server:rewards', function (group, propertyToRob)
    robbableHouses[propertyToRob.id].busy = false
    robbableHouses[propertyToRob.id].lockpickId = 0
    robbableHouses[propertyToRob.id].isOpen = false
    local groupList = exports['qb-phone']:getGroupMembers(group)
    local groupSize = exports['qb-phone']:getGroupSize(group)
    local rewardMultiplier = {
        [1] = 1, -- 400
        [2] = 1.25 -- 500
    }
    local cashReward = 400 * rewardMultiplier[groupSize]
    if Config.psbuffs then
        local hasLuck = exports['ps-buffs']:HasBuff('luck')
        if hasLuck then
            cashReward = cashReward + 400
        end
    end
    for _, v in pairs(groupList) do
        local Player = QBCore.Functions.GetPlayer(v)
        Player.Functions.AddMoney('cash', math.floor(cashReward))
    end
    exports['qb-phone']:resetJobStatus(group)
    TriggerEvent('gems-houserobbery:server:DestroyZones', group)
end)

RegisterNetEvent('gems-houserobbery:server:DestroyZones', function(group)
    local groupList = exports['qb-phone']:getGroupMembers(group)
    for _, v in pairs(groupList) do
        TriggerClientEvent('gems-hosuerobbery:client:DestroyDropOffZones', v)
    end
end)
