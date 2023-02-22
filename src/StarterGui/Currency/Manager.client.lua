local ReplicatedStorage = game:GetService("ReplicatedStorage")

local FormatNumber = require(ReplicatedStorage.Libs.FormatNumber.Simple)
local Remotes = ReplicatedStorage.Remotes

local Gui = script.Parent
local Frame = Gui.Frame

local Clicks = Frame.Clicks.Amount
local CPS = Frame.Clicks.CPS
local BuyClicks = Frame.Clicks.Buy
local Gems = Frame.Gems.Amount

local function UpdateCurrency(currency: "Clicks" | "Gems", amount: number)
	amount = FormatNumber.FormatCompact(amount)
	if currency == "Clicks" then
		Clicks.Text = amount
	elseif currency == "Gems" then
		Gems.Text = amount
	end
end

UpdateCurrency("Clicks", Remotes.GetData:InvokeServer("Clicks"))

Remotes.UpdateClicks.OnClientEvent:Connect(function(amount)
	UpdateCurrency("Clicks", amount)
end)