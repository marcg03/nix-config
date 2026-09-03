{
  programs.librewolf = {
    enable = true;

    settings = {
      "privacy.clearOnShutdown_v2.siteSettings" = false;
      "privacy.clearOnShutdown.siteSettings" = false;
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
