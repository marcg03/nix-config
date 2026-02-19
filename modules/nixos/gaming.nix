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
