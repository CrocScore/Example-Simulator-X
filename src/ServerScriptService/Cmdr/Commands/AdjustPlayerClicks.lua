return {
  Name = "AdjustPlayerClicks";
  Aliases = { "aPC" };
  Description = "Adjusts the player's clicks";
  Group = "Admin";
  Args = {
    {
      Type = "player";
      Name = "Player";
      Description = "The Player to adjust the clicks of";
      Optional = true;
    },
    {
      Type = "number";
      Name = "Amount of clicks";
      Description = "The amount of clicks to adjust the player's clicks by";
      Optional = true;
    }
  }
}