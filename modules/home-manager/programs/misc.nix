{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    gau
    git-crypt
    glow
    kdePackages.alligator
    kdePackages.ktorrent
    musescore
    muse-sounds-manager
    nerd-fonts.sauce-code-pro
    p7zip
  ];
}
