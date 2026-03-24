{
  pkgs,
  usernames,
  ...
}:
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

  services = {
    openssh.enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    printing = {
      enable = true;
      drivers = [ pkgs.gutenprint ];
    };
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  hardware.sane.enable = true;

  users.users = builtins.listToAttrs (
    map (u: {
      name = u;
      value.extraGroups = [
        "scanner"
        "lp"
      ];
    }) usernames
  );

  security.rtkit.enable = true;

  programs = {
    zsh.enable = true;
    noisetorch.enable = true;
    localsend.enable = true;
    gnupg.agent.enable = true;
    firefox.enable = true;
  };

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
    pigz
    qemu
    man-pages
    vlc
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
