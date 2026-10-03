{
  self,
  config,
  lib,
  ...
}:
let
  host = config.networking.hostName;
  isLighthouse = host == "hetzner-cx23";
in
{
  sops.secrets.nebula-key = {
    sopsFile = "${self}/secrets/nebula/${host}.bin";
    format = "binary";
    owner = "nebula-mesh";
    restartUnits = [ "nebula@mesh.service" ];
  };

  services.nebula.networks.mesh = {
    enable = true;
    inherit isLighthouse;
    ca = ./ca.crt;
    cert = ./${host}.crt;
    key = config.sops.secrets.nebula-key.path;
    lighthouses = lib.optionals (!isLighthouse) [ "10.200.0.1" ];
    staticHostMap."10.200.0.1" = [ "vps.marcgrec.com:4242" ];
    listen.port = if isLighthouse then 4242 else 0;
    settings.punchy.punch = true;
    firewall = {
      outbound = [
        {
          port = "any";
          proto = "any";
          host = "any";
        }
      ];
      inbound = [
        {
          port = "any";
          proto = "any";
          group = "trusted";
        }
      ];
    };
  };

  networking.firewall.allowedUDPPorts = lib.mkIf isLighthouse [ 4242 ];
}
