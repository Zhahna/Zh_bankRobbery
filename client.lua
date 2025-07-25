-------------------------
--- NDBankRobbery ---
-------------------------

robberyActive = false
RegisterNetEvent('NDBankRobbery:IsActive:Return')
AddEventHandler('NDBankRobbery:IsActive:Return', function(bool)
	robberyActive = bool
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if not robberyActive then
			if (config.enableBanks == true) then
				for _, bankcoords in pairs(config.bankcoords) do
				DrawMarker(27, bankcoords.x, bankcoords.y, bankcoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, .2, 255, 0, 0, 255, false, true, 2, false, nil, nil, false)
				end
			end

			if (config.enableAmmunations == true) then
				for _, ammunationcoords in pairs(config.ammunationcoords) do
				DrawMarker(27, ammunationcoords.x, ammunationcoords.y, ammunationcoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, .2, 255, 0, 0, 255, false, true, 2, false, nil, nil, false)
				end
			end

			if (config.enable247 == true) then
				for _, shopcoords in pairs(config.shopcoords) do
				DrawMarker(27, shopcoords.x, shopcoords.y, shopcoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, .2, 255, 0, 0, 255, false, true, 2, false, nil, nil, false)
				end
			end

			if (config.enableGasStations == true) then
				for _, ltdcoords in pairs(config.ltdcoords) do
				DrawMarker(27, ltdcoords.x, ltdcoords.y, ltdcoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, .2, 255, 0, 0, 255, false, true, 2, false, nil, nil, false)
				end
			end

			if (config.enableLiquor == true) then
				for _, liquorcoords in pairs(config.liquorcoords) do
				DrawMarker(27, liquorcoords.x, liquorcoords.y, liquorcoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, .2, 255, 0, 0, 255, false, true, 2, false, nil, nil, false)
				end
			end

			-- Bank Code
			local coords = GetEntityCoords(GetPlayerPed(-1))
			for _, bankcoords in pairs(config.bankcoords) do
			if (config.enableBanks == true) then
				if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, bankcoords.x, bankcoords.y, bankcoords.z, true) < 2.0 then
					DisplayNotification('~r~Press the ~w~E ~r~key to rob the bank')
					if IsControlJustReleased(0, 38) then -- E key
						TriggerServerEvent('NDBankRobbery:SetActive', true)
						TriggerServerEvent('PrintBR:PrintMessage', bankcoords.alarm)
						if (config.displayBlips == true) then
							bankcoords.blip = AddBlipForCoord(bankcoords.x, bankcoords.y, bankcoords.z)
							SetBlipSprite(bankcoords.blip, 353)
							SetBlipFlashTimer(bankcoords.blip, 1000 * config.timeToRob)
							SetBlipAsShortRange(bankcoords.blip, true)
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString(bankcoords.name)
							EndTextCommandSetBlipName(bankcoords.blip)
						end
						exports['mythic_notify']:DoHudText('inform', 'Robbery in progres!', { ['background-color'] = '#0737f7', ['color'] = '#ef2f2f' })
						
						TriggerEvent("mythic_progbar:client:progress", {
							name = "SafeRobbery",
							duration = 12000,
							label = "Cracking Safe and Grabbing Money",
							useWhileDead = false,
							canCancel = true,
							controlDisables = {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true,
							},
							animation = {
								animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
								anim = "machinic_loop_mechandplayer",
								flags = 49,
							},
							prop = {
								model = "prop_ing_crowbar",
							}
						}, function(status)
							if not status and not IsEntityDead(GetPlayerPed(-1)) then
								exports['mythic_notify']:DoHudText('inform', 'Robbery in progres!', { ['background-color'] = '#0737f7', ['color'] = '#ef2f2f' })

								--DisplayNotification('~g~Success: You have robbed the Bank successfully!')
								TriggerServerEvent('PrintBR:PrintMessage', config.robberySuccess)
								TriggerServerEvent('GiveRewardBank', true)
							else
								DisplayNotification('~r~Failed: Your Bank robbery has failed.')
								TriggerServerEvent('PrintBR:PrintMessage', config.robberyFailed)
							end	
						end)
						Wait(1000 * config.timeToRob)
						RemoveBlip(bankcoords.blip)
					end
				end
			end
			end

			-- Ammunation Code
			for _, ammunationcoords in pairs(config.ammunationcoords) do
			if (config.enableAmmunations == true) then
				if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, ammunationcoords.x, ammunationcoords.y, ammunationcoords.z) < 1.0 then
					DisplayNotification('~r~Press the ~w~E ~r~key to rob the Ammunation')
					if IsControlJustReleased(0, 38) then -- E
						TriggerServerEvent('PrintBR:PrintMessage', ammunationcoords.alarm)
						TriggerServerEvent('NDBankRobbery:SetActive', true)
						if (config.displayBlips == true) then
							ammunationcoords.blip = AddBlipForCoord(ammunationcoords.x, ammunationcoords.y, ammunationcoords.z)
							SetBlipSprite(ammunationcoords.blip, 353)
							SetBlipFlashTimer(ammunationcoords.blip, 1000 * config.timeToRob)
							SetBlipAsShortRange(ammunationcoords.blip, true)
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString(ammunationcoords.name)
							EndTextCommandSetBlipName(ammunationcoords.blip)
						end
						exports['mythic_notify']:DoHudText('inform', 'Robbery in progres!', { ['background-color'] = '#0737f7', ['color'] = '#ef2f2f' })

						TriggerEvent("mythic_progbar:client:progress", {
							name = "SafeRobbery",
							duration = 60000,
							label = "Cracking Safe and Grabbing Money",
							useWhileDead = false,
							canCancel = false,
							controlDisables = {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true,
							},
							animation = {
								animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
								anim = "machinic_loop_mechandplayer",
								flags = 49,
							},
							prop = {
								model = "prop_ing_crowbar",
							}
						}, function(status)
							if not status and not IsEntityDead(GetPlayerPed(-1)) then
								exports['mythic_notify']:DoHudText('inform', 'Robbery in progres!', { ['background-color'] = '#0737f7', ['color'] = '#ef2f2f' })

								--DisplayNotification('~g~Success: You have robbed the Ammunation successfully!')
								TriggerServerEvent('PrintBR:PrintMessage', config.robberySuccess)
								TriggerServerEvent('GiveRewardAmmo', true)
							else
								DisplayNotification('~r~Failed: Your Ammunation robbery has failed.')
								TriggerServerEvent('PrintBR:PrintMessage', config.robberyFailed)
							end
						end)
						Wait(1000 * config.timeToRob)
						RemoveBlip(ammunationcoords.blip)
					end
				end
			end
			end

			-- 24/7 Code
			for _, shopcoords in pairs(config.shopcoords) do
			if (config.enable247 == true) then
				if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, shopcoords.x, shopcoords.y, shopcoords.z) < 1.0 then
					DisplayNotification('~r~Press the ~w~E ~r~key to rob the 24/7')
					if IsControlJustReleased(0, 38) then -- E
						TriggerServerEvent('PrintBR:PrintMessage', shopcoords.alarm)
						TriggerServerEvent('NDBankRobbery:SetActive', true)
						if (config.displayBlips == true) then
							shopcoords.blip = AddBlipForCoord(shopcoords.x, shopcoords.y, shopcoords.z)
							SetBlipSprite(shopcoords.blip, 353)
							SetBlipFlashTimer(shopcoords.blip, 1000 * config.timeToRob)
							SetBlipAsShortRange(shopcoords.blip, true)
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString(shopcoords.name)
							EndTextCommandSetBlipName(shopcoords.blip)
						end
						exports['mythic_notify']:DoHudText('inform', 'Robbery in progres!', { ['background-color'] = '#0737f7', ['color'] = '#ef2f2f' })

						TriggerEvent("mythic_progbar:client:progress", {
							name = "SafeRobbery",
							duration = 60000,
							label = "Cracking Safe and Grabbing Money",
							useWhileDead = false,
							canCancel = false,
							controlDisables = {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true,
							},
							animation = {
								animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
								anim = "machinic_loop_mechandplayer",
								flags = 49,
							},
							prop = {
								model = "prop_ing_crowbar",
							}
						}, function(status)
							if not status and not IsEntityDead(GetPlayerPed(-1)) then
								exports['mythic_notify']:DoHudText('inform', 'Robbery in progres!', { ['background-color'] = '#0737f7', ['color'] = '#ef2f2f' })

								--DisplayNotification('~g~Success: You have robbed the 24/7 successfully!')
								TriggerServerEvent('PrintBR:PrintMessage', config.robberySuccess)
								TriggerServerEvent('GiveReward247', true)
							else
								DisplayNotification('~r~Failed: Your 24/7 robbery has failed.')
								TriggerServerEvent('PrintBR:PrintMessage', config.robberyFailed)
							end
						end)
						Wait(1000 * config.timeToRob)
						RemoveBlip(shopcoords.blip)
					end
				end
			end
			end

			-- LTD Code
			for _, ltdcoords in pairs(config.ltdcoords) do
			if (config.enableGasStations == true) then
				if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, ltdcoords.x, ltdcoords.y, ltdcoords.z) < 1.0 then
					DisplayNotification('~r~Press the ~w~E ~r~key to rob the LTD Gas Station')
					if IsControlJustReleased(0, 38) then -- E
						TriggerServerEvent('PrintBR:PrintMessage', ltdcoords.alarm)
						TriggerServerEvent('NDBankRobbery:SetActive', true)
						if (config.displayBlips == true) then
							ltdcoords.blip = AddBlipForCoord(ltdcoords.x, ltdcoords.y, ltdcoords.z)
							SetBlipSprite(ltdcoords.blip, 353)
							SetBlipFlashTimer(ltdcoords.blip, 1000 * config.timeToRob)
							SetBlipAsShortRange(ltdcoords.blip, true)
							BeginTextCommandSetBlipName("STRING")
							AddTextComponentString(ltdcoords.name)
							EndTextCommandSetBlipName(ltdcoords.blip)
						end
						exports['mythic_notify']:DoHudText('inform', 'Robbery in progres!', { ['background-color'] = '#0737f7', ['color'] = '#ef2f2f' })

						TriggerEvent("mythic_progbar:client:progress", {
							name = "SafeRobbery",
							duration = 60000,
							label = "Cracking Safe and Grabbing Money",
							useWhileDead = false,
							canCancel = false,
							controlDisables = {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true,
							},
							animation = {
								animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
								anim = "machinic_loop_mechandplayer",
								flags = 49,
							},
							prop = {
								model = "prop_ing_crowbar",
							}
						}, function(status)
							if not status and not IsEntityDead(GetPlayerPed(-1)) then
								exports['mythic_notify']:DoHudText('inform', 'Robbery in progres!', { ['background-color'] = '#0737f7', ['color'] = '#ef2f2f' })

								--DisplayNotification('~g~Success: You have robbed the LTD Gas Station successfully!')
								TriggerServerEvent('PrintBR:PrintMessage', config.robberySuccess)
								TriggerServerEvent('GiveRewardLTD', true)
							else
								DisplayNotification('~r~Failed: Your LTD Gas Station robbery has failed.')
								TriggerServerEvent('PrintBR:PrintMessage', config.robberyFailed)
							end
						end)
						Wait(1000 * config.timeToRob)
						RemoveBlip(ltdcoords.blip)
					end
				end
			end
			end

			-- Liquor Store Code
			for _, liquorcoords in pairs(config.liquorcoords) do
			if (config.enableLiquor == true) then
				if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, liquorcoords.x, liquorcoords.y, liquorcoords.z) < 1.0 then
					DisplayNotification('~r~Press the ~w~E ~r~key to rob the Liquor Store')
					if IsControlJustReleased(0, 38) then -- E
						TriggerServerEvent('PrintBR:PrintMessage', liquorcoords.alarm)
						TriggerServerEvent('NDBankRobbery:SetActive', true)
					if (config.displayBlips == true) then	
						liquorcoords.blip = AddBlipForCoord(liquorcoords.x, liquorcoords.y, liquorcoords.z)
						SetBlipSprite(liquorcoords.blip, 353)
						SetBlipFlashTimer(liquorcoords.blip, 1000 * config.timeToRob)
						SetBlipAsShortRange(liquorcoords.blip, true)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(liquorcoords.name)
						EndTextCommandSetBlipName(liquorcoords.blip)
					end
					exports['mythic_notify']:DoHudText('inform', 'Robbery in progres!', { ['background-color'] = '#0737f7', ['color'] = '#ef2f2f' })

					TriggerEvent("mythic_progbar:client:progress", {
						name = "SafeRobbery",
						duration = 60000,
						label = "Cracking Safe and Grabbing Money",
						useWhileDead = false,
						canCancel = false,
						controlDisables = {
							disableMovement = true,
							disableCarMovement = true,
							disableMouse = false,
							disableCombat = true,
						},
						animation = {
							animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
							anim = "machinic_loop_mechandplayer",
							flags = 49,
						},
						prop = {
							model = "prop_ing_crowbar",
						}
					}, function(status)
						if not status and not IsEntityDead(GetPlayerPed(-1)) then
							exports['mythic_notify']:DoHudText('inform', 'Robbery in progres!', { ['background-color'] = '#0737f7', ['color'] = '#ef2f2f' })

						--	DisplayNotification('~g~Success: You have robbed the Liqour Store successfully!')
							TriggerServerEvent('PrintBR:PrintMessage', config.robberySuccess)
							TriggerServerEvent('GiveRewardLiq', true)
						else
							DisplayNotification('~r~Failed: Your Liqour store robbery has failed.')
							TriggerServerEvent('PrintBR:PrintMessage', config.robberyFailed)
						end
					end)
						Wait(1000 * config.timeToRob)
						RemoveBlip(liquorcoords.blip)
					end
				end
			end
			end
		end
	end
end)


function DisplayNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		TriggerServerEvent('NDBankRobbery:IsActive')
	end
end)