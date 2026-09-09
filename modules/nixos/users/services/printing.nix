user:
{ pkgs, ... }:
{
  services.printing = {
    enable = true;
    drivers = [ pkgs.gutenprint ];
  };
  hardware.sane.enable = true;
  users.users.${user}.extraGroups = [ "scanner" ];
}
