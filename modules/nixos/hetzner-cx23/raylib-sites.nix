{ ... }:
let
  domain = "raylib.marcgrec.com";
  siteRoot = "/srv/raylib";
  deployUser = "marcg";
in
{
  systemd.tmpfiles.rules = [ "d ${siteRoot} 0755 ${deployUser} users - -" ];

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedTlsSettings = true;

    virtualHosts.${domain} = {
      enableACME = true;
      forceSSL = true;
      root = siteRoot;
      locations."/".extraConfig = ''
        add_header Cache-Control "no-cache";
      '';
      locations."= /".extraConfig = "autoindex on;";
      locations."= /alin/".extraConfig = "autoindex on;";
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "marcgrec@tuta.com";
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
