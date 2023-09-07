{ config, pkgs, lib, username, fullname, email, editor, browser, nixos-version, ... }:


{
  # allow non-free software installation
  nixpkgs.config.allowUnfree = true;

  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "${nixos-version}"; # must follow nixos

  #overlays
  services.emacs.package = pkgs.emacs-unstable;
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
      sha256 = 0000000000000000000000000000000000000000000000000000;
    }))
  ];
  

  
  home.packages = with pkgs; [
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

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

    # file browser
    mc # midnight commander
    xfce.thunar # xfce file manager
    
    # git TUI
    lazygit # simple TUI for git

    # editor
    neovim # vim fork
    helix # postmodern text editor
    #vscode
    emacs-unstable
    #emacs29

    # programming language
    gcc # GNU compiler collection
    glibc # GNU C library
    lld # LLVM linker unwrapped
    llvmPackages.bintools # system binary utilities
    clang # C language frontend for LLVM
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
    
    # iso tools
    # etcher   # single usb boot creator
    ventoy  # multiple usb boot iso
    #unetbootin # missing gtk org.gtk.Settings.FileChooser

    
    # games
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
      os-update = "sudo nixos-rebuild switch";
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
