{
  lib,
  inputs,
  system,
  config,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    blender
  ];
}
