{
  pkgs,
  userConfigs,
  ...
}:
{
  users.users.${userConfigs.primatronic.name} = {
    isNormalUser = true;
    description = "${userConfigs.primatronic.fullName}";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };
}
