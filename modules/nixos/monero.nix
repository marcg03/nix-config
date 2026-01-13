{ pkgs, lib, ... }:
let
  wallet = "487n6Cbm96e3cTz7fKKaFuiibiPwfAugHGtgmqUTnCXDYWwL3YkcfER1tbjAHH22mEJee8fAYS5B64nzX4m1PJTqRww37be";
in
{
  networking.firewall.allowedTCPPorts = [
    18080
    37888 # p2pool mini
  ];

  services.monero = {
    enable = true;
    prune = true;

    rpc.address = "127.0.0.1";
    rpc.port = 18081;

    priorityNodes = [
      "p2pmd.xmrvsbeast.com:18080"
      "nodes.hashvault.pro:18080"
    ];

    extraConfig = ''
      zmq-pub=tcp://127.0.0.1:18083
    '';
  };

  users.users.p2pool = {
    isSystemUser = true;
    group = "p2pool";
  };
  users.groups.p2pool = { };

  systemd.services.p2pool = {
    description = "Monero P2Pool";
    wantedBy = [ "multi-user.target" ];
    after = [
      "monero.service"
      "network-online.target"
    ];
    wants = [
      "monero.service"
      "network-online.target"
    ];

    serviceConfig = {
      User = "p2pool";
      Group = "p2pool";
      StateDirectory = "p2pool";
      WorkingDirectory = "/var/lib/p2pool";

      ExecStart = ''
        ${pkgs.p2pool}/bin/p2pool \
          --host 127.0.0.1 \
          --wallet ${wallet} \
          --mini
      '';

      Restart = "on-failure";
      RestartSec = 5;
    };
  };

  services.xmrig = {
    enable = true;
    settings = {
      autosave = false;
      cpu.enabled = true;
      pools = [
        {
          url = "127.0.0.1:3333";
          user = "x"; # unused
          pass = "x"; # unused
          keepalive = true;
          tls = false; # local
          coin = "monero";
        }
      ];
    };
  };

  systemd.services.xmrig.after = [ "p2pool.service" ];
  systemd.services.xmrig.wants = [ "p2pool.service" ];
  systemd.services.xmrig.wantedBy = lib.mkForce [ ];
}
