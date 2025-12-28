{
  xkbLayout,
  ...
}:
{
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
}
