{
  programs.vesktop = {
    enable = true;
    settings = {
      arRPC = false;
      checkUpdates = false;
      discordBranch = "stable";
      hardwareAcceleration = true;
      minimizeToTray = false;
      tray = false;
    };

    vencord.settings.plugins = {
      BetterSettings.enabled = true;
      BlurNSWF.enabled = true;
      ClearURLs.enabled = true;
      CopyFileContents.enabled = true;
      FakeNitro.enabled = true;
      FullSearchContext.enabled = true;
      ImageLink.enabled = true;
      ImageZoom.enabled = true;
      MessageLogger.enabled = true;
      NoTrack.enabled = true;
      NoTypingAnimation.enabled = true;
      YoutubeAdblock.enabled = true;
    };
  };
}
