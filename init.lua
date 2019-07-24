local _, core = ... -- Namespace

local Reminder = core.Reminder;

--------------------------------------
-- Custom Slash Command
--------------------------------------
core.commands = {
	["config"] = core.Config.Toggle, -- this is a function (no knowledge of Config object)
	
	["help"] = function()
		core:Print("List of slash commands:")
		core:Print("|cff40ff00/hr config|r - shows config menu []")
		core:Print("|cff40ff00/hr help|r - shows help info")
	end,
}

local function HandleSlashCommands(str)	
	if (#str == 0) then	
		-- User just entered "/at" with no additional args.
		core.commands.help()
		return		
	end	
	
	local args = {}
	for _, arg in ipairs({ string.split(' ', str) }) do
		if (#arg > 0) then
			table.insert(args, arg)
		end
	end
	
	local path = core.commands -- required for updating found table.
	
	for id, arg in ipairs(args) do
		if (#arg > 0) then -- if string length is greater than 0.
			arg = arg:lower()			
			if (path[arg]) then
				if (type(path[arg]) == "function") then				
					-- all remaining args passed to our function!
					path[arg](select(id + 1, unpack(args))) 
					return					
				elseif (type(path[arg]) == "table") then				
					path = path[arg] -- another sub-table found!
				end
			else
				-- does not exist!
				core.commands.help()
				return
			end
		end
	end
end

function core:Print(...)
    local hex = select(4, self.Config:GetThemeColor())
    local prefix = string.format("|cff%s%s|r", hex:upper(), "Hunter Reminder")	
    DEFAULT_CHAT_FRAME:AddMessage(string.join(" ", prefix, ...))
end

function core:init(event, name)
	if (name ~= "HunterReminder") then return end 

	-- allows using left and right buttons to move through chat 'edit' box
	for i = 1, NUM_CHAT_WINDOWS do
		_G["ChatFrame"..i.."EditBox"]:SetAltArrowKeyMode(false)
	end
	
	----------------------------------
	-- Register Slash Commands!
	----------------------------------
	SLASH_RELOADUI1 = "/rl" -- new slash command for reloading UI
	SlashCmdList.RELOADUI = ReloadUI

	SLASH_FRAMESTK1 = "/fs" -- new slash command for showing framestack tool
	SlashCmdList.FRAMESTK = function()
		LoadAddOn("Blizzard_DebugTools")
		FrameStackTooltip_Toggle()
	end

	SLASH_HunterReminder1 = "/hr"
	SlashCmdList.HunterReminder = HandleSlashCommands
	
    core:Print("Welcome back", UnitName("player").."!")
end

-- Create frame that waits on rested state change
local rested_event = CreateFrame("Frame")
rested_event:RegisterEvent("PLAYER_UPDATE_RESTING")
rested_event:SetScript("OnEvent", Reminder.remind)


local events = CreateFrame("Frame")
events:RegisterEvent("ADDON_LOADED")
events:SetScript("OnEvent", core.init)