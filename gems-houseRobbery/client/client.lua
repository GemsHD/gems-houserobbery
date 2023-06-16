local QBCore = exports['qb-core']:GetCoreObject()
local propertyToRob, propertyId, activeGroup, lockpickerId
local stages = {}

local HouseObj = {}
local POIOffsets = {}

local IsPoliceOfficer = false
local AllPoliceHouses = {}

local function createPoliceZones(spawnCoords, house)
  local xpos = spawnCoords.x
  local ypos = spawnCoords.y
  local zpos = spawnCoords.z

  local zonesToCreate = Config.robbableArea[house.building]
  for _, v in pairs(zonesToCreate) do
    local x = xpos + v.xoff
    local y = ypos + v.yoff
    local z = zpos + v.zoff

    if v.type == "exit" then
      exports['qb-target']:AddBoxZone(v.zoneName .. "_" .. house.id, vector3(x, y, z), 0.75, 1.05, {
        name = v.zoneName .. "_" .. house.id,
        heading = v.heading,
        debugPoly = false,
        minZ = z - 0.25,
        maxZ = z + 0.5
      }, {
        options = {
          {
            type = "client",
            event = "gems-houserobbery:client:exitHouse",
            icon = "fas fa-door",
            label = "Exit",
            propId = house.id
          }
        },
        distance = 1.5
      })
    end
  end
end

local function showEntranceHeaderMenu(propertyId)
  local headerMenu = {}
  local Player = QBCore.Functions.GetPlayerData()

  if Player.job.name == "police" then
    headerMenu[#headerMenu+1] = {
      header = "Enter Property",
      params = {
          event = "gems-houserobbery:client:enterHouse",
          args = {
            propertyId = propertyId
          }
      }
    }
  else
    headerMenu[#headerMenu+1] = {
      header = "Break In",
      params = {
          event = "gems-houserobbery:client:pickDoor",
          args = {}
      }
    }
  end

  headerMenu[#headerMenu + 1] = {
    header = "Close Menu",
    params = {
        event = 'qb-menu:client:closeMenu'
    }
  }

  exports['qb-menu']:openMenu(headerMenu)
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  IsPoliceOfficer = QBCore.Functions.GetPlayerData().job.name == "police"
  if IsPoliceOfficer then
    QBCore.Functions.TriggerCallback('gems-houserobbery:server:getAllHouses', function(houses)
      AllPoliceHouses = houses
      for k,v in pairs(AllPoliceHouses) do

        local coords = vector3(v.x, v.y, v.z)
        local boxName = 'houseRobberyEntrance_' .. v.id

        exports['ps-zones']:CreateBoxZone(boxName, coords, 2, 1, {
          name = boxName,
          heading = v.heading,
          debugPoly = false,
          minZ = v.z - 1.5,
          maxZ = v.z + 1.5,
          data = {
            isPoliceHouseRobbery = true,
            houseIndex = v.id
          }
        })

        createPoliceZones(vector3(v.x, v.y, v.z + v.zOffset), v)
      end
    end)
  end
end)

local function createBlipForGroup()
  if propertyToRob ~= nil then
    local propertyToRobLocation = vector4(propertyToRob.x, propertyToRob.y, propertyToRob.z, 1.0)
    return {
      coords = propertyToRobLocation,
      color = 49,
      sprite = 57,
      label = propertyToRob.info
    }
  end
end

local function loadAnimDict(dict)
  while (not HasAnimDictLoaded(dict)) do
      RequestAnimDict(dict)
      Wait(5)
  end
end

