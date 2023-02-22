local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Template = require(ReplicatedStorage.PlayerData.Template)
local Manager = require(ServerScriptService.PlayerData.Manager)
local ProfileService = require(ServerScriptService.Libs.ProfileService)

local ProfileStore = ProfileService.GetProfileStore("Production", Template)

local KICK_MESSAGE = "Data Issue. Please rejoin."

local function CreateLeaderstats(player: Player)
  local profile = Manager.Profiles[player]
  if not profile then
    return
  end
  local leaderstats = Instance.new("Folder", player)
  leaderstats.Name = "leaderstats"

  local clicks = Instance.new("NumberValue", leaderstats)
  clicks.Name = "Clicks"
  clicks.Value = profile.Data.Clicks

  local gems = Instance.new("NumberValue", leaderstats)
  gems.Name = "Gems"
  gems.Value = profile.Data.Gems
end

local function LoadProfile(player: Player)
  local profile = ProfileStore:LoadProfileAsync("Player_" .. player.UserId)
  if not profile then
    player:Kick(KICK_MESSAGE)
    return
  end

  profile:AddUserId(player.UserId)
  profile:Reconcile()
  profile:ListenToRelease(function()
    Manager.Profiles[player] = nil
    player:Kick(KICK_MESSAGE)
  end)

  if player:IsDescendantOf(Players) == true then
    Manager.Profiles[player] = profile
    CreateLeaderstats(player)
  else
    profile:Release()
  end
end

for _, player in Players:GetPlayers() do
  task.spawn(LoadProfile, player)
end

Players.PlayerAdded:Connect(LoadProfile)
Players.PlayerRemoving:Connect(function(player: Player)
  local profile = Manager.Profiles[player]
  if profile then
    profile:Release()
  end
end)