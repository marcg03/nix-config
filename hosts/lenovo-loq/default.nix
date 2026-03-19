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

  # Wireless Network Card Fix
  boot.extraModprobeConfig = ''
    options rtw89_pci disable_aspm_l1=1 disable_aspm_l1ss=1 disable_clkreq=1
    options rtw89_core disable_ps_mode=1
  '';

  networking.networkmanager.wifi.powersave = false;
  # ~Wireless Network Card Fix

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
