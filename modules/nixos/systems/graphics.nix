{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.graphics;
in {
  options = {
    graphics = {
      enable = lib.mkEnableOption "graphics";
      gpuBrand = lib.mkOption {
        type = lib.types.str;
        default = "nvidia";
        description = "The brand of the GPU to use for graphics.";
      };
      enableOffload = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable GPU offloading for graphics.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      package = pkgs.mesa;
      extraPackages = with pkgs; [
        libva
        libvdpau-va-gl
        vulkan-loader
        vulkan-validation-layers
        mesa.opencl
      ];
    };

    services.xserver.videoDrivers =
      lib.mkIf (cfg.gpuBrand == "nvidia") ["nvidia"]
      // lib.mkIf (cfg.gpuBrand == "amd") ["amdgpu"];
    hardware.nvidia.modesetting.enable = true;

    hardware.nvidia.prime = lib.mkIf (cfg.gpuBrand == "nvidia") {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
