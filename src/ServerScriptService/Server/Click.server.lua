local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Remotes = ReplicatedStorage.Remotes
local PlayerData = require(ServerScriptService.PlayerData.Manager)

local Cooldown = {}

local CLICK_COOLDOWN = 0.2

local function Click(player: Player)
  if table.find(Cooldown, player) then -- Click cooldown by adding player to table than removing after delay
    return
  end
  table.insert(Cooldown, player)
  task.delay(CLICK_COOLDOWN, function() 
    local foundPlayer = table.find(Cooldown, player)
    if foundPlayer then
      table.remove(Cooldown, foundPlayer)
    end
  end)
  PlayerData.AdjustClicks(player, 100)
end

Remotes.Click.OnServerEvent:Connect(Click)