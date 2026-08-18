user:
{ self, pkgs, ... }:
{
  programs.zsh.enable = true;

  users.users.${user}.shell = pkgs.zsh;

  home-manager.users.${user}.imports = [ "${self}/modules/home-manager/programs/zsh.nix" ];
}
