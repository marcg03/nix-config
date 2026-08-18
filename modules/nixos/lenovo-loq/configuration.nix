{ self, inputs, ... }:
let
  inherit (inputs)
    home-manager
    plasma-manager
    disko
    sops-nix
    impermanence
    ;
in
{
  imports = [
    "${self}/modules/nixos/lenovo-loq/users/root.nix"
    "${self}/modules/nixos/lenovo-loq/users/marcg.nix"

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
    "${self}/modules/nixos/lenovo-loq/disko.nix"

    sops-nix.nixosModules.sops
    {
      sops.age.sshKeyPaths = [ "/host/etc/ssh/ssh_host_ed25519_key" ];
    }

    "${self}/modules/nixos/lenovo-loq/networking.nix"
    (import "${self}/modules/nixos/networking.nix" "lenovo-loq")

    "${self}/modules/nixos/desktop-environment.nix"

    "${self}/modules/nixos/services/openssh.nix"
    "${self}/modules/nixos/services/tlp.nix"

    "${self}/modules/nixos/programs/gnupg.nix"

    "${self}/modules/nixos/lenovo-loq/nvidia.nix"
  ];

  hardware.facter.reportPath = "${self}/facter/lenovo-loq.json";

  system.stateVersion = "26.05";
}
