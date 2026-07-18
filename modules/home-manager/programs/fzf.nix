{ pkgs, ... }:
{
  home.packages = [ pkgs.fd ];
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    fileWidget.zsh.command = "fd --type d";
  };
}
