{ pkgs, ... }:
{
  programs.anki = {
    enable = true;
    addons = [ pkgs.ankiAddons.crowdanki ];
  };
}
