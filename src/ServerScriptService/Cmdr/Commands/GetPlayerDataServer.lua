local ServerScriptService = game:GetService("ServerScriptService")

local PlayerData = require(ServerScriptService.PlayerData.Manager)

return function (context, player, dataDirectory: string?)
    player = if player then player else context.Executor
    local profile = PlayerData.Profiles[player]
    if not profile then
        return "No profile found?"
    end

    if not dataDirectory then
        print (profile.Data)
        return "Data has been printed"
    end

    print(profile.Data[dataDirectory])
    return "Data has been printed"
end