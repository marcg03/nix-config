storeDir:
{
  pkgs,
  config,
  ...
}:
{
  programs.password-store = {
    enable = true;
    settings.PASSWORD_STORE_DIR = storeDir;
    package = pkgs.pass-wayland.withExtensions (exts: [
      exts.pass-otp
      exts.pass-genphrase
    ]);
  };
}
