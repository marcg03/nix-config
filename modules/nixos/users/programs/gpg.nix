user:
{ self, config, ... }:
let
  homeConfig = config.home-manager.users.${user};
in
{
  home-manager.users.${user}.imports = [ "${self}/modules/home-manager/programs/gpg.nix" ];

  environment.persistence."/cache".directories = [
    {
      directory = homeConfig.programs.gpg.homedir;
      user = config.users.users.${user}.name;
      group = config.users.users.${user}.group;
      mode = "0700";
    }
  ];
}
