{
  pkgs,
  ...
}:
{
  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
    };
  };

  programs.htop = {
    enable = true;
    package = pkgs.htop-vim;
  };
}
