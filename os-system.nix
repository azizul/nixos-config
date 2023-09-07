{
  lib,
  inputs,
  system,
  config,
  pkgs,

  username,
  fullname,
  nixos-version,
  
  ...
}:

{
  imports = [
    ./gtk.nix
    ./nix.nix
    ./bootloader.nix
    ./env-vars.nix
  ];

  # Enable networking
  networking.networkmanager.enable = true;
  
  # Set your time zone.
  time.timeZone = "Asia/Kuala_Lumpur";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ms_MY.UTF-8";
    LC_IDENTIFICATION = "ms_MY.UTF-8";
    LC_MEASUREMENT = "ms_MY.UTF-8";
    LC_MONETARY = "ms_MY.UTF-8";
    LC_NAME = "ms_MY.UTF-8";
    LC_NUMERIC = "ms_MY.UTF-8";
    LC_PAPER = "ms_MY.UTF-8";
    LC_TELEPHONE = "ms_MY.UTF-8";
    LC_TIME = "ms_MY.UTF-8";
  };
  
  # set zsh as default since home-manager can't
  programs.zsh.enable = true;
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    initialPassword = "${username}";
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "${username}";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    # base
    vim
    wget
    git
    curl
    udev # system & service manager
    pkgconfig # tool to search other package info
    yad # gui dialog tool for shell scripts

    # System application distribution
    flatpak # linux app sandboxing and distribution framework
    appimage-run
    appimagekit
    
    # System bluetooth
    bluez  # bluetooth support for linux
    bluez-tools # command-line manager for bluez
    blueman # gtk based bluetooth manager
    
    # System audio
    pipewire # server and API to handle multimedia pipelines
    wireplumber # session/policy manager for pipewire
    alsaLib # Advanced linux sound architecture ALSA library
    pavucontrol # PulseAudio volume control
    
    # System network
    networkmanager # network config & mgt tools
    networkmanagerapplet # gnome control applet
    
    # System display and desktop
    brightnessctl # control device brightness
    light # tool to control background light
    xdg-desktop-portal # desktop integration
    xdg-utils # desktop integration task
    slurp # select a region in a wayland compositor
    gthumb # image browser and viewer for gnome
    xorg.libX11 
    xorg.libXcursor
    cinnamon.cinnamon-desktop # library and data for various cinnamon module
    dconf # GDE configuration db
    
    # System disk
    gparted # graphical disk partioning tool
    
    # GUI framework
    gtk2 # multiplatform toolkit
    gtk3 # multiplatform toolkit
    gtk4 # multiplatform toolkit
    qt5.qtwayland # cross platform framework for C++
    qt6.qtwayland # cross platform framework for C++ 
    qt6.qmake
    libsForQt5.qt5.qtwayland 
    qt5ct # QT 5 configuration tool
    
     # display manager
    lightdm # cross desktop display manager
    sddm # QML based X11 display manager
    gnome.gdm # program that manages graphical display servers and user logins

    # Wayland & hyprland
    hyprland # dynamic tilling wayland compositor
    xwayland # X server for interfacing X11 apps and Wayland protocols
    cliphist # wayland clipboard manager
    rofi-wayland # windows switcher, run dialog and dmenu for Wayland
    swww # animated wall paper daemon for wayland
    swaynotificationcenter # notification daemon with GUI build for sway
    lxde.lxsession # LXDE session manager
    inputs.hyprwm-contrib.packages.${system}.grimblast
    gtklock # GTK based lock screen for Wayland
    eww-wayland # Elkowar wacky widget
    xdg-desktop-portal-hyprland # xdg desktop portal backend for Hyprland
    
  ];

 # Enable steam
  programs.steam.enable = true;
 
  ####################
  #### FONT     ######
  ####################
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];
  
  ####################
  #### HYPRLAND ######
  ####################
  # default xwayland is enabled & xdg-desktop-portal-hyprland is portal app
  programs.hyprland.enable = true;


  # Home manager options
  home-manager.users.${username} = {
    programs.waybar = {
      enable = true;
#      package = inputs.hyprland.packages.${system}.waybar-hyprland;
    };
  };
  
  ####################
  #### X-SERVER ######
  ####################
  services.xserver = {
    layout = "us";
    xkbVariant = "";
    enable = true;
    libinput.enable = true;
    desktopManager = {
      cinnamon.enable = true;
    };
    displayManager = {
     # autoLogin = {
     #   enable = true;
     #   user = "${username}";
     # };
      gdm = {
        enable = true;
      };
    };
  };
  
  # XDG Desktop Portal stuff
  xdg.portal.enable = true;

  ####################
  #### GPU      ######
  ####################
  hardware.opengl.enable = true;
  
  ####################
  #### BLUETOOTH #####
  ####################
  hardware.bluetooth.enable = true;
  
  ####################
  #### AUDIO     #####
  ####################
  security.rtkit.enable = true;
  sound.enable = lib.mkForce false;
  hardware.pulseaudio.enable = lib.mkForce false;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    wireplumber.enable = true;
    jack.enable = true; # (optional)
  };
  
  ####################
  #### SERVICES  #####
  ####################
  services.devmon.enable = true;
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  services.blueman.enable = true;
  services.flatpak.enable = true;
  services.dbus.enable = true;
  services.locate.enable = true;
  services.openssh.enable = true;
  services.printing.enable = true;

  ####################
  #### OVERLAY   #####
  ####################
  nixpkgs.overlays = [
    (self: super: {
    })
  ];

  system.stateVersion = "${nixos-version}";
}
