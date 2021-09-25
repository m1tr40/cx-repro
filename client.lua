QBCore = nil
local PlayerData = {}

Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

TriggerEvent('QBCore:GetObject', function(obj)
	QBCore = obj
end)


Citizen.CreateThread(function()
  while true do 
      Citizen.Wait(7000) 
        if IsPedInAnyVehicle(GetPlayerPed(-1), false) == 1 then 
            local ped = GetPlayerPed(-1) 
            local vehicle = GetVehiclePedIsIn(ped) 
            local plate = GetVehicleNumberPlateText(vehicle) 
            QBCore.Functions.TriggerCallback('cx-repro:verificarepro', function(temrepro)
                if temrepro then
                    print("Vehicle Tunned")
                    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveForce", 0.6) --Boost
                    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fDriveInertia", 0.6) --Aceleration
                    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fDriveBiasFront", 0.5) --Drive Train
                    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fBrakeBiasFront", 0.36) -- Breaking
                    SetVehicleEnginePowerMultiplier(vehicle, 0.6) --Gear Change
                else
                    print("Vehicle Not Tunned")
                end
            end, plate)
        end
    end
end)


RegisterNetEvent('cx-repro:FazRepro')
AddEventHandler('cx-repro:FazRepro', function()
    local ped = PlayerPedId()
    local inVehicle = IsPedInAnyVehicle(ped)

    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    meucarro = QBCore.Functions.GetVehicleProperties(vehicle)

    if inVehicle then
        QBCore.Functions.Progressbar("prop_laptop_lester", "Tunning Vehicle...", 50000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
            anim = "machinic_loop_mechandplayer",
            flags = 16,
        }, {}, {}, function() 
            StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)

	    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveForce", 0.6) --Boost
	    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fDriveInertia", 0.6) --Aceleration
	    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fDriveBiasFront", 0.5) --Drive Train
	    SetVehicleHandlingFloat(vehicle, "CHandlingData", "fBrakeBiasFront", 0.36) -- Breaking
	    SetVehicleEnginePowerMultiplier(vehicle, 0.6) --Gear Change


            TriggerServerEvent('cx-repro:colocarepro', meucarro)

        end, function() 
            StopAnimTask(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 1.0)
            QBCore.Functions.Notify("Canceled", "error")
        end)
    else
        QBCore.Functions.Notify("You need to be inside a vehicle", "error")
    end    
end)







