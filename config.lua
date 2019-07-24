--------------------------------------
-- Namespaces
--------------------------------------
local _, core = ...
core.Config = {} -- adds Config table to addon namespace

local Config = core.Config
local UIConfig

--------------------------------------
-- Defaults 
--------------------------------------
local defaults = {
	theme = {
		r = 0.25, 
		g = 1, 
		b = 0,
		hex = "40ff00"
	}
}

--------------------------------------
-- Config functions
--------------------------------------
function Config:Toggle()
	local menu = UIConfig or Config:CreateMenu()
	menu:SetShown(not menu:IsShown())
end

function Config:GetThemeColor()
	local c = defaults.theme
	return c.r, c.g, c.b, c.hex
end

function Config:CreateButton(point, relativeFrame, relativePoint, yOffset, text)
	local btn = CreateFrame("Button", nil, UIConfig, "GameMenuButtonTemplate")
	btn:SetPoint(point, relativeFrame, relativePoint, 0, yOffset)
	btn:SetSize(140, 40)
	btn:SetText(text)
	btn:SetNormalFontObject("GameFontNormalLarge")
	btn:SetHighlightFontObject("GameFontHighlightLarge")
	return btn
end

function Config:CreateMenu()
	UIConfig = CreateFrame("Frame", "HunterReminderConfig", UIParent, "BasicFrameTemplateWithInset")
	--UIConfig:SetSize(260, 360)
	UIConfig:SetSize(240, 70)
	UIConfig:SetPoint("CENTER")

	UIConfig.title = UIConfig:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	UIConfig.title:SetPoint("LEFT", UIConfig.TitleBg, "LEFT", 5, 0)
	UIConfig.title:SetText("Hunter Reminder Options")

	------------------------------------
	---- Buttons
	------------------------------------
	---- Save Button:
	--UIConfig.saveBtn = self:CreateButton("CENTER", UIConfig, "TOP", -70, "Save")

	---- Reset Button:	
	--UIConfig.resetBtn = self:CreateButton("TOP", UIConfig.saveBtn, "BOTTOM", -10, "Reset")

	---- Load Button:	
	--UIConfig.loadBtn = self:CreateButton("TOP", UIConfig.resetBtn, "BOTTOM", -10, "Load")

	----------------------------------
	-- Check Buttons
	----------------------------------
	-- Check Button 1:
	UIConfig.checkBtn1 = CreateFrame("CheckButton", nil, UIConfig, "UICheckButtonTemplate")
	--UIConfig.checkBtn1:SetPoint("TOPLEFT", UIConfig.loadBtn, "BOTTOMLEFT", -10, -40)
	UIConfig.checkBtn1:SetPoint("CENTER", UIConfig, "TOP", -95, -45)
	UIConfig.checkBtn1.text:SetText("Remind me to buy Food and Ammo!")
	UIConfig.checkBtn1:SetChecked(true)

	-- Check Button 2:
	--UIConfig.checkBtn2 = CreateFrame("CheckButton", nil, UIConfig, "UICheckButtonTemplate")
	--UIConfig.checkBtn2:SetPoint("TOPLEFT", UIConfig.checkBtn1, "BOTTOMLEFT", 0, -10)
	--UIConfig.checkBtn2.text:SetText("Another Check Button!")
	--UIConfig.checkBtn2:SetChecked(true)
	
	UIConfig:Hide()
	return UIConfig
end
