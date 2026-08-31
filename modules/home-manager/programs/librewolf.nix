{
  programs.librewolf = {
    enable = true;

    settings = {
      "privacy.clearOnShutdown_v2.siteSettings" = false;
      "privacy.clearOnShutdown.siteSettings" = false;
    };

    policies.Cookies = {
      Allow = [
        "https://google.com"
        "http://google.com"
        "https://youtube.com"
        "http://youtube.com"
        "https://claude.ai"
        "http://claude.ai"
        "https://twitch.tv"
        "http://twitch.tv"
        "https://github.com"
        "http://github.com"
        "https://tuta.com"
        "http://tuta.com"
        "https://codeberg.org"
        "http://codeberg.org"
        "https://nixos.org"
        "http://nixos.org"
        "https://speedrun.com"
        "http://speedrun.com"
        "https://linkedin.com"
        "http://linkedin.com"
        "https://europa.eu"
        "http://europa.eu"
      ];
      Locked = true;
    };

    profiles.personal = {
      id = 0;
      isDefault = true;

      settings = {
        "browser.toolbars.bookmarks.visibility" = "always";
        "browser.startup.page" = 0;
      };

      bookmarks = {
        force = true;
        settings = [
          {
            name = "Nix";
            toolbar = true;
            bookmarks = [
              {
                name = "Discourse";
                url = "https://discourse.nixos.org";
              }
              {
                name = "Packages";
                url = "https://search.nixos.org/packages";
                keyword = "np";
              }
            ];
          }
          {
            name = "Claude";
            url = "https://claude.ai";
            keyword = "cl";
          }
          {
            name = "Codeberg";
            url = "https://codeberg.org";
          }
          {
            name = "Tuta";
            url = "https://app.tuta.com";
          }
        ];
      };
    };
  };
}