local function createRobberyZones(spawnCoords, building)
  local xpos = spawnCoords.x
  local ypos = spawnCoords.y
  local zpos = spawnCoords.z

  local zonesToCreate = Config.robbableArea[building]
  for _, v in pairs(zonesToCreate) do
    local x = xpos + v.xoff
    local y = ypos + v.yoff
    local z = zpos + v.zoff

    if v.type == "exit" then
      exports['qb-target']:AddBoxZone(v.zoneName, vector3(x, y, z), 0.75, 1.05, {
        name = v.zoneName,
        heading = v.heading,
        debugPoly = false,
        minZ = z - 0.25,
        maxZ = z + 0.5
      }, {
        options = {
          {
            type = "client",
            event = "gems-houserobbery:client:exitHouse",
            icon = "fas fa-door",
            label = "Exit"
          }
        },
        distance = 1.5
      })
    elseif v.type == "pickup" then
      exports['qb-target']:AddBoxZone(v.zoneName, vector3(x, y, z), 0.75, 1.05, {
        name = v.zoneName,
        heading = v.heading,
        debugPoly = false,
        minZ = z - 0.25,
        maxZ = z + 0.25
      }, {
        options = {
          {
            type = "client",
            event = "gems-houserobbery:client:" ..v.zoneName,
            icon = "fas fa-mask",
            label = "Pick up",
            zone = v.zoneName
          }
        },
        distance = 1.5
      })
    else
      exports['qb-target']:AddBoxZone(v.zoneName, vector3(x, y, z), 0.75, 1.05, {
        name = v.zoneName,
        heading = v.heading,
        debugPoly = false,
        minZ = z - 0.25,
        maxZ = z + 0.25
      }, {
        options = {
          {
            type = "client",
            event = "gems-houserobbery:client:searchArea",
            icon = "fas fa-mask",
            label = "Search",
            zone = v.zoneName
          }
        },
        distance = 1.5
      })
    end
  end
end

function randomAI(generator)
local modelhash = GetHashKey("a_m_m_beach_02")
RequestModel(modelhash)

while not HasModelLoaded(modelhash) do
  Citizen.Wait(0)
end

local airoll = math.random(5)
if airoll == 1 then
  robberyped = CreatePed(GetPedType(modelhash), modelhash, generator.x+6.86376900,generator.y+1.20651200,generator.z+1.36589100, 15.0, 1, 1)
  SetEntityCoords(robberyped, generator.x+6.86376900, generator.y+1.20651200, generator.z+1.36589100)
  SetEntityHeading(robberyped, 80.0)
  SetEntityAsMissionEntity(robberyped, false, true)
  loadAnimDict("dead")
  TaskPlayAnim(robberyped, "dead", 'dead_a', 100.0, 1.0, -1, 1, 0, 0, 0, 0)
  pedSpawned = true
elseif airoll == 2 then
  robberyped = CreatePed(GetPedType(modelhash), modelhash, generator.x+6.86376900,generator.y+1.20651200,generator.z+1.36589100, 15.0, 1, 1)
  SetEntityCoords(robberyped, generator.x-1.48765600, generator.y+1.68100600, generator.z+1.21640500)
  SetEntityHeading(robberyped, 190.0)
  SetEntityAsMissionEntity(robberyped, false, true)
  loadAnimDict("dead")
  TaskPlayAnim(robberyped, "dead", 'dead_b', 100.0, 1.0, -1, 1, 0, 0, 0, 0)
  pedSpawned = true
end
end

RegisterNetEvent('gems-houserobbery:client:setPropertyToRob', function(propertyDetails, propertyIndex)
  propertyId = propertyIndex
  propertyToRob = propertyDetails
end)

RegisterNetEvent('gems-houserobbery:client:setStage', function(lstages)
  stages = lstages
end)

local function createCircleZone()
  local propertyToRobLocation = vector3(propertyToRob.x, propertyToRob.y, propertyToRob.z)
  exports['ps-zones']:CreateCircleZone('propertyToRobZone', propertyToRobLocation, 10.0, {
    debugPoly = false,
    minZ = propertyToRob.z - 5,
    maxZ = propertyToRob.z + 5
  })
end

function CloseMenuFull()
  exports['qb-menu']:closeMenu()
end

local function createDoorTarget()
  if propertyToRob ~= nil then
    local coords = vector3(propertyToRob.x, propertyToRob.y, propertyToRob.z)
    local boxName = 'houseRobberyEntrance_' .. propertyToRob.id

    exports['ps-zones']:CreateBoxZone(boxName, coords, 2, 1, {
      name = boxName,
      heading = propertyToRob.heading,
      debugPoly = false,
      minZ = propertyToRob.z - 1.5,
      maxZ = propertyToRob.z + 1.5,
    })
  end
