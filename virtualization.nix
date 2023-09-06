{
  system,
  config,
  inputs,
  lib,
  pkgs,

  username,
  ...
}:

{
  #### VirtualBox
  # nixpkgs.config.allowUnfree = true;
  # virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.host.enableExtensionPack = true; # The extension pack is proprietary! Fuck!
  # virtualisation.virtualbox.guest.enable = true;
  # virtualisation.virtualbox.guest.x11 = true;
  # users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

  #### QEMU (Make sure you run this once: "sudo virsh net-autostart default")
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  users.users.${username}.extraGroups = [ "libvirtd" ];
  environment.systemPackages = with pkgs; [
    virt-manager
    qemu
  ];
}
