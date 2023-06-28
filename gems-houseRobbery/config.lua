Config = {}

Config.MidLevelDropChance = 35

Config.HighEndDropChance = 4

Config.AmountToSteal = 5

Config.psbuffs = false

Config.isCGH = false

Config.stages = {
    [1] = {name = "Drive to the house", isDone = false, id=1},
    [2] = {name = "Break into the house", isDone = false, id=2},
    [3] = {name = "Steal some stuff", isDone = false, count=0, max=Config.AmountToSteal, id=3},
    [4] = {name = "Head back to Myung", isDone = false, id=4},
  }

Config.robbableItems = {
    [1] = {name = "samsungphone", amount = {min = 1, max = 2}},
    [2] = {name = "iphone", amount = {min = 1, max = 2}},
    [3] = {name = "bandage", amount = {min = 1, max = 2}},
    [4] = {name = "diamond_ring", amount = {min = 1, max = 2}},
    [5] = {name = "goldchain", amount = {min = 1, max = 2}},
    [6] = {name = "rolex", amount = {min = 1, max = 2}},
    [7] = {name = "lockpick", amount = {min = 1, max = 2}},
    [8] = {name = "pistol_ammo", amount = {min = 1, max = 2}},
    [9] = {name = "kitchencleaner", amount = {min = 1, max = 2}},
    [10] = {name = "proteinpowder", amount = {min = 1, max = 2}},
    [11] = {name = "3gjoint", amount = {min = 2, max = 3}},
    [12] = {name = 'steel', amount = {min = 1, max = 3}},
    [13] = {name = 'plastic', amount = {min = 1, max = 3}},
    [14] = {name = 'electronics', amount = {min = 1, max = 3}},
}

Config.midLevelRobbableItems = {
    [1] = {name = "houselockpick", amount = {min = 1, max = 2}},
    [2] = {name = "pistolparts", amount = {min = 1, max = 2}},
    [3] = {name = "shotgunparts", amount = {min = 1, max = 1}},
    [4] = {name = "diamondcard", amount = {min = 1, max = 1}},
    [5] = {name = "diamonddrillbit", amount = {min = 1, max = 1}},
    [6] = {name = "rolls", amount = {min = 10, max = 12}},
    [7] = {name = "cryptostick", amount = {min = 1, max = 3}},
    [8] = {name = "goldstorecard", amount = {min = 1, max = 1}},
    [9] = {name = "smgparts", amount = {min = 1, max = 1}}
}

Config.highEndRobbaleItems = {
    [1] = "goldbar",
    [2] = "diamondusb",
    [3] = "diamondgps",
    [4] = "yachtheistcard",
    [5] = "c4"
}

Config.robbableArea = {
    ['furnitured_midapart'] = {
        {zoneName = "exitZone", xoff = 1.40550000000007, yoff = -10.4817999999998, zoff = 1.070599999999999, type = "exit", heading = 90},
        {zoneName = "drawer2Zone", xoff = 0.545000000000073, yoff = 1.70269999999999, zoff = 0.4118, heading = 180},
        {zoneName = "stashBoxZone", xoff = 7.28620000000001, yoff = 3.99660000000006, zoff = 0.555900000000001, heading = 90},
        {zoneName = "bedroomDrawersZone", xoff = 6.13189999999997, yoff = 3.31470000000002, zoff = 0.917400000000001, heading = 180},
        {zoneName = "bedsideDrawersZone", xoff = 3.80849999999998, yoff = 7.87270000000001, zoff = 0.754300000000001, heading = 90},
        {zoneName = "wardrobeZone", xoff = 6.0104, yoff = 9.63409999999999, zoff = 1.1231, heading = 180},
        {zoneName = "rightShelfZone", xoff = 0.535999999999945, yoff = 5.95000000000005, zoff = 0.657800000000002, heading = 90},
        {zoneName = "leftShelfZone", xoff = 0.535999999999945, yoff = 9.00110000000007, zoff = 1.4174, heading = 90},
        {zoneName = "coffeeTableZone", xoff = -3.66610000000003, yoff = 6.55799999999999, zoff = 0.520300000000002, heading = 90},
        {zoneName = "tvStandZone", xoff = -7.25659999999994, yoff = 6.1866, zoff = 0.520300000000002, heading = 90},
        {zoneName = "tvZone", xoff = -7.25659999999994, yoff = 6.21180000000004, zoff = 1.5275, type = "pickup", heading = 90},
        {zoneName = "diningRoomZone", xoff = -5.72980000000007, yoff = 1.5403, zoff = 0.750800000000002, heading = 90},
        {zoneName = "microZone", xoff = -0.525600000000054, yoff = 0.754999999999996, zoff = 1.1324, type = "pickup", heading = 180}
    },
    ['furnished_lowerpart'] = {
        {zoneName = "exitZone", xoff = 4.96080000000001, yoff = -1.65660000000003, zoff = 3.2923, type = "exit", heading = 90},
        {zoneName = "stashZone", xoff = 6.02780000000001, yoff = -0.022899999999936, zoff = 2.8846, heading = 90},
        {zoneName = "cupboardZone", xoff = 3.82850000000002, yoff = 5.02099999999996, zoff = 3.53, heading = 180},
        {zoneName = "cupboard2Zone", xoff = 5.8877, yoff = 3.04369999999994, zoff = 2.623, heading = 90},
        {zoneName = "tvStandZone", xoff = -3.29569999999995, yoff = 4.35040000000004, zoff = 2.3175, heading = 226},
        {zoneName = "bedsideDrawers", xoff = 1.21250000000003, yoff = -2.38210000000004, zoff = 2.5005, heading = 180},
        {zoneName = "bed", xoff = 2.28520000000003, yoff = -4.16570000000002, zoff = 2.5842, heading = 90},
        {zoneName = "bathroomPlant", xoff = -3.34479999999996, yoff = -1.69749999999999, zoff = 3.092, heading = 90},
        {zoneName = "shelves", xoff = 2.09520000000003, yoff = 4.6853000000001, zoff = 2.938, heading = 90},
    },
    ['classicmotel_shell'] = {
        
    }
}

Config.PoliceChance = 30

Config.WaitTime = {min = 10 * 1000, max = 25 * 1000}

Config.MinPolice = 0
