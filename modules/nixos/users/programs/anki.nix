user:
{ self, ... }:
{
  home-manager.users.${user}.imports = [ "${self}/modules/home-manager/programs/anki.nix" ];

  environment.persistence."/data".users.${user}.directories = [ ".local/share/Anki2" ];
}
