user:
{ self, ... }:
{
  home-manager.users.${user}.imports = [ "${self}/modules/home-manager/programs/vesktop.nix" ];

  environment.persistence = {
    "/cache".users.${user} = {
      directories = [ ".config/vesktop/sessionData" ];
      files = [ ".config/vesktop/state.json" ];
    };
  };
}
