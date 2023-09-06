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
      # use hyrland as desktop manager
      ./../../os-system.nix
      # note this is configured as developer, media and gaming home rig
      ./../../home-manager.nix                 
                                                
    ];

  # hostname
  networking.hostName = "Epictetus"; 
}
