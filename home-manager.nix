{ config, pkgs, lib, username, fullname, email, editor, browser, nixos-version, ... }:


{
  # allow non-free software installation
  nixpkgs.config.allowUnfree = true;

  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "${nixos-version}"; # must follow nixos

   home.packages = [
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
    pkgs.thefuck
    pkgs.keychain
    pkgs.rmlint
    pkgs.rsync
    pkgs.ncdu
    pkgs.btop
    pkgs.rlwrap
    pkgs.tree
    pkgs.tmux
    pkgs.kitty

    # git TUI
    pkgs.lazygit

    # editor
    pkgs.neovim
    pkgs.helix
    #pkgs.vscode
    #pkgs.emacs-unstable
    pkgs.emacs29

    # programming language
    pkgs.sqlite
    pkgs.python3
    pkgs.sbcl
    pkgs.zig
    pkgs.zls
    pkgs.rustup
    pkgs.llvm
    pkgs.openjdk
    pkgs.maven
    pkgs.gradle

    # web browsing
    pkgs.firefox
    pkgs.vieb
    pkgs.nyxt
    pkgs.qutebrowser
    
    # creative tools
    pkgs.gimp
    pkgs.krita
    pkgs.musescore
    pkgs.calibre

    # video and audio
    pkgs.pavucontrol
    pkgs.vlc
    pkgs.audacious

    # iso tools
    # pkgs.etcher   # single usb boot creator
    pkgs.ventoy  # multiple usb boot iso
    #pkgs.unetbootin # missing gtk org.gtk.Settings.FileChooser

    
    # games
    #pkgs.steam # not working
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
