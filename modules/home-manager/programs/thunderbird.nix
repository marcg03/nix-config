{
  programs.thunderbird = {
    enable = true;
    profiles.default.isDefault = true;
  };

  home.file.".thunderbird/profiles.ini".force = true;
}
