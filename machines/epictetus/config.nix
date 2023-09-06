# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

#{ config, pkgs, ... }:
{ username, fullname, email, nixos-version,
  config, pkgs, ... }:

{


  imports =
    [ 
      ./default/hardware-configuration.nix
      ./../../os-system.nix # use hyrland as desktop manager
    ];

  # hostname
  networking.hostName = "Epictetus"; 
}
