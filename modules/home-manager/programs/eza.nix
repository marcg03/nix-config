{
  programs.eza.enable = true;
  programs.zsh = {
    shellAliases = {
      ls = "eza";
      ll = "eza -l";
      la = "eza -la";
      lst = "eza -la --tree --git-ignore --color=always | less -R";
      lat = "eza -la --tree --color=always | less -R";
    };
  };
}
