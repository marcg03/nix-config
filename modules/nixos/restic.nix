hostName:
{
  self,
  pkgs,
  inputs,
  config,
  ...
}:
let
  inherit (inputs)
    sops
    ;

  uuid = "6020c554-91b4-464d-a7bd-73d1cd698c11";
  mountPoint = "/mnt/restic-data-backup";
in
{
  sops.secrets."restic/password".sopsFile = "${self}/secrets/passwords.yaml";

  environment.systemPackages = with pkgs; [ restic ];

  systemd.mounts = [
    {
      what = "/dev/disk/by-uuid/${uuid}";
      where = mountPoint;
      type = "ext4";
      options = "noauto";
      unitConfig = {
        StopWhenUnneeded = true;
        JobTimeoutSec = "5s";
        JobTimeoutAction = "none";
      };
    }
  ];

  services.restic.backups."${hostName}-data-backup" = {
    repository = "${mountPoint}/${hostName}-data-backup";
    paths = [ "/data" ];
    passwordFile = config.sops.secrets."restic/password".path;
    initialize = true;
    timerConfig = null;
    pruneOpts = [
      "--keep-daily 7"
      "--keep-weekly 5"
      "--keep-monthly 12"
    ];
  };

  systemd.services."restic-backups-${hostName}-data-backup".unitConfig.RequiresMountsFor = mountPoint;
}
