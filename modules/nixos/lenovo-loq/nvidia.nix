{ config, lib, ... }:
{
  nixpkgs.config.cudaSupport = true;

  allowUnfreeList = [
    "nvidia-x11"
    "nvidia-settings"
  ]
  ++ [
    "cuda_cccl"
    "cuda_cudart"
    "cuda_nvcc"
    "cuda_nvrtc"
    "cudnn"
    "libcublas"
    "libcufft"
    "libcurand"
    "libcusparse"
    "libnpp"
    "libnvjitlink"
  ];

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    nvidia = {
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      powerManagement = {
        enable = true;
        finegrained = true;
      };
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
    nvidia-container-toolkit.enable = true;
  };

  nix.settings = {
    substituters = [ "https://cache.nixos-cuda.org" ];
    trusted-public-keys = [ "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=" ];
  };
}
