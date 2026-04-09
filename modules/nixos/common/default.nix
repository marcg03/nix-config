{
  pkgs,
  usernames,
  ...
}:
let
  uuid = "4b97ee65-a126-41ed-9480-0156b59be1f9";
  do-backup = pkgs.writeShellScriptBin "do-backup" ''
    set -euo pipefail

    USB_MOUNT=/mnt/usb-backup
    RESTIC_REPO="$USB_MOUNT/restic-backup"

    if [ "$EUID" -ne 0 ]; then
      exec sudo INITIAL_HOME="$HOME" INITIAL_USER="$USER" "$0" "$@"
    else
      INITIAL_HOME="''${INITIAL_HOME:-$HOME}"
      INITIAL_USER="''${INITIAL_USER:-$USER}"
    fi

    BACKUP_DIRS=($INITIAL_HOME/Documents $INITIAL_HOME/src)

    cleanup() {
      ${pkgs.coreutils}/bin/sync "$USB_MOUNT" || true
      ${pkgs.umount}/bin/umount "$USB_MOUNT" || true
    }

    trap cleanup EXIT

    if ! mountpoint -q "$USB_MOUNT"; then
      ${pkgs.mount}/bin/mount /dev/disk/by-uuid/${uuid} "$USB_MOUNT"
    fi

    sudo -u $INITIAL_USER ${pkgs.restic}/bin/restic -r "$RESTIC_REPO" backup "''${BACKUP_DIRS[@]}" --tag "host=$HOSTNAME" --tag "user=$INITIAL_USER"
  '';
in
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
    ffmpeg-full
    restic
    do-backup
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
