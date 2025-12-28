{
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

    initContent = ''
      # vi mode
      bindkey -v
      export KEYTIMEOUT=1

      setopt autocd
      setopt correct
      setopt extendedglob
    '';
  };
}
