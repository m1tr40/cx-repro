QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj)
	QBCore = obj
end)

QBCore.Functions.CreateUseableItem('tunerlaptop', function(source)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	TriggerClientEvent('cx-repro:FazRepro', source)
end)

QBCore.Functions.CreateCallback('cx-repro:verificarepro', function(source, cb, plate)
    local src = source
    exports['ghmattimysql']:execute('SELECT * FROM player_vehicles WHERE plate = @plate and temrepro = 1', {['@plate'] = plate}, function(result)
		if result[1] ~= nil then
			cb(true)
		else
			cb(false)
		end
    end)
end)

RegisterServerEvent('cx-repro:colocarepro')
AddEventHandler('cx-repro:colocarepro', function(vehicleProps)
	exports.ghmattimysql:execute('UPDATE player_vehicles SET temrepro = 1 WHERE plate = @plate', {
		['@plate'] = vehicleProps.plate
	})
end)
