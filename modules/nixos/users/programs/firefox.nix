user: { self, ... }: {
  home-manager.users.${user}.imports = [ "${self}/modules/home-manager/programs/firefox.nix" ];

  environment.persistence."/data".users.${user}.directories = [ ".config/mozilla/firefox" ];
}
