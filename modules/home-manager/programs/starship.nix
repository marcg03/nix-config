{
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
}
