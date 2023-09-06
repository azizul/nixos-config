{
  lib,
  inputs,
  system,
  config,
  pkgs,

  username,
  fullname,
  ...
}:

{
  imports = [
    ./hardware-config.nix
    ./../../global-config.nix
    ./../../video-creation.nix
    ./../../intensive-apps.nix
    ./../../virtualization.nix
  ];

  # Hostname
  networking.hostName = "Pongo";

  # GPU driver stuff:
  # https://nixos.wiki/wiki/AMD_GPU
  services.xserver.videoDrivers = [ "amdgpu" ];
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.hip}"
  ];
  hardware.opengl.extraPackages = with pkgs; [
    rocm-opencl-icd
    rocm-opencl-runtime
    amdvlk
  ];
  hardware.opengl.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
}
