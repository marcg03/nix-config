user:
{ self, ... }:
{
  home-manager.users.${user}.imports = [ "${self}/modules/home-manager/programs/prism-launcher.nix" ];

  environment.persistence."/cache".users.${user}.directories = [ ".local/share/PrismLauncher" ];
}
