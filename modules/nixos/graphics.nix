{ pkgs, lib, config, ...}:

let
    cfg = config.graphics;
in
{
    options = {
        graphics = {
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

    config = {
        hardware.graphics = {
          enable = true;
          enable32Bit = true;
        };

        services.xserver.videoDrivers = lib.mkIf (cfg.gpuBrand == "nvidia") [ "nvidia" ] 
            // lib.mkIf (cfg.gpuBrand == "amd") [ "amdgpu" ];
        hardware.nvidia.modesetting.enable = true;

        hardware.nvidia.prime = {
            offload = {
                enable = true;
                enableOffloadCmd = true;
            };

            intelBusId = "PCI:0:2:0";
            # amdgpuBusId = "";
            nvidiaBusId = "PCI:1:0:0";
        };
    };
}
