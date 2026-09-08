user:
{
  enableNvidia ? false,
}:
{
  self,
  ...
}:
{
  home-manager.users.${user}.imports = [ "${self}/modules/home-manager/programs/podman.nix" ];

  virtualisation.containers = {
    enable = true;
    registries.settings = {
      registry = [
        {
          location = "docker.io";
        }
        {
          location = "quay.io";
        }
      ];
    };
  };

  virtualisation.podman = {
    enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  hardware.nvidia-container-toolkit.enable = enableNvidia;

  environment.persistence."/cache".users.${user}.directories = [ ".local/share/containers" ];
}
