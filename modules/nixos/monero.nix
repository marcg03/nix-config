{
  lib,
  ...
}:
{
  services.monero = {
    enable = true;
    limits.download = -1;
    limits.upload = -1;
    prune = true;
  };

  services.xmrig = {
    enable = true;

    settings = {
      autosave = false;

      cpu = {
        enabled = true;
      };

      opencl = false;
      cuda = false;

      pools = [
        {
          url = "xmr-eu1.nanopool.org:10343";
          user = "83mtyXhBWxp7WP9XhtgJyGZDTpt7q62mpCnmtfrfT5ofFbJ6SqSnsey5ndkWxpcTaoEsFPnuJCzXXDVmTuGtNmStDNAKEMf";
          coin = "monero";
          keepalive = true;
          tls = true;
        }
      ];
    };
  };

  systemd.services.xmrig.wantedBy = lib.mkForce [ ];
}
