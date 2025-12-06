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
    inputs.hardware.nixosModules.lenovo-thinkpad-x230
    inputs.hardware.nixosModules.common-pc-laptop-ssd

    ./hardware-configuration.nix
    "${nixosModules}/common"
  ];

  boot.initrd.luks.devices."luks-56def38e-cada-478c-b096-b9f5b7a4f470" = {
    device = "/dev/disk/by-uuid/56def38e-cada-478c-b096-b9f5b7a4f470";
    allowDiscards = true;
  };

  boot.initrd.luks.devices."luks-198708b4-5500-4218-8379-13accdd26f2a" = {
    device = "/dev/disk/by-uuid/198708b4-5500-4218-8379-13accdd26f2a";
    allowDiscards = true;
  };

  networking.hostName = "${hostname}";

  console.keyMap = "uk";

  services.xserver.xkb = {
    layout = "gb";
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
