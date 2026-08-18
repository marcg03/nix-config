{ self, pkgs, ... }: {
  imports = [ "${self}/modules/nixos/allow-unfree.nix" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.systemPackages = with pkgs; [
    cryptsetup
    git
    helix
    nano
    tmux
    vim
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

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
