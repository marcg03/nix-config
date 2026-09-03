{ config, self, ... }:
{
  sops.secrets."wifi/thinkpad-x230/home" = {
    format = "binary";
    sopsFile = "${self}/secrets/wifi/thinkpad-x230/home.nmconnection.bin";
    path = "/run/NetworkManager/system-connections/home.nmconnection";
    restartUnits = [ "NetworkManager.service" ];
  };
}
