# gems-houserobbery
qb-core house robbery script compatible with renewed phone

Should be a drop and drag, I wouldn't change stages or robbableArea in this but you will have to add your own items to the robbableItems/midLevelRobbableItems/highEndRobbableItems

I've written this script for the CGH RP server at https://discord.gg/cgh2022 welcome to apply and look at other bespoke scripts but I won't really be supporting this as it's written for a specific server and it works fine there.

If you make any improvements feel free to put in a PR :)


Add the below to your init.lua for qb-target

	{
		model = "g_m_y_korean_01",
		coords = vector4(568.45, -1577.03, 27.29, 217.66),
		gender = 'male',
		freeze = true,
		invincible = true,
		blockevents = true,
		scenario = 'WORLD_HUMAN_CLIPBOARD',
		target = {
            options = {
                {
                    event = "gems-houserobbery:client:startHouseRobbery",
                    icon = "fas fa-mask",
                    label = "Sign into burglary",
                }
            },
           distance = 2.5
        }
	},


If using Renewed-Weaponscarry you can add this below code to your local props in the main.lua file and the players will hold the television/microwave they rob from properties

  ["television"] =  { carry = true, model = "prop_tv_flat_02", bone = 28422, x = 0.0, y = -0.1, z = 0.1, xr = 0.0,
  yr = 0.0, zr = -0.0, blockAttack = true, blockCar = true, blockRun = true },
  ["microwave"] =  { carry = true, model = "prop_micro_02", bone = 28422, x = 0.0, y = -0.1, z = 0.03, xr = 0.0,
  yr = 0.0, zr = -0.0, blockAttack = true, blockCar = true, blockRun = true },
  television
