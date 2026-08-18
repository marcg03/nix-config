{
  self,
  config,
  pkgs,
  ...
}:
let
  user = "marcg";
  callUserModule = modulePath: import modulePath user;
in
{
  imports = [
    (callUserModule "${self}/modules/nixos/users/programs/direnv.nix")
    (callUserModule "${self}/modules/nixos/users/programs/foot.nix")
    (callUserModule "${self}/modules/nixos/users/programs/git.nix")
    (callUserModule "${self}/modules/nixos/users/programs/gpg.nix")
    (callUserModule "${self}/modules/nixos/users/programs/helix.nix")
    (callUserModule "${self}/modules/nixos/users/programs/lazygit.nix")
    (callUserModule "${self}/modules/nixos/users/programs/librewolf.nix")
    (callUserModule "${self}/modules/nixos/users/programs/pass.nix")
    (callUserModule "${self}/modules/nixos/users/programs/plasma.nix")
    (callUserModule "${self}/modules/nixos/users/programs/starship.nix")
    (callUserModule "${self}/modules/nixos/users/programs/steam.nix")
    (callUserModule "${self}/modules/nixos/users/programs/tmux.nix")
    (callUserModule "${self}/modules/nixos/users/programs/vesktop.nix")
    (callUserModule "${self}/modules/nixos/users/programs/yazi.nix")
    (callUserModule "${self}/modules/nixos/users/programs/zsh.nix")
  ];

  environment.persistence = {
    "/data".users.${user}.directories = [
      "Dekstop"
      "Documents"
      "Music"
      "Pictures"
      "Videos"
      "nix-config"
      ".ssh"
      "git-repos"
    ];
    "/cache".users.${user}.directories = [
      ".cache"
      "Games"
      "git-worktrees"
    ];
  };

  userConfig.${user}.git = {
    userName = "marcg";
    email = "marcgrec@tuta.com";
  };

  sops.secrets.${user} = {
    sopsFile = "${self}/secrets/passwords.yaml";
    neededForUsers = true;
  };

  users.groups.${user} = { };
  users.users.${user} = {
    isNormalUser = true;
    group = user;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    hashedPasswordFile = config.sops.secrets.${user}.path;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILYVX8kJuY4/o232BC504BRHS+oVn9e+PWAxquv34FNm marcg@thinkpad-x230"
    ];
  };

  home-manager.users.${user}.home.stateVersion = "26.05";
}
