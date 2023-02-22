return {
  Name = "getPlayerData";
  Aliases = { "getData", "gpd" };
  Description = "Prints the Player's data of a specific directory.";
  Group = "Admin";
  Args = {
    {
      Type = "player";
      Name = "Player";
      Description = "The player to get the data from";
      Optional = true;
    },
    {
      Type = "dataDirectory";
      Name = "Data Directory";
      Description = "The directory to get the data from";
      Optional = true;
    }
  }
}