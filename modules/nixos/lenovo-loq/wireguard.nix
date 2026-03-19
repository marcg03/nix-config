{
  ...
}:
{
  networking.wireguard.interfaces.wg0 = {
    ips = [ "10.0.7.10/24" ];
    privateKeyFile = "/etc/wireguard/privatekey";

    peers = [
      {
        publicKey = "BRSZ2smRB60AT2338X1EysUatY5cgpF3VMpVfxvUuVM=";
        endpoint = "vps.marcgrec.com:51820";
        allowedIPs = [ "10.0.7.0/24" ];
        persistentKeepalive = 25;
      }
    ];
  };
  networking.firewall = {
    trustedInterfaces = [ "wg0" ];
  };
}
