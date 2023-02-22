return function (registry)
  registry:RegisterHoook("BeforeRun", function(context)
    if context.Group == "Admin" and context.Executor.UserId ~= 40112844 then -- Change this to your UserId
      return "You are not authorized to run this command"
    end
  end)
end