end

RegisterNetEvent('gems-houserobbery:client:createTargetsAndZone', function()
  createCircleZone()
  createDoorTarget()
end)

RegisterNetEvent('gems-houserobbery:client:alertPD', function()
  local roll = math.random(1, 100)
  if Config.PoliceChance > roll then
    exports['ps-dispatch']:HouseRobbery()
  end
end)

RegisterNetEvent("ps-zones:enter", function(ZoneName, ZoneData)
  if ZoneName == "propertyToRobZone" then
    if stages[1].isDone ~= true then
      QBCore.Functions.TriggerCallback('gems-houserobbery:server:getGroupByMembers', function(group)
        stages[1].isDone = true
        Wait(300)
        TriggerServerEvent('gems-houserobbery:server:setJobStatus', group, stages)
        TriggerServerEvent('gems-houserobbery:server:setGroupStage', group, stages)
        TriggerServerEvent('gems-houserobbery:server:removeBlipForGroup', group, propertyToRob.info)
        TriggerServerEvent('gems-houserobbery:server:notifiyGroup', group, "Break into " ..propertyToRob.info)
      end)
    end
  end

  if ZoneName == "burglaryHandBack" then
    if stages then 
      if stages[3].isDone == true then
        QBCore.Functions.TriggerCallback('gems-houserobbery:server:getGroupByMembers', function(group)
          stages[4].isDone = true
          TriggerServerEvent('gems-houserobbery:server:setJobStatus', group, stages)
          TriggerServerEvent('gems-houserobbery:server:setGroupStage', group, stages)
          TriggerServerEvent('gems-houserobbery:server:notifiyGroup', group, "Myung is happy with your work")
          TriggerServerEvent('gems-houserobbery:server:rewards', group, propertyToRob)
          if HouseObj then
            exports['qb-interior']:DespawnInterior(HouseObj, function() end)
          end
        end)
      end
    end
  end

  if propertyToRob then
    if ZoneName == "houseRobberyEntrance_" .. propertyToRob.id then
      showEntranceHeaderMenu(propertyToRob.id)
    end
  end

  if ZoneData.isPoliceHouseRobbery then
    QBCore.Functions.TriggerCallback('gems-houserobbery:server:getAllHouses', function (houses)
      local property = houses[ZoneData.houseIndex]
      if property.isOpen then
        showEntranceHeaderMenu(ZoneData.houseIndex)
      end
    end)
  end

end)

local function GetPropertyData(house)
  local interiorType = house.building
  local data = nil;
  if interiorType == 'furnitured_midapart' then
    data = exports['qb-interior']:CreateApartmentFurnished(vector3(house.x, house.y, house.z + house.zOffset))
    return data;
  elseif interiorType == 'furnished_lowerpart' then
    data = exports['qb-interior']:CreateFurniLow(vector3(house.x, house.y, house.z + house.zOffset))
    return data;
  else
    return data;
  end
end

local function EnterProperty(house)
  TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.1)
        DoScreenFadeOut(100)
        local data = GetPropertyData(house)
        HouseObj = data[1]
        POIOffsets = data[2]
        Wait(100)
        FreezeEntityPosition(PlayerPedId(), true)
        Citizen.Wait(500)
        Wait(500)
        TriggerEvent('qb-weathersync:client:DisableSync')
        Wait(100)
        SetEntityHeading(PlayerPedId(), 358.106)
        FreezeEntityPosition(PlayerPedId(),false)
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_close", 0.1)
        DoScreenFadeIn(100)
        Wait(100)
end

local house = nil
local function lockpickFinish1(success)
  local src = source
	local willbreak = math.random(1,10)
	if willbreak == 3 then
		QBCore.Functions.Notify('Your Lockpick Broke', 'error')
		TriggerServerEvent('gems-houserobbery:server:RemoveItem', 'houselockpick', 1)
	end
    if success then
      QBCore.Functions.TriggerCallback('gems-houserobbery:server:getGroupByMembers', function(group)
        stages[2].isDone = true
        TriggerServerEvent('gems-houserobbery:server:setJobStatus', group, stages)
        TriggerServerEvent('gems-houserobbery:server:setGroupStage', group, stages)
        TriggerServerEvent('gems-houserobbery:server:setLockpickId', propertyId, src)
        TriggerServerEvent('gems-houserobbery:server:createHouseForGroup', group, propertyId)
        TriggerServerEvent('gems-houserobbery:server:setIsOpen', propertyId, true)
        TriggerEvent('gems-houserobbery:client:alertPD')
        EnterProperty(house)
      end)
	end
