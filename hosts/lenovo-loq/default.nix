{
  pkgs,
  inputs,
  hostname,
  nixosModules,
  userConfig,
  ...
}:

{
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-nvidia
    inputs.hardware.nixosModules.common-pc-laptop-ssd

    ./hardware-configuration.nix
    "${nixosModules}/common"

    "${nixosModules}/avahi.nix"
    "${nixosModules}/gaming.nix"
    "${nixosModules}/podman.nix"
    "${nixosModules}/virtualbox.nix"
  ];

  # Wireless Network Card Fix
  boot.kernelParams = [ "pcie_aspm=off" ];

  boot.extraModprobeConfig = ''
    options rtw89_pci disable_aspm_l1=1 disable_aspm_l1ss=1
  '';

  networking.networkmanager.wifi.powersave = false;
  # ~Wireless Network Card Fix

  hardware.bluetooth.enable = true;
  hardware.nvidia.open = true;
  hardware.nvidia.prime = {
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };
  hardware.nvidia-container-toolkit.enable = true;

  boot.initrd.luks.devices."system_crypt1" = {
    device = "/dev/disk/by-uuid/65723a12-b226-4145-b1fc-3697bf9ffadb";
    allowDiscards = true;
    preLVM = true;
  };

  boot.initrd.luks.devices."system_crypt0" = {
    device = "/dev/disk/by-uuid/05fc8c31-efe1-43f9-bb43-7ded3e39dc6b";
    allowDiscards = true;
    preLVM = true;
  };

  boot.initrd.services.lvm.enable = true;

  networking.hostName = "${hostname}";

  console.keyMap = "us";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  users.users.${userConfig.name} = {
    isNormalUser = true;
    description = "${userConfig.fullName}";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  system.stateVersion = "25.11";
}
