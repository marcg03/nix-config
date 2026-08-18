user: { self, ... }: {
  home-manager.users.${user}.imports = [ "${self}/modules/home-manager/programs/tmux.nix" ];
}
