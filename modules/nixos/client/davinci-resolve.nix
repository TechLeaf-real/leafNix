{pkgs, ...}: {
  environment.systemPackages = [pkgs.davinci-resolve];
  boot.initrd.kernelModules = ["amdgpu"];
  environment.variables = {
    RUSTICL_ENABLE = "radeonsi";
    ROC_ENABLE_PRE_VEGA = "1";
  };
}
