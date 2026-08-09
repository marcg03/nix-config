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

  xdg.configFile = {
    "tmuxp/stlc.yaml".text = ''
      session_name: stlc
      start_directory: "~/src/dev/stlc"
      windows:
        - window_name: zsh
          panes:
            - blank
    '';

    "tmuxp/nix-config.yaml".text = ''
      session_name: nix-config
      start_directory: "~/nix-config"
      windows:
        - window_name: editor
          focus: true
          panes:
            - hx
        - window_name: git
          panes:
            - lazygit
    '';

    "tmuxp/nix-cram.yaml".text = ''
      session_name: nix-cram
      start_directory: "~/src/dev/nix-cram"
      windows:
        - window_name: zsh
          focus: true
          panes:
            - blank
    '';
  };
}
