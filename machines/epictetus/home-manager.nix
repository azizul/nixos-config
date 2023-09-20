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
    (nerdfonts.override { fonts = ["JetBrainsMono" "FantasqueSansMono"
                                   "FiraCode" "DroidSansMono" "Iosevka" ]; })
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
    ydotool # generic command line automation tool
    cava # console base audio visualization for alsa
    neofetch # customize system info script
    cpufetch # fancy cpu architecture script
    starship # customizable prompt for any shell
    sox # simple rate audio converter
    #fzf # fuzzy finder written in Go
    tldr # simplified man page
    outils # checksums programs
    gnupg # GNU pgp program
    ripgrep # fuzzy finder for lazy.nvim
    fd # fuzzy finder for lazy.nvim
    gnumake # linux make; for emacs vterm build
    cmake # cross-platform system generator; for emacs vterm build
    libtool # generic support script; for emacs vterm build
    ispell # linux interactive spelling tool
    figlet # make large letters
    pfetch # pretty system information tool
    
    hunspell # updated ispell spelling tool
    hunspellDicts.en_US
    hunspellDicts.ru_RU
    hunspellDicts.es_ES
    
    aspell # gnu version of improved ispell
    aspellDicts.en # aspell english dictionary
    aspellDicts.en-science # aspell scientific jargon
    aspellDicts.en-computers # aspell computer jargon
    aspellDicts.de # aspell for german
    aspellDicts.ru # aspell russian dictionary
    aspellDicts.ar # aspell arabic dictionary
    aspellDicts.es # aspell spanish dictionary
    
    
    # file browser
    mc # midnight commander
    xfce.thunar # xfce file manager
    xfce.tumbler # xfce D-bus thumbnailer service
    xautolock # launch program when x timed out
    bibata-cursors # material based cursor theme
    pywal # generate color scheme based on wallpaper
    
    # git TUI
    lazygit # simple TUI for git

    # editor
    neovim # vim fork
    helix # postmodern text editor
    #vscode
    #emacs-unstable
    emacs29-pgtk

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
    python311
    sbcl
    zig
    zls
    rustup
    #rustc
    #cargo
    #rust-analyzer
    llvm
    openjdk
    maven
    gradle
    go
    clojure # clojure repl
    clojure-lsp # lsp server for clojure
    leiningen # clojure build tools
    ghc # haskell compiler
    opam # ocaml package manager
    ocamlPackages.merlin # ide helper
    ocamlPackages.utop # ocaml repl
    dune-release
    bubblewrap # sandboxing for ocaml
    erlang # erlang BEAM
    elixir # ruby on erlang BEAM
    elixir-ls # lsp for elixir
    nil # nix lsp server
    jdt-language-server # java lsp server
    luajit # lua jit compiler
    #luajitPackages.luarocks # lua package manager
    lua-language-server # current lsp server in used
    nodejs_20 # javascript runtime engine 
    nodePackages.pyright # python package
    
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
    userName = "${fullname}";
    userEmail = "${email}";
  };

  # keychain program
  programs.keychain = {
    enable = true;
    enableXsessionIntegration = true;
    enableZshIntegration = true;
    agents = [ "ssh" ];
    keys = [ "id_ed25519" ];
  };

  # enable fzf and integrate with zsh
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  
  # enable zsh and extra configs
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    shellAliases = {
      ll = "ls -l";

    };
    
    shellGlobalAliases = {
      emacsd = "emacs --daemon";
      emacsc = "emacsclient -c";
      emacsk = "emacsclient -e \"(kill-emacs)\"";
      emacsb = "emacs --batch -l org config.org -f org-babel-tangle";
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
      # ocaml opam
      eval $(opam env)
      '';
  };
}
