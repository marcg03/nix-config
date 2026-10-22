hostName: {
  environment.persistence."/host".directories = [ "/etc/NetworkManager/system-connections" ];

  networking = {
    inherit hostName;
    networkmanager.enable = true;
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    settings.publish = {
      "disable-publishing" = false;
      "publish-addresses" = true;
      "publish-domain" = true;
    };
  };
}
