{ self, config, ... }:
{
  sops.secrets."wireguard/ubb" = {
    format = "binary";
    sopsFile = "${self}/secrets/wireguard/ubb.bin";
  };

  networking.wg-quick.interfaces.ubb = {
    configFile = config.sops.secrets."wireguard/ubb".path;
    autostart = false;
  };
}
