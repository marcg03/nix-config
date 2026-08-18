{ self, config, ... }:
{
  sops.secrets."root" = {
    sopsFile = "${self}/secrets/passwords.yaml";
    neededForUsers = true;
  };

  users.users.root = {
    hashedPasswordFile = config.sops.secrets."root".path;
  };
}
