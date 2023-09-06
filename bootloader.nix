{
  lib,
  config,
  pkgs,
  system,
  inputs,
  ...
}:

{
  # kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;
  
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  # Enable SysRQ
  boot.kernel.sysctl."kernel.sysrq" = 1;
}
