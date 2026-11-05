user: { self, ... }: {
  home-manager.users.${user}.imports = [ "${self}/modules/home-manager/programs/plasma.nix" ];

  environment.persistence."/data".users.${user} = {
    files = [
      ".config/kwinoutputconfig.json"
    ];
    directories = [
      ".local/share/kscreen"
    ];
  };
}
