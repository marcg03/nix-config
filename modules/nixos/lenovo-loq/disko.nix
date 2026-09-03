{
  lib,
  pkgs,
  utils,
  ...
}:
{
  disko.devices = {
    disk.ssd1 = {
      type = "disk";
      device = "/dev/disk/by-id/nvme-CT1000P3SSD8_235245DD5281";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            type = "EF00";
            size = "512M";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };
          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "crypted1";
              passwordFile = "/tmp/secret.key";
              settings.allowDiscards = true;
              content = {
                type = "lvm_pv";
                vg = "pool";
              };
            };
          };
        };
      };
    };

    disk.ssd2 = {
      type = "disk";
      device = "/dev/disk/by-id/nvme-CT1000P3SSD8_24514D2FF581";
      content = {
        type = "luks";
        name = "crypted2";
        passwordFile = "/tmp/secret.key";
        settings.allowDiscards = true;
        content = {
          type = "lvm_pv";
          vg = "pool";
        };
      };
    };

    lvm_vg.pool = {
      type = "lvm_vg";
      lvs =
        let
          striped = [
            "-i"
            "2"
          ];
        in
        {
          swap = {
            size = "48G";
            extraArgs = striped;
            content = {
              type = "swap";
              resumeDevice = true;
              discardPolicy = "once";
            };
          };
          nix = {
            size = "128G";
            extraArgs = striped;
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/nix";
            };
          };
          host = {
            size = "1G";
            extraArgs = striped;
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/host";
            };
          };
          data = {
            size = "64G";
            extraArgs = striped;
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/data";
            };
          };
          ephemeral = {
            size = "64G";
            extraArgs = striped;
            name = "ephemeral";
          };
          cache = {
            size = "100%FREE";
            extraArgs = striped;
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/cache";
            };
          };
        };
    };
  };

  environment.persistence = {
    "/host" = {
      hideMounts = true;

      files = [
        "/etc/machine-id"
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_ed25519_key.pub"
      ];

      directories = [
        "/var/lib/nixos"
        "/var/lib/systemd"
      ];
    };

    "/data" = {
      hideMounts = true;
    };

    "/cache" = {
      hideMounts = true;

      directories = [
        "/var/cache"
        "/var/log"
      ];
    };
  };

  fileSystems."/" = {
    device = "/dev/pool/ephemeral";
    fsType = "ext4";
    options = [ "noatime" ];
  };

  fileSystems."/nix".neededForBoot = true;
  fileSystems."/data".neededForBoot = true;
  fileSystems."/host".neededForBoot = true;
  fileSystems."/cache".neededForBoot = true;

  boot.initrd.systemd =
    let
      ephemeralUnit = "${utils.escapeSystemdPath "/dev/pool/ephemeral"}.device";
      mkfsExt4 = lib.getExe' pkgs.e2fsprogs "mkfs.ext4";
    in
    {
      enable = true;
      services.ephemeral-unlock = {
        description = "Open ephemeral root";
        wantedBy = [ "initrd-root-device.target" ];
        before = [ "sysroot.mount" ];
        after = [
          "systemd-hibernate-resume.service"
          ephemeralUnit
        ];
        requires = [ ephemeralUnit ];
        unitConfig.DefaultDependencies = false;
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStart = "${mkfsExt4} -q -F /dev/pool/ephemeral";
        };
      };
      storePaths = [ mkfsExt4 ];
    };
}
