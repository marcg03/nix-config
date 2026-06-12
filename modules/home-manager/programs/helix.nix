{
  pkgs,
  ...
}:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      wl-clipboard
      xclip
      git
      fzf
    ];
    settings = {
      theme = "jetbrains_dark";
      editor = {
        clipboard-provider = "wayland";
      };
    };
  };
}
