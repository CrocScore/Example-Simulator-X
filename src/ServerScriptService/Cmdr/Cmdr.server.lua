local ServerScriptService = game:GetService("ServerScriptService")

local Cmdr = require(ServerScriptService.Libs.Cmdr)

local TypesFolder = script.Parent.Types
local CommandFolder = script.Parent.Commands

Cmdr:RegisterDefaultCommands()
Cmdr:RegisterTypesIn(TypesFolder)
Cmdr:RegisterCommandsIn(CommandFolder)