{ modulesPath, ... }:
{
  imports = [ "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix" ];

  nixpkgs.hostPlatform = "x86_64-linux";
  networking.hostName = "nixos-installer";

  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPZDbclb/ifeN+B9673TbCQPgQ2gmN6sqsg4bm+BEkdE marcg@lenovo-loq"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILYVX8kJuY4/o232BC504BRHS+oVn9e+PWAxquv34FNm marcg@thinkpad-x230"
  ];

  services.avahi = {
    enable = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
    nssmdns4 = true;
    openFirewall = true;
  };
}
