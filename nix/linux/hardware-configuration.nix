{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "usbhid" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/mapper/cryptroot";
      fsType = "btrfs";
      options = [ "subvol=@" "compress=zstd:1" "noatime" "ssd" "discard=async" ];
    };

  boot.initrd.luks.devices."cryptroot" = {
    device = "/dev/disk/by-uuid/a8dd2db5-5f1b-43c6-9a42-1584c6adf638";
    crypttabExtraOpts = [ "fido2-device=auto" "token-timeout=10s" ];
  };

  fileSystems."/home" =
    { device = "/dev/mapper/cryptroot";
      fsType = "btrfs";
      options = [ "subvol=@home" "compress=zstd:1" "noatime" "ssd" "discard=async" ];
    };

  fileSystems."/nix" =
    { device = "/dev/mapper/cryptroot";
      fsType = "btrfs";
      options = [ "subvol=@nix" "compress=zstd:1" "noatime" "ssd" "discard=async" ];
    };

  fileSystems."/var/log" =
    { device = "/dev/mapper/cryptroot";
      fsType = "btrfs";
      options = [ "subvol=@log" "compress=zstd:1" "noatime" "ssd" "discard=async" ];
    };

  fileSystems."/.snapshots" =
    { device = "/dev/mapper/cryptroot";
      fsType = "btrfs";
      options = [ "subvol=@snapshots" "compress=zstd:1" "noatime" "ssd" "discard=async" ];
    };

  fileSystems."/swap" =
    { device = "/dev/mapper/cryptroot";
      fsType = "btrfs";
      options = [ "subvol=@swap" "noatime" "ssd" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/9BF3-FAE1";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices = [
    { device = "/swap/swapfile"; }
  ];

  boot.resumeDevice = "/dev/mapper/cryptroot";
  boot.kernelParams = [ "resume=/dev/mapper/cryptroot" "resume_offset=533760" ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
