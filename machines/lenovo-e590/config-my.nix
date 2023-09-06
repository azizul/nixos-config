# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

#{ config, pkgs, ... }:
{ username, fullname, email, nixos-version,
  config, pkgs, ... }:

{


  imports =
    [ 
      ./hardware-configuration.nix
      ./../../env-vars.nix # avoid the usual warning etc
      ./../../os-system.nix # use hyrland as desktop manager
      ./../../home-manager.nix # note this is configured as developer, media and gaming home rig
      
    ];

  # hostname
  networking.hostName = "Epictetus"; 
}
