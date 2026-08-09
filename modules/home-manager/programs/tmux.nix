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
    keyMode = "emacs";
    mouse = true;
    shortcut = "b";
    tmuxp.enable = true;
    sensibleOnTop = true;
    plugins = with pkgs; [
      tmuxPlugins.tokyo-night-tmux
      tmuxPlugins.yank
    ];
    extraConfig = ''
      set -g renumber-windows on

      bind c new-window -c "#{pane_current_path}"
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';
  };
}
