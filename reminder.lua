-- Registers an event 
----------------------
-- Namespaces
----------------------
local _, core = ...
core.Reminder = {}

local Reminder = core.Reminder

local arrowIcon = "|TInterface\\ICONS\\INV_Weapon_ShortBlade_25:0:0|t"
local foodIcon =  "|TInterface\\ICONS\\Inv_misc_food_15:0:0|t"
local msg = "Buy " .. arrowIcon .. " Arrows and " .. foodIcon .. " Food!"

----------------------
-- Reminder function
----------------------
--[[
	Remind the player to do things
--]]
function Reminder:remind(...)
	if IsResting() == true then
		core:Print(msg)
    end
end