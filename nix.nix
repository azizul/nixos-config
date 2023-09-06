{
  lib,
  inputs,
  system,
  config,
  pkgs,
  ...
}:

{
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = [ "root"  "${username}" ];

  
  # Garbage collection TODO enable this after succesful configuration
  #nix.gc = {
  #  automatic = true;
  #  dates = "daily";
  #  options = "--delete-older-than 3d";
  #};
  
}
