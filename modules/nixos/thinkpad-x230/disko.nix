{
  lib,
  pkgs,
  utils,
  ...
}:
{
  disko.devices = {
    disk.main = {
      type = "disk";
      device = "/dev/disk/by-id/ata-SAMSUNG_MZ7TD256HAFV-000L7_S16GNSADB02105";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "512M";
            type = "EF00";
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
              name = "crypted";
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

    lvm_vg.pool = {
      type = "lvm_vg";
      lvs = {
        swap = {
          size = "16G";
          content = {
            type = "swap";
            resumeDevice = true;
            discardPolicy = "once";
          };
        };
        nix = {
          size = "80G";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/nix";
          };
        };
        host = {
          size = "1G";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/host";
          };
        };
        data = {
          size = "40G";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/data";
          };
        };
        ephemeral = {
          size = "16G";
          name = "ephemeral";
        };
        cache = {
          size = "100%FREE";
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

  boot.initrd.systemd.enable = true;

  boot.initrd.systemd.services.ephemeral-unlock =
    let
      ephemeralUnit = "${utils.escapeSystemdPath "/dev/pool/ephemeral"}.device";
    in
    {
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
        ExecStart = "${pkgs.e2fsprogs}/bin/mkfs.ext4 -q -F /dev/pool/ephemeral";
      };
    };

  boot.initrd.systemd.storePaths = [ "${pkgs.e2fsprogs}/bin/mkfs.ext4" ];
}
