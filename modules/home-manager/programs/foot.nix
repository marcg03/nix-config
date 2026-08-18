{ pkgs, ... }:
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "foot-direct";
        font = "SauceCodePro Nerd Font:size=10";
        font-bold = "SauceCodePro Nerd Font:size=10";
        font-italic = "SauceCodePro Nerd Font:size=10";
        font-bold-italic = "SauceCodePro Nerd Font:size=10";
      };
      mouse = {
        hide-when-typing = "yes";
      };
    };
  };

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    nerd-fonts.sauce-code-pro
  ];
}
