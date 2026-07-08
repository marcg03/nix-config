{
  config,
  pkgs,
  inputs,
  hostname,
  usernames,
  nixosModules,
  ...
}:
let
  existingPaths = paths: builtins.filter builtins.pathExists paths;
in
{
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-nvidia
    inputs.hardware.nixosModules.common-pc-laptop-ssd

    ./hardware-configuration.nix
    "${nixosModules}/common"

    "${nixosModules}/avahi.nix"
    "${nixosModules}/gaming.nix"
    "${nixosModules}/${hostname}/gaming.nix"
    "${nixosModules}/podman.nix"
    # "${nixosModules}/virtualbox.nix"
    "${nixosModules}/monero.nix"
    "${nixosModules}/appimage.nix"
    "${nixosModules}/${hostname}/wireguard.nix"
  ]
  ++ existingPaths (map (u: "${nixosModules}/users/${u}.nix") usernames)
  ++ existingPaths (map (u: "${nixosModules}/${hostname}/users/${u}.nix") usernames);

  nix.settings = {
    substituters = [ "https://cache.nixos-cuda.org" ];
    trusted-public-keys = [ "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=" ];
  };

  hardware = {
    bluetooth.enable = true;
    nvidia = {
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      powerManagement = {
        enable = true;
        finegrained = true;
      };
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
    nvidia-container-toolkit.enable = true;
  };

  boot.initrd = {
    luks.devices."system_crypt1" = {
      device = "/dev/disk/by-uuid/65723a12-b226-4145-b1fc-3697bf9ffadb";
      allowDiscards = true;
      preLVM = true;
    };

    luks.devices."system_crypt0" = {
      device = "/dev/disk/by-uuid/05fc8c31-efe1-43f9-bb43-7ded3e39dc6b";
      allowDiscards = true;
      preLVM = true;
    };

    services.lvm.enable = true;
  };

  networking.hostName = "${hostname}";

  console.keyMap = "us";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.umurmur = {
    enable = true;
    openFirewall = true;
  };

  services.openvpn.servers = {
    matlab2026a-6VPN = {
      config = " config /root/nixos/openvpn/matlab2026a-6.ovpn ";
    };
  };

  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 60;

      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";

      NMI_WATCHDOG = 0;

      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";

      RUNTIME_PM_DISABLE = "00:14.0";
    };
  };

  users.users = builtins.listToAttrs (
    map (u: {
      name = u;
      value.extraGroups = [ "adbusers" ];
    }) usernames
  );

  environment.systemPackages = with pkgs; [
    android-tools
  ];

  system.stateVersion = "25.11";
}
