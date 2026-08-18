{ config, self, ... }:
{
  sops.secrets."wifi/lenovo-loq/home" = {
    format = "binary";
    sopsFile = "${self}/secrets/wifi/lenovo-loq/home.nmconnection.bin";
    path = "/run/NetworkManager/system-connections/home.nmconnection";
    restartUnits = [ "NetworkManager.service" ];
  };

  environment.etc."NetworkManager/system-connections/home.nmconnection".source =
    config.sops.secrets."wifi/lenovo-loq/home".path;
}
