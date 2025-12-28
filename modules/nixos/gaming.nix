{
  pkgs,
  ...
}:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      glibc
      stdenv.cc.cc.lib

      xorg.libXtst
      xorg.libX11
      xorg.libXext
      xorg.libXi
      xorg.libXrandr
      xorg.libXxf86vm
      xorg.libXcursor
      xorg.libXfixes
      xorg.libXrender

      libGL
      mesa
      alsa-lib
      pulseaudio
      fontconfig
      freetype
    ];
  };
}
