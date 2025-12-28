{
  inputs,
  userConfig,
  ...
}:

{
  imports = [
    inputs.direnv-instant.homeModules.direnv-instant
    ../services/kdeconnect.nix
  ];

  home.username = "${userConfig.name}";
  home.homeDirectory = "/home/${userConfig.name}";

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
}
