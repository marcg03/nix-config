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
      "gamemode" # FIX: this should be just for lenovo-loq
    ];
    shell = pkgs.zsh;
  };
}
