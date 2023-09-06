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
    ./gtk.nix
    ./nix.nix
    ./bootloader.nix
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
    vim
    wget
    git
    lld
    gcc
    clang
    udev
    llvmPackages.bintools
    procps
    killall
    zip
    unzip
    bluez
    bluez-tools
    brightnessctl
    light
    xdg-desktop-portal
    xdg-utils
    pipewire
    wireplumber
    alsaLib
    pkgconfig
    networkmanager
    networkmanagerapplet
    fzf
    tldr
    sox
    yad
    flatpak
    gtk2
    gtk3
    gtk4
    helix
    brave
    xfce.thunar
    kitty
    bat
    exa
    pavucontrol
    blueman
    ydotool
    cava
    neofetch
    cpufetch
    starship
    lolcat
    gimp
    transmission-gtk
    slurp
    gparted
    vlc
    mpv
    krabby
    zellij
    shellcheck
    thefuck
    gthumb
    cmatrix
    lagrange
    steam
    xorg.libX11
    xorg.libXcursor
    cinnamon.cinnamon-desktop

    # programming languge
    cargo
    rustc
    rust-analyzer
    go

    # command shell
    nushell

    # display manager
    lightdm
    sddm
    gnome.gdm

    # hyprland
    hyprland
    xwayland
    cliphist
    alacritty
    rofi-wayland
    swww
    swaynotificationcenter
    lxde.lxsession
    inputs.hyprwm-contrib.packages.${system}.grimblast
    gtklock
    eww-wayland
    xdg-desktop-portal-hyprland
    
  ];

  ####################
  #### FONT     ######
  ####################
  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    noto-fonts-cjk
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];
  
  ####################
  #### HYPRLAND ######
  ####################
  programs.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
      hidpi = true;
    };
  };

  # Home manager options
  home-manager.users.${username} = {
    programs.waybar = {
      enable = true;
      package = inputs.hyprland.packages.${system}.waybar-hyprland;
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
      autoLogin = {
        enable = true;
        user = "${username}";
      };
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
}
