local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage.Remotes

local Manager = {}

Manager.Profiles = {}

function Manager.AdjustClicks(player: Player, amount: number)
  local profile = Manager.Profiles[player]
  if not profile then
    return
  end
  profile.Data.Clicks += amount
  player.leaderstats.Clicks.Value = profile.Data.Clicks
  Remotes.UpdateClicks:FireClient(player, profile.Data.Clicks)
end

local function GetData(player: Player, directory: string) --  Get data from player profile
  local profile = Manager.Profiles[player]
  if not profile then
    return
  end
  return profile.Data[directory]
end

Remotes.GetData.OnServerInvoke = GetData

return Manager