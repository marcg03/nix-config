user: { self, ... }: {
  home-manager.users.${user}.imports = [ "${self}/modules/home-manager/programs/librewolf.nix" ];

  environment.persistence."/data".users.marcg.directories = [ ".librewolf" ];
}
