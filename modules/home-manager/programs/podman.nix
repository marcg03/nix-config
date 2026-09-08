{ pkgs, ... }:
{
  home.packages = with pkgs; [
    podman
    podman-compose
    skopeo
    dive
  ];
}