end

RegisterNetEvent('gems-houserobbery:client:pickDoor', function()
  if propertyToRob then
    local propId = propertyToRob.id
    local Player = QBCore.Functions.GetPlayerData()
    QBCore.Functions.TriggerCallback('gems-houserobbery:server:getHouseDetailsByIndex', function(houseDetail)
    house = houseDetail
      if house.isOpen then
        EnterProperty(house)
      else
        local result = QBCore.Functions.HasItem('houselockpick')
        if result then
          exports['ps-ui']:Circle(lockpickFinish1, math.random(2,4), math.random(10,15))
        else
          QBCore.Functions.Notify("You don't have a strong enough lockpick!", "error")
        end
      end
    end, propId)
  else
    QBCore.Functions.Notify('You cannot enter this house', 'error')
  end
end)

RegisterNetEvent('gems-houserobbery:client:enterHouse', function (args)
  QBCore.Functions.TriggerCallback('gems-houserobbery:server:getHouseDetailsByIndex', function(houseDetail)
    if HouseObj then
      exports['qb-interior']:DespawnInterior(HouseObj, function() end)
    end
    local house = houseDetail
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.1)
    DoScreenFadeOut(100)
    local data = GetPropertyData(house)
    HouseObj = data[1]
    POIOffsets = data[2]
    Wait(100)
    FreezeEntityPosition(PlayerPedId(), true)
    Wait(500)
    TriggerEvent('qb-weathersync:client:DisableSync')
    Wait(100)
    SetEntityHeading(PlayerPedId(), 358.106)
    FreezeEntityPosition(PlayerPedId(),false)
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_close", 0.1)
    DoScreenFadeIn(100)
    Wait(100)
  end, args.propertyId)
end)

RegisterNetEvent('gems-houserobbery:client:createHouse', function (id, isPolice)
  QBCore.Functions.TriggerCallback('gems-houserobbery:server:getHouseDetailsByIndex', function(propertyDetails)
        if HouseObj then
          exports['qb-interior']:DespawnInterior(HouseObj, function() end)
        end
        local house = propertyDetails
        if id == house.lockpickId then
          DoScreenFadeOut(100)
            Wait(100)
            createRobberyZones(vector3(house.x, house.y, house.z - house.zOffset), house.building)
            Wait(3000)
            randomAI({x = house.x, y = house.y, z = house.z + house.zOffset})
            DoScreenFadeIn(100)
            Wait(100)
        else
          if not isPolice then
            createRobberyZones(vector3(house.x, house.y, house.z + house.zOffset), house.building)
          end
          Wait(3000)
        end
    end, id)
end)

