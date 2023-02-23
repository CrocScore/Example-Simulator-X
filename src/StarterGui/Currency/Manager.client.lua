local ReplicatedStorage = game:GetService("ReplicatedStorage")

local FormatNumber = require(ReplicatedStorage.Libs.FormatNumber.Simple)
local Remotes = ReplicatedStorage.Remotes

local Gui = script.Parent
local Frame = Gui.Frame

local Clicks = Frame.Clicks.Amount
local ClicksPerSecond = Frame.Clicks.CPS
local BuyClicks = Frame.Clicks.Buy
local Gems = Frame.Gems.Amount

local ClicksDuringSecound = 0
local PreviousClicksAmount = 0

local CLICKS_PER_SECOND_STRING_TEMPLATE = "(+AMOUNT/sec)"

local function UpdateClicksPerSecond(amount: number) -- Updates Clicks Per Secound
	local amountOfClicks = amount - PreviousClicksAmount
	PreviousClicksAmount = amount
	if amountOfClicks <= 0 then 
		return 
	end

	ClicksDuringSecound += amountOfClicks
	ClicksPerSecond.Text = CLICKS_PER_SECOND_STRING_TEMPLATE:gsub("AMOUNT", FormatNumber.FormatCompact(ClicksDuringSecound))
	print(ClicksPerSecond)
	ClicksPerSecond.Visible = true

	task.delay(1, function()
		ClicksDuringSecound -= amountOfClicks
		ClicksPerSecond.Text = CLICKS_PER_SECOND_STRING_TEMPLATE:gsub("AMOUNT", FormatNumber.FormatCompact(ClicksDuringSecound))
		-- ClicksPerSecond.Visible = ClicksDuringSecound > 0 -- Only show if there are clicks
	end)
end

local function UpdateCurrency(currency: "Clicks" | "Gems", amount: number)
	if currency == "Clicks" then
		UpdateClicksPerSecond(amount)
		print(FormatNumber.FormatCompact(amount))
		Clicks.Text = FormatNumber.FormatCompact(amount)
	elseif currency == "Gems" then
		Gems.Text = FormatNumber.FormatCompact(amount)
	end
end

UpdateCurrency("Clicks", Remotes.GetData:InvokeServer("Clicks"))

Remotes.UpdateClicks.OnClientEvent:Connect(function(amount)
	UpdateCurrency("Clicks", amount)
end)