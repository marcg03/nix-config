{
  pkgs,
  ...
}:
{
  virtualisation.containers = {
    enable = true;
    containersConf.settings = {
      containers.log_driver = "k8s-file";
    };
    podman = {
      enable = true;
      extraPackages = with pkgs; [ podman-compose ];
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
