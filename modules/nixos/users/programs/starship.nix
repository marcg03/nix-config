user: { self, ... }: {
  home-manager.users.${user}.imports = [ "${self}/modules/home-manager/programs/starship.nix" ];
}
