{
  userConfigs,
  ...
}:
{
  users.users.${userConfigs.marcg.name} = {
    extraGroups = [
      "gamemode"
    ];
  };
}
