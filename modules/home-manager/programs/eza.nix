{
  programs.eza.enable = true;
  programs.zsh = {
    shellAliases = {
      ls = "eza";
      ll = "eza -l";
      la = "eza -la";
    };
  };
}
