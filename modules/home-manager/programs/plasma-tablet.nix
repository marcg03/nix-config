{ pkgs, config, ... }:
{
  programs.plasma = {
    enable = true;
    immutableByDefault = true;

    workspace = {
      clickItemTo = "open";
      lookAndFeel = "org.kde.breezedark.desktop";
    };

    kwin = {
      virtualDesktops.names = [
        "Desktop 1"
        "Desktop 2"
      ];
      effects.desktopSwitching.animation = "off";
    };

    configFile.kwinrc.Wayland.InputMethod = "${pkgs.maliit-keyboard}/share/applications/com.github.maliit.keyboard.desktop";

    panels = [
      {
        location = "bottom";
        widgets = [
          {
            name = "org.kde.plasma.kickoff";
            config.General = {
              icon = "nix-snowflake-white";
              alphaSort = true;
            };
          }
          "org.kde.plasma.pager"
          {
            iconTasks.launchers = [
              "applications:systemsettings.desktop"
              "applications:org.kde.dolphin.desktop"
              "applications:librewolf.desktop"
              "applications:metronome.desktop"
            ];
          }
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
          "org.kde.plasma.showdesktop"
        ];
      }
    ];
  };

  home.file."Desktop/Documents.desktop" = {
    executable = true;
    text = ''
      [Desktop Entry]
      Type=Link
      Name=Documents
      Icon=folder-documents
      URL=file://${config.home.homeDirectory}/Documents
    '';
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  xdg.desktopEntries.metronome = {
    name = "Metronome";
    exec = "librewolf --new-window https://raffarti.gitlab.io/simpleadvancedmetronome/SimpleAdvancedMetronome.html";
    icon = "chronometer";
    categories = [ "Audio" ];
  };

  home.packages = with pkgs; [
    unar
    maliit-keyboard
  ];
}