RegisterNetEvent('gems-houserobbery:client:startHouseRobbery', function()
  local src = source
  local ped = PlayerPedId()
  local player = QBCore.Functions.GetPlayerData() -- Get Player information
  stages = Config.stages
  QBCore.Functions.TriggerCallback('gems-houserobbery:server:getPoliceCount', function (policeCount)
        if policeCount >= Config.MinPolice then
          QBCore.Functions.TriggerCallback('gems-houserobbery:server:getGroupByMembers', function(group) -- This checks the qb-phone export and returns the groupId that the player is in
            if group ~= nil then -- Checks the groupId and makes sure that the player is in a group
              activeGroup = group
              QBCore.Functions.TriggerCallback('gems-houserobbery:server:getGroupSize', function(groupSize) -- This takes the groupId, looks at the amount of players in a group
                if groupSize > 2 then -- This checks that thre group isn't over size - The developer makes the decision on how many people can be in on the job 
                  QBCore.Functions.Notify("Max group size is 2")
                else
                  QBCore.Functions.TriggerCallback('gems-houserobbery:server:getGroupLeader', function(leader) -- This gets the source id of the group leader
                    if player.source ~= leader then -- This checks that the player starting the job is the group leader
                      QBCore.Functions.Notify("You are not the group leader", "error") 
                    else
                      TriggerServerEvent('gems-houserobbery:server:notifiyGroup', group, "Please wait to be offered a job") -- This sends a notification to the group 
              Wait(math.random(Config.WaitTime.min, Config.WaitTime.max))
                      local success = exports['qb-phone']:PhoneNotification( -- This sends a notification to the group leader a waits on them accepting or declining the job
                        "BURGLARY",
                        "Accept burglary Work",
                        "fas fa-mask",
                        "#808080",
                        "NONE",
                        'fas fa-check-circle',
                        'fas fa-times-circle'
                      )
                      if success then -- if the job is accepted then 
                        QBCore.Functions.TriggerCallback('gems-houserobbery:server:getHouseDetails', function(propertyDetails)
                          propertyId = propertyDetails.id
                          propertyToRob = propertyDetails
                          if stages then -- This is a check the stages variable has data
                            stages[1].name = "Drive to " ..propertyToRob.info -- This is how you update the values in the stages variable
                            stages[2].name = "Break into " ..propertyToRob.info
                            local blip = createBlipForGroup() -- This will take the information of the propertyToRob and pick it's vector values and create a blip object
                            TriggerServerEvent('gems-houserobbery:server:setJobStatus', group, stages) -- This updates the group status, this is what is used to ensure that the group cannot do multiple jobs at once
                            TriggerServerEvent('gems-houserobbery:server:setGroupStage', group, stages) -- This updates everyones local version of the stages so every one in thr group is on the same stage
                            TriggerServerEvent('gems-houserobbery:server:createDoorTargetForGroup', group, propertyToRob, propertyId) -- This takes the coords and creates a box zone on the door of the propertyToRob
                            TriggerServerEvent('gems-houserobbery:server:createBlipForGroup', group, propertyToRob.info, blip) -- This takes the blip we created earlier and sends it to the group
                          end
                        end)
                      end
                    end
                  end, group)
                end
              end, group)
            else
              QBCore.Functions.Notify('You need to be in a group', 'error')
            end
          end)
        else
          QBCore.Functions.Notify('Not enough cops', 'error')
        end
  end)
end)

