{
  pkgs,
  ...
}:
{
  programs.password-store = {
    enable = true;
    package = (pkgs.pass-wayland.withExtensions (exts: [ exts.pass-otp ]));
  };
}
