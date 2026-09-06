user:
{ pkgs, lib, ... }:
{
  allowUnfreeList = [
    "steam"
    "steam-unwrapped"
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
    gamescopeSession.enable = true;
    protontricks.enable = true;
  };

  hardware.graphics = {
    enable32Bit = true;
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10;
        desiredgov = "performance";
        igpu_desiredgov = "powersave";
        igpu_power_threshold = 0.3;
      };
      custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
        end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
      };
    };
  };

  users.users.${user}.extraGroups = [ "gamemode" ];

  environment.persistence = {
    "/cache".users.${user}.directories = [
      ".local/share/Steam"
      ".steam"
      ".factorio"
    ];
  };
}
