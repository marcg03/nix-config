{
  pkgs,
  userConfigs,
  ...
}:
{
  users.users.${userConfigs.marcg.name} = {
    isNormalUser = true;
    description = "${userConfigs.marcg.fullName}";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };
}
