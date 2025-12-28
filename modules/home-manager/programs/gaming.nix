{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    javaPackages.compiler.temurin-bin.jdk-21
    pcsx2
    ppsspp
    prismlauncher
  ];
}
