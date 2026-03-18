{
  pkgs,
  ...
}:
{
  # FIX: part of this is host specific (e.g., lenovo-loq) and won't work on other machines
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
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      glibc
      stdenv.cc.cc.lib

      libxtst
      libx11
      libxext
      libxi
      libxrandr
      libxxf86vm
      libxcursor
      libxfixes
      libxrender

      libGL
      mesa
      alsa-lib
      pulseaudio
      fontconfig
      freetype
    ];
  };
}
