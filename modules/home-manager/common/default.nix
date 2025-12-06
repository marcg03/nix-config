{
  pkgs,
  userConfig,
  xkbLayout,
  ...
}:

{
  home.username = "${userConfig.name}";
  home.homeDirectory = "/home/${userConfig.name}";

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    p7zip
    nerd-fonts.sauce-code-pro
    devenv
    glow
    musescore
    muse-sounds-manager
    prismlauncher
    javaPackages.compiler.temurin-bin.jdk-21
  ];

  services.kdeconnect.enable = true;

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

  programs.vesktop.enable = true;

  programs.password-store = {
    enable = true;
    package = (pkgs.pass-wayland.withExtensions (exts: [ exts.pass-otp ]));
    settings = {
      PASSWORD_STORE_KEY = "E136FB3E31366B80246BCB6635E15F4C347F9673";
    };
  };

  programs.plasma = {
    enable = true;
    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
    };

    kwin = {
      effects.desktopSwitching.animation = "off";
      virtualDesktops.number = 5;
    };

    shortcuts = {
      kwin = {
        "Switch to Desktop 1" = "Meta + 1";
        "Switch to Desktop 2" = "Meta + 2";
        "Switch to Desktop 3" = "Meta + 3";
        "Switch to Desktop 4" = "Meta + 4";
        "Switch to Desktop 5" = "Meta + 5";

        "Window to Desktop 1" = if (xkbLayout == "gb") then "Meta + !" else "Meta + !";
        "Window to Desktop 2" = if (xkbLayout == "gb") then "Meta + \"" else "Meta + @";
        "Window to Desktop 3" = if (xkbLayout == "gb") then "Meta + £" else "Meta + #";
        "Window to Desktop 4" = if (xkbLayout == "gb") then "Meta + $" else "Meta + $";
        "Window to Desktop 5" = if (xkbLayout == "gb") then "Meta + %" else "Meta + %";
      };
    };
  };

  programs.jq = {
    enable = true;
  };

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
    };
  };
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "base16_transparent";
    };
    languages = {
      language = [
        {
          name = "nix";
          formatter = {
            command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
          };
          auto-format = true;
        }
        {
          name = "python";
          auto-format = true;
          language-servers = [
            "ty"
            "ruff"
          ];
        }
      ];
    };
    extraPackages = with pkgs; [
      ty
      ruff
      rust-analyzer
      marksman
      typescript-language-server
      vscode-json-languageserver
      nil
      clang-tools
    ];
  };

  programs.uv.enable = true;

  programs.eza.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 5000;
      save = 5000;
      share = true;
      ignoreAllDups = true;
      ignorePatterns = [
        "rm"
        "rm -f"
        "rm -rf *"
        "pkill *"
        "clear"
        "exit"
        "?"
        "??"
        "???"
      ];
    };

    shellAliases = {
      ls = "eza";
      ll = "eza -l";
      la = "eza -la";
      gs = "git status";
    };

    initContent = ''
      # vi mode
      bindkey -v
      export KEYTIMEOUT=1

      setopt autocd
      setopt correct
      setopt extendedglob
    '';
  };

  programs.git = {
    enable = true;

    ignores = [
      "**/.claude/settings.local.json"
      ".DS_Store"
      "*.swp"
      "*.tmp"
      "result"
    ];

    settings = {
      user.name = "${userConfig.name}";
      user.email = "${userConfig.email}";

      alias = {
        co = "checkout";
        ci = "commit";
        st = "status -sb";
        br = "branch";
        lg = "log --oneline --graph --decorate";
      };

      core.editor = "hx";
      core.autocrlf = "input";

      pull.rebase = true;
      push.default = "current";
      init.defaultBranch = "main";
      merge.ff = "only";
    };
  };

  programs.starship = {
    enable = true;

    settings = {
      add_newline = false;

      directory.truncate_to_repo = true;
      git_status.disabled = false;
      battery.disabled = true;
      time.disabled = true;

      character = {
        success_symbol = "❯";
        error_symbol = "✗";
      };
    };
  };

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

  programs.lazygit = {
    enable = true;
  };

  programs.claude-code.enable = true;

  programs.home-manager.enable = true;
}
