AddEventHandler(
	"onClientMapStart",
	function()
		TriggerServerEvent("hud:setplayer")
	end
)

local healthleft = 5.5
local healthbottom = 29
local armorleft = 3
local armorbottom = 25
local fuelleft = 80
local fuelbottom = 4.5

RegisterNetEvent("hud:sethud")
AddEventHandler(
	"hud:sethud",
	function(hl, hb, al, ab, fl, fb)
		healthleft = hl
		healthbottom = hb
		armorleft = al
		armorbottom = ab
		fuelleft = fl
		fuelbottom = fb
		SendNUIMessage(
			{
				action = "intialization",
				healthleft = healthleft,
				healthbottom = healthbottom,
				armorleft = armorleft,
				armorbottom = armorbottom,
				fuelleft = fuelleft,
				fuelbottom = fuelbottom,

			}
		)
	end
)

local fueledit = false
function FuelEdit()
	if armoredit or healthedit == fasle then
		if fueledit then
			fueledit = false
			print(armorbottom)
			TriggerServerEvent("hud:save", healthleft, healthbottom, armorleft, armorbottom, fuelleft, fuelbottom)
		else
			fueledit = true
		end
	else
		TriggerEvent("framework:tnotify:alert", "error", "Finish editing the current element!")
	end
end

local armoredit = false
function ArmorEdit()
	if healthedit or fueledit == false then
		if armoredit then
			armoredit = false
			print(armorbottom)
			TriggerServerEvent("hud:save", healthleft, healthbottom, armorleft, armorbottom, fuelleft, fuelbottom)
		else
			armoredit = true
		end
	else
		TriggerEvent("framework:tnotify:alert", "error", "Finish editing the current element!")
	end
end

local healthedit = false
function HealthEdit()
	if armoredit or fueledit == false then
		if healthedit then
			healthedit = false
			print(armorbottom)
			TriggerServerEvent("hud:save", healthleft, healthbottom, armorleft, armorbottom, fuelleft, fuelbottom)
		else
			healthedit = true
		end
	else
		TriggerEvent("framework:tnotify:alert", "error", "Finish editing the current element!")
	end
end

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if armoredit then
				if IsControlPressed(0, 175) then
					armorleft = armorleft + 0.5
					SendNUIMessage(
						{
							action = "editarmor",
							left = armorleft
						}
					)
					armorleft = armorleft
				end
				if IsControlPressed(0, 174) then
					armorleft = armorleft - 0.5
					SendNUIMessage(
						{
							action = "editarmor",
							left = armorleft
						}
					)
					armorleft = armorleft
				end
				if IsControlPressed(0, 172) then
					armorbottom = armorbottom + 0.5
					SendNUIMessage(
						{
							action = "editarmor",
							bottom = armorbottom
						}
					)
					armorbottom = armorbottom
				end
				if IsControlPressed(0, 173) then
					armorbottom = armorbottom - 0.5
					SendNUIMessage(
						{
							action = "editarmor",
							bottom = armorbottom
						}
					)
					armorbottom = armorbottom
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if healthedit then
				if IsControlPressed(0, 175) then
					healthleft = healthleft + 0.5
					SendNUIMessage(
						{
							action = "edithealth",
							left = healthleft
						}
					)
					healthleft = healthleft
				end
				if IsControlPressed(0, 174) then
					healthleft = healthleft - 0.5
					SendNUIMessage(
						{
							action = "edithealth",
							left = healthleft
						}
					)
					healthleft = healthleft
				end
				if IsControlPressed(0, 172) then
					healthbottom = healthbottom + 0.5
					SendNUIMessage(
						{
							action = "edithealth",
							bottom = healthbottom
						}
					)
					healthbottom = healthbottom
				end
				if IsControlPressed(0, 173) then
					healthbottom = healthbottom - 0.5
					SendNUIMessage(
						{
							action = "edithealth",
							bottom = healthbottom
						}
					)
					healthbottom = healthbottom
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if fueledit then
				if IsControlPressed(0, 175) then
					fuelleft = fuelleft + 0.5
					SendNUIMessage(
						{
							action = "editfuel",
							left = fuelleft
						}
					)
					fuelleft = fuelleft
				end
				if IsControlPressed(0, 174) then
					fuelleft = fuelleft - 0.5
					SendNUIMessage(
						{
							action = "editfuel",
							left = fuelleft
						}
					)
					fuelleft = fuelleft
				end
				if IsControlPressed(0, 172) then
					fuelbottom = fuelbottom + 0.5
					SendNUIMessage(
						{
							action = "editfuel",
							bottom = fuelbottom
						}
					)
					fuelbottom = fuelbottom
				end
				if IsControlPressed(0, 173) then
					fuelbottom = fuelbottom - 0.5
					SendNUIMessage(
						{
							action = "editfuel",
							bottom = fuelbottom
						}
					)
					fuelbottom = fuelbottom
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(500)
			local player = PlayerPedId()
			local maxhealth = GetEntityMaxHealth(player)
			if (GetEntityHealth(player)) == maxhealth then
				health = maxhealth
			elseif IsEntityDead(player) then
				health = 0
			else
				health = (GetEntityHealth(player) - 100)
			end
			local armor = GetPedArmour(player)

			SendNUIMessage(
				{
					action = "huddis",
					showhud = true,
					health = health,
					armor = armor
				}
			)
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(500)
			local ped = PlayerPedId()
			if IsPedInAnyVehicle(ped, false) then
				local inCar = GetVehiclePedIsIn(ped, false)
				carSpeed = math.ceil(GetEntitySpeed(inCar) * 1.23)
				fuel = exports.vehicle_fuel:GetFuel(inCar)
				SendNUIMessage(
					{
						action = "car",
						showhud = true,
						speed = carSpeed,
						fuel = fuel
					}
				)
			else
				SendNUIMessage(
					{
						action = "car",
						showhud = false
					}
				)
			end
		end
	end
)
