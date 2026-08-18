user:
{ self, inputs, ... }:
let
  inherit (inputs) home-manager;
in
{
  home-manager.users.${user}.imports = [ "${self}/modules/home-manager/programs/direnv.nix" ];

  environment.persistence."/data".users.${user}.directories = [ ".local/share/direnv" ];
}
