{ config, pkgs, lib, username, fullname, email, editor, browser, nixos-version, ... }:


{
  # allow non-free software installation
  nixpkgs.config.allowUnfree = true;

  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "${nixos-version}"; # FIXME not sure why this is required
  
  #overlays
  #services.emacs.package = pkgs.emacs-unstable;
  #nixpkgs.overlays = [
  #  (import (builtins.fetchTarball {
  #    url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
  #    sha256 = "0lzks54qzqvfazany625nn2f8knlm0sd25j0i2jh3g0y60srrcij";
  #  }))
  #];

  # enable font management
  fonts.fontconfig.enable = true; 
  
  home.packages = with pkgs; [
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # fonts?
    (nerdfonts.override { fonts = ["JetBrainsMono" "FantasqueSansMono" "FiraCode" "DroidSansMono" "Iosevka" ]; })
    comfortaa
    inter
    dotcolon-fonts 
    source-code-pro
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    # shell
    thefuck # correct your previous console command
    keychain # keychain management tools
    rmlint # remove duplicates and other lint
    rsync # incremental file transfer utility
    ncdu # disk usage analyzer with ncurses UI
    btop # resource monitoring tool
    rlwrap # readline wrapper for console program; i.e. SBCL
    tree
    tmux # terminal multiplexer
    kitty # openGL based terminal emulator
    procps # tool to list proc files
    killall
    zip
    unzip
    shellcheck # shell script analysis tool
    bat # cat clone with git integration
    exa # ls replacement in rust
    ydotool # generic command line automation tool
    cava # console base audio visualization for alsa
    neofetch # customize system info script 
    cpufetch # fancy cpu architecture script
    starship # customizable prompt for any shell
    sox # simple rate audio converter
    fzf # fuzzy finder written in Go
    tldr # simplified man page
    outils # checksums programs
    gnupg # GNU pgp program
    ripgrep # fuzzy finder for lazy.nvim
    fd # fuzzy finder for lazy.nvim
    gnumake # linux make; for emacs vterm build
    cmake # cross-platform system generator; for emacs vterm build
    libtool # generic support script; for emacs vterm build 
    
    # file browser
    mc # midnight commander
    xfce.thunar # xfce file manager
    
    # git TUI
    lazygit # simple TUI for git

    # editor
    neovim # vim fork
    helix # postmodern text editor
    #vscode
    #emacs-unstable
     emacs29

    # programming language
    gcc # GNU compiler collection
    glibc # GNU C library
    # FIXME clash with gcc ld
    #lld # LLVM linker unwrapped
    # FIXME clash with gcc ranlib
    #llvmPackages.bintools # system binary utilities
    # FIXME clash with gcc ld 
    #clang # C language frontend for LLVM
    sqlite # SQL db engine
    python3
    sbcl
    zig
    zls
    rustup
    llvm
    openjdk
    maven
    gradle
    go
    clojure

    # internet browsing
    firefox
    vieb
    nyxt
    qutebrowser
    lagrange # gemini client
    
    # creative tools
    gimp # GNU image manipulation program 
    krita
    musescore
    calibre
    transmission-gtk # fast and easy bitorrent client
    
    # video and audio
    audacious
    vlc # cross platform media player and streaming server
    mpv # general purpose media player, fork of MPlayer and mplayer2

    # music tools
    sunvox
    ardour
    
    # iso tools
    # etcher   # single usb boot creator
    ventoy  # multiple usb boot iso
    #unetbootin # missing gtk org.gtk.Settings.FileChooser

    # virtualization & iso
    podman
    virt-manager
    
    # games
    retroarch
    steam # digitial distribution app
  ];


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # similar to home file, but this is placed inside ~/.config folder
  xdg.configFile = {
    # link source file of application
    "hypr/hyprland.conf".source = ./xdg-config/hypr/hyprland.conf;
    "waybar" = {
      recursive = true;
      enable = true;
      source = ./xdg-config/waybar;
    };
    "helix/config.toml".source = ./xdg-config/helix/config.toml;
    "mc" = {
      recursive = true;
      enable = true;
      source = ./xdg-config/mc;
    };
    "emacs" = {
      recursive = true;
      enable = true;
      source = ./xdg-config/emacs;
    };
    "kitty" = {
      recursive = true;
      enable = true;
      source = ./xdg-config/kitty;
    };
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/zizu/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "${editor}";
    BROWSER = "${browser}";
    NIXPKGS_ALLOW_UNFREE = "1";
    QT_QPA_PLATFORM = "xcb";
    QT_QPA_PLATFORMTHEME = lib.mkForce "qt5ct";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  ########################
  #### PROGRAMS CONFIG ###
  ########################
  
  # enable git and set the configuration
  programs.git = {
    enable = true;
    userName = "${username}";
    userEmail = "${fullname}";
  };

  # enable zsh and extra configs
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      #os-update = "sudo nixos-rebuild switch";
      #os-config = "sudo vim /etc/nixos/configuration.nix";
      #hm-update = "home-manager switch";
      #hm-config = "vim ~/.config/home-manager/home.nix";
    };
    history = {
      size = 1000;
      path =  "${config.xdg.dataHome}/zsh/history";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" ];
      theme = "robbyrussell";
    };
    initExtra =
      ''
      eval `keychain --eval --agents ssh id_ed25519`
      '';
  };
}
