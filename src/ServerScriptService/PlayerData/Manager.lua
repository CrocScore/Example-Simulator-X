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

local function GetAutoClickMode(player: Player, buttonType: "Fast" | "Regular") --  Get data from player profile
  local profile = Manager.Profiles[player]
  if not profile then
    return
  end
  return profile.Data.Auto[buttonType].Active
end

Remotes.GetData.OnServerInvoke = GetData
Remotes.GetAutoClickMode.OnServerInvoke = GetAutoClickMode

return Manager