local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local Gui = script.Parent
local Frame = Gui.Frame

local Click = Frame.Click
local FastAuto = Frame.Fast
local RegularAuto = Frame.Regular

local BUTTON_OFF_COLOR = Color3.fromRGB(255, 102, 102)
local STROKE_OFF_COLOR = Color3.fromRGB(156, 62, 62)
local BUTTON_ON_COLOR = Color3.fromRGB(104, 255, 101)
local STROKE_ON_COLOR = Color3.fromRGB(61, 147, 58)
local CLICK_TEXT_TEMPLATE = "TYPE Auto Clicker (MODE)"

local RegularMode = false
local FastMode = false

local function UpdateButton(buttonType: "Regular" | "Fast", mode: Boolean)
    local button
    if buttonType == "Regular" then
        button = RegularAuto
        RegularMode = mode
    else
        button = FastAuto
        FastMode = mode
    end
    
    if mode then
        button.BackgroundColor3 = BUTTON_ON_COLOR
        button.Label.Text = CLICK_TEXT_TEMPLATE:gsub("TYPE", buttonType):gsub("MODE", "ON")
        button.Label.TextColor3 = BUTTON_ON_COLOR
        button.UIStroke.Color = STROKE_ON_COLOR
    else
        button.BackgroundColor3 = BUTTON_OFF_COLOR
        button.Label.Text = CLICK_TEXT_TEMPLATE:gsub("TYPE", buttonType):gsub("MODE", "OFF")
        button.Label.TextColor3 = BUTTON_OFF_COLOR
        button.UIStroke.Color = STROKE_OFF_COLOR
    end
end

FastAuto.MouseButton1Click:Connect(function()
    Remotes.UpdateAutoClicker:FireServer("Fast")
end)
RegularAuto.MouseButton1Click:Connect(function()
    Remotes.UpdateAutoClicker:FireServer("Regular")
end)

Click.MouseButton1Click:Connect(function()
    Remotes.Click:FireServer()
end)

Remotes.UpdateAutoClicker.OnClientEvent:Connect(UpdateButton)
UpdateButton("Regular", Remotes.GetAutoClickMode:InvokeServer("Regular"))
UpdateButton("Fast", Remotes.GetAutoClickMode:InvokeServer("Fast"))