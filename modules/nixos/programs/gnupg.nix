{ pkgs, ... }:
{
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-all;
  };

  environment.systemPackages = with pkgs; [ gnupg ];
}
