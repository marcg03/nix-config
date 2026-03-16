{
  pkgs,
  userConfigs,
  ...
}:
{
  users.users.${userConfigs.marcg.name} = {
    isNormalUser = true;
    description = "${userConfigs.marcg.name}";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };
}
