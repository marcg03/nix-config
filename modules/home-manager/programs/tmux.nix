{
  pkgs,
  ...
}:
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    baseIndex = 1;
    newSession = true;
    keyMode = "vi";
    mouse = true;
    shortcut = "space";
    sensibleOnTop = true;
    tmuxinator.enable = true;
    plugins = with pkgs; [
      tmuxPlugins.tokyo-night-tmux
      tmuxPlugins.yank
      tmuxPlugins.sensible
      tmuxPlugins.vim-tmux-navigator
    ];
    extraConfig = ''
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';
  };
}
