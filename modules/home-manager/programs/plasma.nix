{ pkgs, ... }:
{
  programs.plasma = {
    enable = true;
    immutableByDefault = true;
    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
    };

    kwin = {
      virtualDesktops.names = [
        "Desktop 1"
        "Desktop 2"
        "Desktop 3"
        "Desktop 4"
        "Desktop 5"
      ];
      effects.desktopSwitching.animation = "off";
    };

    shortcuts.kwin = {
      "Switch to Desktop 1" = "Meta+1";
      "Switch to Desktop 2" = "Meta+2";
      "Switch to Desktop 3" = "Meta+3";
      "Switch to Desktop 4" = "Meta+4";
      "Switch to Desktop 5" = "Meta+5";
    };

    panels = [
      {
        location = "bottom";
        widgets = [
          {
            name = "org.kde.plasma.kickoff";
            config = {
              General = {
                icon = "nix-snowflake-white";
                alphaSort = true;
              };
            };
          }
          "org.kde.plasma.pager"
          {
            iconTasks = {
              launchers = [
                "applications:systemsettings.desktop"
                "applications:org.kde.dolphin.desktop"
                "applications:librewolf.desktop"
                "applications:foot.desktop"
              ];
            };
          }
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
          "org.kde.plasma.showdesktop"
        ];
      }
    ];
  };

  home.packages = with pkgs; [ unar ];
}
