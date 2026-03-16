{
  pkgs,
  userConfigs,
  ...
}:
{
  users.users.${userConfigs.primatronic.name} = {
    isNormalUser = true;
    description = "${userConfigs.primatronic.name}";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };
}
