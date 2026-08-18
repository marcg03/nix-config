# NixOS configurations for my machines

> **TL;DR** I use an impermanence setup with sops-nix for secrets and disko for
partitioning/luks/lvm.

## Impermanence

This setup uses the following mounts for persistence:
- `/host` stores only stuff that answers the following question with no: "Should
these files ever leave the machine?". Some example files are `/etc/machine-id`
or `/etc/ssh/ssh_host_ed25519_key`.
- `/data` stores files that survive a reboot and should be backed up.
- `/cache` stores files that survive a reboot but should not be backed up.

## Setup (NixOS-Anywhere)

This method needs the target computer connected via
an ethernet cable and another computer from which
[nixos-anywhere](https://github.com/nix-community/nixos-anywhere) is run.

### Getting the custom installer on a USB

Run `nix build
'.#nixosConfigurations.nixos-installer.config.system.build.isoImage'`. This will
build an iso image at `./result/iso/nixos-minimal-*-x86_64-linux.iso`.

Run `sudo dd if=./result/iso/nixos-minimal-*-x86_64-linux.iso of=/dev/sdX
oflag=sync status=progress bs=4M` to get the image on the USB.

Now the USB is ready to be booted into.

### Installation

```bash
nix run github:nix-community/nixos-anywhere -- \
  --extra-files <host-files-dir> --flake '.#<my-desired-nixos-config>' \
  --disk-encryption-keys /tmp/secret.key <(pass show <my-secret-pass>) \
  --target-host root@<target-computer>
```

`<host-files-dir>` must contain
`/host/etc/ssh/{ssh_host_ed25519_key,ssh_host_ed25519_key.pub}` (used to decrypt
the SOPS secrets via ssh-to-age; make sure this is correctly configured).
