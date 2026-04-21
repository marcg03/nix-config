{
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
    inputs.hardware.nixosModules.lenovo-thinkpad-x230
    inputs.hardware.nixosModules.common-pc-laptop-ssd

    ./hardware-configuration.nix
    "${nixosModules}/common"

    "${nixosModules}/avahi.nix"
    "${nixosModules}/gaming.nix"
    "${nixosModules}/podman.nix"
    "${nixosModules}/${hostname}/wireguard.nix"
  ]
  ++ existingPaths (map (u: "${nixosModules}/users/${u}.nix") usernames);

  boot.initrd.luks.devices."luks-56def38e-cada-478c-b096-b9f5b7a4f470" = {
    device = "/dev/disk/by-uuid/56def38e-cada-478c-b096-b9f5b7a4f470";
    allowDiscards = true;
  };

  boot.initrd.luks.devices."luks-198708b4-5500-4218-8379-13accdd26f2a" = {
    device = "/dev/disk/by-uuid/198708b4-5500-4218-8379-13accdd26f2a";
    allowDiscards = true;
  };

  networking.hostName = "${hostname}";

  # Add CUDA binary cache
  nix.settings = {
    substituters = [ "https://cache.nixos-cuda.org" ];
    trusted-public-keys = [ "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=" ];
  };

  console.keyMap = "uk";

  services = {
    xserver.xkb = {
      layout = "gb";
      variant = "";
    };

    power-profiles-daemon.enable = false;
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      };
    };
  };

  system.stateVersion = "25.11";
}
