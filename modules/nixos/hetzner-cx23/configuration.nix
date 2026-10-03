{
  self,
  inputs,
  config,
  modulesPath,
  ...
}:
let
  inherit (inputs) disko sops-nix;

  user = "marcg";
in
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")

    disko.nixosModules.disko
    "${self}/modules/nixos/hetzner-cx23/disko.nix"

    "${self}/modules/nixos/hetzner-cx23/networking.nix"

    "${self}/modules/nixos/nebula"

    sops-nix.nixosModules.sops
    {
      sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    }
  ];

  boot.loader.grub.enable = true;

  sops.secrets.${user} = {
    sopsFile = "${self}/secrets/passwords.yaml";
    neededForUsers = true;
  };

  users.groups.${user} = { };
  users.users.${user} = {
    isNormalUser = true;
    group = user;
    extraGroups = [ "wheel" ];
    hashedPasswordFile = config.sops.secrets.${user}.path;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILYVX8kJuY4/o232BC504BRHS+oVn9e+PWAxquv34FNm marcg@thinkpad-x230"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPZDbclb/ifeN+B9673TbCQPgQ2gmN6sqsg4bm+BEkdE marcg@lenovo-loq"
    ];
  };

  services.openssh.enable = true;

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };

    git.enable = true;
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    optimise.automatic = true;
  };

  nixpkgs.hostPlatform = "x86_64-linux";

  system.stateVersion = "26.11";
}
