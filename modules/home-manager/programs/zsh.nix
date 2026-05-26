{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    # autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    defaultKeymap = "viins";

    autocd = true;

    setOptions = [
      "correct"
      "extendedglob"
    ];

    history = {
      size = 10000;
      save = 10000;
      share = true;
      ignoreAllDups = true;
      saveNoDups = true;
      findNoDups = true;
      ignoreSpace = true;
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

    initContent = ''
      nixify() {
        if [ ! -e ./.envrc ]; then
          echo "use nix" > .envrc
          direnv allow
        fi
        if [[ ! -e shell.nix ]] && [[ ! -e default.nix ]]; then
          cat > default.nix <<'EOF'
      with import <nixpkgs> {};
      mkShell {
        nativeBuildInputs = [
          bashInteractive
        ];
      }
      EOF
          ''${EDITOR:-vim} default.nix
        fi
      }
      flakify() {
        if [ ! -e flake.nix ]; then
          nix flake new -t github:nix-community/nix-direnv .
        elif [ ! -e .envrc ]; then
          echo "use flake" > .envrc
          direnv allow
        fi
        ''${EDITOR:-vim} flake.nix
      }
    '';
  };
}
