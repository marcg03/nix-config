{ config, pkgs, ... }:
{
  programs.anki = {
    enable = true;
    addons = [
      (pkgs.ankiAddons.crowdanki.withConfig {
        config = {
          snapshot_path = "${config.xdg.dataHome}/crowdanki";
        };
      })
    ];
  };
}
