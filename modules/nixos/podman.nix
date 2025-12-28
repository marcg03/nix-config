{
  pkgs,
  ...
}:
{
  virtualisation.containers.enable = true;
  virtualisation.containers.containersConf.settings = {
    containers.log_driver = "k8s-file";
  };
  virtualisation.podman = {
    enable = true;
    extraPackages = with pkgs; [ podman-compose ];
    defaultNetwork.settings.dns_enabled = true;
  };
}
