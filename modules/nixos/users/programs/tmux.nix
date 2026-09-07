user: { self, ... }: {
  home-manager.users.${user}.imports = [ "${self}/modules/home-manager/programs/tmux.nix" ];

  environment.persistence."/data".users.${user}.directories = [ ".config/tmuxp" ];
}
