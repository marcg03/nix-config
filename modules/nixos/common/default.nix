{ pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  fonts.packages = with pkgs; [
    dejavu_fonts
  ];

  time.timeZone = "Europe/Bucharest";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ro_RO.UTF-8";
    LC_IDENTIFICATION = "ro_RO.UTF-8";
    LC_MEASUREMENT = "ro_RO.UTF-8";
    LC_MONETARY = "ro_RO.UTF-8";
    LC_NAME = "ro_RO.UTF-8";
    LC_NUMERIC = "ro_RO.UTF-8";
    LC_PAPER = "ro_RO.UTF-8";
    LC_TELEPHONE = "ro_RO.UTF-8";
    LC_TIME = "ro_RO.UTF-8";
  };

  services.openssh.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
    };
  };

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.zsh.enable = true;

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

  programs.localsend.enable = true;

  programs.gnupg.agent.enable = true;

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = with pkgs; [
    helix
    vim
    wget
    git
    wl-clipboard
    brave
    lazygit
    yazi
    unzip
    zip
    unrar
    rar
  ];

  networking.firewall = rec {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };
}
