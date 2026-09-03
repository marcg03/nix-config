{ self, inputs, ... }:
let
  inherit (inputs)
    nixos-hardware
    home-manager
    plasma-manager
    disko
    sops-nix
    impermanence
    ;
in
{
  imports = [
    nixos-hardware.nixosModules.lenovo-thinkpad-x230

    "${self}/modules/nixos/thinkpad-x230/users/root.nix"
    "${self}/modules/nixos/thinkpad-x230/users/marcg.nix"

    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = {
        inherit self inputs;
      };
      home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
    }

    impermanence.nixosModules.impermanence

    disko.nixosModules.disko
    "${self}/modules/nixos/thinkpad-x230/disko.nix"

    sops-nix.nixosModules.sops
    {
      sops.age.sshKeyPaths = [ "/host/etc/ssh/ssh_host_ed25519_key" ];
    }

    "${self}/modules/nixos/thinkpad-x230/networking.nix"
    (import "${self}/modules/nixos/networking.nix" "thinkpad-x230")

    "${self}/modules/nixos/desktop-environment.nix"
    "${self}/modules/nixos/thinkpad-x230/bluetooth.nix"

    "${self}/modules/nixos/services/openssh.nix"
    "${self}/modules/nixos/services/tlp.nix"

    "${self}/modules/nixos/programs/gnupg.nix"

    (import "${self}/modules/nixos/restic.nix" "thinkpad-x230")
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  console.keyMap = "uk";
  services.xserver.xkb.layout = "gb";

  system.stateVersion = "26.05";
}
