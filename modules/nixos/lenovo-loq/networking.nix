{ config, self, ... }:
{
  sops.secrets."wifi/lenovo-loq/home" = {
    format = "binary";
    sopsFile = "${self}/secrets/wifi/lenovo-loq/home.nmconnection.bin";
    path = "/run/NetworkManager/system-connections/home.nmconnection";
    restartUnits = [ "NetworkManager.service" ];
  };
}
