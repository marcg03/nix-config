{ self, inputs, ... }:
let
  inherit (inputs)
    nixos-hardware
    home-manager
    plasma-manager
    disko
    ;
in
let
  user = "marcg";
  callUserModule = modulePath: import modulePath user;
in
{
  imports = [
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-cpu-intel

    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = {
        inherit self inputs;
      };
      home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
    }

    disko.nixosModules.disko
    "${self}/modules/nixos/surface-pro-3/disko.nix"

    "${self}/modules/nixos/desktop-environment.nix"

    "${self}/modules/nixos/services/openssh.nix"
    "${self}/modules/nixos/services/tlp.nix"

    "${self}/modules/nixos/programs/gnupg.nix"

    (callUserModule "${self}/modules/nixos/users/programs/plasma-tablet.nix")
  ];

  users.groups.${user} = { };
  users.users.${user} = {
    isNormalUser = true;
    group = user;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILYVX8kJuY4/o232BC504BRHS+oVn9e+PWAxquv34FNm marcg@thinkpad-x230"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPZDbclb/ifeN+B9673TbCQPgQ2gmN6sqsg4bm+BEkdE marcg@lenovo-loq"
    ];
  };

  networking = {
    hostName = "surface-pro-3";
    networkmanager.enable = true;
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    settings.publish = {
      "disable-publishing" = false;
      "publish-addresses" = true;
      "publish-domain" = true;
    };
  };

  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];

  zramSwap.enable = true;

  hardware.enableRedistributableFirmware = true;
  hardware.sensor.iio.enable = true;
  hardware.facter.reportPath = "${self}/facter/surface-pro-3.json";

  programs.kdeconnect.enable = true;

  home-manager.users.${user} = {
    imports = [
      {
        programs.librewolf.enable = true;
      }
    ];
    home.stateVersion = "26.11";
  };
  system.stateVersion = "26.11";
}
