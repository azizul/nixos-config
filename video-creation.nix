{
  lib,
  inputs,
  system,
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./obs.nix
  ];

  environment.systemPackages = with pkgs; [
    kdenlive
    mediainfo
  ];
}