local function SearchArea(boxZoneName)
  QBCore.Functions.Progressbar("search_burglary", "Searching...", 15000, false, true, {
    disableMovement = true,
    disableCarMovement = true,
    disableMouse = false,
    disableCombat = true,
  }, {
    animDict = "missexile3",
    anim = "ex03_dingy_search_case_a_michael",
    flags = 8,
  }, {}, {}, function() -- Done
    StopAnimTask(PlayerPedId(), "missexile3", "exit", 1.0)
    if boxZoneName == "microZone" or boxZoneName == "tvZone" then
      if boxZoneName == "microZone" then
        TriggerServerEvent('gems-houserobbery:server:AddItem', 'microwave', 1)
      end
      if boxZoneName == "tvZone" then
        TriggerServerEvent('gems-houserobbery:server:AddItem', 'television', 1)
      end
    else
      local item = Config.robbableItems[math.random(1, #Config.robbableItems)]
      TriggerServerEvent('gems-houserobbery:server:AddItem', item.name, math.random(item.amount.min, item.amount.max))
      Wait(100)
      local midRoll = math.random(1, 100)
      if midRoll < Config.MidLevelDropChance then
        local midItem = Config.midLevelRobbableItems[math.random(1, #Config.midLevelRobbableItems)]
        TriggerServerEvent('gems-houserobbery:server:AddItem', midItem.name, math.random(midItem.amount.min, midItem.amount.max))
      end
      Wait(100)
      local highEndRoll = math.random(1, 100)
      if highEndRoll < Config.HighEndDropChance then
        local highEndItem = Config.highEndRobbaleItems[math.random(1, #Config.highEndRobbaleItems)]
        TriggerServerEvent('gems-houserobbery:server:AddItem', highEndItem, 1)
      end
    end
    QBCore.Functions.TriggerCallback('gems-houserobbery:server:getGroupByMembers', function(group)
      stages[3].count = stages[3].count + 1
      if stages[3].count >= Config.AmountToSteal then
        stages[3].isDone = true
        TriggerServerEvent('gems-houserobbery:server:setJobStatus', group, stages)
        local dropOffMessage = "Leave the house and return to Myung"
        TriggerServerEvent('gems-houserobbery:server:notifiyGroup', group, dropOffMessage)
        TriggerServerEvent('gems-houserobbery:server:setGroupStage', group, stages)
        TriggerServerEvent('gems-houserobbery:server:startHandback', group)
      else
        local message = "Steal goods ("..stages[3].count.."/"..Config.AmountToSteal..")"
        TriggerServerEvent('gems-houserobbery:server:setJobStatus', group, stages)
        TriggerServerEvent('gems-houserobbery:server:notifiyGroup', group, message)
        TriggerServerEvent('gems-houserobbery:server:setGroupStage', group, stages)
      end
    end)
    exports['qb-target']:RemoveZone(boxZoneName)
  end, function() -- Cancel
    StopAnimTask(PlayerPedId(), "ex03_dingy_search_case_a_michael", "exit", 1.0)
    QBCore.Functions.Notify("Cancelled", "error")
  end, "fa-regular fa-sack-dollar")
end

RegisterNetEvent('gems-houserobbery:client:searchArea', function(args)
  SearchArea(args.zone)
end)

RegisterNetEvent('gems-houserobbery:client:microZone', function(args)
  SearchArea(args.zone)
end)

RegisterNetEvent('gems-houserobbery:client:tvZone', function(args)
  SearchArea(args.zone)
end)

RegisterNetEvent('gems-houserobbery:client:exitHouse', function(args)
    local house = propertyToRob
    if args.propId then
      house = AllPoliceHouses[args.propId]
    end
    DoScreenFadeOut(100)
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.1)
    Citizen.Wait(100)
    FreezeEntityPosition(PlayerPedId(), true)
    TriggerEvent('qb-weathersync:client:EnableSync')
    Citizen.Wait(1000)
    SetEntityCoords(PlayerPedId(), house.x, house.y, house.z)
    FreezeEntityPosition(PlayerPedId(), false)
    Citizen.Wait(500)
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_close", 0.1)
    DoScreenFadeIn(100)
    Citizen.Wait(100)
    -- We need to despawn the interior when the job is finished?
    local Player = QBCore.Functions.GetPlayerData()
    if Player.job.name == "police" then
      exports['qb-interior']:DespawnInterior(HouseObj, function() end)
    end
end)

RegisterNetEvent('gems-houserobbery:client:startHandback', function()
  exports['ps-zones']:CreateCircleZone('burglaryHandBack', vector3(568.45, -1577.03, 28.29), 5.0, {
    debugPoly = false,
    minZ = 23.0,
    maxZ = 28.0
  })
end)

RegisterNetEvent('gems-hosuerobbery:client:DestroyDropOffZones', function()
  exports['ps-zones']:DestroyZone("houseRobberyEntrance_" .. propertyToRob.id)
  exports['ps-zones']:DestroyZone('propertyToRobZone')
  exports['ps-zones']:DestroyZone('burglaryHandBack')
  exports['qb-interior']:DespawnInterior(HouseObj, function() end)
end)



--Event Handlers

AddEventHandler('onResourceStop', function(resource)
  if resource == GetCurrentResourceName() then
      if HouseObj ~= nil then
          exports['qb-interior']:DespawnInterior(HouseObj, function()
            local house = propertyToRob
            DoScreenFadeOut(100)
            Citizen.Wait(100)
            FreezeEntityPosition(PlayerPedId(), true)
            Citizen.Wait(1000)
            SetEntityCoords(PlayerPedId(), house.x, house.y, house.z)
            FreezeEntityPosition(PlayerPedId(), false)
            Citizen.Wait(500)
            DoScreenFadeIn(100)
            Citizen.Wait(100)
          end)
      end
  end
end)