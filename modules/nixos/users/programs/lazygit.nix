user: { self, ... }: {
  home-manager.users.${user}.imports = [ "${self}/modules/home-manager/programs/lazygit.nix" ];
}
