{
  services.xandikos = {
    enable = true;
    address = "0.0.0.0";
    port = 8080;
    extraOptions = [ "--autocreate" "--defaults" ];
  };

  networking.firewall.interfaces."nebula.mesh".allowedTCPPorts = [ 8080 ];
}
