{
  services.monero = {
    enable = true;
    limits.download = -1;
    limits.upload = -1;
    prune = true;
  };
}
